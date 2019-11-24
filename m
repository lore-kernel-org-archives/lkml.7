Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCE4C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D813020719
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 03:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FypTV9hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKXDCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 22:02:17 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:39539 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKXDCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 22:02:17 -0500
Received: by mail-pf1-f174.google.com with SMTP id x28so5560272pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 19:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cs410pk2WGGskzmW00wQGEQsVx1UHdJx4TCUeQnvyi8=;
        b=FypTV9hr1yrpcpZXQxme+38rUMvHaHHI2CgVqm/AnBtCIY2CsCFTkpWxBrTrYDPGKO
         gYcySGIXSJ0mpfN0y3AxnnrcfIlukFZnocwoTdSmlFk3n52pC9C8In8jFCyu3vjtBSpD
         ej2KXS46Iu1qn+oOqBGWP+/OfQXUver9IEIyWdU0GVrIpDIMXNDfGOQaJMtH4004iOBq
         nkYy+c1mnAUtPL86Tx6pKZRrnG6hAfU6Lm0lnBYmkWdTsAghZr/xl8RhqpHUrJQAXQO0
         Qs816VBxDblr8xtZM5aU8C4NkCS6wGNfnVFen/HYc5ksJkYEs9PfDxVUrPt1WiJCvhFF
         AX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cs410pk2WGGskzmW00wQGEQsVx1UHdJx4TCUeQnvyi8=;
        b=qPFSejmfokYDudya5MOU3JUQo0l1dnxmAcDpMdYSieW2NAW/6cL99iTeTZP4cpFjbJ
         mjpNJzp04MOTQ5BhnQkjak9IqAyiHzTesd4yBLhZq5LLIM0MregQad4HK8wRll6aZ1aq
         iT67Db0UzK7tvhckMbG/lR24lDbvEh5J18xYyGUD8I0o9B6/wAYR/kL2azd3WWdJEeuZ
         uLj2SBPOwDA6La7rC4Txlqnue9q/wF5aOu+opjM1zfUfAymSvDMcB2uPDtDw7Oe64Zz0
         x3BYsoJJU3Be80Vh5D1qsM6JsCxlHjl43N+shx047ctywY49QyF5JFvURNawe7xPWXgp
         p0MQ==
X-Gm-Message-State: APjAAAXWDAx0bkFSNpz+czLisXeg4y66KkZzlXAVqumxJqGyuS/zH4NF
        SdFyCgDLoXzIDQ8t5EzabJJs1w==
X-Google-Smtp-Source: APXvYqxVCh1R4UCxh2jpfBCuVx7MilWEZVy8nP29FUiR2f0oa4d5b+AhH8fW8ZiNhYOVxpWk8q06Xg==
X-Received: by 2002:a62:501:: with SMTP id 1mr27669598pff.69.1574564535099;
        Sat, 23 Nov 2019 19:02:15 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id z10sm3287704pgc.5.2019.11.23.19.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 19:02:14 -0800 (PST)
Date:   Sat, 23 Nov 2019 19:02:09 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Po Liu <po.liu@nxp.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [net-next] enetc: add support Credit Based Shaper(CBS) for
 hardware offload
Message-ID: <20191123190209.5ad772fc@cakuba.netronome.com>
In-Reply-To: <20191122070321.20915-1-Po.Liu@nxp.com>
References: <20191122070321.20915-1-Po.Liu@nxp.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 07:17:18 +0000, Po Liu wrote:
> +	if (tc == prio_top) {
> +		max_interference_size = port_frame_max_size * 8;
> +	} else {
> +		u32 m0, ma, r0, ra;
> +
> +		m0 = port_frame_max_size * 8;
> +		ma = enetc_port_rd(&si->hw, ENETC_PTCMSDUR(prio_top)) * 8;
> +		ra = enetc_get_cbs_bw(&si->hw, prio_top) *
> +			port_transmit_rate * 10000ULL;
> +		r0 = port_transmit_rate * 1000000ULL;
> +		max_interference_size = m0 + ma + (u64)ra * m0 / (r0 - ra);
> +	}
> +
> +	/* hiCredit bits calculate by:
> +	 *
> +	 * maxSizedFrame * (idleSlope/portTxRate)
> +	 */
> +	hi_credit_bit = max_interference_size * bw / 100;
> +
> +	/* hiCredit bits to hiCredit register need to calculated as:
> +	 *
> +	 * (enetClockFrequency / portTransmitRate) * 100
> +	 */
> +	hi_credit_reg = (ENETC_CLK * 100ULL) * hi_credit_bit
> +			/ (port_transmit_rate * 1000000ULL);

Hi! The patch looks good to me, but I'm concerned about those 64bit
divisions here. Don't these need to be div_u64() & co.? Otherwise
we may see one of the:

ERROR: "__udivdi3" [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!

messages from the build bot..

I could be wrong, I haven't actually tested..
