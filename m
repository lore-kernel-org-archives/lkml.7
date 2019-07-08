Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A4C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394152166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562620967;
	bh=9hJ+3MQFdcdqCeb/+gpDk/c+Iz7pPWjoKK5acwaq9/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mlRV8btW0h7nW5l2xPwhnlXlUkqJ42xl2g+f+VTTU8hiLzYC0EdX+Nuy/u5vSdjqQ
	 h2k2p6Nx2zy5lnb1PDqkniPNmJEtU9+SfaJkcdTRP/73DWRqwJ6NqUidoEi8lHFAD9
	 rdwxRI/ROth0DErSNIQDcZ3ytWatk2UBTBfY8OMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfGHVWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:22:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbfGHVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:22:45 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so23001753iom.3;
        Mon, 08 Jul 2019 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NSE5CY3redJsm4t7pRGU3s4fZIlD2BqMxCVPQ8FSzXo=;
        b=D/xe4Xmu7wluXapCVmOlm6+5VMspwstBpNLsPgbBdEX+0LWZBV/uN6T1dd5rAGRZS5
         fLl6r9OBT3NTMWdcACrHF9KdudccabR7S8pLL8AdEBjSQFbCohgu8ZI0OrRVzmRYhzPR
         4fqE+uOkBE5o0d17FXZhc/RVqx6+g0VzTQbEecqor6iGp27Mm4Pa7BGMfNwWG9QgrDs7
         DgyGtD3STpK8G2WWVZlIaOU9ncDv89GCHG2w3dGcPo32TZ5enWyaXK8E5Vnqud1noFrk
         oJCPWHOLJNzZzWSeHuvFTDYh/TCkgOfCN/WilwFHYNDkX/AfYzFTYN8Rx7zu940904AB
         dKzA==
X-Gm-Message-State: APjAAAWko8dEqzCTY0QcHDz0aCGHwfhsLO7hoXFZAn9z4Pvyz+wJdhLF
        B7cxH/P7ADLW0NwegDZ6pQ==
X-Google-Smtp-Source: APXvYqw5qAqE/dmkwfhr3DjK0T2ya0CbXFtEj4BEP2Zcfp4mzALzm2rCnDPK754kgXQMG20+5SSkmg==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr22342957ios.227.1562620964562;
        Mon, 08 Jul 2019 14:22:44 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u17sm15062781iob.57.2019.07.08.14.22.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:22:44 -0700 (PDT)
Date:   Mon, 8 Jul 2019 15:22:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: dt-bindings: rockchip: Document RK3328 VPU binding
Message-ID: <20190708212243.GA18200@bogus>
References: <VI1PR03MB4206A833FF54A3235571896CAC1F0@VI1PR03MB4206.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR03MB4206A833FF54A3235571896CAC1F0@VI1PR03MB4206.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 10:54:27 +0000, Jonas Karlman wrote:
> Update devicetree binding documentation for Rockchip VPU on RK3328.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  .../devicetree/bindings/media/rockchip-vpu.txt | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
