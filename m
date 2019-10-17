Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9AECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A4721835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571334782;
	bh=LCVxvydkAL0erKf8wbZjT7cWO6Exfx+iCpuz+gWiuNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EC5kC6lND9CROi/hP1t8aenlGFhDOl4JhorIpRg9JDTgnN84EBkkYejFdS9cpP8SU
	 AIv0UiOUv/Xw2HxtkBcIiGOOSBxx29fq/iw3AVKGQZMqWliVmMaf0vyMmNIgaSaZXs
	 pSpe4MNduYtQpYt6bl49kkys9C66+0wYTakx3wr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437203AbfJQRxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436896AbfJQRxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:53:00 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898D921925;
        Thu, 17 Oct 2019 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571334779;
        bh=LCVxvydkAL0erKf8wbZjT7cWO6Exfx+iCpuz+gWiuNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JdkWoRS5zqqKWgMSt0vhEglBorlpT3guThhG436+of7EfeSVXeopU7hsBkjYzXWzr
         UyaA6vZekSS5mBdnCz/qUJ1FIOT/JXQFeSDEXhtIu+K+q9rNBAW6zfD9f0LC8fBrQ+
         24a4GmshL3QpW7GJ+Zr0fCDy4rjYmC7isFyhyUT0=
Received: by mail-qt1-f178.google.com with SMTP id c21so4800894qtj.12;
        Thu, 17 Oct 2019 10:52:59 -0700 (PDT)
X-Gm-Message-State: APjAAAX+Rnlm58wF8z5vmbFgb8ya44gEkv08zjtRm2oW9vb26aZUA9WQ
        LfF7uKjY68JV+UEFfh2z8Wla2g/JB3ZBBtKvvw==
X-Google-Smtp-Source: APXvYqy+Xar5KMJ9Wa1ba9rnZphxqVaZoPg7dO2QGR4l7VYDFcuO+0jEB2ZTRPIChY3GMwt8KCnU1jCrA6sSz7PWPdE=
X-Received: by 2002:a0c:f792:: with SMTP id s18mr5145884qvn.20.1571334778692;
 Thu, 17 Oct 2019 10:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190617162123.24920-1-yamada.masahiro@socionext.com>
 <CAK7LNATtqhxPcDneW0QOkw-5NyPNP06Qv0bYTe7A_gCiHMiU7A@mail.gmail.com>
 <CAK7LNASMwqy0ZUZ=kTJ7MJ6OJNa=+vbj5444xzmubJ8+6vO=sg@mail.gmail.com>
 <CAK7LNAS=9yGqMQ9eoM4L0hhvuFRYhg6S4i6J3Ou9vcB1Npj4BQ@mail.gmail.com>
 <20191017163414.GA4205@bogus> <5b5ece90-0b9f-38e4-8c23-3c9ea4105c79@gmail.com>
In-Reply-To: <5b5ece90-0b9f-38e4-8c23-3c9ea4105c79@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Oct 2019 12:52:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJHGcbf-p7D=MvSRiX_7CVY0Kj9bRKybhbWG=4MxaxGiw@mail.gmail.com>
Message-ID: <CAL_JsqJHGcbf-p7D=MvSRiX_7CVY0Kj9bRKybhbWG=4MxaxGiw@mail.gmail.com>
Subject: Re: [PATCH] libfdt: reduce the number of headers included from libfdt_env.h
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/17/2019 11:34, Rob Herring wrote:
> > On Wed, Oct 16, 2019 at 08:01:46PM +0900, Masahiro Yamada wrote:
> >> Hi Andrew,
> >>
> >> Could you pick up this to akpm tree?
> >> https://lore.kernel.org/patchwork/patch/1089856/
> >>
> >> I believe this is correct, and a good clean-up.
> >>
> >> I pinged the DT maintainers, but they did not respond.
> >
> > Sorry I missed this. Things outside my normal paths fall thru the
> > cracks.
> >
> > I'll apply it now.
> >
> > Rob
> >
>
> Looks like my reply crossed with Rob's.  Rob, shouldn't
> scripts/dtc/update-dtc-source.sh make this change?

No, the includes in include/linux are kernel files which wrap/replace
the upstream ones.

Rob
