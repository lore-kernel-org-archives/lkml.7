Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A3FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFC92067C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576766702;
	bh=vAaulfw1pF77O08ApVOdriNy2OT8rG3mQpywJSyfN4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VMDEkXhH7E4tEBEKfQ8rTqdIZUzROPKrgMaVBJLTMiupkMY5/L0994inLBkLRBYOd
	 rTAvuOo/a1sAtDwcgHfIVly8oR2b2+2NtiDG5d1BEW2h2EDpGlGVJq7oGJbFWLNwLU
	 fXqUrQe/JYBjJ++JQq5XL8MXjQ1MSKMEsddYa1g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLSOpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfLSOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:45:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA5B2053B;
        Thu, 19 Dec 2019 14:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576766701;
        bh=vAaulfw1pF77O08ApVOdriNy2OT8rG3mQpywJSyfN4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zbSeAtQhWyT+0vUu5L4MnKkNI7dV1law3SZgt+khmgC/2FgFiEjBGgv8sk9KSRXoy
         h/tbaj4fG3hnf1MNHYwjeLNW/RfP9hIuVxIaVpiGSrIWipV3gx/cB15yZdA3cCzJcU
         Ipcgpu1lc5HK9h6Y6Grly6oI7eow1PF6MCQRn8Xg=
Date:   Thu, 19 Dec 2019 15:44:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linuxfoundation.org,
        kernel-team@android.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saravana Kannan <saravanak@google.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 00/16] iommu: Permit modular builds of ARM SMMU[v3]
 drivers
Message-ID: <20191219144458.GB1959534@kroah.com>
References: <20191219120352.382-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219120352.382-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:03:36PM +0000, Will Deacon wrote:
> Hi all,
> 
> This is version four of the patches I previously posted here:
> 
>   v1: https://lore.kernel.org/lkml/20191030145112.19738-1-will@kernel.org/
>   v2: https://lore.kernel.org/lkml/20191108151608.20932-1-will@kernel.org
>   v3: https://lore.kernel.org/lkml/20191121114918.2293-1-will@kernel.org
> 
> Changes since v3 include:
> 
>   * Based on v5.5-rc1
>   * ACPI/IORT support (thanks to Ard)
>   * Export pci_{enable,disable}_ats() (thanks to Greg)
>   * Added review tags
> 
> I tested this on AMD Seattle by loading arm-smmu-mod.ko from the initrd.

All look good to me!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
