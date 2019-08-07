Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8B021BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QWzRJr6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfHGLur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:50:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37783 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfHGLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:50:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id y26so87975650qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e3e0L/SskZXcaclJTGtiQqHhk/Wn3UfjFXd8QvpfKTA=;
        b=QWzRJr6KDulNeiwnKxoX/J2k5VHFI8J2XcrrcR9LhozL6wAiSlIoiSPnxmr5dtZgIu
         A6JXpR0J2Goh0qNOpgSKdBrX3nHbd3KYiWZlPvKCmgY7kZ+FpF5u9yuelxLo5eV+bG01
         Iph7jG08mptcwI1BOzuscipdCQdDDqItbwx3z5sP+8ENZ6OKKGqvZS5M9+qNsS/Jc2oy
         9xPGqwJrLJMwTtpt/IhAtFBWuvLw035zhYydTxRIPFd3bYbPwazcm0ODJiSzEqN4pTEC
         Tud8dTiYw1PN1EbmLuvVjOv2qn1LWK+QqiZss9sHhzLMBHu3wF/VqTAh29a/3fBh43B8
         cALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e3e0L/SskZXcaclJTGtiQqHhk/Wn3UfjFXd8QvpfKTA=;
        b=ad2Ojol/6e8HaKK07lRh9SqzvIHDq8PefGhZLGZNIKOuuUXJ5ItY+SKN4xDB2hmake
         IBD/9Ee6KUi6AXPgaj0fPYqFv63SFdDq6hkbE8oI6xyhpw7ivvAzJ1Jydfl9PBSEhOf3
         TQqDZJBDiRrTVyHi3j37pw/d+KOjCIBZGmCq+XMCXgiE6asgKVL1i+f5/EvTKmw0aE8T
         VmIVWg+GxLZ31wdhdHMjYLlwCxU+D4p7mjxnX2ZXTTz2cZSnqPNTajHyJJE9FCqCAAHz
         WY9+YsFzCKpRIU0dZf7PxBZvSdSlmYqE4vNMHmXy4AW6xZyzEcCxZGCyBl3Ihkm0V/ce
         Lvdg==
X-Gm-Message-State: APjAAAVnxjMc2wkEqqTU4kOP/KXfnVn8ugpJnudEx8QPEx34Km5SZUMt
        mr7RfUJHqOqnNVTl0ZAEcg2G4GiuZ4wY3w==
X-Google-Smtp-Source: APXvYqy0vhSBZ43m+6AFWZNrxa5IQNt30ULCeA3cDxvaDLebVXpYJdnH9cwilZ/+bBX69IKvf1IMqg==
X-Received: by 2002:ac8:2763:: with SMTP id h32mr7944940qth.350.1565178645995;
        Wed, 07 Aug 2019 04:50:45 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 42sm47144410qtm.27.2019.08.07.04.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 04:50:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] arm64/cache: fix -Woverride-init compiler warnings
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190807105652.cyi3fou2rfsxhxrk@willie-the-truck>
Date:   Wed, 7 Aug 2019 07:50:43 -0400
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D11F0810-A6D0-4835-B71A-9DDDC120423B@lca.pw>
References: <20190806193434.965-1-cai@lca.pw>
 <20190807105652.cyi3fou2rfsxhxrk@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 7, 2019, at 6:56 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Tue, Aug 06, 2019 at 03:34:34PM -0400, Qian Cai wrote:
>> diff --git a/arch/arm64/kernel/cpuinfo.c =
b/arch/arm64/kernel/cpuinfo.c
>> index 876055e37352..a0c495a3f4fd 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -34,10 +34,7 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>> static struct cpuinfo_arm64 boot_cpu_data;
>>=20
>> static char *icache_policy_str[] =3D {
>> -	[0 ... ICACHE_POLICY_PIPT]	=3D "RESERVED/UNKNOWN",
>> -	[ICACHE_POLICY_VIPT]		=3D "VIPT",
>> -	[ICACHE_POLICY_PIPT]		=3D "PIPT",
>> -	[ICACHE_POLICY_VPIPT]		=3D "VPIPT",
>> +	[0 ... ICACHE_POLICY_PIPT]	=3D "RESERVED/UNKNOWN"
>> };
>>=20
>> unsigned long __icache_flags;
>> @@ -310,13 +307,16 @@ static void cpuinfo_detect_icache_policy(struct =
cpuinfo_arm64 *info)
>>=20
>> 	switch (l1ip) {
>> 	case ICACHE_POLICY_PIPT:
>> +		icache_policy_str[ICACHE_POLICY_PIPT] =3D "PIPT";
>> 		break;
>> 	case ICACHE_POLICY_VPIPT:
>> +		icache_policy_str[ICACHE_POLICY_VPIPT] =3D "VPIPT";
>> 		set_bit(ICACHEF_VPIPT, &__icache_flags);
>> 		break;
>> 	default:
>> 		/* Fallthrough */
>> 	case ICACHE_POLICY_VIPT:
>> +		icache_policy_str[ICACHE_POLICY_VIPT] =3D "VIPT";
>> 		/* Assume aliasing */
>> 		set_bit(ICACHEF_ALIASING, &__icache_flags);
>=20
> I still think this is worse than the code in mainline. I don't think
> -Woverride-init should warn when overriding a field from a GCC range
> designated initialiser, since it makes them considerably less useful
> imo.

Unfortunately, compiler people are moving into a different direction as
Clang would warn those kind of usage too.

It actually prove that those warnings are useful to find real issues. =
See,

Fae5e033d65a (=E2=80=9Cmfd: rk808: Fix RK818_IRQ_DISCHG_ILIM =
initializer=E2=80=9D)
32df34d875bb (=E2=80=9C[media] rc: img-ir: jvc: Remove unused no-leader =
timings=E2=80=9D)

Especially, to find redundant initializations in large structures. e.g.,

e6ea0b917875 (=E2=80=9C[media] dvb_frontend: Don't declare values twice =
at a table=E2=80=9D)=
