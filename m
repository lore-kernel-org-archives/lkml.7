Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BC9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908992332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xmpcf/9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfHUHNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 03:13:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfHUHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:13:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so921930wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0wJkb8pVe8d9YxnMKhtFvwVNyzhHysdsOlvVVZ4ZbNw=;
        b=xmpcf/9rnngZepnPB3E8+LA3qVd3YoawaOZYF2zXXKVMqvotUN6YQHR5z7E6Zxwh0D
         e1BS+SzOCbJ496qdvCm6bggGul24V41RGsA25GBqbPD4QXdmN75WxcbaaE+ov7wiiXWW
         eoqqNB/p7BwLiH+yXPals/BktP3uxVAc8g9YyVBKqr/eFpTV1HAT6sWzi2iPB1zf91Gi
         9Gmv5kXr5iAnpfuwA95ksddwOS3HFr33nYKIirX/yP+kSug4wTy+9aWvLztZveSCKE4E
         8XouN3n2u7WwyGik7YSlQ88s/Bfm2yaQ3Dn19Qvo8hhyfsFuQfg6Sv0ZfJAUXYE79ahF
         PIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0wJkb8pVe8d9YxnMKhtFvwVNyzhHysdsOlvVVZ4ZbNw=;
        b=nYdFpnRaYAVjRGML44obOHM0/bG+mHVFV6TJ5FiEq7NVDQ4kcMEmfMFQGUK6R+uGON
         ONXQNpfvqZZizr+iNltjaYWI9F9SX9DItkRe+v3ZTKV6xImgjZRd5hYXy4fKQoCilkZf
         jVKEiZXzvxX94lpTQiDWdTcLstqbX+FqZTYQv7/ZEgYJFcXRkIbsPevvGVcLOaZGcE7Z
         OBFhqmgLjIeaSO7losuUE99aIJi8U05TRSgCbb4nQKRTxg2w+3kVQzQXGFtNJDISXkPl
         PYbXeYFQsK/dVSncrbYthR9WydRrNVqLulp7wc4xJxNtHM7jQwmaWW0D0DajLJWQ+Rr4
         P/0A==
X-Gm-Message-State: APjAAAXtK3t451f3pUjOodv74qbcRV7X4+wSPWemE0PG2+esVGZTjJql
        DjJZr/w7KaQScsWwdZXbn7mBmtOX6/1COw==
X-Google-Smtp-Source: APXvYqwFFJik1iFafIKfu0BvGp54Ye3GQlCkroen7Fy00pX/7sbnIdk0TATnec2z1ROUS6qqu8HWzQ==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr37676642wrm.83.1566371620586;
        Wed, 21 Aug 2019 00:13:40 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z1sm27581936wrp.51.2019.08.21.00.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 00:13:40 -0700 (PDT)
Subject: Re: [PATCH 0/3] dt-bindings: Convert Arm Mali GPUs to DT schema
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-kernel@vger.kernel.org
References: <20190820195959.6126-1-robh@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bbfe4e3b-9e75-0447-544e-a0f8f6a19f20@baylibre.com>
Date:   Wed, 21 Aug 2019 09:13:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820195959.6126-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/08/2019 21:59, Rob Herring wrote:
> This series converts the various Arm Mali GPU bindings to use the DT
> schema format.
> 
> The Midgard and Bifrost bindings generate warnings on 'interrupt-names'
> because there's all different ordering. The Utgard binding generates 
> warnings on Rockchip platforms because 'clock-names' order is reversed.

Except the fact clocks should be required on all amlogic bindings,
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
I'll send a fixup patch to enforce clocks.

Thanks,
Neil

> 
> Rob
> 
> Rob Herring (3):
>   dt-bindings: Convert Arm Mali Midgard GPU to DT schema
>   dt-bindings: Convert Arm Mali Bifrost GPU to DT schema
>   dt-bindings: Convert Arm Mali Utgard GPU to DT schema
> 
>  .../bindings/gpu/arm,mali-bifrost.txt         |  92 ----------
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 115 ++++++++++++
>  .../bindings/gpu/arm,mali-midgard.txt         | 119 -------------
>  .../bindings/gpu/arm,mali-midgard.yaml        | 165 +++++++++++++++++
>  .../bindings/gpu/arm,mali-utgard.txt          | 129 --------------
>  .../bindings/gpu/arm,mali-utgard.yaml         | 166 ++++++++++++++++++
>  6 files changed, 446 insertions(+), 340 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> 

