Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D73C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D85206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="v5uo6zSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLXMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:09:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33853 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfLXMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:09:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so10349703pgf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 04:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=K4+yYEajmvASBw/wK7dx01YAKKK9lQkCygbw5uYtDvw=;
        b=v5uo6zSi8Zl71hkeRCL1WDbTWJpta5F83ZOr5fxkkmp8Nw9B+KoTpjA3o2GjQy6HDP
         z+802JX+aRA390qBjINq0fnHSEcntSkwsD2EIdKdxcvAxxrKOvxCCaWOUUvCrR+n8fRj
         meVMHS9VnwRQ3Mpp3i0JSkU6+2DH9Tm8yVzs9R4X2pRKBJzEhe4Iu0+PxpENQ/X2kzLq
         V/G9BIlbM5R458R2UgYGUF2TnKMV2LmqGcHfOZ5qKpX+LQzykslgAxQOVxRyy1Xrojh+
         ahp+RNTQr5w5UIgQgyaUDAlDJlFjIHRY7VldSOH4+iPjEpgAad3Lc8Ta0OVzWIkcCVWq
         1C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=K4+yYEajmvASBw/wK7dx01YAKKK9lQkCygbw5uYtDvw=;
        b=TaE/kK4asY3fWAwgHntK1rWlEOhLBBK/agumzSTRK8FOy6IVAchw19UTVMlsi0rWcO
         lf2rDI92bVpihFdznl++XJLman+ZszCktKU5PSeBs3tMFzgfpSCF4wnmK08ZUVG0M8st
         auew/NaEubNL9Qs3+WatKPvfJ1MReQG4lwXopjkX+FoiwQdt8FLhSnGlJ3v1JNuij0ZM
         t/PMAaPsg10uF2KI2T7yG9VRZDVVh6mbTSgZEsu7ifOFLFWVAwSGbXr73caQaNtJnHXQ
         WfEGqVh/l3T85cejlXLwXmjkCyIzWLzyAlE4xzocr9T24JIZxOCd1FN+eTK213QDYxCH
         YjOQ==
X-Gm-Message-State: APjAAAXzX7RiOb/cgm4YH3FvHAjUY6QaBJ35i09T1o1MS5pBEHeYKTSA
        pcc8JZiEuDVdllMHqJwCMuG1Pw==
X-Google-Smtp-Source: APXvYqxA1SUulGpkbXDrLJ25MMXUtUB4dZYV+TVQUc/X6xA8o+7HrjCmP4+vfrzt7tm6wB0tahblTA==
X-Received: by 2002:a63:1106:: with SMTP id g6mr36472053pgl.13.1577189369917;
        Tue, 24 Dec 2019 04:09:29 -0800 (PST)
Received: from [192.168.0.9] (111-255-104-19.dynamic-ip.hinet.net. [111.255.104.19])
        by smtp.gmail.com with ESMTPSA id 68sm25845145pge.14.2019.12.24.04.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 04:09:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 02/10] lib: vdso: move call to fallback out of common code.
Date:   Tue, 24 Dec 2019 20:09:26 +0800
Message-Id: <3D74AE31-03EA-4552-8AF7-90AA9DD65830@amacapital.net>
References: <36f1ce73-d8bc-9c46-8a2a-b6514d4a1ba0@c-s.fr>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
In-Reply-To: <36f1ce73-d8bc-9c46-8a2a-b6514d4a1ba0@c-s.fr>
To:     christophe leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 24, 2019, at 7:41 PM, christophe leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> =EF=BB=BF
>=20
>> Le 24/12/2019 =C3=A0 03:24, Andy Lutomirski a =C3=A9crit :
>>> On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>=20
>>> On powerpc, VDSO functions and syscalls cannot be implemented in C
>>> because the Linux kernel ABI requires that CR[SO] bit is set in case
>>> of error and cleared when no error.
>>>=20
>>> As this cannot be done in C, C VDSO functions and syscall'based
>>> fallback need a trampoline in ASM.
>>>=20
>>> By moving the fallback calls out of the common code, arches like
>>> powerpc can implement both the call to C VDSO and the fallback call
>>> in a single trampoline function.
>> Maybe the issue is that I'm not a powerpc person, but I don't
>> understand this.  The common vDSO code is in C.  Presumably this means
>> that you need an asm trampoline no matter what to call the C code.  Is
>> the improvement that, with this change, you can have the asm
>> trampoline do a single branch, so it's logically:
>> ret =3D [call the C code];
>> if (ret =3D=3D 0) {
>>  set success bit;
>> } else {
>>  ret =3D fallback;
>>  if (ret =3D=3D 0)
>>   set success bit;
>> else
>>   set failure bit;
>> }
>=20
> More simple than above, in fact it is:
>=20
> ret =3D [call the C code];
> if (ret =3D=3D 0) {
> set success bit;
> } else {
> ret =3D fallback [ which sets the success/failure bit];
> }
> return ret

Cute.

>=20
>=20
>> return ret;
>> instead of:
>> ret =3D [call the C code, which includes the fallback];
>=20
> C code cannot handle the success/failure bit so we need to do something wh=
ich does:
>=20
> int assembly_to_fallback()
> {
>    ret =3D [syscall the fallback]
>    if (success bit set)
>        return ret;
>    else
>        return -ret;
> }

Wait, your calling convention has syscalls return positive values on error?

But I think this is moot. The syscalls in question never return nonzero succ=
ess values, so you should be able to inline the syscall without worrying abo=
ut this.

>=20
> Also means going back and forth between the success bit and negative retur=
n.
>=20
>> if (ret =3D=3D 0)
>>   set success bit;
>> else
>>   set failure bit;
>> It's not obvious to me that the former ought to be faster.
>>>=20
>>> The two advantages are:
>>> - No need play back and forth with CR[SO] and negative return value.
>>> - No stack frame is required in VDSO C functions for the fallbacks.
>> How is no stack frame required?  Do you mean that the presence of the
>> fallback causes worse code generation?  Can you improve the fallback
>> instead?
>=20
> When function F1 calls function F2 (with BL insn), the link register (LR) i=
s set with the return address in F1, so that at the end of F2, F2 branches t=
o LR (with BLR insn), that's how you return from functions.
>=20
> When F2 calls function F3, the same happens, LR is set to the return of F3=
 into F2. It means that F2 has to save LR in order to be able to return to F1=
, otherwise the return address from F2 into F1 is lost.
>=20
> But ... thinking about it once more, indeed fallback means doing a syscall=
, and in fact I realise that syscalls won't clobber LR, so it should be poss=
ible to do something. Let me try it.
>=20

With that plus assume that nonzero return means failure, I think you should h=
ave all your bases covered.=
