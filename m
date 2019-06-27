Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDD2C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51322084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6iCfd+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfF0N62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:58:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35581 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfF0N61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:58:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so5817614wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yPxiusgytclyAbyFq6njmSSLiDoSuvAd67bVV9/V9fo=;
        b=P6iCfd+KcP3OHawcKNeOOQV8cD7yZ1eOVnRFUiZc39lB2Cy63bVQ20KHlB+zXjL+6x
         QE5ReDNfuYirh1g3MBwY+v0B36xTxb+lbLFjyQ/KotEVvOflTKQmBccjqz98FMpTKIp0
         ABmJA03WF+Tk1TKkaaPVC6Ky5cc2qMabsXeLGOL00DJc4wWukHXeXnik0ZIbIc9/vgza
         XclQ8HkponLdIXHaqmUdLZ7ukk2gzmzD9vBvtm96ZHwBl40weg6nP9J6r8cyC7ILd2Vc
         UMvu1YQL1MdZ5JZG4qdBFaVquwr2sfzsI++IqBS9Tzj9eBBlN8LruV1F6JwHZxLpihc7
         L/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yPxiusgytclyAbyFq6njmSSLiDoSuvAd67bVV9/V9fo=;
        b=WIEu+/nYJpZQaTpyueVy0IkdZGwzmdU4DZ18gLO1zct5qxfMAm+hFWRsnbEyAnOBB1
         ssFLysVAl2C48WOsptawzt+qEHEhi+4KHXiu9yalkgstSjh4wneOCSw9xOZ/wFv+oSgh
         xlOVRKbEMECaASIr0aI6euYJjcPJ2bS8W9FCl2hr5xhO3iuNqk7GfJvS4HSG3fThQYGJ
         USYjZpbTjglR0jrSPDQyx7vVZrYom/eVDC3Z0nqml221QFuGsWYa4ez+dCqW6wfJouGz
         9DEkMUwaCXfRN6LjkYNU4EB03MmQfbVopLY7GG0uO0GBAuBYPKGZjI5nBw1rfgI5aR+K
         kP6w==
X-Gm-Message-State: APjAAAXwKZ8iLXFSSIkofQ2c0ikUPp1FjTwaPESNyxC2oNL6JiYmmL85
        +a4T6J7aRb6bAQhDG03+LeBjOQyRNhc=
X-Google-Smtp-Source: APXvYqymA0gPaOh8rlePb3B92zmbWrn0bYiouuseCQLkHVt9qjLYhXySZ7ih8v16HkNhLDDL1js8HA==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr3346926wmf.19.1561643905702;
        Thu, 27 Jun 2019 06:58:25 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z19sm7059597wmi.7.2019.06.27.06.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 06:58:25 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: nvmem: Add YAML schemas for the generic
 NVMEM bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190627080959.4488-1-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+er-MZY-Vuez3B48fb05AH9UzNZck=BK6xHutuXdfDTQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6775b9b9-b712-0b37-fa4c-ace9527f5fc9@linaro.org>
Date:   Thu, 27 Jun 2019 14:58:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+er-MZY-Vuez3B48fb05AH9UzNZck=BK6xHutuXdfDTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 27/06/2019 14:55, Rob Herring wrote:
> But you didn't update the license to (GPL-2.0 OR BSD-2-Clause). See below.

I did forward what Maxime has sent me.

Maxime, are you okay if I do that changes to this patch and resend?

--srini
