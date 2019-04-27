Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72115C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B1420651
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfD0KYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:24:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725977AbfD0KYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:24:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3RANkZH016060
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 06:24:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s4g0v8ssb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 06:24:48 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 27 Apr 2019 11:24:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 27 Apr 2019 11:24:43 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3RAOgHJ61604074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Apr 2019 10:24:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B8A5204E;
        Sat, 27 Apr 2019 10:24:42 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 0F2C15204F;
        Sat, 27 Apr 2019 10:24:42 +0000 (GMT)
Date:   Sat, 27 Apr 2019 12:24:40 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris>
 <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
 <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
 <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19042710-4275-0000-0000-0000032EDECA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042710-4276-0000-0000-0000383E30C7
Message-Id: <20190427102440.GA28889@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904270075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 08:20:52PM -0400, Prarit Bhargava wrote:
> Heiko and Jessica,
> 
> The issue doesn't appear to be with my patch AFAICT.  The s390_trng fails to
> load and then the kernel occasionally hangs (as Heiko mentioned) calling
> synchronize_rcu().
> 
> The call sequence is
> 
> module_load()
> 	do_init_module()
> 		do_one_initcall(mod->init)
> 
> which fails.
> 
> The failure path in do_one_initcall() is entered and we start executing code at
> kernel/module.c:3541
> 
> fail_free_freeinit:
>         kfree(freeinit);
> fail:
>         /* Try to protect us from buggy refcounters. */
>         mod->state = MODULE_STATE_GOING;
>         synchronize_rcu();
> 
> ^^^ the kernel hangs here.  Sometimes it's very short and other times it seems
> to hang.   I've left systems that appear to be hung and come back after 10
> minutes to find that they've somehow made it through this call.
> 
> Is there a known issue with RCU on s390 that is making this occur?

No there is no known issue with RCU on s390. The reason that
synchronize_rcu() doesn't finish is because a different cpu is within
an endless loop in add_unformed_module() just like Jessica suspected.

Note: the kernel is compiled with CONFIG_PREEMPT off - there is no
kernel preemption that will make the looping cpu ever go over schedule
and subsequently let synchronize_rcu() finish.

To confirm Jessicas theory - looking into the dump we have:

crash> bt 742
PID: 742    TASK: 1efa6c000         CPU: 7   COMMAND: "systemd-udevd"
 #0 [3e0043aba30] __schedule at abb25e
 #1 [3e0043abaa0] schedule at abb6a2
 #2 [3e0043abac8] schedule_timeout at abf49a
 #3 [3e0043abb60] wait_for_common at abc396
 #4 [3e0043abbf0] __wait_rcu_gp at 1c0136
 #5 [3e0043abc48] synchronize_rcu at 1c72ea
 #6 [3e0043abc98] do_init_module at 1f10be
 #7 [3e0043abcf0] load_module at 1f3594
 #8 [3e0043abdd0] __se_sys_init_module at 1f3af0
 #9 [3e0043abea8] system_call at ac0766

Which is the process waiting for synchronize_rcu to finish. Wading
through the stack frames gives me this struct module:

struct module {
  state = MODULE_STATE_GOING,
  list = {
    next = 0x3ff80394508,
    prev = 0xe25090 <modules>
  },
  name = "s390_trng\000...
...

Then we have the looping task/cpu:

PID: 731    TASK: 1e79ba000         CPU: 7   COMMAND: "systemd-udevd"
 LOWCORE INFO:
  -psw      : 0x0704c00180000000 0x0000000000ab666a
  -function : memcmp at ab666a
...
  -general registers:
     0x0000000000000009 0x0000000000000009
     0x000003ff80347321 000000000000000000
     0x000003ff8034f321 000000000000000000
     0x000000000000001e 0x000003ff8c592708
     0x000003e0047da900 0x000003ff8034f318
     0x0000000000000001 0x0000000000000009
     0x000003ff80347300 0x0000000000ad81b8
     0x00000000001ee062 0x000003e004357cb0
 #0 [3e004357cf0] load_module at 1f1eb0
 #1 [3e004357dd0] __se_sys_init_module at 1f3af0
 #2 [3e004357ea8] system_call at ac0766

which is find_module_all() calling memcmp with this string:

3ff80347318:  733339305f74726e 6700000000000000   s390_trng.......

So it all seems to fit. A simple cond_resched() call, which enforces
an RCU quiescent state for the calliung cpu, fixes the problem for me
(patch on top of linux-next 20190424 -- c392798a85ab):

diff --git a/kernel/module.c b/kernel/module.c
index 410eeb7e4f1d..48748cfec991 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3585,6 +3585,7 @@ again:
 					       finished_loading(mod->name));
 			if (err)
 				goto out_unlocked;
+			cond_resched();
 			goto again;
 		}
 		err = -EEXIST;

