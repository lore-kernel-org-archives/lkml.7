Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F25320863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W0rIAfQB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gHKHTmgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfCROTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:19:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbfCROTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:19:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98B9E60AA3; Mon, 18 Mar 2019 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552918756;
        bh=TBOXXb7BXAwhtYLQC/HNvQrmp7KPq6Cv1wVQoZ0pAJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0rIAfQB592L6spWhzvDkjsvxMHeY81RxVFlKYAlUwdWhVY2lkLYHvQEId7TasYyd
         jj+zbByb/up0hsTDFPz3GheZelwX313k0+UNhKFLAPEvCXtbs9kNRpmbHyKGE/uifL
         f4Rh2BgPs+tIVoyKRqhhwPpU5Rh8DZm/59C81X2E=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D24160850;
        Mon, 18 Mar 2019 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552918755;
        bh=TBOXXb7BXAwhtYLQC/HNvQrmp7KPq6Cv1wVQoZ0pAJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHKHTmgHjrbUegHGgEN6GxqEfE3yvAu9h/2z1VwsL6iusVcSbceyXgNy7Wtdms6Jv
         wUccaVAHEngP33QVC3vKC+1K4n3JeeWxD6w3gVFwBEVlYHk57M7M5cntT8gbA2FEP+
         fuGZ7hWY9JBJppPr0QahEjfpxA/dB9TNyhmmAG00=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D24160850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Mon, 18 Mar 2019 08:19:12 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        hoegsberg@google.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Message-ID: <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
        freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        hoegsberg@google.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
 <20190318095321.GA5417@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318095321.GA5417@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:53:21AM +0100, Joerg Roedel wrote:
> On Fri, Mar 01, 2019 at 12:38:26PM -0700, Jordan Crouse wrote:
> > Add an attribute to return the base address of the pagetable. This is used
> > by auxiliary domains from arm-smmu to return the address of the pagetable
> > to the leaf driver so that it can set the appropriate pagetable through
> > it's own means.
> 
> What is this going to be used for? Page-table management is supposed to
> happen in the arm-smmu driver and the gpu driver only makes changes
> through iommu_map/iommu_unmap calls.

Adreno GPUs can an internal mechanism to switch the pagetable address in the
attached arm-smmu v2 IOMMU so that each individual rendering process can have
their own pagetable. The driver uses iommu_map and iommu_unmap to write
the pagetable but the address for each individual pagetable needs to be queried
so it can be sent to the hardware. You can see the driver specific code that
does this here:

https://patchwork.freedesktop.org/patch/289507/?series=57441&rev=1

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
