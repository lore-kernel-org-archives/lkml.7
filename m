Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEFB2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574453806;
	bh=67A8j0jZAs+8jyR/QDV+aimpNpJvsoUGnuCtm2D/BiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xcAv7SwSFllRpzoMkdrXkZSFdfNEaGH/MBGcK2TSaBg5Kn0Au/rLcfY10BP5rmA3r
	 blKJZwjjn7oc8rPsqaJztzeau0oBwWx4hGN7v+aYCP4YbO2IS2zW+9mxUYRlmdkYkH
	 fXtggTWus22AvcpgIstgnucLV1CDhjuzoe3Pvozc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKVUQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfKVUQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:16:45 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F252070E;
        Fri, 22 Nov 2019 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574453803;
        bh=67A8j0jZAs+8jyR/QDV+aimpNpJvsoUGnuCtm2D/BiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eui+xKimRueCHxz7rOXYhdKB9qgSncPLjzG6BmAYw1jRSJM5GfF0DCxI9Xw7/Wd4J
         QMoVI1i5MmY7x0U0ruhPStk6lN72r1ArXtJySkZDdveF1KukoaIFF4pLTfAUvYkje6
         dSmprRjR8JAuCF4nI42QRLS0z7+ubg5GtFf3yC3k=
Received: by mail-qv1-f53.google.com with SMTP id i3so3416086qvv.7;
        Fri, 22 Nov 2019 12:16:43 -0800 (PST)
X-Gm-Message-State: APjAAAUP/xLsUt7+milubkX1oUoaaa/xXwIxrYiUwPQ1tyQUua3oS5Vt
        XMuV2MCdEQSSqj3DF8wC+54NedMlljzekdhCxg==
X-Google-Smtp-Source: APXvYqxaY+WJDuS4dkyBgjEJBjl1ZArY1TNHbOoXgn58PPmvdcHkxqDLwSJ/uEHer9BJUR3W47CqLimTdLShQ7xW/CI=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr263322qvu.136.1574453802820;
 Fri, 22 Nov 2019 12:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org> <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck> <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
 <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8HjzpDfh2=gUXuV-OLWbePVEPJU369V4_S6=Q7e4_bzg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 14:16:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
Message-ID: <CAL_JsqLVN2pZGU054cdUskghEb8_DJ_zNfzrOdgR_DvLA5YG=A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        iommu@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:13 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 22 Nov 2019 at 17:01, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > [+Ard]
> > >
> > > Hi Rob,
> > >
> > > On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > > > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > > > mboxes and io-channels") added device link support for IOMMU linkages
> > > > > described using the "iommus" property. For PCI devices, this property
> > > > > is not present and instead the "iommu-map" property is used on the host
> > > > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > > > IOMMU instance.
> > > > >
> > > > > Add support for "iommu-map" to the device link supplier bindings so that
> > > > > probing of PCI devices can be deferred until after the IOMMU is
> > > > > available.
> > > > >
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Saravana Kannan <saravanak@google.com>
> > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >
> > > > > Applies against driver-core/driver-core-next.
> > > > > Tested on AMD Seattle (arm64).
> > > >
> > > > Guess that answers my question whether anyone uses Seattle with DT.
> > > > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > > > associated with the PCI host. I raise this mainly because the dts
> > > > files for Seattle either need some love or perhaps should be removed.
> > >
> > > I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> > > (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> > > modular builds of the arm-smmu driver require that the old binding is
> > > disabled [1].
> >
> > Going to post those dts changes?
> >
>
> Last time I tried upstreaming seattle DT changes I got zero response,
> so I didn't bother since.

I leave most dts reviews up to sub-arch maintainers and I'm pretty
sure AMD doesn't care about it anymore, so we need a new maintainer or
just send a pull request to Arnd/Olof.

Rob
