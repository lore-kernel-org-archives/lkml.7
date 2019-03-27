Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6308C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9891220651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A4At1cZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfC0Q1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:27:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38656 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfC0Q1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:27:19 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2RGR7An049195;
        Wed, 27 Mar 2019 11:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553704027;
        bh=dEXtOR5/Dgw7BDXryLsmfCRIgp/Np7W/GISNmubO/NM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=A4At1cZuLMLt2OlCVZqQdhEf63RlQm5JczVTdXOMlc9BRiMgdelP2jzCBlMxzKEkL
         D/872W8Z0i5fHvGaJ45yu7mgK6DGjhzQeN5McpqSsoDLzV8D2szHihg6Ep86VImxJe
         jfeFJ6X8WspjIFFEo5/IUzjo5sG/QQ2GoRoVELAE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2RGR7qW113673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Mar 2019 11:27:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 27
 Mar 2019 11:27:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 27 Mar 2019 11:27:06 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2RGR64C005050;
        Wed, 27 Mar 2019 11:27:06 -0500
Subject: Re: [PATCH 09/14] bus: ti-sysc: Move rstctrl reset to happen later
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190325215849.13182-1-tony@atomide.com>
 <20190325215849.13182-10-tony@atomide.com>
 <20190326231306.GC49658@atomide.com>
 <b6bd2b04-00b4-6730-4401-6ac95e75322a@ti.com>
 <20190326234022.GD49658@atomide.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <cd0bce74-4af7-bcde-2552-e12c8d1c9da4@ti.com>
Date:   Wed, 27 Mar 2019 11:27:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326234022.GD49658@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 3/26/19 6:40 PM, Tony Lindgren wrote:
> Hi,
> 
> * Suman Anna <s-anna@ti.com> [190326 23:22]:
>> On 3/26/19 6:13 PM, Tony Lindgren wrote:
>> Hmm, are you envisioning the SYSC reset (OCP SoftReset) here or the PRCM
>> RSTCTRL hardresets here? The latter in general requires the clocks to be
>> running first (module won't be in ready status until you deassert the
>> hardresets with clocks running). You can look up the Warm-reset or
>> Cold-reset sequences in the TRMs for any of the processors.
> 
> That's for rstctrl. I just did a quick test with my earlier
> reset-simple patch and I noticed sgx on am33xx produces a
> clock error unless we deassert it's rstrctrl before enabling
> clocks first:
> 
> gfx-l3-clkctrl:0004:0: failed to enable

Yeah, and I see a similar one across the other modules controlled by
RSTCTRL bits for me as well - MMUs, PRUSS etc. This is because you can
only check the module ready status in _omap4_clkctrl_clk_enable() only
both after the clocks are turned on and resets are deasserted. That
check will always fail with rstctrl asserted. The omap_hwmod code does
use the reset status checks for bailing out, but that stuff is not
present in clkctrl code and can only be achieved by adding a
CLKF_NO_IDLEST (somewhat misnamed) to the corresponding clkctrl atm.

See [1] for AM33xx SGX. I will be posting some of these once I check the
behavior.

> 
>> I am working on preparing the next version of PRUSS patches with ti-sysc
>> on AM33xx/AM437x/AM57xx platforms, so will pick up these patches for my
>> testing.
> 
> OK great, yes please check and test with your rstctrl use case.
> I guess you still need to use the reset-simple patch for now
> until we have a proper prm rstctrl driver.
> 
> Note that you probably also want to leave out the struct
> omap_hwmod data from omap_hwmod_*_data.c files with rstctrl
> entries.

You mean no hwmod entries at all, or hwmod entries with no rstctrl data?

regards
Suman

[1]
http://git.ti.com/gitweb/?p=ti-linux-kernel/ti-linux-kernel.git;a=commitdiff;h=536d660714e98bdb7f96e5990a095283e52e4d8a


