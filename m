Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EE6C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CAA2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="tsPo2G7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbfINA2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 20:28:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34119 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbfINA2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:28:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id b128so175418pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 17:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NhResPHYpP/yD3FC59wZU8T2o/WD8zkKy81BphaMHGY=;
        b=tsPo2G7qPhUMN1GHLYb3GBYUf0TykP2AIuJHtThMvgCMQTL7f4KBIK2x9vyObnXBxU
         faNocgNcD8J8DZo8IpWost4dv6WY388zXivFpweU4Tik8V+uQgi0bW8Bq7EdyXjfE5UB
         zVLRqVxviFk2JsartqxT32sO6afsW3SgtVK0yGG+1wz+m9uTwlOK3otqXD2tk/dBIKqe
         BXixY50EgsKppXs+a0yh1P08/nLHcye7iI2oNmBmyycgEYE/JnBQppGhb6LABS4LrJd6
         vQwIRBhhJP3yR+vWgvGvwScP8dOeIaL3R5FjDLOO4ke1lsNy7YdfSsabOWEWRsXucoaN
         E8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NhResPHYpP/yD3FC59wZU8T2o/WD8zkKy81BphaMHGY=;
        b=ZlX2oSaJ7PJZTLUxycuG+iNn6YdcFgRvxHKIPq8BCCVrxBEJFcNWcfXrLZdTQ/k9lg
         fg5/BZwpX+6VcIiXtPZMRKfQQu+BLhG6CwGegSJneESPQu9PBRaAlIg6rmP1sB8fT7Wm
         nwTU/bQl/FujjZb905ydTigOgcaDZaJ6vpT+slCecOc6pN6NPSwQMGcOndnp0ztuR4Cg
         G5r6h29BWx1wlheTWxLhXgKhQN8LhHINo1kC6/w9K+hqCAsjvlM2Nccc41NfRBKw48HJ
         GNc61XSmJX+ccUYESWXkiokcs3faf0jupZKp+Zup/cvOxv/zH/b+n+dEagm0O3ddCk/j
         OUaw==
X-Gm-Message-State: APjAAAWpl5qETHqF311xRv2OWXj9im71qVVoCYiXypmcFG/KvnbaFLif
        M2k04xPAmU1juM/8fpy7VplmAQ==
X-Google-Smtp-Source: APXvYqxRdEtyOggi3lBxFgMVnejYnGLR4WaPjsL6p5iDa27kkB1uFFU0uXGAKdDKpW9bcOHYjjS81w==
X-Received: by 2002:a63:5c06:: with SMTP id q6mr46177252pgb.45.1568420933196;
        Fri, 13 Sep 2019 17:28:53 -0700 (PDT)
Received: from ?IPv6:2600:1010:b020:48a9:95f9:675c:ced:7824? ([2600:1010:b020:48a9:95f9:675c:ced:7824])
        by smtp.gmail.com with ESMTPSA id o22sm2602170pjq.21.2019.09.13.17.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 17:28:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] x86: fix function types in COND_SYSCALL
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16G102)
In-Reply-To: <CABCJKudjb7FzsM1iXukOqgcXuC31YkH1inBmFME5msbZ=jh4+Q@mail.gmail.com>
Date:   Fri, 13 Sep 2019 17:28:51 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E577F06C-C48E-4633-9D9D-4535B315D304@amacapital.net>
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-5-samitolvanen@google.com> <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com> <CABCJKudjb7FzsM1iXukOqgcXuC31YkH1inBmFME5msbZ=jh4+Q@mail.gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 13, 2019, at 4:28 PM, Sami Tolvanen <samitolvanen@google.com> wrote=
:
>=20
>> On Fri, Sep 13, 2019 at 3:46 PM Andy Lutomirski <luto@kernel.org> wrote:
>> Didn't you just fix the type of sys_ni_syscall?  What am I missing here?
>=20
> The other patch fixes indirect call type mismatches when the function
> is called through the syscall table. However, cond_syscall creates an
> alias to the actual sys_ni_syscall function defined in
> kernel/sys_ni.c, which still has the wrong type.
>=20

Ah, I get it. Doesn=E2=80=99t this cause a little bit of code bloat, though?=
  What if you made __x86_ni_syscall, etc (possibly using the *DEFINE_SYSCALL=
0 macros) and then generate weak aliases to those?=
