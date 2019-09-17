Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D21C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C020321848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 22:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HaliTMsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfIQWoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 18:44:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:34667 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfIQWoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 18:44:19 -0400
Received: by mail-vk1-f194.google.com with SMTP id d126so1117884vkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yY07VfqUgX4my5EZpAWIwf+BIxT48gqw0QDDJNjm3OE=;
        b=HaliTMsv7+naeIldZcwaeYFI3ASWOOEZ+iVfiE+zXqfOwF2PeRU1PUIAAiOFW8G6ez
         138IgTrtwWE7gXmnn5/EgNJRgYNI9CrCX1n/yj5llJwvOEPYmc9hB9z1w3YHTUzHCwVJ
         VDrwuZCP+zF+4+YGQUXe0+4JzxAZ/m/KVsOkSHiEjrfCl7b+P6ikuQvSLyfTOvoDtZvV
         /1PR/PX/hMqOlMIUXCbdFUAW+wlCC1vu2SBUR14cJY47dIRiKw3O2jxZtLhdqUlhXTPj
         msss/IQ5cziXuodxv/npmNRMB42UgEw/PF2a7RONdR0MT33Tb0m9xPikN3dQxStyWsM+
         gm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yY07VfqUgX4my5EZpAWIwf+BIxT48gqw0QDDJNjm3OE=;
        b=Y052zx2J3gMFPhX4E5ux5jP2IiUZJok55rYUSyhyzsDUPjP1Kuhgq2Z7sawElLSXCw
         8qSQIdh178rW1kNjPGBXD9StMbiuUkvtLcHHG93GG8BlMoBoj6Sw2igAOf1Y7ZP3P5uc
         HEXmy+cbwzxSnOcAST1cZeC9Y3z/uR2/RgUMGHyqU87EJHhB6C3/rGmXTK8e/UyEcdTy
         JFFVirDXy1ravdAijhLF+v+rV5xVITHTAOJYF015mmyy34f2MRXxX8QPCTbzI8qCmWjY
         0OiGzaQWf4tPbMjujem9jeQQGs5WIyLciqLIKGpqGc3vNHFD+XNY+dvGl5SRdyIxRjQU
         Tx2A==
X-Gm-Message-State: APjAAAVD1b0jGdMSsNY3ooDPEVIBaGk/WabQF9NupfOqFWDuekmJg1/X
        7dm45rBCPHgOxm0ZXqX848kogJDIdznxV6HOY4NSlg==
X-Google-Smtp-Source: APXvYqwinJY/WYX4Ib6pQtvbPlH/IUpq13Z9Ssi6Fkuq1LKDBfCJTkrvG2sbfabwmX4m/V91A211m45yefarHdPCri0=
X-Received: by 2002:a1f:b6ca:: with SMTP id g193mr608323vkf.70.1568760258060;
 Tue, 17 Sep 2019 15:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20190913210018.125266-5-samitolvanen@google.com> <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com>
 <CABCJKudjb7FzsM1iXukOqgcXuC31YkH1inBmFME5msbZ=jh4+Q@mail.gmail.com> <E577F06C-C48E-4633-9D9D-4535B315D304@amacapital.net>
In-Reply-To: <E577F06C-C48E-4633-9D9D-4535B315D304@amacapital.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 17 Sep 2019 15:44:05 -0700
Message-ID: <CABCJKufLKfd9RjtdAjCN4eccVhL1ztTOAc2nX4D+zzPhvM_c9g@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: fix function types in COND_SYSCALL
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 5:28 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> Ah, I get it. Doesn=E2=80=99t this cause a little bit of code bloat, thou=
gh?

A little bit yes, a few extra functions for syscalls that are not
otherwise implemented.

> What if you made __x86_ni_syscall, etc (possibly using the *DEFINE_SYSCAL=
L0 macros) and then generate weak aliases to those?

That would be convenient, but COND_SYSCALL is used in kernel/sys_ni.c,
and we can't create an alias to a function defined elsewhere:

$ cat test.c
long b(void);
long a(void) __attribute__((alias("b")));
$ gcc -c test.c
test.c:2:6: error: =E2=80=98a=E2=80=99 aliased to undefined symbol =E2=80=
=98b=E2=80=99
 long a(void) __attribute__((alias("b")));
      ^

Curiously, when we use inline assembly to create the alias (similarly
to the current cond_syscall), gcc just quietly drops the alias if the
function is not defined.

Sami
