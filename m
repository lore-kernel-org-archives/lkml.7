Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA9AFC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1202921924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573231657;
	bh=cs+B3yBrSuaAZXL4uv8XzM+V7pyVqJSiFSP8eVhd1EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2A50R3tQCupHIlRbzWIa9VN9csrdgx34aR4ftmXHDuxROlcwKJ/J63SLx1tewiWSV
	 x6YzDLTtfxFVy7gq+r1sn+/I7C/U8MByLhFYFSyjZwdi/rWxjFx6xborqrYBT/96ol
	 2KJRrFJ4wIa/RWNXhgC+Yub2OMV/s3JH2rbDzn+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKHQrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKHQrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:47:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2D621882;
        Fri,  8 Nov 2019 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573231655;
        bh=cs+B3yBrSuaAZXL4uv8XzM+V7pyVqJSiFSP8eVhd1EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZKTAliYefLOXM89fFk6VfR6ZAhxURhObP0x1v8/X3wN4FqrZMSDSCosI/M4v4Wv1
         IJrlwqP6AAsJZfvSyKWILkCfqkEzkmD3z2YPLvczvMO7S55ZLcd5AJkKrJrp3lJftg
         iJffAEbRSwFQ1JO91ch7fPeGEgnVa572cgcaWeMo=
Date:   Fri, 8 Nov 2019 16:47:30 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 6/9] Revert "iommu/arm-smmu: Make arm-smmu-v3
 explicitly non-modular"
Message-ID: <20191108164728.GB20866@willie-the-truck>
References: <20191108151608.20932-1-will@kernel.org>
 <20191108151608.20932-7-will@kernel.org>
 <06dfd385-1af0-3106-4cc5-6a5b8e864759@huawei.com>
 <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e906ed1-ab85-7e25-9b29-5497e98da8d8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:44:25PM +0000, John Garry wrote:
> On 08/11/2019 16:17, John Garry wrote:
> > On 08/11/2019 15:16, Will Deacon wrote:
> > > +MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
> > 
> > Hi Will,
> > 
> > >   static struct platform_driver arm_smmu_driver = {
> > >       .driver    = {
> > >           .name        = "arm-smmu-v3",
> > >           .of_match_table    = of_match_ptr(arm_smmu_of_match),
> > > -        .suppress_bind_attrs = true,
> > 
> > Does this mean that we can now manually unbind this driver from the SMMU
> > device?
> > 
> > Seems dangerous. Here's what happens for me:
> > 
> > root@ubuntu:/sys# cd ./bus/platform/drivers/arm-smmu-v3
> > ind @ubuntu:/sys/bus/platform/drivers/arm-smmu-v3# echo
> > arm-smmu-v3.0.auto > unbind
> > [   77.580351] hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
> > ho [   78.635473] platform arm-smmu-v3.0.auto: CMD_SYNC timeout at
> > 0x00000146 [hwprod 0x00000146, hwcons 0x00000000]
> > 
> > >       },
> > >       .probe    = arm_smmu_device_probe,
> > > +    .remove    = arm_smmu_device_remove,
> > >       .shutdown = arm_smmu_device_shutdown,
> > >   };
> > > -builtin_platform_driver(arm_smmu_driver);
> > > +module_platform_driver(arm_smmu_driver);
> > > +
> 
> BTW, it now looks like it was your v1 series I was testing there, on your
> branch iommu/module. It would be helpful to update for ease of testing.

Yes, sorry about that. I'll update it now (although I'm not sure it will
help with this -- I was going to see what happens with other devices such
as the intel-iommu or storage controllers)

Will
