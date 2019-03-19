Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390C62075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553028000;
	bh=z7iuGagrwEaBId+f098IfvLJJwkOy9SVQw22I4DA0WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0PA+zBA74ZmOdJtc44l6ZGTpfAF0en9cDSDOU2bWpe8muHykjLGvzaKIy8EkEgQau
	 gfd0T0YIX5VI4IwP0cCVvBluUv4+GA0YsvnkiGAR/a93etXKVfDfEYfL6QFXOHjSBB
	 UXmIQOHCDR8FiRgGZ7/unLJ771zWpkqOO2yYIIlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCSUj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:39:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44684 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCSUj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:39:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id w2so310651wrt.11;
        Tue, 19 Mar 2019 13:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SQjUGvbtviPeRdXVgSnXLx9Qu2xWq+9wjer0xhPxQc=;
        b=U5MiH1WHRvW2BPXSmbFyRMF/frJy7jQn8w/Bff0zURj9w9iWrSq9ghVezDQFmC0k/I
         MhmQ73qwzWJHMaugwWZVVHC8D0GAwoq+4VSsFzRk0DxAncWhcRgpvEQIi1CJt9jeMc9m
         NTWPs4OOsutJzHwUwIowx5WP1tnyEoaJ6pdMcESv1Rb7HRu0DXQog67d8gVcLc+48Rk9
         LoyBUN+KNNtHmrXZJNXYzvT52HxK32CDyL3LvMfux7Siy4DbFv0iLRxv39uyWK3bERwo
         jIpL+2QXZKs72xYOShJCcuVXDGdQ94yHuW1H0fjnzP9h0K8Tr6KwYDqDyaAsD3Ifgx8+
         qNcA==
X-Gm-Message-State: APjAAAUpOYePneuDOMjy9hBkcYR3iSc6P/3tEtnfTCs1rvSaYJAbu9QS
        s1QZBkXb/4fDN43psin2/I0=
X-Google-Smtp-Source: APXvYqw5wO64i6x9SmvLfDMXwqKjKjcp36TduqPNhf084IleMKCwzt92Ub9Lmu/DHBYUgXtl3EhL+A==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr18247393wrx.281.1553027996454;
        Tue, 19 Mar 2019 13:39:56 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id z1sm12539323wrw.28.2019.03.19.13.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 13:39:55 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:39:46 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 03/15] ARM: exynos: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190319203946.GB16150@kozik-lap>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-3-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551785646-46173-3-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:33:54PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-exynos/firmware.c:201:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
> ./arch/arm/mach-exynos/firmware.c:204:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 193, but without a corresponding object release within this function.
> ./arch/arm/mach-exynos/suspend.c:642:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 634, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Thanks, applied, with adjustments in commit msg and removal of Florian's
reviewed-by tag (I cannot find his email with review).

Best regards,
Krzysztof

