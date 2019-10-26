Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A1CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 10:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929B820863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 10:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="USP3P3B2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Md6Dg7kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfJZKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 06:12:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55354 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJZKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 06:12:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F6D760A61; Sat, 26 Oct 2019 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572084778;
        bh=7I09K5+CmAYJ4+S3gYjmbFECynwUeOnBJfhDvdQI5to=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=USP3P3B2USPu6bSKWZYTpMAlcVA8OkWOIwx6TGwTA9C6p4WjZBwyXpV6Fk0+iFyil
         asCpK1jJzEZFSHj1w3JwZDwdH0EXkOmoEoAFCSsvsebBM6cW3MPdhnoYV8gA8ytEQo
         ZvEsfh6s6J5sBLP83tzVnTq3q/mNoS57KZ+ETFNA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4460560A61;
        Sat, 26 Oct 2019 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572084777;
        bh=7I09K5+CmAYJ4+S3gYjmbFECynwUeOnBJfhDvdQI5to=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Md6Dg7kTGuXVpqmAZfASuB5staSOsMUSox9FfGwfmr8hxY11PnlLPSFBcJdLiOtJU
         mdT2cHbWERzIzgoBUNWQGgXxS2wswbCeNMuS7otPaViTsWBcSGTp61iIbgMQVknEic
         h9a0ZkRJTCoymHHfGVpM9JOdL4p5RkqT+cpTbpvg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 26 Oct 2019 03:12:57 -0700
From:   isaacm@codeaurora.org
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        will@kernel.org, pratikp@codeaurora.org, lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
In-Reply-To: <20191026053026.GA14545@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
 <20191026053026.GA14545@lst.de>
Message-ID: <e5fe861d7d506eb41c23f3fc047efdfa@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-25 22:30, Christoph Hellwig wrote:
> The definition makes very little sense.
Can you please clarify what part doesn’t make sense, and why? This is 
really just an extension of this patch that got mainlined, so that 
clients that use the DMA API can use IOMMU_QCOM_SYS_CACHE as well: 
https://patchwork.kernel.org/patch/10946099/
>  Any without a user in the same series it is a complete no-go anyway.
IOMMU_QCOM_SYS_CACHE does not have any current users in the mainline, 
nor did it have it in the patch series in which it got merged, yet it is 
still present? Furthermore, there are plans to upstream support for one 
of our SoCs that may benefit from this, as seen here: 
https://www.spinics.net/lists/iommu/msg39608.html.

Thanks,
Isaac
