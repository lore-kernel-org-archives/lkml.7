Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A120C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C542085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfCGVpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:45:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41291 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:45:45 -0500
Received: by mail-qt1-f194.google.com with SMTP id v10so18999186qtp.8;
        Thu, 07 Mar 2019 13:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jX2cnA1OI5IjfRzrp+mz2kZbtYib9CVIt/eVBfS7yqg=;
        b=RTq9rWw9GZ4IAYsMMAPD/AxLT8SG87RMbCT0/rQtaQnk1xELWkN+w6sDTxbIQ8LKkH
         KhchfQUhszuplmR0zsyix4iItS+XpkaOvcOlSpv2sSdlrRzVWG/ZGxRj5XBBNROAZ3RE
         nkGQZvVlBytaGcRGijwJNZ/xSlKd8oU66/GD/C77FTHZ3ha8gCh2nG+hcrrjDMgUSCvT
         20i5eNTgSPYEcXakStNx2KkD25mOnP+j8N1Dnf4muAihDA1H5mjnZZm8/Tes0t8+o82Z
         69844W+NX5QjuC4i3WP4qu2wbo/uqw6AnjS5v8cAEKORkCaZN2Qa50+/2ZsFZEdeHqSC
         hmtA==
X-Gm-Message-State: APjAAAW0rrpeL1GdtEs1muPXvk5MoCJ3rezEZxHs20ShzRIpNeWuYJF9
        obc8RlhaBzKJ46rex+WAP5vdDCiQ0dB3d4ZIiKg=
X-Google-Smtp-Source: APXvYqymLqHDMEhXA3CdXYdlf/HEsxZEPAbIc+v0T0WAIjQ3j6/wiEI6HYD0UofG0h6Pas2HuvCdXjRF7zgPOC3SSb4=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr12241157qve.180.1551995144004;
 Thu, 07 Mar 2019 13:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com> <20190307164647.GC25101@redhat.com>
In-Reply-To: <20190307164647.GC25101@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 22:45:27 +0100
Message-ID: <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 5:46 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 03/07, Arnd Bergmann wrote:
> >
> > We could use % everywhere,
>
> Yes.
>
> But again, why not simply use the "for (;;)" loops? Why we can't kill the
> supid switch(_NSIG_WORDS) tricks altogether?

I'd have to try, but I think you are right. It was probably an
overoptimization back in 1997 when the code got added to
linux-2.1.68pre1, and compilers have become smarter in the
meantime ;-)

Also, the common case these days is _NSIG_WORDS==1, which
is true on all 64-bit architectures other than MIPS64.

      Arnd
