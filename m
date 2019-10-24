Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B7CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E83F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BS4uHZj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408681AbfJXHpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:45:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404543AbfJXHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:45:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so24429778wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8MK2RiHGp9pfjrS4QwXeKc1hTbmxkxbMcmyOE1JRjPo=;
        b=BS4uHZj02H9pHROzkNytyfGEeihxtX3ez8mKCnBn1j0Nwm7cdKvjQx3zCwpnFPYQCh
         uDhK5AxafL4DhOSthXh482PXDCYOzesxOibOlgdHGRGC7an+353zMO8CwjKXOz4y4KqL
         YjyHUzuHhxMl4CmS+z3OT1O9nSXOVSNeBBWbHJVbDBtZ8TgKAc3q9LZgLmvhH/yH2+WJ
         Y3Df7LCFlmT/9tgP536xkEbGu/8t6d6hDiatl3cZCJH1NQVykAR8HvEE5c2MIBuHQ4bH
         s0CAK/QHX39U9muY1Zzg7SRnECp7J7KFyf7WxY9yrq8J6zHtsH5tJsl2/KD6InNdRv+Q
         02Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8MK2RiHGp9pfjrS4QwXeKc1hTbmxkxbMcmyOE1JRjPo=;
        b=DE65bvkG8m+KY9PDa9Bilkggg3Qg9dLEifI36Qvfo6Qlf6CSQKdbu870UjHbLu5HC6
         KPFRIrhFr+GIA4yxI1MUAtmEZAkJbF3lTd5brPWChmzNavnfuCrFx1IT2FpQLQASifms
         E8XWM8T2Nq8HOzESIEZ7lJ21zNathJot+kcgKULW/Crnq0IVtbVZu0ZIPeeOA/vLdwej
         alu3gtOgM6V1+v/BprGCcNlXFJBcMNgtqovIst64eVlMJsu4nivd1FPfUA5rRHClqoxQ
         2AjbHtq+SK0gZXlfmlHpQfj3Fl0wF0T9b1H4odhAQLoS0QeDdmUG85/67o2eRccBvgaf
         jvNg==
X-Gm-Message-State: APjAAAWp6otEsU5K6HZ4xTtO76D4FQtjcXt+E0A/jJRnZhGvxZ+uF8Eo
        CMr3QPTgQGaK1AldpCW6KAHE7g==
X-Google-Smtp-Source: APXvYqyEr3q0Nm2hhAwoaokgMxptO8L61VsET/ldJA9eV2a+9od8LMt+6olKH8GD8q4y6CF45PZ9VQ==
X-Received: by 2002:adf:e64f:: with SMTP id b15mr2329545wrn.372.1571903108303;
        Thu, 24 Oct 2019 00:45:08 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id x8sm24352249wrr.43.2019.10.24.00.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 00:45:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:45:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND v4 1/3] mfd: wm8998: Remove some unused registers
Message-ID: <20191024074506.GE15843@dell>
References: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021135813.13571-1-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Charles Keepax wrote:

> Save a few bytes by removing some registers from the driver that are not
> currently used and not intended to be used at any point in the future.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8998-tables.c           | 12 ------------
>  include/linux/mfd/arizona/registers.h |  7 -------
>  2 files changed, 19 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
