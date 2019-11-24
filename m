Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD9C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171F52075E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CQBjZJAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKXXfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:35:07 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35793 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfKXXfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:35:06 -0500
Received: by mail-pf1-f170.google.com with SMTP id q13so6330981pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=IAX5OsvQRFhKUVQf9ZlgdiZ0hiTtv7ussL8NqCM89xg=;
        b=CQBjZJADEWDMnh/O55ZZyyKuHM3lHl/Cs7sj8JVwoM8X3SLQs/jhmNaCCoFxpgFC4g
         opzBTt8OmQvgOLfvkwLJvBfEH0hjyy0FtECa2itRyCOE061wAAncoCKldnlKW6fMD+b2
         2XF3SSMWTYhxj4tWkOhjp5PwS5KGUU2ZCpVG2seV0UTJsPUoZBctrqVYxtV1kKnO92tW
         V1viAVqpSX1oypYw0Q9ZCpgZws35eVJxTyFwle1YxsA9N0oRnpSg+1Nzk1APXKtT/QUw
         B2EueQVIFlEq6ncV0is9dMR3HEJYuutOP3ApyK1VPuKJhLmIa8zGbZ8GkDat4+NbdveS
         Ohew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=IAX5OsvQRFhKUVQf9ZlgdiZ0hiTtv7ussL8NqCM89xg=;
        b=luD/cA/yfrg0QlrG7CdNaukNocWp+IQrevT1c8Q8V4Jx+p483RHaMGrvZhq3kBwssj
         Njkul6UNDr0+kzZic3IILdBGbaPSEm44rBpFWyUd5BVWBxndNtZkT3h0Yc2NDrnNcqKM
         ROp5rD+VQLeIwstUefIV/QHtAW3Lu+8mIkDWeVQTfNNNzWTGxdkj5zWQXblM9ed53KXH
         xDdNlfwx7IUGd9cqFWQgI75N0iivrAtXUuorspDtvKzeEGmSYqQUXR6SULEFA6vJ54GA
         IVhrsNKwqwPfAdVjYXzJlctsmrDX7CqELnLURAjyleHz+jiaMMsS84wXIoPo4O6Wxoh8
         cO2Q==
X-Gm-Message-State: APjAAAW/0xnZBt31tNGFlQyqdn6BUsmFVyo0Le0zM3J7rxSPZV/kcyjf
        SJe4s2yOWvzNInsFOy6v+PeUsw==
X-Google-Smtp-Source: APXvYqxNAS091SYTF7LWUbmNijXLey/JwiGkEGlAES3q+1uVZ0F13uA6K8LvjVSUWygYD+NFsaX9uw==
X-Received: by 2002:a62:ac06:: with SMTP id v6mr30674323pfe.210.1574638505235;
        Sun, 24 Nov 2019 15:35:05 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id z1sm5717299pfk.61.2019.11.24.15.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 15:35:05 -0800 (PST)
Date:   Sun, 24 Nov 2019 15:34:58 -0800
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
Message-ID: <20191124153458.14015cb2@cakuba.netronome.com>
In-Reply-To: <20191123190209.5ad772fc@cakuba.netronome.com>
References: <20191122070321.20915-1-Po.Liu@nxp.com>
        <20191123190209.5ad772fc@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019 19:02:09 -0800, Jakub Kicinski wrote:
> On Fri, 22 Nov 2019 07:17:18 +0000, Po Liu wrote:
> > +	if (tc == prio_top) {
> > +		max_interference_size = port_frame_max_size * 8;
> > +	} else {
> > +		u32 m0, ma, r0, ra;
> > +
> > +		m0 = port_frame_max_size * 8;
> > +		ma = enetc_port_rd(&si->hw, ENETC_PTCMSDUR(prio_top)) * 8;
> > +		ra = enetc_get_cbs_bw(&si->hw, prio_top) *
> > +			port_transmit_rate * 10000ULL;
> > +		r0 = port_transmit_rate * 1000000ULL;
> > +		max_interference_size = m0 + ma + (u64)ra * m0 / (r0 - ra);
> > +	}
> > +
> > +	/* hiCredit bits calculate by:
> > +	 *
> > +	 * maxSizedFrame * (idleSlope/portTxRate)
> > +	 */
> > +	hi_credit_bit = max_interference_size * bw / 100;
> > +
> > +	/* hiCredit bits to hiCredit register need to calculated as:
> > +	 *
> > +	 * (enetClockFrequency / portTransmitRate) * 100
> > +	 */
> > +	hi_credit_reg = (ENETC_CLK * 100ULL) * hi_credit_bit
> > +			/ (port_transmit_rate * 1000000ULL);  
> 
> Hi! The patch looks good to me, but I'm concerned about those 64bit
> divisions here. Don't these need to be div_u64() & co.? Otherwise
> we may see one of the:
> 
> ERROR: "__udivdi3" [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!
> 
> messages from the build bot..
> 
> I could be wrong, I haven't actually tested..

Yup:

drivers/net/ethernet/freescale/enetc/enetc_qos.o: In function `enetc_setup_tc_cbs':
enetc_qos.c:(.text+0x5b4): undefined reference to `__udivdi3'
enetc_qos.c:(.text+0x608): undefined reference to `__udivdi3'
/home/jkicinski/devel/linux/Makefile:1077: recipe for target 'vmlinux' failed
make[1]: *** [vmlinux] Error 1
make[1]: Leaving directory '/home/jkicinski/devel/linux/build_tmp2'
Makefile:179: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2

Please fix and repost.
