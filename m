Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46428C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0915520821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy7nTfGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfDPQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:58:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfDPQ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:58:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so28128792wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMiIg/Mq+bijGm/ixxSYuFv6kDwHBQLwBH9rlQX0Cek=;
        b=qy7nTfGncEFJEplbaWPFmvnc2i6vJqb6RG1AzijryoBwwPCG1r0eKfcpSzmkjaoYok
         vovdsj+/RitCXQfKDSf4RUN16TjDca37pYfwolAibMrumh7KkeAntf/+gRjDHGjADRtM
         nLDeo/Z0ZMzK+b5dKxFTrGlcGalQ+cz8Kw4xNHlaNh2Te1tlcmfondymY5Sr1w4SVY96
         Jo+AdWvMURGl6UZXbYU8xmlUA59zmeUBD7FtrSHys+x745ELJw5gP9IAT3oW5swDA6Cx
         Q2bv+YfoZydBomV8+Qn3n4yw2iLhe3OQgKRQ3awd43txq+FBP7fKEA2xcHJ1ZWGxH7Zp
         M5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMiIg/Mq+bijGm/ixxSYuFv6kDwHBQLwBH9rlQX0Cek=;
        b=YUnmLunN6wG4M3ujyTGAEVobT+ZO4qihtLVc6ySDzHhQd0ZZXw0iux3hNXl0kW63jW
         kUuT55XwP4beBTCougAJzDbFxDnARixD3IBQNCX1oXPVoBFQbr07rJhtU1179I5nIPBI
         iszabCvY9Ee9Fmb+VZczfVs97eqbDxr7pX6dCPeHL2OuID9TckMjkFNq41eXurEXdtHp
         hoqkTpdYXgqNPIcv3q9YA4IPh7yIM4YNXom886Wg0C/+AXlJMqm/mk0DMDphiPqrIZFg
         vi71wE94k/maTgIjbWHHGzaewo0ToSbe8tvnop9uJurV/cdQiKmdsZGg0ngZAcOZN/2P
         vsYw==
X-Gm-Message-State: APjAAAV6FcZC6Aau0NZestSSrO0A5zkcH3lG8pzArXW5XZxcCRDBafcr
        +ExEn5RrJsrT3qSFzMO4BpbDkjFt1ts=
X-Google-Smtp-Source: APXvYqxYnIEmBkHtFTmDZCU+BzLiFSEzEjEu8bxiHA89I9s0WgaI8QqLR4PwfmWmyiRUD5MOCWDJ2w==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr31149700wru.266.1555433902979;
        Tue, 16 Apr 2019 09:58:22 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id 204sm31474547wmc.1.2019.04.16.09.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 09:58:22 -0700 (PDT)
Subject: Re: [PATCH v4 08/12] thermal: qoriq: Convert driver to use regmap API
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-9-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ca39b750-3fc5-2efb-5cc9-613962ce1496@linaro.org>
Date:   Tue, 16 Apr 2019 18:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-9-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Convert driver to use regmap API, drop custom LE/BE IO helpers and
> simplify bit manipulation using regmap_update_bits(). This also allows
> us to convert some register initialization to use loops and adds
> convenient debug access to TMU registers via debugfs.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---


Nice!

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

