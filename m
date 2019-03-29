Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3555F206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JESSw5GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfC2P6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:58:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54866 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfC2P6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:58:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TFw1mu125078;
        Fri, 29 Mar 2019 10:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553875081;
        bh=wH9LUPrJqKUpGl5H8O5YKCImdImswwDl0NwpUTdppc0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JESSw5GIKaahGtgkSBJAP3IIeuidX8m0kvK4VEraJO5mVLJZJyHBbyYl1wZQiBiaF
         AFnd7+0qtIUX2oZo3oiN9lyKp25Ig3J0oCZwl7S/4QdR1VhB1LC/N9hU2fBc+rx8ay
         W4+3NwX3vWIpvNjC6mjG0s1LQe0yduYaqwkJH+EY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TFw17r053574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 10:58:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 10:58:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 10:58:01 -0500
Received: from [172.22.188.74] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TFvx3t105141;
        Fri, 29 Mar 2019 10:57:59 -0500
Subject: Re: [RFC PATCH net-next] net: ethernet: ti: cpsw: drop
 TI_DAVINCI_CPDMA config option
To:     "David S. Miller" <davem@davemloft.net>,
        <linux-omap@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1553794193-8098-1-git-send-email-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <2b50d7d7-ba17-af6f-4c5d-c84106176f1b@ti.com>
Date:   Fri, 29 Mar 2019 17:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1553794193-8098-1-git-send-email-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.19 19:29, Grygorii Strashko wrote:
> Both drivers CPSW and EMAC can't work without CPDMA, hence simplify build
> of those drivers by always linking davinci_cpdma and drop TI_DAVINCI_CPDMA
> config option.
> Note. the davinci_emac driver module was changed to "ti_davinci_emac" to
> make build work.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> 
Sry, wrong patch version, ignore it please.

-- 
Best regards,
grygorii
