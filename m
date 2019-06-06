Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB7CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1CC20665
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dPVis3py"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfFFONH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:13:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39765 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:13:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so982638plm.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YcQi322gU65udmxZ663ZZ4Wmd0vpO9jY2pkneP18U8=;
        b=dPVis3pyGrHlNapFxyZ1x9FyS9jHmd9LaTMqq9zxLdzeQq73zejEUwtK4x5P95VHCi
         WbnjrcVTw0kkko56uuK+VX/DWBgM1VpJFCd01k6qoXzQQtq5xVio6DKcJm6ewlYcOpur
         4SZVbac3X8ApQkp/ZMqoc/JPST/Xr+gZGXi8VKa5d133BKihAWW0jSubtK9BEMlwopWe
         7L860vq3MXyqIsj+4++leoIvxTpF8yJnIP2AiZFrB6iLZeBX8MQWEC+C0Lp2378pgD1f
         bFvIhFlWxE9Cx7pYCOPUTs9+JHwiZYModJGX45diPPvUZXpA4lIYB4iXdVnR1cgeoluJ
         4tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YcQi322gU65udmxZ663ZZ4Wmd0vpO9jY2pkneP18U8=;
        b=RuksFNxZD6A/3aNsWoNT+ou+ngJjts6253MZjMUbd9hwnUXx+hhBZ5H6r9L7CPmdNl
         EqgX2iZW3AkgWg7O0tU384CZjTiQyetp1WYZXTMPTz2ROf/P6wWbunzCvY2cZoH0ogNs
         l0Su0qqd2THEk3etbOyxWeKmYWHYm35EHVO3ZYv0HmbwoHm/G7woGx+Y64vYstzcaVpa
         hpCTbJRopkipTR6NTfKQGQeRJ1ZIMEzRjtPMF90Rn/fg+2U2zn4cwZ91bb+XZGIAJZj3
         VhG3YV9JNL4P03yMZ3iZiA2cFtkhbwI54QARrN7FxECmhan2EJW31ZB+RhqNXuFNEj0I
         zviA==
X-Gm-Message-State: APjAAAWOJVH/MxGIegaKCxuZw/BqAKlOBafMi54ByQQzSc6FQXXB50gI
        Sc7J0R3D1oOvnnFRsgzpcyRb01neuc8tyYdX/aRf5TCa
X-Google-Smtp-Source: APXvYqyCYbjRIpjwEeSGolukiCOTXNw8C4SSP9ycOgfXGLinPd8wUGSRHSVfBirA48MFR9Ix1En/stGzGz8j5P5LvTo=
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr26034435pla.308.1559830386509;
 Thu, 06 Jun 2019 07:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190506164440.37399-1-cai@lca.pw> <20190507073901.GC3486@suse.de>
In-Reply-To: <20190507073901.GC3486@suse.de>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Thu, 6 Jun 2019 15:12:54 +0100
Message-ID: <CAPL0++5g+VVGkTJexCn+=ALOgzsfmB2JgE4OJjWsgJ1DUwT3-Q@mail.gmail.com>
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Qian Cai <cai@lca.pw>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Is there anything I need to do to get this patch into linux-next? My
patch to convert the amd iommu driver to use the dma-iommu ops depends
on this patch.

Thanks,
Tom

On Tue, May 7, 2019 at 8:39 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi Qian,
>
> On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> > The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> > iommu_map_page") added domain_flush_np_cache() in map_sg() which
> > triggered a crash below during boot. sg_next() could return NULL if
> > sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
> > could be NULL which ends up deferencing a NULL pointer later here,
> >
> > domain_flush_np_cache(domain, s->dma_address, s->dma_length);
> >
> > so move domain_flush_np_cache() call inside for_each_sg() to loop over
> > each sg element.
>
> Thanks for the fix, but it is too late to merge it into the tree. I am
> going to revert commit 1a1079011da3 for now and we can try again in the
> next cycle.
>
>
> Thanks,
>
>         Joerg
>
