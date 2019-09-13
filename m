Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF9C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86DF92089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Muma7wU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbfIMO0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:26:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43465 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIMO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:26:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so20649269qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azm0iCcEcLT4hP2ezLX9IH/CNTQYVbzbUpSdpFDhS6M=;
        b=Muma7wU7xrn/3eoODqlVRvCuiNodQ0jM/YGuZk17KRlQ+sXHjloLKgfJuARAKNbttw
         ZXWX5nRBYXbMxq6E6UZ7fr7qQd7PA/We79kui5sa00OB1/hT0wkY1lHtAiyJAnq7wN58
         PpC3YvxEID2w1Zc5e7igg13PT9Pslth2O5xmJc4pOdjYr7j/Ux5rLWkxX6CJnc2nxOkj
         uZMZX3jxegkn/5eyV1O2o2Y4AgCto/eztbIswtSKZY6UkZHPbRAJ5Y9LsNt+lBAOhWxd
         xOuuCttfM+CTc5sZpQXgU6mqEbpc4cryUInczp8jAPHv37yiwotDtlI2NtYpu8/HC431
         kjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azm0iCcEcLT4hP2ezLX9IH/CNTQYVbzbUpSdpFDhS6M=;
        b=fI1ht1wssSLiy/Ll3cUE4u5YaqsclMV5kJDFXlMnNKZH/9grZL8BUBc7r2d1vp0rAp
         Ql3brCxJJ6OmNvL3/b223yhLX3Q7SAz5RXeq/VcyyRGEbF+GXx+s5rwSd+i20OAXlLbv
         9ijyoNyonqHRqqMX5QkgdSHkZYP3SJ65o4i6evZfBX01/3rg1d/38/XBrkvvrbI07DhW
         aMTqEYEB9hvjq6KsN7m52D8dOrGw36LQ8BIf0TlBpGb9MeHmQ+ZcbvdgtnJRNJitg9Dx
         opoQ0EYa1PaM7F+8x7ACTxaWml0lcHWOD7wgbE/FpMWCh7PhAgCIZfxc4LDpN5kW/VPJ
         z1vQ==
X-Gm-Message-State: APjAAAW4wCPCLLCmS9tNLYIlqdyBTS/GB2PVin7VlLJ8nkRc17Qq1kXF
        apINPsBbZ5FTWWxQtTXkmsRWGfCd+o7iL0QxBg==
X-Google-Smtp-Source: APXvYqwvIEmEHGdQDy+6TCnCkxmg7LX7EPhqfEAWQyNuhuySpaCg+l4qKRkviip5T5jA3ejq1Vb8Wt7RAKKyifcMyoQ=
X-Received: by 2002:a37:8905:: with SMTP id l5mr47165423qkd.152.1568384789630;
 Fri, 13 Sep 2019 07:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org> <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
In-Reply-To: <4299c79e33f22e237e42515ea436f187d8beb32e.camel@perches.com>
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 13 Sep 2019 15:26:18 +0100
Message-ID: <CAL_JsqJju36BZPK6DJab28Ne-ORpEyPpxH0H4DuymxFMabpMRQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To:     Joe Perches <joe@perches.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 3:12 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-09-12 at 13:01 -0700, Bart Van Assche wrote:
>
> > Another argument in favor of W=1 is that the formatting of kernel-doc
> > headers is checked only if W=1 is passed to make.
>
> Actually, but for the fact there are far too many
> to generally enable that warning right now,
> (an x86-64 defconfig has more than 1000)
> that sounds pretty reasonable to me.

It's in the 1000s on arm because W=1 turns on more checks in building
.dts files. There are lots of duplicates as most of the dts content is
as an include file (e.g. board dts includes soc dts).

We could shift the dts checks to W=2 (and what's enabled by W=2 now to
3) I guess.

Why not just promote what doesn't give false or still noisy warnings
out of W=1 to be the default?

Rob
