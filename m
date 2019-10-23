Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA6CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54742205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Xj42kaG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbfJWUVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:21:46 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39770 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390286AbfJWUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:21:46 -0400
Received: by mail-wm1-f43.google.com with SMTP id r141so259224wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvlbyXuPyFTwAied7QnteSmnSAks0nnDSQo1KMTiaVE=;
        b=Xj42kaG68KB2VqgfIb5WaldkwjZPYh7u9UuIqn13LK273eVvgXA00Y6Cswp8d1l7qz
         T4/UEKKv7M1R1vyNyt7A7scnybyl1yjgaLmKbryMQECyRBLKXIo5TbE8jP6iPxa6Lsp1
         erAhoFjfmB25XdzGmrcYkhnwlrc9jd7YJADBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvlbyXuPyFTwAied7QnteSmnSAks0nnDSQo1KMTiaVE=;
        b=i6U3EPsVWndoBAjj/6T9p8TR6qUNYMEkerG8SxEIPVIxuNqYmo89kpRpnzTFt2RjeS
         gjOVWALkiXb3yJV0/daExjjMARjpzNoLWEk9b/5zTJbG1Q4+X+d2ty3e7mrIs1eA/MDC
         oe6VCSSua1FaaQ8+DIbZnfuedhb25J9mWEyWct5eZqfj8VzkQO4Zs3wG36G4pRsalciu
         84GO5QDlRkHJBZMf6HldhDH7+vd2b4g39ESaWGsKLU54qF4fDwZMTj5pRTTZGFhJI8hF
         c5C4h+1guxwjThjN18WMdcBLsoDcB5jWWDcdQHeV5pjg2OJnElsaw5EtZ+NbgAFy694f
         6oLg==
X-Gm-Message-State: APjAAAUwxyclYCzfZTV4l+XY6NXzvNXr8tkSs3ysuSZtnxNUebfNKAmg
        SRzNzI8LViFu0hnPJt3Pob+4NA7425CN0uWw
X-Google-Smtp-Source: APXvYqx/TQ4n7MgqmhhUNyCHVlVoWUDwk6UPKxs7AhubFXQlhlXDfD+59nnAXt9e3Fhnux5l8ALyIw==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr1570137wmb.95.1571862102054;
        Wed, 23 Oct 2019 13:21:42 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id v128sm365873wmb.14.2019.10.23.13.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 13:21:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] backlight: pwm_bl: fix cie1913 comments and
 constant
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-2-linux@rasmusvillemoes.dk>
 <20191014072710.GE4545@dell>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d716cb92-4d72-f661-2ef9-2771846569e8@rasmusvillemoes.dk>
Date:   Wed, 23 Oct 2019 22:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014072710.GE4545@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2019 09.27, Lee Jones wrote:

> Applied, thanks.

I'm not seeing the series in next-20191023, should it be there?

Rasmus
