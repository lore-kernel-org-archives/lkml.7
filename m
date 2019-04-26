Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C214C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D01220449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556295441;
	bh=1q+kKaHdSpv3rLLPhgQuSf1Tixn0EUsVtaj51dsI5Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NkDT5HHtOJKOFvt5HzzINGu1RJXthPB+3IQn4KEWDfNeHBjbrmus2s/wZIsb6uRi3
	 UcxenIVnwluUM3gZjT/AShEC5QLJmzuEMMf37k355R7Ea5VEEEa14pw08qwI2q3zbB
	 smKHPop9aM+DHhLOfSPInVuEp5ppV2rnA/FlOe3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfDZQRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfDZQRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:17:19 -0400
Received: from linux-8ccs (ip5f5ade77.dynamic.kabel-deutschland.de [95.90.222.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063EF2084F;
        Fri, 26 Apr 2019 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556295002;
        bh=1q+kKaHdSpv3rLLPhgQuSf1Tixn0EUsVtaj51dsI5Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYTW92zM1hJrSo17ScwIw9ki98bV+gXIBr2FvpMWhe3rXUCbWok/2SEiikcXn5uY2
         PtjU1xR6SrRe1ci90bT4o9M2YZ0dCuvPIAshe9a/ufoxyx472585SzwLpOxESeVLQw
         hpMZX5n0Gcn+8nA+8WAi+QME3i8IBHAKHSrmJchU=
Date:   Fri, 26 Apr 2019 18:09:57 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
Message-ID: <20190426160956.GA3827@linux-8ccs>
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190426150741.GD8646@osiris>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Heiko Carstens [26/04/19 17:07 +0200]:
>On Fri, Apr 26, 2019 at 09:22:34AM -0400, Prarit Bhargava wrote:
>> On 4/26/19 9:07 AM, Heiko Carstens wrote:
>> > Hello Prarit,
>> >
>> > it looks like your commit f9a75c1d717f ("modules: Only return -EEXIST
>> > for modules that have finished loading") _sometimes_ causes hangs on
>> > s390. This is unfortunately not 100% reproducible, however the
>> > mentioned commit seems to be the only relevant one in modules.c.
>> >
>> > What I see is a hanging system with messages like this on the console:
>> >
>> > [   65.876040] rcu: INFO: rcu_sched self-detected stall on CPU
>> > [   65.876049] rcu:     7-....: (5999 ticks this GP) idle=eae/1/0x4000000000000002 softirq=1181/1181 fqs=2729
>> > [   65.876078]  (t=6000 jiffies g=-471 q=17196)
>> > [   65.876084] Task dump for CPU 7:
>> > [   65.876088] systemd-udevd   R  running task        0   731    721 0x06000004
>> > [   65.876097] Call Trace:
>> > [   65.876113] ([<0000000000abb264>] __schedule+0x2e4/0x6e0)
>> > [   65.876122]  [<00000000001ee486>] finished_loading+0x4e/0xb0
>> > [   65.876128]  [<00000000001f1ed6>] load_module+0xcce/0x27a0
>> > [   65.876134]  [<00000000001f3af0>] __s390x_sys_init_module+0x148/0x178
>> > [   65.876142]  [<0000000000ac0766>] system_call+0x2aa/0x2c8
>> > I did not look any further into the dump, however since the commit
>> > touches exactly the code path which seems to be looping... ;)
>> >
>>
>> Ouch :(  I wonder if I exposed a further race or another bug.  Heiko, can you
>> determine which module is stuck?  Warning: I have not compiled this code.
>
>Here we go:
>
>[   11.716866] PRARIT: waiting for module s390_trng to load.
>[   11.716867] PRARIT: waiting for module s390_trng to load.
>[   11.716868] PRARIT: waiting for module s390_trng to load.
>[   11.716870] PRARIT: waiting for module s390_trng to load.
>[   11.716871] PRARIT: waiting for module s390_trng to load.
>[   11.716872] PRARIT: waiting for module s390_trng to load.
>[   11.716874] PRARIT: waiting for module s390_trng to load.
>[   11.716875] PRARIT: waiting for module s390_trng to load.
>[   11.716876] PRARIT: waiting for module s390_trng to load.
>[   16.726850] add_unformed_module: 31403529 callbacks suppressed
>[   16.726853] PRARIT: waiting for module s390_trng to load.
>[   16.726862] PRARIT: waiting for module s390_trng to load.
>[   16.726865] PRARIT: waiting for module s390_trng to load.
>[   16.726867] PRARIT: waiting for module s390_trng to load.
>[   16.726869] PRARIT: waiting for module s390_trng to load.
>
>If I'm not mistaken then there was _no_ corresponding message on the
>console stating that the module already exists.

Hm, my current theory is that we have a module whose exit() function
is taking a while to run to completion. While it is doing so, the
module's state is already set to MODULE_STATE_GOING.

With Prarit's patch, since this module is probably still in GOING,
add_unformed_module() will wait until the module is finally gone. If
this takes too long, we will keep trying to add ourselves to the
module list and hence stay in the loop in add_unformed_module().
According to Documentation/RCU/stallwarn.txt, this looping in the
kernel may trigger an rcu stall warning (see bullet point stating "a
CPU looping anywhere in the kernel without invoking schedule()".

Heiko, could you modify the patch to print the module's state to
confirm?

Thanks,

Jessica
