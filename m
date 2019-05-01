Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BBC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE082089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MjjlszWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfEAU0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:26:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43213 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAU0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:26:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so8644715plp.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FSF7/Ot6zFZjWolRIiiMJFDPBlKnObZA93vCGCliBc0=;
        b=MjjlszWEp2k51s+D16yH7570R3HNDO+yiKMzcb62dpX5XPDgDdEeG15uxijmnIIuy5
         ImillGZgFSmmza64MgKbel48kER2ZlyFs/DZP23HtW4UlHR0mxM5znVNc1D/F3V/Njx5
         8ZIHyc7ZyPMTidQXW0V+pBm8owats8Kc5RQKfAVWyCvogJ364QdWd+fRiJcbhAp04wHu
         ACLaDJ5v0ftNPNcxQaZ0rXzJjzl1Z/69Hvm+XTEtjYtC7fgkUpZ1P/azGVkbbaIOuzId
         W11gXkjcBUD9t10LEUlXDae9Jj40OSlmO07pAeg6WbZKOgnKHtaEFAwSCIY0T4X0pmm8
         APCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FSF7/Ot6zFZjWolRIiiMJFDPBlKnObZA93vCGCliBc0=;
        b=jIm/ffBNUtnqU0WdWiyLKUYfx7a0ixgRrSoN091PIhpcwS+XvKFACac2SfHUqYVuvN
         wdamfBI3E1BNEHmtnVsXVk1s5lCQXcqTAAGc5hyWhkpXwq8HtrXMVaAODXFLVRB9K5G+
         eYwKbQ9MMS0iUUX/177VVwVdV7h91eyOl6WDO7viXUvKu1pqzyi+6+VlPomuX1kQujlT
         Vh1vlq33vUEOULlH/Edea/Rxp413Ok562JsS3qkFl496qEGZ+/fdVczkJU8b1Xz+w3WK
         1fioGKyXE+G8Sr3RQDFLR19xMttXnfjszZtpZVgJRr3MbkfIehjFJ5DmRWYGphHqNyyt
         Z2Hg==
X-Gm-Message-State: APjAAAWZSuNFTpIAVY2lEugaTh1l41mspC83wAqm9PCv1Qw8M5db0nC+
        Q1RE83hKN46NQZEWFphxTBWVeQ==
X-Google-Smtp-Source: APXvYqzqjNu0ar3TFQIFklzr0BY7iNG3G/s5ef5npkmzvIdTAgTtyPgqVuqgzdhsJosGB5STBwEuqA==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr76569541plf.327.1556742359199;
        Wed, 01 May 2019 13:25:59 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02a:b64e:1024:4224:172b:986b? ([2600:1010:b02a:b64e:1024:4224:172b:986b])
        by smtp.gmail.com with ESMTPSA id 128sm47662235pgb.47.2019.05.01.13.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 13:25:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base as GSBASE at the paranoid_entry
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <7029A32B-958E-4C1E-8B5F-D49BA68E4755@intel.com>
Date:   Wed, 1 May 2019 13:25:56 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2863FA6C-F783-4322-9A01-4A2B8A7817A3@amacapital.net>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de> <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de> <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net> <C79FA889-BD9B-4427-902F-52EE33A3E6EF@intel.com> <CALCETrV4zACb9L_FaU12ZF1O6_vjVyGrcyWwk-mfSUhyxGMXJA@mail.gmail.com> <0816B012-44E8-40FB-8003-33C4841CD0E1@intel.com> <7029A32B-958E-4C1E-8B5F-D49BA68E4755@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 1, 2019, at 1:21 PM, Bae, Chang Seok <chang.seok.bae@intel.com> wro=
te:
>=20
>=20
>>> On May 1, 2019, at 11:01, Bae, Chang Seok <chang.seok.bae@intel.com> wro=
te:
>>>=20
>>> On May 1, 2019, at 10:40, Andy Lutomirski <luto@kernel.org> wrote:
>>>=20
>>> On Wed, May 1, 2019 at 6:52 AM Bae, Chang Seok <chang.seok.bae@intel.com=
> wrote:
>>>>=20
>>>>=20
>>>>> On Apr 5, 2019, at 06:50, Andy Lutomirski <luto@amacapital.net> wrote:=

>>>>>=20
>>>>> Furthermore, if you folks even want me to review this series, the ptra=
ce tests need to be in place.  On inspection of the current code (after the d=
ebacle a few releases back), it appears the SETREGSET=E2=80=99s effect depen=
ds on the current values in the registers =E2=80=94 it does not actually see=
m to reliably load the whole state. So my confidence will be greatly increas=
ed if your series first adds a test that detects that bug (and fails!), then=
 fixes the bug in a tiny little patch, then adds FSGSBASE, and keeps the tes=
