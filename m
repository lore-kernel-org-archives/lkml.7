Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_CSS,URIBL_CSS_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428CAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6EC20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556304429;
	bh=QZEWODy8iMHnTn3GLqAdJA8si/S0cZPlnGn1Ge7JHFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c6fV6czHcCpYcDz/Lxg25UdQYyF6/iDXfNTzBV7viEMdO+/HXj8bEAidCw0CIkguH
	 8uzPC95K+p3fpxpuKs6hO5/wRVZlcVrQPjiBdxPNiyR536iETBJzbjqv0qM6G1RUWD
	 ekcJ2Cbmyww+fWu4mxG+LjMNHirxY1jnmK1YAOlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfDZSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:47:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45750 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDZSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:47:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so3479386otk.12;
        Fri, 26 Apr 2019 11:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+/Gzu2QgbHlVwuuJtKjCzgC6MZkAs1OZ4D6qZedx9Wo=;
        b=Fb8nUhFz4RJ4Rlw2Zb7A76pznrMjhItklTtFmuV9N4VjN0iiII3zximVzWeLG2CFUp
         vB+OriMfKlrsuRLwC53lpeLWoBVPTwabDVI6W1xtqNXMtFswLmdyNi8AiSybYofuyZ0K
         fnLsENXdImBvzaS+0fd/5ZXDnnWjzjmuFkmrwOVzZnNmSS4iu1arSdARS4KeiTuTAoGB
         8fiySQNKIuTxLf2ILRFb+YoN5elhRcMt60rPCuYmOlEa2wBs6gBnLKP+64kYgx6oruz3
         C1Ni0qDuVp/v44IFB1yHUGlhenEv04Nzuld+kecoP9qAlkxrjkevnkruCeCEsmb720dV
         tcYQ==
X-Gm-Message-State: APjAAAV7InsKAtzVSPNGpofGoUXfWeph+EVwjkbtp8l3uVp3chXGBXiT
        qf6ZhRl1MMmN5Yq1mMms33w05DM=
X-Google-Smtp-Source: APXvYqwpLu4yd/NUP5d7VIFzSA6Vgb6ArLSXCIerzuyKhSoeiLs2gqkSoMoCZ2e6C54tFpUEi9lTSQ==
X-Received: by 2002:a9d:6a18:: with SMTP id g24mr4219334otn.35.1556304426500;
        Fri, 26 Apr 2019 11:47:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 189sm11037015oii.58.2019.04.26.11.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:47:05 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:47:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH v4 03/26] dt-bindings: leds: Add LED_FUNCTION definitions
Message-ID: <20190426184705.GA9506@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-4-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-4-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:16 +0200, Jacek Anaszewski wrote:
> Add initial set of common LED function definitions.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>
> ---
>  include/dt-bindings/leds/common.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
