Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9512CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B9F20692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 23:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nvjj2M1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfIMX24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 19:28:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41579 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMX24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 19:28:56 -0400
Received: by mail-vs1-f65.google.com with SMTP id g11so19373074vsr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ByWKtpvQqUKKvg1jiX3mJ0tx0yCgkYQnklhIV6UCr+Q=;
        b=Nvjj2M1kY4o9x04H82VV1kfGtBWY77i5j95acGyNGiYlvKU9WiTHN+u1d1oqGmVOnV
         gZQHFNNnioWNYDmpXf3lBtVIlKU3r4Gp5O6bece1yjI7h1PCOgpvy7WalBD8C4Hn9ReK
         UWIy5/CVg5YkPswKr+jOQWIrB9tD341sq3DQScSpnmBx+r3Dr4fW8jriqFUAdWkNOLUs
         UxSDaPJgqTSYfwh1zqNCFh8KCXyardbwCMg4szE3cnI0pl4jPueqqomtFq4Ez0BZ/cy2
         XP/epAXZ9uY1dMGIII90dIhsioOxLOfZ2Ua9QXzyU9ypynei+UOpF63YHkrJAwCNA3Nx
         BqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByWKtpvQqUKKvg1jiX3mJ0tx0yCgkYQnklhIV6UCr+Q=;
        b=MNc3wQF6su4Y99C3rvQAT+O/JUTX7VIsY76P7xDQVlYrsYy5CVXWOwYClBhL7N6RVk
         mm5USmu7H5GutE2LDDT3QBoxsaZOQbV9q8CBKX+QseJ1UTW6PLNukWUC0egchEQkgfel
         N2afsOCGsVtvIRtTyGC95uGFDelCotrVQ1Pf7AtvRxwVepc0OXCa35GmUmBTwSZK1sL3
         qUGmikCI83TdPT9CG4inwpFfczj+pxJnYjtfR1wqmkwPShk7PjGszCRT7ra9eVs3Unxz
         kfMMI3D/c0+dAFWYMPp8YqyyAysMU9vZCmY/Oa01XOAffI1IQO5exPp0Z0Wju44mF/0q
         KFjQ==
X-Gm-Message-State: APjAAAWKCQkQNYVTRr9cv0BpsJGCKiPcRq5BYXMWTcHlszTj7nSMfgiI
        C/rVfQ6B4QMIUl46cLVa/MXmoFYno4Rni7WyBdVzaw==
X-Google-Smtp-Source: APXvYqxC7zFSr7TqheMiuOR5Uk6bhUaCanKa0PZgaXJue6LEfqPtqLgLxeg0TLq69SYWb4m4J08dAzStHWwKt3Xpp+I=
X-Received: by 2002:a67:e219:: with SMTP id g25mr28195491vsa.112.1568417334723;
 Fri, 13 Sep 2019 16:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
 <20190913210018.125266-5-samitolvanen@google.com> <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com>
In-Reply-To: <CALCETrXVVB4xP2Vv-BsvELsViamjgi-ZccPhOEP2sMxBZ4dyBg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Sep 2019 16:28:43 -0700
Message-ID: <CABCJKudjb7FzsM1iXukOqgcXuC31YkH1inBmFME5msbZ=jh4+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86: fix function types in COND_SYSCALL
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:46 PM Andy Lutomirski <luto@kernel.org> wrote:
> Didn't you just fix the type of sys_ni_syscall?  What am I missing here?

The other patch fixes indirect call type mismatches when the function
is called through the syscall table. However, cond_syscall creates an
alias to the actual sys_ni_syscall function defined in
kernel/sys_ni.c, which still has the wrong type.

Sami
