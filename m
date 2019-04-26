Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFDFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F21E206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNNMfOjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDZOaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:30:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39214 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfDZOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:30:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so1721039pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1+CcfaeA5cndPo10X2D8Z3LRtIWeGy3NIk3ykbCnms=;
        b=cNNMfOjfndrXKTFjgV+Q9wj/+PpYSS1CcVQPSJaYbBSpVybLgs2sdYyqJsKkzUIFFE
         HHRXh7W7IUUPTTaimKU0pSnNhXfD4vlZC9n3d2KoqfJSi3ChG3SrxUVxwSIFe3ixVxlH
         h6XfdRNaGBp1P7355ybonLr1V0bv6dMX6zRSVOSJe0XgIArt8CUzQBWi3w8eXIlFa3vF
         Ys0ZzpPVebND13PnaHp8jHiNsF7dIJ0w5sHaqqDTiw/pwXD7QZvOhBXoUFEFAKACDYk+
         b5s2mxi4dRT13q98ddejBvTlo/SxhX8x+bpGUAmj3yIQm0gNhHxNWfgu5jgYPpyodhRp
         3jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1+CcfaeA5cndPo10X2D8Z3LRtIWeGy3NIk3ykbCnms=;
        b=RHUnQnhU4a75TJmRME5QSeE5xtSw24pxboJnsv3xP+25xCRmwBl2qGeKJwYpseMUIo
         iFURYbF8JzfDDqfF7J3q+YoE+zaihGtzadmEjfUruAvmZ8y89wPBb0jRqVT6cX3cIQf1
         8kG71uOtKfPK8LhOvtzXzx08w7y0sqcArotaoi9riH4XdI039DwNXbkIsw997IWx5aI1
         kFNvWLcV+fuBtWaCsVqJAIpbprgAn1o9+FXWHm9wuelxo60QAhDCnmqJRJxAPQ4R95eK
         j93ErEX9L77ue6ZZxjTQXdOTZ8PvKnJWaSxpeEtFgBdsdQI6jPZd17hEv6Z24bZMdstu
         xuYQ==
X-Gm-Message-State: APjAAAUpfPqsUHsU/kiTeXxF5L+ymVxdsxTcv7iroGlcG2B061Wu4OMH
        6UZeS83bzJRf75atXIbb153rDG/5+q00rK4kAyJzrg==
X-Google-Smtp-Source: APXvYqyBwQ++728Ta+TCBYlekvvSelBJQpoJb6GVE/PvFnS2Z7Z0aUAb3KeRFuBAoikipYLbNeaUY4YI5HStE5Km0wY=
X-Received: by 2002:a63:e850:: with SMTP id a16mr44282265pgk.195.1556289017748;
 Fri, 26 Apr 2019 07:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190426155653.2cdebc5d@canb.auug.org.au> <20190426062548.GB5920@kroah.com>
In-Reply-To: <20190426062548.GB5920@kroah.com>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 26 Apr 2019 07:30:06 -0700
Message-ID: <CAO=notwQFWRVDtoH+NGWpm647pJHVFvVoPm3EKdKmdrRUmDZqw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the char-misc tree
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:25 PM Greg KH <greg@kroah.com> wrote:
>
> On Fri, Apr 26, 2019 at 03:56:53PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the char-misc tree, today's linux-next build (x86_64
> > allmodconfig) produced this warning:
> >
> > drivers/misc/aspeed-p2a-ctrl.c: In function 'aspeed_p2a_mmap':
> > drivers/misc/aspeed-p2a-ctrl.c:110:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
> >   pgprot_t prot = vma->vm_page_prot;
> >   ^~~~~~~~
> >
> > Introduced by commit
> >
> >   01c60dcea9f7 ("drivers/misc: Add Aspeed P2A control driver")
>
> Patrick, I thought you fixed all of these already?  Can you send a patch
> again?

I fixed the ones caught by the robot.  I'll have to switch up my build
environment a bit to fault on warnings for the kernel, not sure why it
isn't --

>
> Can you also make the driver so it can build with CONFIG_COMPILE_TEST
> enabled so that others can find your problems earlier in the review
> process?

Roger that.

>
> thanks,
>
> greg k-h
