Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CC6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12FE217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 07:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBbtp5r5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfGQHlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:41:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40905 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfGQHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 03:41:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so22567818lji.7;
        Wed, 17 Jul 2019 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lw/TXsCai4QfLzVGDhxj8a9lGFROKEp3oH4Hb/Wjn04=;
        b=JBbtp5r5XdlXLeZDGao53d1V+tIhgYx5qGpSMOyI+RO2cLBeHlTGYDKeG9Sz2n+uM1
         QXiwi68DGb+0/Jakfwo4ybAgBgIwNo/uvPuMgd7ohOmJFnj80kirl3LGQmUTjjQO0Mua
         Oiz7+zwPnibo2C7k5rg7sBvkkvziit3rhMF6Zskj9JkC1WFMygwGLn/Wh8Uy7ZR3vhKy
         gWTBtXGmFbnEXh3GzXmRiSDxgqjz35tjatnn8nHe70nSj0s/k9zNia9rwrPsaRh3p1Vy
         mgEwWsbKVTDCkixIwsfST+hMCrxSME+8e7QDG0Z6DZPGBcXFoXXfbK0hxxDNdyRXApYd
         Hfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lw/TXsCai4QfLzVGDhxj8a9lGFROKEp3oH4Hb/Wjn04=;
        b=hU/cb3A0o+GGl3NW5g8rZXVhgZt1vl6JM1H+PrWykOS1H+L/PuHmO8fMQSzlS2Gbwe
         HhP/OkOq0r3rWLENtLRY6eTVfCVWWVnkIoOpylAo3DAXJiHEMZAxrLZ23enxgEX/4Ys9
         8oJ+aRNyHxxRzJQKXRwRhiyFsDhbV/Ao7kAsxSsaLZsnYEX7a1tLEWHQBv8nV0uEI05p
         hBOLyKBcpF2Hi1lKNHpjdJ1Szp8k9NHBejh5U5D2iqZRIy4KGvrKu3b+CUFkDjEd61zI
         QJ2mtQ8Voqa7O1QMTEDynaq+JCvj/x4pAon15TnFl3uNVpkATZU4wzI5Il0Sj2gq3qxh
         4sZQ==
X-Gm-Message-State: APjAAAV64T2+05FMfNh7tfr2QM7X/CGTvnwQ2y/+euqFWPSkB/BQ5FiW
        GhhJEy6UBZs8leMSPiHxPyk=
X-Google-Smtp-Source: APXvYqy01rf35h70yn165Du8bC7FyaDXPuRrdrji0FyfcLx4MVE0lOGqceUOlRLkNKw0H7CNPuHH/Q==
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr19321093lji.84.1563349299875;
        Wed, 17 Jul 2019 00:41:39 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id t67sm4298880lje.19.2019.07.17.00.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 00:41:39 -0700 (PDT)
Date:   Wed, 17 Jul 2019 06:35:59 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Message-ID: <20190717033559.GB621@penguin>
References: <20190716221929.3782-1-lukma@denx.de>
 <20190716221929.3782-3-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716221929.3782-3-lukma@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 12:19:28AM +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The platform data once was optional, make it optional again. This
> is a first step towards device tree support for the mc13xxx touchscreen
> driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I suppose it will go together with the 1st patch through Lee's MFD tree?

Thanks.

-- 
Dmitry
