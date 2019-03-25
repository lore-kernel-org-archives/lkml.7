Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BDCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A230D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553551394;
	bh=AXimIyhreGVuv9mVtLtyAiUcs4M7GC0QkFEGZPfPFek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hXi/sTVtBBOy/4pvziCAt2aLZqXuexIDkKaGmHQQjrMjfdzKrLUN4FrAXwF5l5mQ/
	 pppZkRmVAlABHXDFR7RjKdVW6zQ0jkY8VI5ifiQpFEdaqV5UV1/eXiX/OME2D1BjIq
	 VT/WT8eyEdjirfySpwCAm8msetU/9rv8f5eGnhQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfCYWDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:03:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37535 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfCYWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:03:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id c16so9590619otn.4;
        Mon, 25 Mar 2019 15:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X6cIFFo+5iJnTuGtifmpuC3Mvexk6jLnF97JhPvO7Vk=;
        b=rBhwAjWi6XX0gX3R7CUua5gVjZ/BUWpJSMqLzzqaZ0eazNht0cVMuElvUE+SYFPIRW
         y4pMhTRW39TENjVQsFMAuNDcwtI2HYWJ6lbNWPt/MTrpX9XEXe1bRD7BPrX6PjMQ2wWU
         N/G93KCOpu1JaQ1zUgs8e/A7vL1uu92g3GgSHubZTtUxXaeCFc0e9BXBQWviFqJHdaha
         9a7bZgKhssh2dhudVT7m0Wqt964CrtV/7Iw6Y3hM/xhY8ARyUKcPLTWP9Z350gW1R8N6
         d5Zwwnt3y1rMxZ4peQ6QJrMc7vGqOvfKmmmmHnpLAfMKVgQVdg6G1Xaqkk9+0s9ba7Yc
         jWVw==
X-Gm-Message-State: APjAAAUWeiPnoRx8Ig/tMHib9Ohu8uFQap/Imq9MjbRBVMZmFt6qT9d+
        0XhrMnBtcBWPbL5SdEy4nw==
X-Google-Smtp-Source: APXvYqwUnKUqabk/5hXIy9C4asJJAp746TO0puiQW+9Se53ZyvCy4GkzAnkjzwZDE3DHt7O3WFc4GQ==
X-Received: by 2002:a9d:77c9:: with SMTP id w9mr16737896otl.197.1553551392132;
        Mon, 25 Mar 2019 15:03:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm6989278oiw.48.2019.03.25.15.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 15:03:11 -0700 (PDT)
Date:   Mon, 25 Mar 2019 17:03:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 6/7] dt-bindings: clk: at91: add bindings for SAM9X60 pmc
Message-ID: <20190325220310.GA18566@bogus>
References: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
 <20190220112605.23095-7-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220112605.23095-7-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 12:26:04 +0100, Alexandre Belloni wrote:
> Add SAM9X60 PMC compatible string.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
