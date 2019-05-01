Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA5C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A1F208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556740889;
	bh=DJuvpvapaDVmQhgXF7f69SbWSWV6Vf4G8XFX0mV0v6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LMwPEpP5efJ0TyXq/+25NdfPp4PYa7aLxN7xu3DsMCLpYyDu33RJJt73xvUbtYwW7
	 Qfyn250HPYgx4TlxaY7W9j94bBUUCI9Hg1j+cQGjL659KKZMKbnjUvamtvjuj+dmSz
	 RgC7yitnMNKKDtmC1Bufd9Xf0Lfi//magKDiJmr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfEAUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:01:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42027 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfEAUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:01:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id k9so11632216oig.9;
        Wed, 01 May 2019 13:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qIHTWDGzYQZkJHiXkUezp72uwINxeVDukTjbaIhuiTs=;
        b=R2Wd9mnXHRshVfmnyfesUrYm7DYErdCjeHNc1CgndFDB+XpPWxl4b0rivaqfHjFXqy
         KxkaU3EEBMyGFIXITdLFdEyK4/nrIFwAinxa6EPTHhZ9p9SVE+LfCdmQ8hV4fsiDkxJu
         dbF2VLNloc3n8pS8DRu/vMmDXLMncFGM2RJzpLQjRjji4UBKXV7SyRiqlj5qVzndmvEy
         2wc+7xNfSpUJxUmG+RFZ6GguXMGIRlFeltMrd3qcHw2EUzcwHk8vzJRwJYasFZ62fGGX
         Y43zSoJHQOkL0z9+3VtKnrDGp0QauM3mFdkj2R8QoGbHqvvmxEuOR0tm8HcJIGMeVYwZ
         wvBw==
X-Gm-Message-State: APjAAAUzwiLk8ASQHjK3BufS83KUvN5i+SLtq/d4g85/JvkzTVnjUy/d
        x67u3e04WoSZoL6xrqTWkA==
X-Google-Smtp-Source: APXvYqwwvwj4oDg/bmeUnn4vK+Jak43dJ5tnDPhQiN/4HMQjCLWKMf5r4j6Hlke3L5ETSZw1m0/USA==
X-Received: by 2002:aca:c4c3:: with SMTP id u186mr56454oif.82.1556740887017;
        Wed, 01 May 2019 13:01:27 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w131sm17543434oig.29.2019.05.01.13.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:01:25 -0700 (PDT)
Date:   Wed, 1 May 2019 15:01:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, yingjoe.chen@mediatek.com,
        sean.wang@mediatek.com, erin.lo@mediatek.com,
        eddie.huang@mediatek.com, matthias.bgg@gmail.com,
        s.hauer@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: adc: mt8183: add binding document
Message-ID: <20190501200125.GA29927@bogus>
References: <20190424011112.14283-1-zhiyong.tao@mediatek.com>
 <20190424011112.14283-2-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424011112.14283-2-zhiyong.tao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 09:11:11 +0800, Zhiyong Tao wrote:
> The commit adds mt8183 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mt6577_auxadc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
