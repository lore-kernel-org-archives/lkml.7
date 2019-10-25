Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB6CA9EBE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDAE21E6F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039217;
	bh=FejHKcLxUD6YZa9A0tJyNtYYQaYIFbX8ad+SM9QQ0Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N4QP7avqemJaSgkaIrjH0mSbN7UCKrr4kbXYxeFeGJ6Q76OrY72kMmCIlSG//9OZY
	 K/7ceQ5y07ztBWwSf9aAdcMGYxfIy043gsnFYCAXPFAMKBFeYLGfzRLXcdq+YFGYRj
	 oNIMRkLLNiDqOlhQnZHr7ffexiNlfFqZ5SwF8w3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfJYVdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:33:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44317 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:33:36 -0400
Received: by mail-oi1-f194.google.com with SMTP id s71so2530383oih.11;
        Fri, 25 Oct 2019 14:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=YVOI5BksXqXVDYjh4ZHfhwaKBf7oo5QOi6Ea1fnvZZA=;
        b=joRYFP9buimVYGbL4DeMgOM9yzLWMV5TFSeuGNLBXIC+KBLtdo7RcgNkb3F2T9h/Cb
         +ay4L+iWFU1fXZoXR6TmNGNcCKfGyiVz2/16USRdkFwHANMrGhHiVZWXXkkhzrglk2bB
         8Cj2u8VqDzwH6044NyMN194qgVJdPhAxVfOl0j5R9gM7b6pUOmT0KSoALlYhrqaLiiCN
         w5JOrNB1AvuqzrAp7W6qvmkBW5tvNW3yRToH5CgkA8id2Ue7ha92yP2kQ139HjsWoIpY
         uDlbWxGlZTgOSIEZqgdGST9Tr31YrE8guEFPT1IagKKDuAqxEHFiq3D749QZ3nQf6vNp
         tZUA==
X-Gm-Message-State: APjAAAXarS3it9Y35/V3vR6YS60j/eQ0PH5xnI9+8hAcOcJJLk4XywQK
        zxVBvf4SW+7ekUgxdgBGbg==
X-Google-Smtp-Source: APXvYqxYjwJxn6QbHvgIuZeN2Tf1vqbH+R6KZFoYsxBwWvCaHLGlk2Yy19NAAb3evbHiPlC//+mPmQ==
X-Received: by 2002:aca:c457:: with SMTP id u84mr4804204oif.35.1572039215372;
        Fri, 25 Oct 2019 14:33:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm1116390otq.61.2019.10.25.14.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:33:34 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:33:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen.Hristev@microchip.com
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: sama5d4_wdt: add
  microchip,sam9x60-wdt compatible
Message-ID: <20191025213334.GA23280@bogus>
References: <1571648890-15140-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571648890-15140-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 09:14:05 +0000, <Eugen.Hristev@microchip.com> wrote:
> 
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The Atmel sama5d4_wdt needs to be compatible with microchip,sam9x60-wdt
> The sama5d4_wdt driver is updated to work with both hardware blocks
> (sama5d4/sama5d2 and sam9x60 based blocks)
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
