Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790F7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5172146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0EDEWKHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfLPUQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:16:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44739 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfLPUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:16:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so5198337lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YLUuImzEeNdgR4wgqVgRBbAIWmyCTwR/wtnyDd3xIaE=;
        b=0EDEWKHIm56j47HaFMM23Z3l1LkmrWmnHY1vwaiC80joIxDNVf68/zHyaL5o/+Lno3
         jS607DFkpV9KSvysbU3IDwbrLZ1mLeiY7CX6/iqErTbFVxleUV8gIyNL+1JgaVcqSFsH
         1nnIVwAmIgGN7cAVMzgm0kfZ4hU+l67/r69M4dIzz2+/43LE/kZ1O2N70G6d4P+AivYw
         knkVpPKaJZlw9y26rrvgYDXTE3UJNnUZI3Zaj144jWyOaLMSMguaaOmz0ZzmHsc9rFcq
         OhTrIg9WMCIvoVT3FX3TXPMmq/qGg3NY4v2qt831uQs7kgAsBUASHHCN2qbpxRFaN3mf
         JInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YLUuImzEeNdgR4wgqVgRBbAIWmyCTwR/wtnyDd3xIaE=;
        b=eLQ4hoZTF9rBc0090izmn/TBABQYQXQaVB9TA5nk6dycckwnuzB9tSlxplc4zD5Iwr
         jF//y06FfnK7Xvf8vQxXF99zArRoYD06uOaeXYLt8pquAsK/6iYThH5slKv98mhN4IoN
         Mf7CUPrUVpV4bqdy0KZJdD0TYMC8vNIRgS6a/+XnxiG4ELb43Kx70UHtmtWoJencCSGN
         ec30RMeqacK6pkT9BCVKq1giluosOAwBqGqIfAXHVuJrkKGce97+eJYLiVTVwTXYoovY
         JpUHbRre/3LO6dT8ttIQ04Zg8MeFdG4V8VpnyzxVt5zmZ6C80kn3xvNcMxRqrqGpFRsS
         NjYw==
X-Gm-Message-State: APjAAAWaeYsMCUurRgBe4rV96/c6KdgGlD16u/m5FHDM8DkQ4HCV2C21
        kez6vUPNtDxJ5xL5vM9jQISdfQ==
X-Google-Smtp-Source: APXvYqyt/fVYTuNQcFJk0htjrTxRnckdp1ZR4t6oFaGjxai9lo0wTzQ8KMfd0AAc9f/0dPUfeLqsog==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr559623lfc.92.1576527376259;
        Mon, 16 Dec 2019 12:16:16 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a24sm11015145ljp.97.2019.12.16.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 12:16:16 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:16:05 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/4] net: stmmac: Always use TX coalesce timer
 value when rescheduling
Message-ID: <20191216121605.4780302d@cakuba.netronome.com>
In-Reply-To: <BN8PR12MB3266BDA48CE9F65D564B0918D3510@BN8PR12MB3266.namprd12.prod.outlook.com>
References: <cover.1576007149.git.Jose.Abreu@synopsys.com>
        <23c0ff1feddcc690ee66adebefdc3b10031afe1b.1576007149.git.Jose.Abreu@synopsys.com>
        <20191214122837.4960adfd@cakuba.netronome.com>
        <BN8PR12MB3266BDA48CE9F65D564B0918D3510@BN8PR12MB3266.namprd12.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 09:20:53 +0000, Jose Abreu wrote:
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index f61780ae30ac..726a17d9cc35 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -1975,7 +1975,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
> > >  
> > >  	/* We still have pending packets, let's call for a new scheduling */
> > >  	if (tx_q->dirty_tx != tx_q->cur_tx)
> > > -		mod_timer(&tx_q->txtimer, STMMAC_COAL_TIMER(10));
> > > +		mod_timer(&tx_q->txtimer, STMMAC_COAL_TIMER(priv->tx_coal_timer));  
> > 
> > I think intent of this code is to re-check the ring soon. The same
> > value of 10 is used in stmmac_tx_timer() for quick re-check.
> > 
> > tx_coal_timer defaults to 1000, so it's quite a jump from 10 to 1000.
> > 
> > I think the commit message leaves too much unsaid.
> > 
> > Also if you want to change to the ethtool timeout value, could you move 
> > stmmac_tx_timer_arm() and reuse that helper?  
> 
> Yeah, it's a quick re-check but 10us can be too low on some speeds and 
> leads to CPU useless-looping. The intent is to let this always be 
> configurable by user.

Okay, please do mention the bump from 10us to the default of 1ms in the
commit message, though.
