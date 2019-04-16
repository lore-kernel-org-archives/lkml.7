Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B896DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9043120675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbfDPJOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:14:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43167 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfDPJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:14:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so22410671qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 02:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vi8vuKV7FF8LFTD9Ed1q0g3vJ+6TdGMNWOak7k27ocw=;
        b=UO9SMGCYcZON5XfHQrhuCCmBRHROfS6/rVD3+zSUmjiH5WKM6IT7OdYpara7e31XIQ
         gA2JgUUhsFLOKQIIPWfVQ42C3VXwbiWH1uKBXzmHikYZERNOOl8jNJaPvUE/53qW6iBs
         cJX2rwJsBVQijfXDWJgEueshtLVVLWfxzofs6Rk8trpgApIyPcf6rjPvn70XO4uk+R/K
         8sYz+RKLhdOD+s2F6AjLt86s2yzq1Whd5H0mRg87BsIwKv+bFp237YIejaJPiILCJct9
         wNFh9O2ZBDr0+ArQr9hHyDCsrqkrkNc+hzECKcolCN2oWrLMTlLRiITswbui+qDBaZ8h
         HqqA==
X-Gm-Message-State: APjAAAVkjfswSytssnoqKj/TevPbzAcWR60gQiJt8/ACJ3P3UNJAuvmk
        7EYcNhskIFaTobXFVpPhDutmLu3IxRaMD++LR18=
X-Google-Smtp-Source: APXvYqxBgx0waGInw/ldbLgtjJ6hQ+aCQTBhF5b2AEyGf3wzgfednKCZAjxE18Nwx9qmdfNUADRi4CA6wrnArVoO+hY=
X-Received: by 2002:a0c:93f2:: with SMTP id g47mr62680310qvg.22.1555406092667;
 Tue, 16 Apr 2019 02:14:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190416172937.6a7621f7@canb.auug.org.au> <CAK8P3a31Cp_COwjuOm6uG_23M3Ys4tJTB33jBENj-so0jkhgzg@mail.gmail.com>
 <20190416185327.5c129073@canb.auug.org.au>
In-Reply-To: <20190416185327.5c129073@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Apr 2019 11:14:36 +0200
Message-ID: <CAK8P3a2UsBYw4CVVt4Fh0NMP+sE6kQuKZ99XXpYYurYSgK2Asg@mail.gmail.com>
Subject: Re: [PATCH] kernel/compat.c: mark expected switch fall-throughs
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:54 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 16 Apr 2019 10:32:55 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > We could also consider just getting rid of put_compat_sigset() and
> > get_compat_sigset() but replacing them with a combined
> > put_sigset()/get_sigset() that does the right thing for both native
> > and compat tasks. This lets us kill a couple of compat system
> > calls that only differ in their sigset_t argument. On little-endian
> > systems (which are the vast majority of the installed base), there
> > is no difference anyway there is no overhead anyway since
> > native and compat sigset_t are identical.
>
> That sounds like a bigger patch that would require some real testing :-)

Yes, definitely. I mainly mentioned it in case someone wants to
do that work anyway, as it would avoid the need for your patch.

      Arnd
