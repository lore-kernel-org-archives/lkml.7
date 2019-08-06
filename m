Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDBC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F31206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aU+lXWEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfHFI2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:28:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42351 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:28:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so37066284wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DVFYv472sz+yHZKlPnNeqX3YVoj+1DLyrPSYY32g1tE=;
        b=aU+lXWEv+aOZX4F54PjmzIgEBPB/5g4gVzTLgVwe3Bp34WRGMKwo1gwqyZI3EqndvQ
         66/UK0P6Dq4l56pAOqlTP98HZCwlFEd4r86u5zQ8jH05RniLtwMIIjeKX1QWZ+nrSslx
         yC4pHdFRv8CNIjqY8xXlS67znB9nh+bEO5mag1bOurVgi2kKUtOkEi6VDB11E3DaK1hi
         Vq6ok8XxOB0vlzLqvwVpOCM97SY1RXpTPoJ1z3nDyYg2I5+jWRXUPnYD1eneknocO3qI
         5O2OHzXRsEeSr9UVdGPwR4s2w6Y1UTr+UJtBhU4OhTePuKxapn4IZGNNVblETx64h74f
         UFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DVFYv472sz+yHZKlPnNeqX3YVoj+1DLyrPSYY32g1tE=;
        b=KvU9piKDKdJZjKzU29pN0NkjvbvSntzb93BYGg23Z6+6YynzxzuJE4yvcAcCaubnWS
         OJEBGA3SiGDhvObh0kr+m8Zn45ee/QtCSE1MV3pgTWzjCoqHFwhYPIqdHbavWqNAoeqQ
         /ZI8iHIwuYgHzysQcP+qFr2wF54RuQiPXJtbEybGRymonLvW/sXj+JRXtHrwZY74D/It
         5x3b1UgvHUhwi4X8YcwtL35VR97rkF8Gn/JnTQYCTHEnjYWi6lYSZEA12RditVh6udB6
         x78dTOyG7/9Fz+LM/ITp9zyrUYiI6qmW3tVQN1SaKUlN7h7yMUsQrnnNIlWwUERxRORc
         3olA==
X-Gm-Message-State: APjAAAXVeeRczLTYz9Jv1PUKHQwKf/HPycwT/F48ZY6dixZ8rCWAykXg
        3eDCMJQFS8T5fuN8GgoVvbhEnA==
X-Google-Smtp-Source: APXvYqzOLXGaercRAbrASDcbtLCTcSm2SMt3N5yX52X0q7EIRcAvf1mi5IUz8Fk3qAs/wmcB+8dmQg==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr3279108wre.248.1565080100382;
        Tue, 06 Aug 2019 01:28:20 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f7sm87293405wrv.38.2019.08.06.01.28.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 01:28:19 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, sboyd@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 1/4] clk: core: introduce clk_hw_set_parent()
In-Reply-To: <20190731084019.8451-2-narmstrong@baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com> <20190731084019.8451-2-narmstrong@baylibre.com>
Date:   Tue, 06 Aug 2019 10:28:19 +0200
Message-ID: <1j36iewvdo.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31 Jul 2019 at 10:40, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Introduce the clk_hw_set_parent() provider call to change parent of
> a clock by using the clk_hw pointers.
>
> This eases the clock reparenting from clock rate notifiers and
> implementing DVFS with simpler code avoiding the boilerplates
> functions as __clk_lookup(clk_hw_get_name()) then clk_set_parent().
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Looks ok to me but we will obviously need Stephen's ack to apply it

> ---
>  drivers/clk/clk.c            | 6 ++++++
>  include/linux/clk-provider.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c0990703ce54..c11b1781d24a 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2487,6 +2487,12 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
>  	return ret;
>  }
>  
> +int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
> +{
> +	return clk_core_set_parent_nolock(hw->core, parent->core);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_set_parent);
> +
>  /**
>   * clk_set_parent - switch the parent of a mux clk
>   * @clk: the mux clk whose input we are switching
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 2ae7604783dd..dce5521a9bf6 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -817,6 +817,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
>  					  unsigned int index);
> +int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
>  unsigned int __clk_get_enable_count(struct clk *clk);
>  unsigned long clk_hw_get_rate(const struct clk_hw *hw);
>  unsigned long __clk_get_flags(struct clk *clk);
> -- 
> 2.22.0
