Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4D42083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfDJNE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:04:58 -0400
Received: from ns.iliad.fr ([212.27.33.1]:44546 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfDJNE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:04:58 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B941D21873;
        Wed, 10 Apr 2019 15:04:56 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 9CEA42094A;
        Wed, 10 Apr 2019 15:04:56 +0200 (CEST)
Subject: Re: [PATCH 23/23] watchdog: tangox_wdt: Convert to use device managed
 functions and other improvements
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-24-git-send-email-linux@roeck-us.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <6ebee4d6-c650-c322-a966-4269d54da9be@free.fr>
Date:   Wed, 10 Apr 2019 15:04:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554830641-9247-24-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Apr 10 15:04:56 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2019 19:24, Guenter Roeck wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> Other improvements as listed below.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop assignments to otherwise unused variables
> - Drop unnecessary braces around conditional return statements
> - Drop empty remove function
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Replace stop on remove with call to watchdog_stop_on_unregister()
> - Use devm_watchdog_register_driver() to register watchdog device

No devm_clk_prepare() in mainline? :-(

https://lore.kernel.org/patchwork/patch/755487/

Regards.
