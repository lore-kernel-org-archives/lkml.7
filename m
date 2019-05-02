Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54101C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCD12075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEBMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfEBMlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C69131A41DC;
        Thu,  2 May 2019 12:41:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC42BA224;
        Thu,  2 May 2019 12:41:49 +0000 (UTC)
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules to
 finish loading
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <20190430222207.3002-1-prarit@redhat.com>
 <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
 <20190502094813.GA6690@linux-8ccs>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <f0bc15a4-0f99-c899-b7d7-2d4db86e287e@redhat.com>
Date:   Thu, 2 May 2019 08:41:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502094813.GA6690@linux-8ccs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 02 May 2019 12:41:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 5:48 AM, Jessica Yu wrote:
> +++ Prarit Bhargava [01/05/19 17:26 -0400]:
>>
>>
>> On 4/30/19 6:22 PM, Prarit Bhargava wrote:
>>> On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
>>> loading the s390_trng.ko module.
>>>
>>> Add a reschedule point to the loop that waits for modules to complete
>>> loading.
>>>
>>> v3: cleanup Fixes line.
>>
>> Jessica, even with this additional patch there appears to be some other issues
>> in the module code that are causing significant delays in boot up on large
>> systems.
> 
> Is this limited to only s390? Or are you seeing this on other arches
> as well? And is it limited to specific modules (like s390_trng)?

Other arches.  We're seeing a hang on a new 192 CPU x86_64 box & the
acpi_cpufreq driver.  The system is MUCH faster than any other x86_64 box I've
seen and that's likely why I'm seeing a problem.

> 
>> FWIW, the logic in the original patch is correct.  It's just that there's, as
>> Heiko discovered, some poor scheduling, etc., that is impacting the module
>> loading code after these changes.
> 
> I am really curious to see what these performance regressions look
> like :/ Please update us when you find out more.
> 

I sent Heiko a private v4 RFC last night with this patch (sorry for the
cut-and-paste)

diff --git a/kernel/module.c b/kernel/module.c
index 1c429d8d2d74..a4ef8628f26f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3568,12 +3568,12 @@ static int add_unformed_module(struct module *mod)
	mutex_lock(&module_mutex);
	old = find_module_all(mod->name, strlen(mod->name), true);
	if (old != NULL) {
-		if (old->state == MODULE_STATE_COMING
-		    || old->state == MODULE_STATE_UNFORMED) {
+		if (old->state != MODULE_STATE_LIVE) {
			/* Wait in case it fails to load. */
			mutex_unlock(&module_mutex);
-			err = wait_event_interruptible(module_wq,
-					       finished_loading(mod->name));
+			err = wait_event_interruptible_timeout(module_wq,
+					       finished_loading(mod->name),
+					       HZ / 10000);
			if (err)
				goto out_unlocked;
			goto again;

The original module dependency race issue is fixed simply by changing the
conditional to checking !MODULE_STATE_LIVE.  This, unfortunately, exposed some
other problems within the code.

The module_wq is only run when a module fails to load.  It's possible that
the time between the module's failed init() call and running module_wq
(kernel/module.c:3455) takes a while.  Any thread entering the
add_unformed_module() code while the old module is unloading is put to sleep
waiting for the module_wq to execute.

On the 192 thread box I have noticed that the acpi_cpufreq module attempts
to load 392 times (that is not a typo and I am going to try to figure that
problem out after this one).  This means 191 cpus are put to sleep, and one
cpu is executing the acpi_cpufreq module unload which is executing
do_init_module() and is now at

fail_free_freeinit:
        kfree(freeinit);
fail:
        /* Try to protect us from buggy refcounters. */
        mod->state = MODULE_STATE_GOING;
        synchronize_rcu();
        module_put(mod);
        blocking_notifier_call_chain(&module_notify_list,
                                     MODULE_STATE_GOING, mod);
        klp_module_going(mod);
        ftrace_release_mod(mod);
        free_module(mod);
        wake_up_all(&module_wq);
        return ret;
}

The 191 threads cannot schedule and the system is effectively stuck.  It *does*
eventually free itself but in some cases it takes minutes to do so.

A simple fix for this is to, as I've done above, to add a timeout so that
the threads can be scheduled which allows other processes to run.  After
thinking about it a bit more, however, I wonder if a better approach is to
change the mod->state to MODULE_FAILED & running the module_wq immediately so
that the threads can return an error.

I'm experimenting with that now.

P.
