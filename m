Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5163C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952242054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="baBlAhgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCLPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:25:00 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3604 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:24:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c87cf4c0000>; Tue, 12 Mar 2019 08:25:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 08:24:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 08:24:58 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 15:24:57 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: use devm_clk_*() helpers
To:     Sameer Pujar <spujar@nvidia.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <treding@nvidia.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552401352-30043-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7598abfe-ae1a-61d2-e4d2-c95dc78c9697@nvidia.com>
Date:   Tue, 12 Mar 2019 15:24:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552401352-30043-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552404300; bh=YtaJ9x8sYN10MYrP9ppuxiz1StD6MzfGIzIWexmRM3k=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=baBlAhgr5FPyRZ4fM4ZFFM1S0+rlM5XbJDk3WvkcftwpBtCrR/e0ZOILnUstFJC9A
         pCtZN5ocjItLNj7hlIMllA9HFcXIklrvnERWbYsmZVi40uO+2k+KmeI087rMJQ/QuD
         FrFF856pD/+jhQv+jdHLdlHo8845D3dxQYC6HPadmoY10HQsV5lv20XaTdKKgL9r9d
         fuAc0VtrcLbxE11SbsDxFvborwA9yd+hxX6A56ue6JrIOkqYycSYDHpNazcnLPVW5c
         TwEWm+DMMI8hBake6q3wlRBDGd2J/cXMiZjWXzg872UIjYxv1OsCi46h0Fvy5llHX1
         oLrJOM/eUT10A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/03/2019 14:35, Sameer Pujar wrote:
> Usage of pm_clk_*() results in non-zero prepare_count for clocks and hence
> module clocks remain ON always. This is not desired as it will leak power
> unncessarily. This patch replaces pm_clk_*() with devm_clk_*() interface.

Technically, this is not true for all devices. The actual problem here
is that for some Tegra devices that use the BPMP co-processor to manage
clocks, the clock are actually enabled during the prepare-phase and
hence when using the pm-clocks framework they are never disabled for
these devices. However, this is not the case for Tegra210 which does not
use the BPMP for managing clocks.

It maybe worth highlighting the fact the BPMP has to enable clocks
during the prepare phase because calls to the BPMP are always blocking.

> This helps to keep refcounts balanced when device is not in use and runtime
> PM callbacks help to enable or disable clocks. System suspend/resume calls
> can use pm_runtime_force_suspend/resume.

I think that this last bit should be a separate patch as it has nothing
to do with the $subject.

Cheers
Jon

-- 
nvpublic
