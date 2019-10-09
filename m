Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1FECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80F20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570649133;
	bh=WepKEfiglGfT0PHp7z0qXsGnaB12Dhk4g6jPezZVFis=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=fEgdlakyCpVelag9hWD6iPit2nDRxI3Q9qA7iCNwHuy//GoEfSeHiSImVkSsATo3n
	 oubrEYLT3BGVsHqxsRoBjGB6Gku6nHplIyTf2Dw7j4lc/RqNtR/Zv8e10A4tyb8htr
	 7nomPq5u32oH+oQxt7iIsVdCIdjU+GH3i3qjNhNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfJITZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJITZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:25:31 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264BF206B6;
        Wed,  9 Oct 2019 19:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570649130;
        bh=WepKEfiglGfT0PHp7z0qXsGnaB12Dhk4g6jPezZVFis=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=EaWUP/42y0bxL0r0NFrzsCiGNcy8bDLv4JjVBLPdiLTsWpGY25sLmOawyP5o4WGmQ
         CtoITtngjPZamHUZR6EP1g8dg/23dtcz7eJM8vY8nwZl/wse4HznM10v5rLx+tMXgP
         pjfKoRFIPghMM7Y3qBxgnQ+cxRO9jaHJZhByXdic=
Date:   Wed, 9 Oct 2019 21:25:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Shah, Nehal-bakulchandra" <nbshah@amd.com>
cc:     Kurt Garloff <kurt@garloff.de>, Joerg Roedel <joro@8bytes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Singh, Sandeep" <Sandeep.Singh@amd.com>
Subject: Re: IOMMU vs Ryzen embedded EMMC controller
In-Reply-To: <63913cd8-a0c5-61e3-2f52-139bade01afc@amd.com>
Message-ID: <nycvar.YFH.7.76.1910092124260.13160@cbobk.fhfr.pm>
References: <643f99a4-4613-50af-57e4-5ea6ac975314@garloff.de> <47da1247-fbc1-fe50-041c-3808b0e140bf@garloff.de> <nycvar.YEU.7.76.1909251726550.15418@gjva.wvxbf.pm> <20190925154256.GB4643@8bytes.org> <70b2d326-6257-025c-5ffa-1f543a900073@garloff.de>
 <63913cd8-a0c5-61e3-2f52-139bade01afc@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019, Shah, Nehal-bakulchandra wrote:

> >>> Do you have BAR memory allocation failures in dmesg with IOMMU on?
> > 
> > No. The device is *not* treated as PCI device and I still think that 
> > this is the source of the evil.
> > 
> >>> Actually, sharing both working and non-working dmesg, as well as 
> >>> /proc/iomem contents, would be helpful.

> >> Yes, can you please grab dmesg from a boot with iommu enabled and add 
> >> 'amd_iommu_dump' to the kernel command line? That should give some 
> >> hints on what is going on.
> > 
> > For now I attach a dmesg and iomem from the boot with IOMMU enabled. 
> > Nothing much interesting without IOMMU, sdhci-acpi there just works -- 
> > let me know if you still want me to send the kernel msg.
> > 
> > Thanks for looking into this!
> > 
> 
> I have added Suravee from AMD in the mail loop. He works on IOMMU part. 
> As per my understanding, it needs a patch in IOMMU driver for adding 
> support of EMMC. Note that on Ryzen platform we have EMMC 5.0 as ACPI 
> device.

Friendly ping ... any news here?

Thanks,

-- 
Jiri Kosina
SUSE Labs

