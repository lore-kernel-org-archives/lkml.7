Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE360C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E4207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576583680;
	bh=3JUa6CxPotelEfI00Ed3itJqwxqUaHiguQqeOll/buE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=P8arnCAA629aZNO41dZ3Itqiyp/7OXbZsxVzvyNCh3a6gVM3R+EJTJA/cLpVC+cPJ
	 EUNeL30DguQZiPE7NagCAoZ+nbxP42mIwJWWirZeBvUxX5CXDC3Y6qYAxIqms6cAK7
	 31rOjpthAezPuDhjNAAgX8tCEUFhOBNqCQ6YrdLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLQLyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:54:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:54:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so10985925wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3nflKlTNLavsE7WnoQiZpktt84Oug6lmtzWMsYo4M9k=;
        b=h43y9xrTR4wrW4jpoWfAGmND8+ThRNcMaWCuMpihQG8a+ZozmuBfOvvw9LsflBSSqV
         cMY0vQDdHHTzpacwTuCqCQUqTQx8cWbulmv33acaclOYwcTUftHiwLUU9V0MHjsvoBND
         R0G2G3irKaqtWdk7mvEpCo1GvI7sHmPGkAln2+aM4oJOXY9pv3f3jT9tQpyDECBH4gv0
         XaNXFCOtC5ZuMz4eEf5T87EP7obII9n16CFEoU0cAMVozlWqKTVcpVOKqqYQ1AcgqSCe
         bTydZUzwESNZH0esENniExKbhgLC5WMwwVKdhUqYvvOzzpRY+BPn2oPxzpceL/EVChtj
         jGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3nflKlTNLavsE7WnoQiZpktt84Oug6lmtzWMsYo4M9k=;
        b=Ddj31ZccR+ZFYvn89hAfjYRsxKTeBbekTxTsiuYOpPEcVokkhE6hxsliJAxzmaFp74
         YiM1nq2gdwn8t5BVhZLtMo3xGi5cRlvPUhDFb5Gxi7hAw6ayw1nMa5Rez3LoEriCrQPv
         XDFT8I0AhJG+uAeA2FkXIcVEIjLuJ4+WXCxGgaGoNgZNq3FKAI8Ob1lbPp7c/E9cSsK8
         FTdRgiM4HVVjyuQIlddHs+JktYDwrroF1p2Xbzr7EggzgvqNdCWdW9vW+qCLl9QW2Ak8
         lX06PVOQCyMszyvfyO289GX82seO7hTRxBFlPacV8JzcWeKz0HrpMdETDBBJjXsxbBSM
         62zw==
X-Gm-Message-State: APjAAAVwzWYS3JpgpF7bTczxD1rTFzwe7x7fUkjVGBcyXJk7m6h/seHR
        9PcA6vd6DsBFNt2uXXWCx1A=
X-Google-Smtp-Source: APXvYqwbHTwj16f+gfZLfi31dRhX/VSY3hF+0sHj7Uq5pQgUoVMDHuoubBpMVIZDawFZTk1qP7053w==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr38135760wrm.62.1576583677735;
        Tue, 17 Dec 2019 03:54:37 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g7sm25521433wrq.21.2019.12.17.03.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:54:37 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:54:35 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fix
Message-ID: <20191217115435.GA28382@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

   # HEAD: 346da4d2c7ea39de65487b249aaa4733317a40ec sched/cputime, proc/stat: Fix incorrect guest nice cpustat value

Fix the guest-nice cpustat values in /proc.

 Thanks,

	Ingo

------------------>
Flavio Leitner (1):
      sched/cputime, proc/stat: Fix incorrect guest nice cpustat value


 fs/proc/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 37bdbec5b402..fd931d3e77be 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -134,7 +134,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		+= cpustat[CPUTIME_SOFTIRQ];
 		steal		+= cpustat[CPUTIME_STEAL];
 		guest		+= cpustat[CPUTIME_GUEST];
-		guest_nice	+= cpustat[CPUTIME_USER];
+		guest_nice	+= cpustat[CPUTIME_GUEST_NICE];
 		sum		+= kstat_cpu_irqs_sum(i);
 		sum		+= arch_irq_stat_cpu(i);
 
@@ -175,7 +175,7 @@ static int show_stat(struct seq_file *p, void *v)
 		softirq		= cpustat[CPUTIME_SOFTIRQ];
 		steal		= cpustat[CPUTIME_STEAL];
 		guest		= cpustat[CPUTIME_GUEST];
-		guest_nice	= cpustat[CPUTIME_USER];
+		guest_nice	= cpustat[CPUTIME_GUEST_NICE];
 		seq_printf(p, "cpu%d", i);
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(user));
 		seq_put_decimal_ull(p, " ", nsec_to_clock_t(nice));
