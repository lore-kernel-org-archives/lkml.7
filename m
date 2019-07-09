Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC94EC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED06217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562638122;
	bh=Z1DNXk5xit/B7YUSzac+SHkSKRmnEZYTSE7x+mSxprA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BY7Bx/zVsyvJTXuNIVyWb6bjm0r5dbtdwMr1U+nXBNOlF1FnGVYdBBO0WSxazL7UZ
	 aw9QBLS9UbPhmKRTBN389SUctuDTVCUtahhz9CrNsAZEleTUgaR+YROXiw+2Z6g42y
	 abEjZTLlXC7A1ZyWZNqR4202reWLvhtYr1IP5BE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfGICIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:08:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46425 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:08:41 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so39707184iol.13;
        Mon, 08 Jul 2019 19:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wW02jFZSaX8A4fbGCTcNYrXs8wdG93m32ZsgP4TKJAY=;
        b=jI7QSZhTpwVUXjFXjn5lrzcBSe21pZtTlbeVw3pKle99gI1itxn0ZKJm5cPlqT5jKk
         2QD3FliixHoJ4vMkX3Hg7yTZnMIDVwlzmTKTmxmxSPOyMyXKazQb2mD+mEkzuxJgbyDT
         YFRqatC9ELVbUkH+HDcsW29gGCycw6pIhjjK2dkU/Yg6pz6lgej0zzyaHnL390GvLDuz
         lBCPofWDblpiXVeE0hz7T9VkujyRbJfDTlxx/VWPbdSmBN4qw8zsr4ujVA4MMpLoxy7l
         UOp8elV0VZizx+i6ls1kh6xOAQNqS+nRyRiNYKISVJwDjlgtr4vJOD/L5h70qWUUmJzz
         gqBg==
X-Gm-Message-State: APjAAAUTBmQyJSQh++tEm0wvfeQHk7FKrZLryrVUjb2pVCub4iIt34Gv
        dQ/Ma5DRPKAHcsoIQPoc05Cx0K0=
X-Google-Smtp-Source: APXvYqxcQQE5qQSk7Mm64m/hLZNPpvvL4cOTHW4gDvJJAiCHDSQbpnBAXAreRsYB2rcKBCJdwN/+Jg==
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr2335199ior.163.1562638120102;
        Mon, 08 Jul 2019 19:08:40 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k2sm15537532iom.50.2019.07.08.19.08.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:08:39 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:08:38 -0600
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
Subject: Re: [PATCH v5 10/13] dt-bindings: media: sunxi-ir: Add H6 compatible
Message-ID: <20190709020838.GA23382@bogus>
References: <20190607231100.5894-1-peron.clem@gmail.com>
 <20190607231100.5894-11-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607231100.5894-11-peron.clem@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Jun 2019 01:10:57 +0200, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= wrote:
> There are some minor differences between A31 or A64 with H6 IR peripheral.
> 
> But A31 IR driver is compatible with H6.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Sean Young <sean@mess.org>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
