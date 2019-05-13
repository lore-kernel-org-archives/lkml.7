Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5851C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91512133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfEMLXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMLXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:23:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD7893086202;
        Mon, 13 May 2019 11:23:22 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10C571001DE1;
        Mon, 13 May 2019 11:23:20 +0000 (UTC)
Subject: Re: [PATCH] modules: fix livelock in add_unformed_module()
To:     Barret Rhoden <brho@google.com>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <be47ac01-a5ac-7be1-d387-5c841007b45f@google.com>
 <20190510184204.225451-1-brho@google.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <dd48a3a4-9046-3917-55ba-d9eb391052b3@redhat.com>
Date:   Mon, 13 May 2019 07:23:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510184204.225451-1-brho@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 13 May 2019 11:23:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/19 2:42 PM, Barret Rhoden wrote:
> When add_unformed_module() finds an existing module with the same name,
> it waits until the preexisting module finished loading.  Prior to commit
> f9a75c1d717f, this meant if the module was either UNFORMED or COMING,
> we'd wait.  That commit changed the check to be !LIVE, so that we'd wait
> for UNFORMED, COMING, or GOING.

Hi Barret, thanks for the fix but I dropped that patch for other reasons.
Please see below.

> 
> The problem with that commit was that we wait on finished_loading(), and
> that function's state checks were not changed.  If a module was
> GOING, finished_loading() was returning true, meaning to recheck the
> state and presumably break out of the loop.  This mismatch between the
> state checked by add_unformed_module() and the state checked in
> finished_loading() could result in a hang.
> 
> Specifically, when a module was GOING, wait_event_interruptible() would
> immediately return with no error, we'd goto 'again,' see the state !=
> LIVE, and try again.
> 
> This commit changes finished_loading() such that we only consider a
> module 'finished' when it doesn't exist or is LIVE, which are the cases
> that break from the wait-loop in add_unformed_module().
> 
> Fixes: f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  kernel/module.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 410eeb7e4f1d..0744eea7bb90 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3407,8 +3407,7 @@ static bool finished_loading(const char *name)
>  	sched_annotate_sleep();
>  	mutex_lock(&module_mutex);
>  	mod = find_module_all(name, strlen(name), true);
> -	ret = !mod || mod->state == MODULE_STATE_LIVE
> -		|| mod->state == MODULE_STATE_GOING;
> +	ret = !mod || mod->state == MODULE_STATE_LIVE;
>  	mutex_unlock(&module_mutex);

With your change the above my x86 system still locks up during boot and adds
minutes to boot time because the many CPUs are sleeping waiting for the
module_wq to be run.

A module is loaded once for each cpu.

CPU 0 loads the module, adds the module to the modules list, and sets the module
state to MODULE_STATE_UNFORMED.

Simultaneously all the other CPUs also load the module and sleep in
add_unformed_module().

If CPU 0 is interrupted/rescheduled for any reason that means the other CPUs are
stuck waiting until the module thread on CPU0 is executed again.  I mentioned
earlier that on some systems systemd is launching greater than the number of CPU
module loads so this occurs quite often on large CPU systems.  This is an odd
bug that also needs to be resolved but I suspect that it is in systemd & not the
kernel.

My follow-up patch changes from wait_event_interruptible() to
wait_event_interruptible_timeout() so the CPUs are no longer sleeping and can
make progress on other tasks, which changes the return values from
wait_event_interruptible().

https://marc.info/?l=linux-kernel&m=155724085927589&w=2

I believe this also takes your concern into account?

Please correct me if I'm wrong and am not understanding your issue.

P.

>  
>  	return ret;
> 
