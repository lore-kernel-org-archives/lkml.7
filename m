Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32EEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9689120C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vd8lWUxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfHFKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:03:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45695 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732584AbfHFKDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:03:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1so986127wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yRfiZQS/MLeED/+UleHvJbVSuxRbNh/I4+CcWmfu7n8=;
        b=Vd8lWUxERdFr52N+7CmJG7ZCxbUmKHsZXQh/8skgu8vMxG9PVFSXBzzcln5FO6DyvW
         mtkMK5yR8FvjgO4K37wqDtozL3n0WKWD/gXnWUPDJt/4RKXBvdnwwQw/sftROFIc5LLy
         vaSyVQ+9t66RxvOMcyqaqAwgeFLjHc75DlnMNP4fdX56X+FlOO6hWY8a8h66+UVEJL+5
         nqHj17rHatoPqHzs0Y76G2CZo6IoL3bT3NcQi3UcdBTpGDFgWPOd6jMu02TOKFGvrPbu
         hzf23irMD2GsWBeFePeEoCR/KE+J6aPg4akZOsMjLSKfY2bYvnIdwyTkYeYi7nKkYHvD
         +uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yRfiZQS/MLeED/+UleHvJbVSuxRbNh/I4+CcWmfu7n8=;
        b=JEM2+rMece6zHgpkrkNKl1MduoM5P2IzfNDQfkairHfflv1cI/5qWkCUjeW7FSKdbO
         ctyw9l4JDqbQb0GY6MAArRv1B5vc2avx6OKp/dvrhfSFPUO1+8Hv+3MK9mdQQFUr/0aI
         jO1EpAsFevT+0+U/xW6drBhGB/6hata15P66Q3ZS584C5FbJbR7R49JsSr2L2ZY0+4Sk
         i+tOYZwgMbR4pBQ78ehBCaoxhIfo+txE8nyedV/iNsR0iijBzgKXvRtfdqfBbAv03mLZ
         2l9S2d9cBq23p2ylfSI//CekU+TmmieCCD7vqZqZUuXrNEViV9RruTJ0BXkHjMTdUyYM
         DBig==
X-Gm-Message-State: APjAAAV/uqjIglIpY5d4by5d/oiyDjSz8M/zWnctQsL2iUkqNw9uZ3HH
        oZgcpcFX942G9werAvSb4UHZvw==
X-Google-Smtp-Source: APXvYqzagEuL70h0nJNiwsRJzSzRRsUyeFmpldhU1sRM+F+c6A1G1ix0bnDeLmhOnsF1ZMs7mjqZ9Q==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr3830434wrp.158.1565085830815;
        Tue, 06 Aug 2019 03:03:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n9sm134635207wrp.54.2019.08.06.03.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:03:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvmem: sunxi_sid: fix A64 SID controller support
To:     Stefan Mavrodiev <stefan@olimex.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     linux-sunxi@googlegroups.com
References: <20190731071447.9019-1-stefan@olimex.com>
 <20190731071447.9019-2-stefan@olimex.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9b26646f-f8db-cf8d-6f47-f2fbb0ac41a8@linaro.org>
Date:   Tue, 6 Aug 2019 11:03:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190731071447.9019-2-stefan@olimex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2019 08:14, Stefan Mavrodiev wrote:
> Like in H3, A64 SID controller doesn't return correct data
> when using direct access. It appears that on A64, SID needs
> 8 bytes of word_size.
> 
> Workaround is to enable read by registers.
> 
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>

Applied Thanks,
srini
