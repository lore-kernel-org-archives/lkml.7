Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD3C207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568998313;
	bh=Nyw5aGQnqiBN1bUzXu88HP2HpKPdWSNMWN8vpL0WnQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XDXkFEwuSnKeiWnKTNw/N8iF6pPXlW13Of2wtA8vzNByjUk4Dz+1U3bmZF9wKD4Pn
	 4OurTlk8geIE+vOm6NNmhJK+yuA4xlNuFZlBj7+dqHe/WTA/yV/aBu5rZa4owT19Kp
	 7EXIQnXzCwtfb3qXuhd47G9fkjHBYiGtI6nS3G3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404793AbfITQvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:51:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39982 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404122AbfITQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:51:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so7734595ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+7PTgM+rmvcNSmgpDn3Z1VM5gzT4aYWFasiNPbOBn8=;
        b=SfCpSBhMbBk4k0YZN7A/wTNcmEx3XjOb6aELxqYXCViy/ELntXAO7/OS0FK9prRUHS
         MvrUywNKZIJ9lC0Q57KVN5fqLjlisYwYqbiS9S1v57ZkC2ngx4EAHnYNviAuFarLJwAq
         SIoVtonfBBzt++dwxCTZGmuZ//kfwc51HXH3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+7PTgM+rmvcNSmgpDn3Z1VM5gzT4aYWFasiNPbOBn8=;
        b=CFfvwVQyKhxJHHpxZh7xi07TWvC3ijMgTGX64WYoy0HnJbQOSGLV7EIsUbO8d8bQVF
         ctk0hjqiuVTbOY1FgfbNKKT6zTC0eFENdFRwaF7Z6DVXyE7JfDcF0+KLxTetXZ8xd1ZK
         bnc+IKEi7tkEaxuS9Uss4LNRBaBJT09Rk1iHQwBbHiUwg+Q+mOVGBhKbHae7DG+ojJrz
         IX5NjTEkDKRjbkLQ0U1Uk5tRYZrEBxEnIowJ+XSPjUZC9V2zZThOk7Kcb62crTJrlia2
         Ka3Pc6oZU8nc2/+5WXo5q5dGoFFjrNC+8CMT9bwJ/2i6TGkIO4eP3pc3r69y+lujHkMD
         8Hvg==
X-Gm-Message-State: APjAAAWXBBr6lVGuznd0rhFz2VhBXWbs7+E+9xj63Xp0yacZVRu6BDQz
        x34pt+QOc/iX2RXUGK78Pdju8f5mCt0=
X-Google-Smtp-Source: APXvYqyCmcsnovuxGaIIHe3poPPxaWp68V+2umZ/xE4cxUJ8YD68emaZBsUTHAeXmHW+1NdE+/oq/A==
X-Received: by 2002:a2e:252:: with SMTP id 79mr2979006ljc.188.1568998308607;
        Fri, 20 Sep 2019 09:51:48 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x3sm557062ljm.103.2019.09.20.09.51.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:51:47 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a22so7790944ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:51:47 -0700 (PDT)
X-Received: by 2002:a2e:96d3:: with SMTP id d19mr465327ljj.165.1568998307274;
 Fri, 20 Sep 2019 09:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org>
 <CAHk-=wgs+UoZWfHGENWSVBd57Z-Vp0Nqe68R6wkDb5zF+cfvDg@mail.gmail.com>
 <CAKRRn-edxk9Du70A27V=d3Na73fh=fVvGEVsQRGROrQm05YRrA@mail.gmail.com> <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
In-Reply-To: <CAFd5g45ROPm-1SD5cD772gqESaP3D8RbBhSiJXZzbaA+2hFdHA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Sep 2019 09:51:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
Message-ID: <CAHk-=wgMuNLBhJR_nFHrpViHbz2ErQ-fJV6B9o0+wym+Wk+r0w@mail.gmail.com>
Subject: Re: [GIT PULL] Kselftest update for Linux 5.4-rc1
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Sorry about that. I am surprised that none of the other reviewers
> brought this up.

I think I'm "special".

There was some other similar change a few years ago, which I
absolutely hated because of how it broke autocomplete for me. Very few
other people seemed to react to it.

Part of it may be that the kernel is almost the _only_ project I work
with, so unlike a lot of other developers, I end up having muscle
memory for kernel-specific issues.

Auto-completion was also one of the (many) reasons why I hated CVS -
having that annoying "CVS" directory there just always annoyed me.
There's a reason why git uses a dot-file.

So I just have issues that perhaps other people don't react to as
much. And aggressive tab-completion happens to be a thing for me.

               Linus
