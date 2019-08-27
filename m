Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C619C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86A722DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566919602;
	bh=xLcF11Ipozhwa6MlhIeyfYaLRZXKjhZAg+MDQ5Z2VOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXTX9kZre3/zO/Ifi+mGRBPgb+92msL/qhtC0IGCk76UySZ8/ljFsf+FDeW5QVuGT
	 3RrNrDMMu6kTKvipeKGiJVy7LiSvWTxbqhcjQg/t1Wu5WhjAVA6F4MD5tjGQxWn18y
	 UHOQts6ns13nulmTf9TJ3fRXHUoTY3KCKfrvhXys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfH0P0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:26:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43292 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfH0P0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:26:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so19031742otp.10;
        Tue, 27 Aug 2019 08:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTabeQNKIt3DMf8V0lSBJbBI/KH3E3xsfnhmOPLsomA=;
        b=R7mZkbyu43HHUB/SzsM56uljTo0/0x2n0kDJjPgDzJP2blUWszDFUi8xWArUNWDGoA
         XsFofk3fzhCJDz6fvPdm/ovT7hMDg90LZ+JBiE19tI8bcdvNP6/2PTzvRZesj2YWXSPP
         KbmwznZq0lCzgyC3NZcU7aWHr1NNsNnuH0Q1NDe8rih3eSH7T8t6AAbq7DGCwzNsqZ2+
         pJESvXtNftqyl0WSRbTQdPBfMhahaBhOOSKCtw8uHJs0XozjAbQFVZp6KJbuwV8ZrfxF
         3Yoe44x0efwvjkxX1JTixQUy+vBO2C8Rr3MsMaO2qS8pXCU1o+TRd5SIbk6LSj3Yrzh0
         HTxA==
X-Gm-Message-State: APjAAAWhxH+Pjvhm1jNi2MzAZm9uF2oTI4YNj7/EIOJqiMiMCirZIyOv
        7sUQYmZUHFXzSn5fmLbXjQ==
X-Google-Smtp-Source: APXvYqzyhZACPtTqUFIzED5uPoZOA1rJSVxC3AZ5Tb22VDqDkoAUxKSKXJLmHkRDTp9/KaCYI1XFaA==
X-Received: by 2002:a9d:6a4a:: with SMTP id h10mr2300487otn.260.1566919600784;
        Tue, 27 Aug 2019 08:26:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d27sm5377657otf.25.2019.08.27.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:26:40 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:26:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5 12/18] dt-bindings: thermal: add binding document for
 a64 thermal controller
Message-ID: <20190827152639.GA25694@bogus>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
 <20190810052829.6032-13-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810052829.6032-13-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2019 05:28:23 +0000, Yangtao Li wrote:
> This patch adds binding document for allwinner a64 thermal controller.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
