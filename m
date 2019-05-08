Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E1C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C03321019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkvDCMSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfEHLg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:36:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53978 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfEHLg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:36:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so2833741wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1n5seRzjwFE2JAPpmlsAdvWESXCV7ha349PgP9YAChA=;
        b=EkvDCMSAAIpIhNQTKWiogMgrvUCaKx1SisounhivI7e6cgiHDQOTuOpMYOpAekljrs
         B8G2wIBZb83bRjCr4sMsepATJg2fM063cy/Ys8dXf0YkhF0CH/syRtdV6hsbwFq1neOX
         p0Y1blshiXio8oIbPDNaAqsiYcc33OMuPY8nbeCgKaXw34HqZolYc3f2uiMgF2U6r53m
         tV8EAFTwfpgw2iaglj/ZNjZ9GIFEc+WkE2qKWmjCjR/04RFgDq5kTJc9QNhpg2vgk6A7
         TXbGd0ERt4MJ8Yfv9cyRY6kUIO2pH8L22oK8KP7kfPfbsg/E7GnKHHjsvSEQyC6dQ2NK
         xuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1n5seRzjwFE2JAPpmlsAdvWESXCV7ha349PgP9YAChA=;
        b=ZYe5G0YUJH7bRiUoKdk75JnCBpIPBEFfTt4pbft4u/VzFi93KwLLnTPO+/ROuH6tKg
         muA/WUeDeIb7bNmjH9ZiIs7fEJsfZdgdGiVMzr1jnqleVWvo9PfIRIEqMP/6eMbvNhmT
         O+/+xHYTgqMr9o+gFjbNbdyuxofIaBAyjEEjotT/VVKl0SZAPdOTX4PAFulU9xnRfK2M
         kxy05sh5cE7P69HnDtuUwxClism7t0jz0Yo99wHVNqyx5RmgHrfjsm1J32cVRw/5aXBg
         qRIBQ5PQZJmjkG7eyUZfymCYzOde5OeeYS3wmBC/94rKc/Y8Eo4ImQ7FWPLR7oh36qFA
         ZzQw==
X-Gm-Message-State: APjAAAV3luKIt/qZ2xuDFRW+59UESKPQFeK1xgCORWut3ChRHqsXldeP
        XpeUoo1ISFjM/74dbvah80Z55g==
X-Google-Smtp-Source: APXvYqzdTuHQjmT/moThJdmQjilsHb4F5OpP8OfyK1Ch3EmrkCcjCc+533iIUmxF2dinFT5MliCHUA==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr2741998wmj.81.1557315415262;
        Wed, 08 May 2019 04:36:55 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id f6sm2784047wro.12.2019.05.08.04.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:36:54 -0700 (PDT)
Date:   Wed, 8 May 2019 12:36:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 5/7] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
Message-ID: <20190508113653.GD31645@dell>
References: <20190506191614.25051-1-dmurphy@ti.com>
 <20190506191614.25051-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506191614.25051-6-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2019, Dan Murphy wrote:

> The LM3697 is a single function LED driver. The single function LED
> driver needs to reside in the LED directory as a dedicated LED driver
> and not as a MFD device.  The device does have common brightness and ramp
> features and those can be accomodated by a TI LMU framework.
> 
> The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
> LED dt binding needs to be added.  The new LM3697 LED dt binding will then
> reside in the Documentation/devicetree/bindings/leds directory and follow the
> current LED and general bindings guidelines.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v4 - Made assiciated ramp bindings changes and capitalization issue otherwise
> no change - https://lore.kernel.org/patchwork/patch/1068618/
> 
> v3 - No changes added Reviewed-by Rob - https://lore.kernel.org/patchwork/patch/1058762/
> v2 - Made changes to reference ti,brightness-resolution to the ti-lmu.txt -
> https://lore.kernel.org/patchwork/patch/1054501/
> 
>  .../devicetree/bindings/leds/leds-lm3697.txt  | 73 +++++++++++++++++++

>  .../devicetree/bindings/mfd/ti-lmu.txt        | 27 +------

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
