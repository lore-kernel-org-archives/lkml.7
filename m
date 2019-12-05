Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3028C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD1B2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hoCaCJMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfLETPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:15:15 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:37001 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:15:14 -0500
Date:   Thu, 05 Dec 2019 19:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1575573312;
        bh=vb4xN0McS6Sjd9AgIw6FMJzU4MIU0iiQYzK5EcMynOI=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=hoCaCJMp0ardbB4eMvVQDdkFvPwrTp8wFZttEepDfWwocHq1I9iSlP8nfVUTHaFwx
         jh/KEdgFAp4Cvn01Yv/HzkB0/KRPtrQPfLMx5uUncNPN4ovwEOf9zX/7b24NeJY4mB
         15kF/lNowyFXuiwakTuKTu0HtAs5ZeVyzlwDUuK4=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>,
        "malat@debian.org" <malat@debian.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: [PATCH] x86/tsc: Don't use cpuid 0x16 leaf to determine cpu speed.
Message-ID: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects tsc drift on systems with changed base clock frequency
(e.g. overclocking).

We can't use 0x16 cpu leaf as it's documented as "not reflecting actual
values" and is supposed to be used only as a mean to determine "processor
brand string and for determining the appropriate range to use when
displaying processor information e.g. frequency history graphs".

Signed-off-by: Krzysztof Piecuch <piecuch@protonmail.com>
---
 arch/x86/kernel/tsc.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..fc9a000a814c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -641,29 +641,16 @@ unsigned long native_calibrate_tsc(void)
 =09=09=09boot_cpu_data.x86_model =3D=3D INTEL_FAM6_ATOM_GOLDMONT_D)
 =09=09crystal_khz =3D 25000;

+=09if (crystal_khz =3D=3D 0)
+=09=09return 0;
+
 =09/*
 =09 * TSC frequency reported directly by CPUID is a "hardware reported"
 =09 * frequency and is the most accurate one so far we have. This
 =09 * is considered a known frequency.
 =09 */
-=09if (crystal_khz !=3D 0)
-=09=09setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-
-=09/*
-=09 * Some Intel SoCs like Skylake and Kabylake don't report the crystal
-=09 * clock, but we can easily calculate it to a high degree of accuracy
-=09 * by considering the crystal ratio and the CPU speed.
-=09 */
-=09if (crystal_khz =3D=3D 0 && boot_cpu_data.cpuid_level >=3D 0x16) {
-=09=09unsigned int eax_base_mhz, ebx, ecx, edx;
-
-=09=09cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
-=09=09crystal_khz =3D eax_base_mhz * 1000 *
-=09=09=09eax_denominator / ebx_numerator;
-=09}

-=09if (crystal_khz =3D=3D 0)
-=09=09return 0;
+=09setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

 =09/*
 =09 * For Atom SoCs TSC is the only reliable clocksource.
--
2.17.1

