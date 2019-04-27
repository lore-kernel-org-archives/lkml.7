Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7850CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450AE208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfD0KyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:54:03 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39281 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfD0KyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:54:02 -0400
Received: from [192.168.0.2] (ip5f5bf0d8.dynamic.kabel-deutschland.de [95.91.240.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 32804604E3661;
        Sat, 27 Apr 2019 12:54:00 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Why is suspend with s2idle available on POWER8 systems?
Message-ID: <5fdabbb9-0a62-4802-f1ca-f83584f935fa@molgen.mpg.de>
Date:   Sat, 27 Apr 2019 12:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Updating an IBM S822LC from Ubuntu 18.10 to 19.04 some user space stuff 
seems to have changed, so that going into sleep/suspend is enabled.

That raises two questions.

1.  Is suspend actually supported on a POWER8 processor?

> Apr 27 10:18:13 power NetworkManager[7534]: <info>  [1556353093.7224] manager: sleep: sleep requested (sleeping: no  e
> Apr 27 10:18:13 power systemd[1]: Reached target Sleep.
> Apr 27 10:18:13 power systemd[1]: Starting Suspend...
> Apr 27 10:18:13 power systemd-sleep[82190]: Suspending system...
> Apr 27 10:18:13 power kernel: PM: suspend entry (s2idle)
> -- Reboot --

> $ uname -m
> ppc64le
> $ more /proc/version
> Linux version 5.1.0-rc6+ (joey@power) (gcc version 8.3.0 (Ubuntu 8.3.0-6ubuntu1)) #1 SMP Sat Apr 27 10:01:48 CEST 2019
> $ more /sys/power/mem_sleep
> [s2idle]
> $ more /sys/power/state
> freeze mem
> $ grep _SUSPEND /boot/config-5.0.0-14-generic # also enabled in Ubuntu’s configuration
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_SUSPEND=y
> CONFIG_SUSPEND_FREEZER=y
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> # CONFIG_PM_TEST_SUSPEND is not set

Should the Kconfig symbol `SUSPEND` be selectable? If yes, should their 
be some detection during runtime?

2.  If it is supported, what are the ways to getting it to resume? What 
would the IPMI command be?

For now I disabled the automatic suspend, masking the targets [1].


Kind regards,

Paul


[1]: https://wiki.debian.org/Suspend#Disable_suspend_and_hibernation
