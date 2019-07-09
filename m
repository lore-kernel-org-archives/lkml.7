Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C726C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9152171F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562638106;
	bh=F5o7VusCTe129hu9bUBA2LA07935eUvbMoaoc7rYNHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RU3zRzxx0ltfXdKMtfKihGeMgYrELbcyB8mbm0QS7Gc14+kQC8ItjaIWO4e+SH3fJ
	 ugeI3y1qgazcjtOFXXUA/GpLlMYYegQ1OKwtdjAfYfPxLgCanUja3MTaipxeeEmBCa
	 6bOkhYWZbM2QZGGaP9XMAO/idF93FM5ocxna2zZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGICIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:08:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34627 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:08:24 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so39862922iot.1;
        Mon, 08 Jul 2019 19:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IE1y5H/RT4r/zi1iX2xOXwKW7wkw1OFBCrUZWVZC5W8=;
        b=R36SjNb3EKqtumZzA/svkBCTltyfiGgCzIR0ExyY5uobxEEa9F4j8ZJBlfTE6pC6H4
         9sqWgfQK39V8J0XdO4u8jBzrsYsQB/rJabSh1MQOnSGwP+aH60m05XSJOIYogY1MLEuS
         bUpJC3J8Vl1kVAC06o+ZfsCukeNgFZSZfd89NvMYy8mbmdg9ZQbtLTdjSIjjbztSRjzU
         fqTTrwkqRt4z2Wi8vmbeYyl2QXzKyRa0gaJzEBEpQ9DDY6XSpSgO92z3jLFQikc68XlP
         pdz6Sf7pNOUVe1hQejVGk4R34CMvbCKhHzG9XgJEm24ojcr4NqOsHYRdxBleQact7Ro/
         oTxg==
X-Gm-Message-State: APjAAAV2A51UHaBKCURx60ScS2Yy5sDEmpiV3KTCdtPg+fL8c3CJzrod
        m8qdklj5wAHeUE4bnKH2Jg==
X-Google-Smtp-Source: APXvYqxw9ionkF3hJSPCFztvLR/KiHmiHCaYViAN5mgSRxikl8WumRTbwu0UQjSYlMv4d9Ikf3Cc8A==
X-Received: by 2002:a02:380c:: with SMTP id b12mr25269035jaa.85.1562638103827;
        Mon, 08 Jul 2019 19:08:23 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 8sm11880474ion.26.2019.07.08.19.08.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:08:23 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:08:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v5 07/13] dt-bindings: media: sunxi-ir: Add A64 compatible
Message-ID: <20190709020822.GA22749@bogus>
References: <20190607231100.5894-1-peron.clem@gmail.com>
 <20190607231100.5894-8-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607231100.5894-8-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Jun 2019 01:10:54 +0200, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> There are some minor differences between A31 and A64 driver.
> 
> But A31 IR driver is compatible with A64.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Sean Young <sean@mess.org>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
