Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A96C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1CA2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="YwV4nGNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfHMU5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:57:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37941 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:57:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id u190so17193708qkh.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=bNfCPQHfFfS05Ua0jgfTWRkNVMemAI0m1k8K0MkNCfo=;
        b=YwV4nGNRSR1A1eVJ/QD41sekOqfOp8xgyNC95HHYPXad4HG7a2JDRShmZhBlpGQUUt
         WSHEMsmrJ19lmUCYMUrWkocjF2D0hTI4iyF5PpD0ZhSAQO+GkBFVViFj9Gx4u0oJPIWS
         y1GYX3DWqvmZ4Sjfdt+P0aNDrEQX9tP/jtldhK1rGqsPbAAoJ+Bk7SDMmzBcjGOfTvwg
         Pp/zVhGRjz7gsjbgYw3pqzG15i7zJ0RUecjBuDopi4mFQbblrWUTjCHFH52oWPytiFD4
         IVpRDmpauS0ZvJMBttPhzfi9MdcVF7kuk2lhyfa2uX4iQdFXBu9gUfwyrmRD5IvX2NgN
         LlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bNfCPQHfFfS05Ua0jgfTWRkNVMemAI0m1k8K0MkNCfo=;
        b=SL24B/M4lPLWYEVSV+V74mkUh5VYLGm7CxsFpPYHo6JkRvFarNqmqaTrvQ2zcUBohs
         tzbJqQOcqNoquRWSvlarPWtseLG8hZ2uMdQ75RDdFaUSDpv58mD6KMXr6P7m7CDy14bZ
         srzSu7bSb9/Gad0T5Y50zMC1uw4DWkn030O+KT526dvWiwlmGsP4rtb2LUP+wmo1ryGT
         lJtAdcqFoqVAwAdhsI2AtgSZV1VuVDC2mffwzXEYKwAbSB1cPGOLfBKY0iEyjNVQ36MT
         Hl9o39lsMmh9CaAcCGWR/q+BGeGZWmTFLlKg8uOVO8R87OL9ma+WT3YEo6eYopMPbBdB
         1MSg==
X-Gm-Message-State: APjAAAUcMAJ/gmMFwi8lNMetIexU3KvIAZODq5y9O3Cc0VeiWrCA8pkl
        3+R++uQYf6nUYDHUfWu96ptfsWj7geU=
X-Google-Smtp-Source: APXvYqxfiM+cvNMIUPbfi2x+FX0ul2aixQ+5yH92qTgQl+N7+EOdhtTpE+zWSqcR0Xy7ioIiApIKdw==
X-Received: by 2002:a37:b82:: with SMTP id 124mr33996866qkl.260.1565729854473;
        Tue, 13 Aug 2019 13:57:34 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d71sm11374918qkg.70.2019.08.13.13.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 13:57:34 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:57:22 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 01/12] net: stmmac: Get correct timestamp
 values from XGMAC
Message-ID: <20190813135722.22ea671d@cakuba.netronome.com>
In-Reply-To: <195f374a0b46e5e65a691742fc2dbeffacfaf148.1565602974.git.joabreu@synopsys.com>
References: <cover.1565602974.git.joabreu@synopsys.com>
        <195f374a0b46e5e65a691742fc2dbeffacfaf148.1565602974.git.joabreu@synopsys.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 11:44:00 +0200, Jose Abreu wrote:
> TX Timestamp in XGMAC comes from MAC instead of descriptors. Implement
> this in a new callback.
> 
> Also, RX Timestamp in XGMAC must be cheked against corruption and we need
> a barrier to make sure that descriptor fields are read correctly.
> 
> Changes from v1:
> 	- Rework the get timestamp function (David)
> 
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>

The barrier sounds like it might be a bug fix, does it occur in he wild?

> @@ -113,13 +119,11 @@ static int dwxgmac2_get_rx_timestamp_status(void *desc, void *next_desc,
>  	unsigned int rdes3 = le32_to_cpu(p->des3);
>  	int ret = -EBUSY;
>  
> -	if (likely(rdes3 & XGMAC_RDES3_CDA)) {
> +	if (likely(rdes3 & XGMAC_RDES3_CDA))
>  		ret = dwxgmac2_rx_check_timestamp(next_desc);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return ret;
> +	if (!ret)
> +		return 1;
> +	return 0;

nit:

	return !ret;

>  }
>  
>  static void dwxgmac2_init_rx_desc(struct dma_desc *p, int disable_rx_ic,

