Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D088C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB6C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TU+WvyEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391247AbfISP1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:27:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41184 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391234AbfISP1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:27:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so3427121otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQhJr69/vPd/U/psJVJ1y2BU+JZc/GqWvX4OAnagwrY=;
        b=TU+WvyEN5IqmhO1QeCdr0zyP5aga8ovoC/U2eRs61E+zTYw6pidSqTlkToVYeiIHo6
         vCcaYto8j9wnV9tJrRMQRX0nadMJFe7U6CZLGRjbdhBK35pUGFPhvnnu9BcvNG6vl1yA
         wtSwB0eb62xfZVsN+sGz7OcIHWAUcDVZ8eQ0ZxSoKRT+1F202vpKjLle/8YGBqDDH793
         uBqFTCNdFgu9r/ReamEEtBFyyRKuV9ACURztz002sq82ARVTbabM+KjTIkK7pfmcHezX
         2DxqyGFnmk7tvKZz12hstb8UMYVmd4W5+0DAM8450Uy88YRbBd9mPpjxKKhT19A+kApK
         /9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQhJr69/vPd/U/psJVJ1y2BU+JZc/GqWvX4OAnagwrY=;
        b=jY6S6EnlyKZd+f2DvyqM81pPIFghx3w66nwxJcXzdRdxNpx3hm2w6reKraV4nG3I6T
         rtED/RjrfsdEB9WsfE6nQjat3nlyEIonZP7/PsJVknqB+2w8jbjnZJAEb5jkJ3a/ipvB
         pMEkrEfRw5LKV2AoWHfapDAdDvLMeurTWbPyF3DByNwEg7d1BAqKcM5JCp065+8il35E
         wg0MO0wSU0bKIaZgwcXBbBip8UaCBfv0++ZwaDTQkAOWbpKpwz8KODtbFHvrWlfLfqrv
         xO6Hwdfb4eRhuoPjnJaipD9Mu4JZmzg4z9WDXvK0aJkL4vPzWBp8FAJ7Str4JxyeOEoV
         bqfA==
X-Gm-Message-State: APjAAAXN9NrVqVmTWI3j9AG09Iu40b3Dy8kx8HiQcgR3tA10785aVePU
        1BSOpac6Jr+jJswyLaCsLAI6FV7dDg5YOVmu89Zhtg==
X-Google-Smtp-Source: APXvYqxSV6mNOx+JelZSXq1gKYybEh6/xyhCkyebC74L1X6VZAart17bTvoaHHN9s5S2diRF49ItUjuFyqqea11bCLs=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr7012748otj.207.1568906871267;
 Thu, 19 Sep 2019 08:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190919150147.GO3642@sirena.co.uk>
In-Reply-To: <20190919150147.GO3642@sirena.co.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Sep 2019 08:27:40 -0700
Message-ID: <CAPcyv4hq2N2H-HszhEm-rT2YziTLSeU1A5ea19-bDvSXMZLjCw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the
 libnvdimm-fixes tree
To:     Mark Brown <broonie@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yi Zhang <yi.zhang@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 8:02 AM Mark Brown <broonie@kernel.org> wrote:
>
> Hi all,
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>
>   drivers/nvdimm/pfn_devs.c
>
> between commit:
>
>   274b924088e935 ("libnvdimm/pfn: Fix namespace creation on misaligned addresses")
>
> from the libnvdimm-fixes tree and commit:
>
>   edbb52c24441ab ("libnvdimm/pfn_dev: Add page size and struct page size to pfn superblock")
>
> from the nvdimm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc drivers/nvdimm/pfn_devs.c
> index cb98b8fe786e2,80c7992bc5389..0000000000000
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@@ -724,9 -786,10 +788,11 @@@ static int nd_pfn_init(struct nd_pfn *n
>         memcpy(pfn_sb->uuid, nd_pfn->uuid, 16);
>         memcpy(pfn_sb->parent_uuid, nd_dev_to_uuid(&ndns->dev), 16);
>         pfn_sb->version_major = cpu_to_le16(1);
> -       pfn_sb->version_minor = cpu_to_le16(3);
> +       pfn_sb->version_minor = cpu_to_le16(4);
>  +      pfn_sb->end_trunc = cpu_to_le32(end_trunc);
>         pfn_sb->align = cpu_to_le32(nd_pfn->align);
> +       pfn_sb->page_struct_size = cpu_to_le16(MAX_STRUCT_PAGE_SIZE);
> +       pfn_sb->page_size = cpu_to_le32(PAGE_SIZE);
>         checksum = nd_sb_checksum((struct nd_gen_sb *) pfn_sb);
>         pfn_sb->checksum = cpu_to_le64(checksum);

Yes, looks correct. Apologies for not highlighting this conflict in advance.
