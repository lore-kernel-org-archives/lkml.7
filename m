Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8BFC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3720449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfCGTTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:19:54 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:20590 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfCGTTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:19:53 -0500
Received: from belgarion ([90.76.35.80])
        by mwinf5d23 with ME
        id l7Ko1z0051jkVcS037KpxA; Thu, 07 Mar 2019 20:19:51 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 07 Mar 2019 20:19:51 +0100
X-ME-IP: 90.76.35.80
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
References: <20190307102250.1140038-1-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 07 Mar 2019 20:19:47 +0100
In-Reply-To: <20190307102250.1140038-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 7 Mar 2019 11:22:41 +0100")
Message-ID: <87imwu5w6k.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> pxa_cpufreq_init_voltages() is marked __init but usually inlined into
> the non-__init pxa_cpufreq_init() function. When building with clang,
> it can stay as a standalone function in a discarded section, and produce
> this warning:
>
> WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
> The function pxa_cpufreq_init() references
> the function __init pxa_cpufreq_init_voltages().
> This is often because pxa_cpufreq_init lacks a __init
> annotation or the annotation of pxa_cpufreq_init_voltages is wrong.
>
> Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
