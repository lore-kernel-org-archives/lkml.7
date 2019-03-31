Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5033C20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014429;
	bh=tuG+tde7UcSiBDxh394cf1kmuMpcx4Av/q+YGetcar8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CYQdqmc+b0/AdkesNgzwBPyxL9H0kcXSp5ozgT19uDMCWLuMqQvK2/WyzTtZS7v1q
	 1ADhXdVo/A5rXARFHJAyKXnflmXGQqJV2CPFm4XVgLavW8bWCkEJZ/u+t1Olj5poBp
	 hNXPTr4B2aJjFs3H4iSTyBJfSL0US45xmCEmx/A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfCaGk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCaGk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so2980525pfd.8;
        Sat, 30 Mar 2019 23:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBm8Vnx1AYs7Q5eJhNxPBF1vBH4iPjIvKHMwRRO7NBA=;
        b=HgS+lTJhtdUpPRFX61ZOce5u2aOs/nr5qqEyVHaKCZEFmr4DZnaF+kApMtrtTz0sO2
         97XdKoeQKsXxpHQgZJ5WwWy/4iBW3KIQUISBymEcW0IQae5zeysBnTxHMX/VPJNWLvsJ
         OJ+V5v/+pOIX9jy0HmjqctOFK8/9h71vzmIvCuIpuAsukKMTBGfi5xbWnO6XwQsnwwX4
         D+9/+qqE7sNBUVGE+lQczpKk/senc4pIbevKF9hia3r5HKUkUpG6h/8vW/uasPEsgr5P
         5mF2qkZLFgrMLZvEtTy3QNyDoW7tJwU84R33/BQ6s1TQI0S5zhLdV4ctx6BPU4XX/pzW
         KPgQ==
X-Gm-Message-State: APjAAAVkC+SFuDuJtD4eze94HIWYReZW5PjCrygS+CF473j0EpddUyWr
        T5ANo8k8cDNckBLIjjx8kydSP3CB7A==
X-Google-Smtp-Source: APXvYqz8Xao6zy4OEXpuKucVwnc2XTw+gFf3WAN+92JlXv4/zIsTCeWvw0LTDTpYp0YP+qI7ky3QFw==
X-Received: by 2002:a62:6086:: with SMTP id u128mr30968375pfb.148.1554014425963;
        Sat, 30 Mar 2019 23:40:25 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id c3sm12783968pfg.88.2019.03.30.23.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:25 -0700 (PDT)
Message-ID: <5ca060d9.1c69fb81.b8ed9.b975@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 1/5] dt-bindings: arm: atmel: add bindings for PIT64B
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552580772-8499-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 16:26:35 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add device tree bindings for PIT64B timer.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

