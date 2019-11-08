Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF21DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A52178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 07:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AqCytg1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfKHHnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 02:43:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34407 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfKHHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 02:43:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so5912605wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 23:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gNQtn7/uUN2ljx3dU/Odyrx4tv892gHBGI+Z3nZ9LAE=;
        b=AqCytg1X3jPH8kgfye9A9jb26I9SMoTFC+22F5Z1CyA3qarF0mZnlSuzvwb0qbQMNh
         p6nUXeqy2SAXn2BqmdUMXbMHmiqCvUrIrpZV+9BEwAFJa5QR8ENkHo3gNx1jkGOK6pw2
         8F2O4VDu/fgPfLNkpj6rf3BEvsg3oesPbqlR1fuqYEkCFOoP5zERf3x3qQErK9gFZVa+
         i1q39NN4t9jYLtqzXMYKNn1z2/9NUwQ/8v4nTJJsv6iZ6c8sFEreNfdb3zB/4lwA5jPb
         N0ZMhXUEALlO3YIOBxbBi7yZQR8o7o7hSCufXESr+QSJ2kFKTfckgSOF1G5NDeMhDRbV
         ZDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gNQtn7/uUN2ljx3dU/Odyrx4tv892gHBGI+Z3nZ9LAE=;
        b=UVlITnaHs5Xr37QDSl9/2L/xJ0jpT4qvCyVOSNonugREY2H0Z4sN7ZY32VKb9Z2vL1
         I3wQH5uM85kr6l5cMvWsHlxFcQruzc7ckSnpY4ezLAAz641dVGByjol/bJ8JcnXdncBY
         xyfDnDY1Sm9tLoS2gjuhhZm7Wcv/HukDwQv3vKm1EGB9E5Y4d4iCAyZt+YNVQNwC8mze
         5G9Xzlf0ZlfJkRF3fBteZa+seKmYlZTjJX6KqRQmddMjKq2IaFZoNZJ9+fLDq7AiFXnJ
         lLsI0DetR6/5m0ns7AZTJb4sGgHS9PpDQWu4t0RMnGYixwUgVuOnJwTWRCLtlDx5lSMG
         5R9w==
X-Gm-Message-State: APjAAAUfgsGRMxUCDkcp/l8RsfxV2gKVKnxO8zcCKsRP7b31nk8F7OX/
        +Jye5jYzFAOpFg6c7sJR3yG/9g==
X-Google-Smtp-Source: APXvYqxYjGaklh3lrhXXSL51hFVk11rNwqJLwFJ6E2Q13uV91J5H5IknfpzHN6C/DoGyNbBlcr1N9g==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr5554996wrv.187.1573198978705;
        Thu, 07 Nov 2019 23:42:58 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id a15sm4465660wrw.10.2019.11.07.23.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 23:42:58 -0800 (PST)
Date:   Fri, 8 Nov 2019 07:42:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: max98090: remove 24-bit format support if RJ
 is 0
Message-ID: <20191108074255.GB18902@dell>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Nov 2019, Lee Jones wrote:

> From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> 
> [ Upstream commit 5628c8979642a076f91ee86c3bae5ad251639af0 ]

Please ignore this, it was not meant for public review.

For some reason --suppress-cc=all broke when upgrading yesterday.

Sorry for the noise.

> The supported formats are S16_LE and S24_LE now. However, by datasheet
> of max98090, S24_LE is only supported when it is in the right justified
> mode. We should remove 24-bit format if it is not in that mode to avoid
> triggering error.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
