Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A8CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7672238A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JzlSyO5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE2OaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:30:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33709 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2OaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:30:24 -0400
Received: from [172.20.5.109] (207-225-69-115.dia.static.qwest.net [207.225.69.115] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4TET5Ip2561081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 29 May 2019 07:29:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4TET5Ip2561081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559140147;
        bh=0QBCMhL0UtNfpa1/nHPwY54RLtb1R1cG9r3yArQfJtw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=JzlSyO5eP+ZYLQHrdvCzaFyQ8yV9k74Kwz9U3ZBRjGi+VZ2tnTPD79icUl023IVaa
         lorhYOOJ39lVimV25yC8m2dMXeg0m03X5EGPWuJ6QzpjHbUcuWphp4BFY7sIrz4FgP
         TT9aVIxbcqZR5INiHae7timA+hTN2S6EkuNTGTj9j10QfOQA1Zm/XchNd7ZDZPeTkx
         EFwSJMe3MEfRQ9KoN1PHX3oJZFhRT7M0C8qaTRhDfALGrRbpwmV6xNHrucaWs+HEIg
         x3oclNc0c4VudCFk50ebDNaxcIoemxYdHIzudfM9TPcv//LgFBeKs0qxuOyvB2RC6f
         KoMPScX/VGQxA==
Date:   Wed, 29 May 2019 07:29:01 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190529141500.193390-3-elver@google.com>
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
To:     Marco Elver <elver@google.com>, peterz@infradead.org,
        aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, mark.rutland@arm.com
CC:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
From:   hpa@zytor.com
Message-ID: <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2019 7:15:00 AM PDT, Marco Elver <elver@google=2Ecom> wrote:
>This patch is a pre-requisite for enabling KASAN bitops
>instrumentation:
>moves boot_cpu_has feature test out of the uaccess region, as
>boot_cpu_has uses test_bit=2E With instrumentation, the KASAN check would
>otherwise be flagged by objtool=2E
>
>This approach is preferred over adding the explicit kasan_check_*
>functions to the uaccess whitelist of objtool, as the case here appears
>to be the only one=2E
>
>Signed-off-by: Marco Elver <elver@google=2Ecom>
>---
>v1:
>* This patch replaces patch: 'tools/objtool: add kasan_check_* to
>  uaccess whitelist'
>---
> arch/x86/ia32/ia32_signal=2Ec | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/ia32/ia32_signal=2Ec b/arch/x86/ia32/ia32_signal=2E=
c
>index 629d1ee05599=2E=2E12264e3c9c43 100644
>--- a/arch/x86/ia32/ia32_signal=2Ec
>+++ b/arch/x86/ia32/ia32_signal=2Ec
>@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal
>*ksig,
> 	void __user *restorer;
> 	int err =3D 0;
> 	void __user *fpstate =3D NULL;
>+	bool has_xsave;
>=20
> 	/* __copy_to_user optimizes that into a single 8 byte store */
> 	static const struct {
>@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct ksignal
>*ksig,
> 	if (!access_ok(frame, sizeof(*frame)))
> 		return -EFAULT;
>=20
>+	/*
>+	 * Move non-uaccess accesses out of uaccess region if not strictly
>+	 * required; this also helps avoid objtool flagging these accesses
>with
>+	 * instrumentation enabled=2E
>+	 */
>+	has_xsave =3D boot_cpu_has(X86_FEATURE_XSAVE);
> 	put_user_try {
> 		put_user_ex(sig, &frame->sig);
> 		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
> 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>=20
> 		/* Create the ucontext=2E  */
>-		if (boot_cpu_has(X86_FEATURE_XSAVE))
>+		if (has_xsave)
> 			put_user_ex(UC_FP_XSTATE, &frame->uc=2Euc_flags);
> 		else
> 			put_user_ex(0, &frame->uc=2Euc_flags);

This was meant to use static_cpu_has()=2E Why did that get dropped?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
