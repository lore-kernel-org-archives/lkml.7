Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4531AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3821883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567492857;
	bh=Kjnhxdr190S6hyFGdIsCbzAIQoMLyHpi5BtCmbjQvfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtfRoIH8PU/co0RZqFw2rQTODg1x5wWlFsNy7h/lhgBmnWbmOQ9+kIfP5YUui5Ay5
	 ufV5sVTysEXocWD4PGBtYtv/XBJ/NFonaND+7kjpapT+EdITFezsvYrvC8dGXAixG9
	 NQiFEod3w80ClgQvkQiEaGDdI2F4mmzCKwa3xUKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfICGk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfICGk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:40:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048432173E;
        Tue,  3 Sep 2019 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567492855;
        bh=Kjnhxdr190S6hyFGdIsCbzAIQoMLyHpi5BtCmbjQvfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJNMYLqKdbPFEmIjo2UcyeccD7qZ4BLQcspji35Bg8d5E5Cfx5WnE2mk2d8cDlg1T
         ZwfTmgVyXlwi1nUwRCoa62/pcsRd7iTbF88V4/6joXY7I95cZvmsCudYIkrgFAJJo8
         kPgaKEfu3M7dXQ6AotA/WJq4dpeaZY3h4hYgLX6k=
Date:   Tue, 3 Sep 2019 07:40:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: "Rework enabling/disabling of ATS for PCI masters" failed to
 compile on arm64
Message-ID: <20190903064050.zsmaum4gajqjdivv@willie-the-truck>
References: <63FF6963-E1D9-4C65-AD2E-0E4938D08584@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63FF6963-E1D9-4C65-AD2E-0E4938D08584@lca.pw>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:10:30PM -0400, Qian Cai wrote:
> The linux-next commit “iommu/arm-smmu-v3: Rework enabling/disabling of ATS for PCI masters” [1] causes a compilation error when PCI_ATS=n on arm64.
> 
> [1] https://lore.kernel.org/linux-iommu/20190820154549.17018-3-will@kernel.org/
> 
> drivers/iommu/arm-smmu-v3.c:2325:35: error: no member named 'ats_cap' in 'struct pci_dev'
>         return !pdev->untrusted && pdev->ats_cap;
>                                    ~~~~  ^
> 
> For example,
> 
> Symbol: PCI_ATS [=n]
>   │ Type  : bool
>   │   Defined at drivers/pci/Kconfig:118
>   │   Depends on: PCI [=y] 
>   │   Selected by [n]: 
>   │   - PCI_IOV [=n] && PCI [=y] 
>   │   - PCI_PRI [=n] && PCI [=y]│  
>   │   - PCI_PASID [=n] && PCI [=y] │  
>   │   - AMD_IOMMU [=n] && IOMMU_SUPPORT [=y] && X86_64 && PCI [=y] && ACPI [=y]

https://lkml.kernel.org/r/20190903063028.6ryuk5dmaohi2fqa@willie-the-truck

Will
