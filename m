Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDC2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O2P8pHa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCLP2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:28:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3852 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCLP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:28:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c87d02e0000>; Tue, 12 Mar 2019 08:28:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 08:28:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 08:28:44 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 15:28:43 +0000
Subject: Re: [PATCH] bus: tegra-aconnect: use devm_clk_*() helpers
To:     Sameer Pujar <spujar@nvidia.com>, <treding@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552401249-29838-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b4d6bbde-2c65-a46c-febf-38bc6a92683b@nvidia.com>
Date:   Tue, 12 Mar 2019 15:28:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552401249-29838-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552404526; bh=Sv/cYdmS2VVziZTSCxaP+iNMb/9u2v1EemRgxgkkw9k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=O2P8pHa1O/idyoQH1VI3SLshP0vtPqFUDbGBA66Qmon4rWW/fSui3e44jjvlrvKgW
         YOFoN32HfbrrfOwuCmD+3TQBIFUGBVpy1hpF6K5PW2hE4sKmPAo23gqBEECKpBuY/j
         se/veECOjeKVrSpD7m3qEFXwW41vpf9t0Zj7sLekmVSY/sVFqQTQ7K4Tdlo3Dgz5K6
         qAJmP9Jhx1CRA2K8i4wI7Ry6a8nZ3Gejplgu2z5ockLdNm06scARJtmrSwEj8afq98
         TTWdIcWIl2amxAFhfGW06XYyo1AMHsVL2pqOe+/pClt9x+rUl4R+oq4JwC9UQUPfUS
         GXD9bsCCR+zPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2019 14:34, Sameer Pujar wrote:
> aconnect bus driver is using pm_clk_*() for managing required clocks. With
> this, clocks seem to be always ON. This happens because, the clock prepare
> count is incremented in pm_clock_acquire() which is called during device
> probe(). The count is decremented during remove(). Hence the prepare_count
> for the clock is non-zero till the remove() gets executed. This is true for
> BPMP managed clock sources, where clock enable and disable happens during
> prepare and unprepare phases respectively. Thus clocks remain ON always and
> that is why pm_clk_*() cannot be used on Tegra.

Same comments here as for the ADMA patch. This is not completely true
for all devices.

> This patch replaces pm_clk_*() with devm_clk_*() and runtime PM callbacks
> reflect this. System suspend/resume can use pm_runtime_force_suspend/resume

You need to explain the last bit more. In fact I don't believe it
belongs in this patch.

Cheers
Jon

-- 
nvpublic
