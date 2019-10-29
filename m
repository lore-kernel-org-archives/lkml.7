Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47185CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D4420874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572375142;
	bh=Krc2pCr9LuPyN2uKv0HlZ/f2LrTF4Kh4UwUXzL6+wBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YM8349QY/S/LxqOtfQHbm62uby4W02C2xfxqRXc19IrejjnWJxo8grLbGSe6Lc6aJ
	 VOJ3daF2940GuIK8nIUAkxv7XNx7eHSngxsgW1xEIL8QSTeTuicD0H4zrXfNEmAXNG
	 fYRVVU0kFTep5dQhjCTYSMU2Llka/x8ujNruDyjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfJ2SwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:52:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36161 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfJ2SwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:52:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so10720657otm.3;
        Tue, 29 Oct 2019 11:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4jlz/kL2P1DJTOhPG8FEPuOrBDl84lxyvnWrHLEJJyA=;
        b=pdBpsmNU/c9ahJttJp3Fgs/IQ3UnjmudJXd4/8eQ/aM/47LW24NACJ+dHKFlwa68ge
         lpTCww4cQs7iqUbNDDbRoLl6ArzjDuijxRldzPJ3GrGDPXP00JEjgSiCicWUHB3ih8Yd
         8tyoyilmrbZFfCTOhQSLHJj76Px8HKDa6uxyi96b7XZXccaZXrb1g6Di5iRRJOCan3yT
         1r8d61pFI1lL2oST+rxDX2HnKFu5n8WFFqPq4h1EgN6HEJjY6LNzRj6HK77/NIerUCxC
         CdqpA2aAX4msnO0lgnxVrIOwkxisbwJkL4r8Oih6FNdodJBSkgM3vG8oIAE9rM1UF/b5
         x1Yw==
X-Gm-Message-State: APjAAAVQKB+29f27y2AGVB37syAEsYNDTRD6jcju2550Q4bTSablklbI
        9o8qDyxbUDD1q+vKEIN7qw==
X-Google-Smtp-Source: APXvYqy2ZH7KJ1dKJ59ixaELGPG82nNz0xixf9qaXzvb8Egunou3KEQXbwvR28QVZHsCASJKK5swMQ==
X-Received: by 2002:a05:6830:2001:: with SMTP id e1mr19040031otp.69.1572375139861;
        Tue, 29 Oct 2019 11:52:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm4040283oic.6.2019.10.29.11.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:52:19 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:52:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND 2] dt-bindings: max77693: fix missing curly brace
Message-ID: <20191029185218.GA18469@bogus>
References: <20191023093437.GA30570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023093437.GA30570@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 12:34:37 +0300, Matti Vaittinen wrote:
> Add missing curly brace to charger node example.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> 
> Resending once more.  Sorry again guys. This time I added also the DT folks
> and used correct email for Bartlomiej.
> 
>  Documentation/devicetree/bindings/mfd/max77693.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
