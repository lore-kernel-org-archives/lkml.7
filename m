Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1DFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E061218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USYKuFpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfC2O4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:56:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36247 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfC2O4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:56:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so1350342pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCJaKSLYBD5sHEdNj7dz3XsRUFPmYUlDbvM4pGVHcP8=;
        b=USYKuFpxnMI8jir3rxZ2Ci9JRoyJahlJFCW7OLm9sRXQ3QMY+nLPcDXBDGvMBgwy/k
         4grF3+yRZas9vcXxqMfPeB7gls9jDsTamhU4BRZ2YugxspNO5jY6XiEFsZLxsOvxnWE8
         7qzKULQN9TgLGO7CC1mI/lO14h8+EF09ocSpe4AU0YjVUvBdEjU2KOcJFSn/dfPWz04m
         snxdh6x6S5UlhUSsp85BgtMWqAf9AEM2QR0TcS/3Ieqq1iO3tHp6SLvzkEBwnFHljv7s
         nIfXVtQ3ve6+Cbm2hMa3HJhec0AAIg1FEaCEFqFmwTNkk/ve0NhcyruAKxZkgKuMdTLY
         tP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCJaKSLYBD5sHEdNj7dz3XsRUFPmYUlDbvM4pGVHcP8=;
        b=l327AB4jLjkgI1AmSizuFDBoWOmPKv4tObQty6Vn2049MnIilfeqJAAGcQPmxSEJOx
         0Gfq1+acFkjM2ppQljV9SKzhccqNh/nQ30evesy+cXOBsby51I9vK0wfMWaQyAhzAokt
         q7lv6YYLfIMrnduxlN+PnH0WDsN1I8MV4bK9gyfMsxESpW1Pp0VdbAomvOVVWNWaL8pQ
         KGCPz8JyfiyMpT5Mn62Qm2cKO5I2ItfSe/HgckLvGAi6JycrgQGF95v4zUeuo+mIDHse
         umtr6ysxb0wuY+0uS4ZJnPwJYbamKsY16T1lX9yQINuvV08S10ezkjnmZqMPw4LbrArm
         nekQ==
X-Gm-Message-State: APjAAAVz2fJrLrvVEvoNdFsKU0SosJntAlIBp6nxd5ySpEoIXcFj3UC9
        Lu/uEao9g3vQOHN1WH+5xYS+WZEo9fox3EjizrWn3A==
X-Google-Smtp-Source: APXvYqxxomg+IGTWCIGjjjNixrM5N4wHUmwy+/nRHxoAsYOY9sNve1EXpn3FF05adWPBDhOKhwWncxAc7Q0CivyB8eo=
X-Received: by 2002:a62:b602:: with SMTP id j2mr34493150pff.68.1553871392721;
 Fri, 29 Mar 2019 07:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
 <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com> <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
In-Reply-To: <CAL_JsqJSvzOQbJSgz7z2wZj9-z=bfhzF_C+662Gnf68TgAPFaA@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Fri, 29 Mar 2019 07:56:21 -0700
Message-ID: <CAO=notx6K7xTW1VG6BGJFBM5k8EQsWXn3WoWSPSrZRsxkwueSA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 6:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 28, 2019 at 12:03 PM Patrick Venture <venture@google.com> wrote:
> >
> > On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > ---
> > > > Changes for v8:
> > > > - None
> > > > Changes for v7:
> > > > - Moved node under the syscon node it requires
> > > > Changes for v6:
> > > > - None
> > > > Changes for v5:
> > > > - None
> > > > Changes for v4:
> > > > - None
> > > > Changes for v3:
> > > > - None
> > > > Changes for v2:
> > > > - Added comment about syscon required parameter.
> > > > ---
> > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> > > >  1 file changed, 48 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > >
> > >
> > > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > > there's no need to repost patches *only* to add the tags. The upstream
> > > maintainer will do that for acks received on the version they apply.
> > >
> > > If a tag was not added on purpose, please state why and what changed.
> >
> > Adding tags in this case is adding a change version?  I was doing this
> > to keep the two patches version-synced.  I thought that was required.
> > There was a version change in the other patch in this set.
>
> Adding tags is not considered a change. I gave a Reviewed-by in v7.
> Subsequent versions should carry that tag if there's no change (or
> only minor changes) in this patch. What happens in the other patches
> is not really important. Maintainers are not going to go searching
> thru the versions to find all the ack/review tags. And if I've already
> reviewed this, I don't want to look at it again.

Thank you, I didn't realize that had happened.

>
> Rob
