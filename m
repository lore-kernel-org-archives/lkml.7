Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92794205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552407251;
	bh=tJJ1Divm+qqh0sGztuq8oW4+oA3zEgJQ5tHx/cf5xgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zCTOX0fTVbPrSkVnqe0v2BmztPUuOpSYh0hddYhOquDi99ozGB5Sn4nNLnLjx8O0
	 t3P3hToTlPEPkirj95NRs5GGES7Jv2ruApgrQ/BH+GM1s/tT8aL08lwA0PX/huWxsq
	 m8SS8OvQ4re0dLGQy/PR+xcPmyO8Cmp3VHpvKPf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfCLQOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:14:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37319 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:14:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id b3so2998882otp.4;
        Tue, 12 Mar 2019 09:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKUhxTAul6cwTKknRmZAHzYNVV/MGLnlb4TN6Hep+yw=;
        b=fwsLbyLsNylWdyGX78CGrRXhJZ90c9uedYcEyUjxxu5EVs7Wz6dW++yFX0Sh0sxvJE
         lxcqtKaFTwulG5KNpisxDThAsjVWuve5oVrR0azeMV8rnctPrQt5TXXUzM/HSab4U+9C
         +bPLP/B0Pi48hFM09tOAKHWtBkhMSV6NOjsuO+Xm20Zr2vH+cnEsxs8clSaRUEz+IFwC
         gcNOukW6k0Db9Pl2ucwO3Ey0QNwkrLVy+9w1yBCh+aRxRP7kjqxDN/YF7PgzVxh6BatO
         mUmy102dUbzSJFcGIJyS30g0lLWD17n+0RgJVRTKQjzmuzxg9fBjBqCivLoYoFg/azC0
         N4GQ==
X-Gm-Message-State: APjAAAW/CAPxlM4XOhQyMRnAIql++Bdua+uH1GcoxyvAiFsRncQH3QeA
        o1FAxRJ/fV9SBpvMjhEFdQ==
X-Google-Smtp-Source: APXvYqxWrO62JBNCG9YA64l0oFTD1/z26IkhTK3MjoPn9Yz8Jlb7w4zlBcTtIS8IQdz6IAhUZLylUg==
X-Received: by 2002:a9d:5c09:: with SMTP id o9mr24880390otk.128.1552407249146;
        Tue, 12 Mar 2019 09:14:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6sm3738074oig.5.2019.03.12.09.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:14:08 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:14:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: Re: [PATCH v2 1/4] dt-bindings: Add vendor prefix for MaxBotix
Message-ID: <20190312161407.GA30150@bogus>
References: <20190301134155.ujtl434di6eb7jir@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301134155.ujtl434di6eb7jir@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 14:41:57 +0100, Andreas Klinger wrote:
> Add MaxBotix, which is a vendor of ultrasonic rangers in different
> varieties and interfaces.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
