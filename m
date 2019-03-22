Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F2321904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553237114;
	bh=bWhsaeWhQPicYb/9TPJ6/Fp1lQk6GyuWmuNkkqdwrcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uu99bSI3vFZ9Cp9k2Ltday/1ZAKBYLpIC2w3A/j4vAQpbujSuWC65PMLny/AyS6b+
	 8h1M8CrfnGCd4RuEYfSSUyuBknbmQ5PfObRxtZ4JAdtqIV10abd7eSleynllAjdsRa
	 ojCyQZY67E2304dkCY7Q6Cafe2VOk75mk2NVO+vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCVGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfCVGpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:45:12 -0400
Received: from localhost (unknown [106.201.33.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E279621873;
        Fri, 22 Mar 2019 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553237111;
        bh=bWhsaeWhQPicYb/9TPJ6/Fp1lQk6GyuWmuNkkqdwrcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2uS9cp8r93KbvSmleTsH5X3LnhtH3qNBXOIFUsveOKcIvODMZ4VnzC7EojvrET28w
         vqOWZTZSpjYCdzSDE05wKA/F1ZvKU+S6+uS9KJekxZWnsTMXaJnD5g/wnHpSjxieug
         +AQOk9CDOAJ7+Qft9lBio/gk3aWj0bsDVo4o2Lfg=
Date:   Fri, 22 Mar 2019 12:15:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BISECTED, REGRESSION] Broken networking on MIPS/OCTEON
 EdgeRouter Lite
Message-ID: <20190322064506.GB5348@vkoul-mobl>
References: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322002125.GD7872@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-03-19, 02:21, Aaro Koskinen wrote:
> Hi,
> 
> When booting v5.1-rc1 on EdgeRouter Lite (MIPS/OCTEON), with at803x phy
> driver enabled, networking no longer works - I even need to go physically
> power cycle the board before getting networking to work again (otherwise
> bootloader cannot tftp an older working image).
> 
> Bisected to:
> 
> 	commit 6d4cd041f0af5b4c8fc742b4a68eac22e420e28c
> 	Author: Vinod Koul <vkoul@kernel.org>
> 	Date:   Thu Feb 21 15:53:15 2019 +0530
> 
> 	    net: phy: at803x: disable delay only for RGMII mode

Hello,

So with cd28d1d6e52e ("net: phy: at803x: Disable phy delay for RGMII
mode") it works for you but not 6d4cd041f0af ("net: phy: at803x: disable
delay only for RGMII mode"). That is bit more weird case :)

So does the ethernet expect RGMII mode or RGMII_ID mode here, looks like
disable delay is expected as well?

Can you point me to the DT node as well..

> Booting v5.1-rc1 with this commit reverted makes networking to work
> fine again.

-- 
~Vinod
