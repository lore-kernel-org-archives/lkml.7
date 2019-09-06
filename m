Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1330C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2E2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388879AbfIFKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:46:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57113 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfIFKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:46:25 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x86AkCfe050875;
        Fri, 6 Sep 2019 19:46:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 06 Sep 2019 19:46:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x86AkB0Q050870
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 6 Sep 2019 19:46:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
 <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
 <20190905140833.GB3838@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <20ec856d-0f1e-8903-dbe0-bbc8b7a1847a@i-love.sakura.ne.jp>
Date:   Fri, 6 Sep 2019 19:46:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905140833.GB3838@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/05 23:08, Michal Hocko wrote:
> On Thu 05-09-19 22:39:47, Tetsuo Handa wrote:
> [...]
>> There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
>> But that requires a solution for OOM stalling problem.
> 
> You can hardly remove stalling if you are not reducing the amount of
> output or get it into a different context. Whether the later is
> reasonable is another question but you are essentially losing "at the
> OOM event state".
> 

I am not losing "at the OOM event state". Please find "struct oom_task_info"
(for now) embedded into "struct task_struct" which holds "at the OOM event state".

And my patch moves "printk() from dump_tasks()" from OOM context to WQ context.
Thus, I do remove stalling by defer printing of "struct oom_task_info" until
the OOM killer sends SIGKILL and the OOM reaper starts reclaiming memory.

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -639,6 +639,21 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+/* Memory usage and misc info as of invocation of OOM killer. */
+struct oom_task_info {
+	struct list_head list;
+	unsigned int seq;
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	uid_t uid;
+	pid_t tgid;
+	unsigned long total_vm;
+	unsigned long mm_rss;
+	unsigned long pgtables_bytes;
+	unsigned long swapents;
+	int score_adj;
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1260,7 +1275,7 @@ struct task_struct {
 #ifdef CONFIG_MMU
 	struct task_struct		*oom_reaper_list;
 #endif
-	struct list_head		oom_victim_list;
+	struct oom_task_info		oom_task_info;
 #ifdef CONFIG_VMAP_STACK
 	struct vm_struct		*stack_vm_area;
 #endif
