Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA41C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ACB24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxbUaQR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLSK6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:58:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfLSK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:58:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so5528915wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 02:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Q6JHWk739xDDCKW+bRI8JXmRfOhV3reXhjb+RjWQi4=;
        b=yxbUaQR0OaOY62E64p7ZtrGmCe3a9ltKn0UeAY1I8kENAnPRlhPjxRXUsfCjcW7Prc
         9GjsfCnqHewNZusceEgkk+HgioCdLhU5oqa0++U5yWLBlgoL0qfjJPUH+wKyVIMB4DF6
         PELUo7owpd/K6wlCOnXsvk+7KR0922E+nPCYiXWiyIvzF9O6LSeAQm+8j0RSekETk+Pa
         VcRIoh51OO4rMEl6Gp7jV/iNdUX7sBEt/+eq+SxQEvU1NyevVmgTgdZ6YL7iWyTVAfCh
         zd0Y2L6e8R+Xx9ZGhoMwrakR18R1S1gNLiDuvO6HfjYEhhg347fkOgaXxiL5PRQrmhII
         vUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Q6JHWk739xDDCKW+bRI8JXmRfOhV3reXhjb+RjWQi4=;
        b=JuI869PxcTlDfTqoD+wAeDZvuER4lxs9iyAuWjJGtUtu32nzxnavbGB+HJrCZCdlUS
         XUl7G/+5UHJiBR/oaAKKQxAOyl7EXppUC8vQvqYA8dqD5mfoXEltWZDZE7AZBoFFk6fT
         KDLQqKWa5vgk38cqHftdJGZr6L7lo7x38C2xf94Sucnabb/tai3id4czITwJhBAGUROO
         o8/wFpTgOTii8SmyRayE690i2ekueODAjc6Bi54jR+Zmmwnnn8Yx8alJrXOC+p5AwbE7
         DU/3RN8Hp2Qb07Xh33FAD33GboMqZjCPFa3MP8Ez6O+QEn/vdVNj7C8Qz7JvPKavhTAm
         KyXQ==
X-Gm-Message-State: APjAAAVi3lT5+f8iPGolT+aVpcYJDIS847L30i4iDAdO4NHWJwKe5Th1
        5zNA9xSMSDCgXDd9ks6+TtHUsQ==
X-Google-Smtp-Source: APXvYqyevHUNdO1kL91cdVZGI9VNIB5I/qkrBjCZMXQkbpy1kOC16zhPzTGGZBZVmaGZ+Jf3qbGYGA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr8413151wrm.290.1576753099094;
        Thu, 19 Dec 2019 02:58:19 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x10sm5918379wrv.60.2019.12.19.02.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 02:58:18 -0800 (PST)
Subject: Re: [PATCH v2 2/4] nvmem: add support for the write-protect pin
To:     Khouloud Touil <ktouil@baylibre.com>, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org
References: <20191210154157.21930-1-ktouil@baylibre.com>
 <20191210154157.21930-3-ktouil@baylibre.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <adc6cace-5ee8-5e17-3edc-79b35f00159c@linaro.org>
Date:   Thu, 19 Dec 2019 10:58:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191210154157.21930-3-ktouil@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2019 15:41, Khouloud Touil wrote:
> The write-protect pin handling looks like a standard property that
> could benefit other users if available in the core nvmem framework.
> 
> Instead of modifying all the memory drivers to check this pin, make
> the NVMEM subsystem check if the write-protect GPIO being passed
> through the nvmem_config or defined in the device tree and pull it
> low whenever writing to the memory.
> 
> There was a suggestion for introducing the gpiodesc from pdata, but
> as pdata is already removed it could be replaced by adding it to
> nvmem_config.
> 
> Reference: https://lists.96boards.org/pipermail/dev/2018-August/001056.html
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 19 +++++++++++++++++--
>   drivers/nvmem/nvmem.h          |  2 ++
>   include/linux/nvmem-provider.h |  3 +++
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
