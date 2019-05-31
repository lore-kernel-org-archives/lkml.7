Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F82C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56898242AA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 21:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfEaVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 17:03:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42706 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEaVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 17:03:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so7219318qkc.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 14:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQZ0tC9yXzl9rq7qJxkFQdwUp1Ynzm5ICs3cFZoG4PE=;
        b=sXFrMD6MNJljMSj06xwM0AC0gCdQ77bdCIoGk2FGYSbXEmeWXR5pF3ka2gHXy6HVzG
         NWu6xLSKtQiaw14KaA/u8bpqlgkLQ5cxlg5VsfH2+vZfa6DNg4//z+WT3lMPkNG0wcUw
         TWRIpNy/n4L3IxtN8fe8V1v2zVB2UM9lTQWXCYuzlvzjS8s4gLn4zUkUtV3Xh45or/Gh
         9S5Zq2//Nf/NADsCHnrxh/LnRMP0MdVWVXs0pxo/ZHpPeZkTLD+Dy6WYG0ic7GOEP3K8
         wlGcOQ5qLnrCNfg9Wn7JoauoXep5Km7jQVejBwKKNimNFS0HsU+1Uu87AVPEUo928ZtO
         ZqeA==
X-Gm-Message-State: APjAAAUU8eOpnz5didPGP6FUBSkquzohvTmcbizPXwEquzcTtN7lG3cX
        OtWFS1wqD5sRJMZX3OfMbpOEjF9J4PNeZZpjz+M=
X-Google-Smtp-Source: APXvYqw8Gt47Ss6yAe0Fk1e2jy5O2gFmZjTyn0v1L+cc305iz0lTO6/jzCFIjXMHxhM13pygLVcfPpesJv5MlWJHBao=
X-Received: by 2002:ae9:e608:: with SMTP id z8mr1640546qkf.182.1559336616255;
 Fri, 31 May 2019 14:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
 <20190531183227.GA34102@archlinux-epyc> <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
 <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
In-Reply-To: <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 23:03:19 +0200
Message-ID: <CAK8P3a2pYp6aaOSrtHKbVW+hPbwgj1An6dWNd-YLJyR5otvU-A@mail.gmail.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:06 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Fri, May 31, 2019 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > clang, I would suggest dropping your patch then, and instead adding
>
> I disagree.  The minimum version of gcc required to build the kernel
> is 4.6, so the comment about older versions of gcc is irrelevant and
> should be removed.

Sure, that's ok. It just feels wrong to remove a warning that points
to a real problem that still exists and can be detected at the moment.

If we think that clang-9 is going to be fixed before its release,
the warning could be changed to test for that version as a minimum,
and point to the bugzilla entry for more details.

      Arnd
