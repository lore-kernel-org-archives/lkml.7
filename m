Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF02C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FD22071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574438490;
	bh=ABV4JDXjTc3+syys4x82oGbN9hbBLYGVEuA+cqBGOdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qMioVGbCRz4Cu2E8HgD1zoCv6DvGHspAwEZGwXAxc6ccJwwxP1SzXdUdWXoue3JkP
	 bZfjQlYOwF3eRv6Y7lJ1cO6SfPuOAC+UQEOflP2ZPtvlnjBPeIE2fd5ueelGKnR+OE
	 udS4NigxMfAOBCXewHN01yoFfmcFa83nLnnpGbgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfKVQBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfKVQB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:01:28 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186DA2071F;
        Fri, 22 Nov 2019 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574438488;
        bh=ABV4JDXjTc3+syys4x82oGbN9hbBLYGVEuA+cqBGOdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tVuVWC6m9TzubuWX9xmvVgf50Dt6oZmXzjVbYWBMm6vWohKmyoMJUzwbQJZD4Dlq9
         GA520+YQbO8n8ywQ/HxZm2cI/Ll54QuT5U8bGF15kE3PIqAuLVKdaJ7O73ABHI4+3Z
         Xt7TM78lu/ggKxBBDJFUgymlIXu20wbF0QlsURhI=
Received: by mail-qt1-f174.google.com with SMTP id w47so4251977qtk.4;
        Fri, 22 Nov 2019 08:01:28 -0800 (PST)
X-Gm-Message-State: APjAAAWZ8HFi2phwOpVSN/vKke4wciK66E0QyoEnTdoNV521LnKuCoe9
        EgRIxyDICIpvwiiOcyeC97ohsLGu9dfX/Nq6kg==
X-Google-Smtp-Source: APXvYqx7KNsAISuNpnJlZcp/nAOHCqYGa8Bku64u91/s2E6BljJZTyFkVMIvN7E4x6WOeUhWY1Y2VG2imoW/80t1w7Y=
X-Received: by 2002:aed:2706:: with SMTP id n6mr15291379qtd.224.1574438487269;
 Fri, 22 Nov 2019 08:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20191120190028.4722-1-will@kernel.org> <CAL_JsqJm+6Cg4JfG1EzRMJ2hyPV1O8WbitjGC=XMvZRDD+=OGw@mail.gmail.com>
 <20191122145525.GA14153@willie-the-truck>
In-Reply-To: <20191122145525.GA14153@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Nov 2019 10:01:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
Message-ID: <CAL_JsqJvhP2YqQwAZg=GecpVNMbHN9OcZxTO8LrvH_jphFJw=A@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for "iommu-map"
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, iommu@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 8:55 AM Will Deacon <will@kernel.org> wrote:
>
> [+Ard]
>
> Hi Rob,
>
> On Fri, Nov 22, 2019 at 08:47:46AM -0600, Rob Herring wrote:
> > On Wed, Nov 20, 2019 at 1:00 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > Commit 8e12257dead7 ("of: property: Add device link support for iommus,
> > > mboxes and io-channels") added device link support for IOMMU linkages
> > > described using the "iommus" property. For PCI devices, this property
> > > is not present and instead the "iommu-map" property is used on the host
> > > bridge node to map the endpoint RequesterIDs to their corresponding
> > > IOMMU instance.
> > >
> > > Add support for "iommu-map" to the device link supplier bindings so that
> > > probing of PCI devices can be deferred until after the IOMMU is
> > > available.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >
> > > Applies against driver-core/driver-core-next.
> > > Tested on AMD Seattle (arm64).
> >
> > Guess that answers my question whether anyone uses Seattle with DT.
> > Seattle uses the old SMMU binding, and there's not even an IOMMU
> > associated with the PCI host. I raise this mainly because the dts
> > files for Seattle either need some love or perhaps should be removed.
>
> I'm using the new DT bindings on my Seattle, thanks to the firmware fairy
> (Ard) visiting my flat with a dediprog. The patches I've posted to enable
> modular builds of the arm-smmu driver require that the old binding is
> disabled [1].

Going to post those dts changes?

> > No issues with the patch itself though. I'll queue it after rc1.
>
> Thanks, although I think Greg has already queued it [2] due to the
> dependencies on other patches in his tree.

Okay, forgot to check my spam from Greg folder and missed that.

Rob
