Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81104C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C59220674
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556135427;
	bh=R0q2vlaBwry72v/Rp0HRRMY6juk7PDgZ094B2Z5TSDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zGmv3dxKf8jovICDLyJ0BnGPBNu4CTE7v4uUeOm/FOgAbGtGBOySnMz6YOZsuLe5w
	 dVDGWN1D7hakFjo7aZ/DWb/ZXk7Dv6kLQPaDEwtNQ2lvAhXR2H2UdBnuUTM9S/Jn4L
	 r8CvfJWJPbgCOPyGtBFLsvJLbMKV+Lf/kTfouHNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfDXTu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:50:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37274 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDXTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:50:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id k6so1593632oic.4;
        Wed, 24 Apr 2019 12:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gX5DaKXgzgKwHuI4bQ2Vuz6TWDgQGkcLA/0KBG8pAs0=;
        b=kSVSDiqBsYJNa+9DsHdcAh9DytMt4VlWCDkghpZ9Zy2tWUDc3YTHM61N93aYKdMbpD
         wwsYgN0LLGxoXpcsIwa8AWhg0I+tzaWI9mdDvyc3lXjivpA6g6Uj0LqS3goCyU7RHLy0
         VmB5nXsYc6CS+a5PM45DFD9xeclztGeR44VA5QjG5viEbTuQQxg44fyrcn6ywzf4qPrQ
         BJg6CpA64suWGcRIyBfBUsK/ZtIBruofDQR8+cazPzj/O59JGuP1LNVC6LZpKWJUQmee
         2Z9bquEBOREUGhmbiDP/Bw6ADUaiODzU1qFvNyTKm1r5LzBdSZia3Evbrx0higQkDywl
         HgMw==
X-Gm-Message-State: APjAAAWFsFctEd6HRyrDqmBjyb4wDtd1PGvY5ZLMHNFDvRm/QYQSMDp1
        6cJgifRQUyJO5o26xNXzvw==
X-Google-Smtp-Source: APXvYqzNC0zi2UctBg09jKsdU5XdGqtwFCK4/4d+sdJraGSeL8x7mWFkarGIMtEC3NX3nPmZMB9Vqg==
X-Received: by 2002:aca:b60a:: with SMTP id g10mr535062oif.35.1556135424386;
        Wed, 24 Apr 2019 12:50:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm7609770otr.39.2019.04.24.12.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:50:23 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:50:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK HU <ck.hu@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        ginny.chen@mediatek.com, kendrick.hsu@mediatek.com,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: Re: [PATCH v4 01/12] dt-binding: gce: remove thread-num property
Message-ID: <20190424195022.GB7270@bogus>
References: <20190415125833.38704-1-bibby.hsieh@mediatek.com>
 <20190415125833.38704-2-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415125833.38704-2-bibby.hsieh@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 08:58:22PM +0800, Bibby Hsieh wrote:
> "thread-num" is an unused property so we remove it from example.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