t working.
>>>>>=20
>>>>=20
>>>> I think I need to understand the issue. Appreciate if you can elaborate=
 a little bit.
>>>>=20
>>>=20
>>> This patch series gives a particular behavior to PTRACE_SETREGS and
>>> PTRACE_POKEUSER.  There should be a test case that validates that
>>> behavior, including testing the weird cases where gs !=3D 0 and gsbase
>>> contains unusual values.  Some existing tests might be pretty close to
>>> doing what's needed.
>>>=20
>>> Beyond that, the current putreg() code does this:
>>>=20
>>>  case offsetof(struct user_regs_struct,gs_base):
>>>      /*
>>>       * Exactly the same here as the %fs handling above.
>>>       */
>>>      if (value >=3D TASK_SIZE_MAX)
>>>          return -EIO;
>>>      if (child->thread.gsbase !=3D value)
>>>          return do_arch_prctl_64(child, ARCH_SET_GS, value);
>>>      return 0;
>>>=20
>>> and do_arch_prctl_64(), in turn, does this:
>>>=20
>>>  case ARCH_SET_GS: {
>>>      if (unlikely(arg2 >=3D TASK_SIZE_MAX))
>>>          return -EPERM;
>>>=20
>>>      preempt_disable();
>>>      /*
>>>       * ARCH_SET_GS has always overwritten the index
>>>       * and the base. Zero is the most sensible value
>>>       * to put in the index, and is the only value that
>>>       * makes any sense if FSGSBASE is unavailable.
>>>       */
>>>      if (task =3D=3D current) {
>>>       [not used for ptrace]
>>>      } else {
>>>          task->thread.gsindex =3D 0;
>>>          x86_gsbase_write_task(task, arg2);
>>>      }
>>>=20
>>>      ...
>>>=20
>>> So writing the value that was already there to gsbase via putreg()
>>> does nothing, but writing a *different* value implicitly clears gs,
>>> but writing a different value will clear gs.
>>>=20
>>> This behavior is, AFAICT, complete nonsense.  It happens to work
>>> because usually gdb writes the same value back, and, in any case, gs
>>> comes *after* gsbase in user_regs_struct, so gs gets replaced anyway.
>>> But I think that this behavior should be fixed up and probably tested.
>>> Certainly the behavior should *not* be the same on a fsgsbase kernel,
>>> and and the fsgsbase behavior definitely needs a selftest.
>>=20
>> Okay, got the point; now crystal clear.
>>=20
>> I have my own test case for that though, need to find a very simple and
>> acceptable solution.
>>=20
>=20
> One solution that I recall, HPA once suggested, is:
>    Write registers in a reverse order from user_regs_struct, for SETREGS
>=20
> Assuming these for clarification, first:
>    * old and new index !=3D 0
>    * taking GS as an example though, should be the same with FS
>=20
> Then, interesting cases would be something like these, without FSGSBASE:
>    Case (a), when index only changed to (new index):
>        (Then, the result after SETREGS would be)
>        GS =3D (new index), GSBASE =3D the base fetched from (new index)
>    Case (b), when base only changed to (new base):
>    Case (c), when both are changed:
>        GS =3D 0, GSBASE =3D (new base)
>=20
> Now, with FSGSBASE:
>    Case (a):
>        GS =3D (new index), GSBASE =3D (old base)
>    Case (b):
>        GS =3D (old index), GSBASE =3D (new base)
>    Case (c):
>        GS =3D (new index), GSBASE =3D (new base)
>=20
> As a reference, today's kernel behavior, without FSGSBASE:
>    Case (a):
>        GS =3D (new index), GSBASE =3D the base fetched from (new index)
>    Case (b):
>        GS =3D (old index), GSBASE =3D (old base)
>    Case (c):
>        GS =3D (new index), GSBASE =3D the base fetched from (new index)
>=20
> Now, with that reverse ordering and taking that "GSBASE is important" [1],=

> it looks like to be working in terms of its base value:
>    Case (b) and (c) will behave the same as with FSGSBASE
>    Case (a) still differs between w/ and w/o FSGSBASE.
>        Well, I'd say this bit comes from the 'new model' vs. the 'leagcy
>        model'. So, then okay with that. Any thoughts?
>=20
>=20
>=20

This seems more complicated than needed.  How about we just remove all the m=
agic and make putreg on the base registers never change the selector.

As far as I can tell, the only downside is that, on a non-FSGSBASE kernel, s=
etting only the base if the selector already has a nonzero value won=E2=80=99=
t work, but I would be quite surprised if this breaks anything.=
