Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC88C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F822086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTBKI9dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfF0NqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:46:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39525 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0NqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:46:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so2653508wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/919te5EBO6kM914CpYGsOFLurxjc/NmMo/1QG/Xa5A=;
        b=BTBKI9dx+mpus8NIgL8rNZrseG0p0dmEql/3XYjBX2kUKXj9ECVmhx6IvT3FV+qnnU
         /u3zb0JXUVXZ1GqpRjMtBoCObTp5aEsYQoiWEHDm0TnaZt3hPTTJBb/KGcqGOY7sFkKL
         TiLqV6ZhTKVP8HEx5hJkSQO9lRSdTHz/NgqzDdUu6nRk2S/yZ7sdYd/cvF80phZK6UjW
         1KoEwAiUCoumsxJpWunQvkVNeBgTZP1FiCdjcUlP7OkWuEm4LiICXfOb4RZ+0JOcJHPV
         YRgi1J2mJy6vvKWwKm3M3IWc/iLDaqRve6qoMshfNMxqhTSt356qB7DdSAjxDbrNL4Rt
         O5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/919te5EBO6kM914CpYGsOFLurxjc/NmMo/1QG/Xa5A=;
        b=MJ1uWcJ/R9zWAysvShyIfPjHwsI9we/3CeS6o46gFpJFniAVYKoIzwAfki3uiRppt9
         vPpwbI+eVjfNlQ4QuhJ/Uu7IetZUVt57imh021qJZAh4HOz9AA7Y7hO5x6NuCNFFdjbg
         WZXEgECCfQgJI3J5tXc1kNifiTOngImjmcwGREiaYz9MmMn1wDxVW6Qi6mG2f+rNd0aG
         xM2i2Uq2Mz3LxmrVTIjTFsU3tWNd3UFSyUrAmL3YTM4uBLqKZcwYvsAZDLHwhijB5VoH
         IVHhk+eKBXxZoLYTDXai+TWTlqwbk3jNncZaMdanmpk8j79MDWPCf/VEntyv053ZPw19
         a93Q==
X-Gm-Message-State: APjAAAVPvHRAqyzfs4g5PODEX6ZU+NxkXjnT9DWqP+lDC9RtA46/b5Tl
        W1SssqjnK0Qc8cf9zlZuyzMQoQ==
X-Google-Smtp-Source: APXvYqyzaI4+6KntP+zl6u1fbjYwGBVRfBIJ4qdqo0Zs/e5ASJSedLfMzV+TX57WdgXVuCe/Vq14ww==
X-Received: by 2002:adf:8028:: with SMTP id 37mr3363716wrk.106.1561643172103;
        Thu, 27 Jun 2019 06:46:12 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id s10sm1516126wrt.49.2019.06.27.06.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 06:46:11 -0700 (PDT)
Date:   Thu, 27 Jun 2019 14:46:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Fixup SPDX headers
Message-ID: <20190627134610.GF2000@dell>
References: <20190626133336.12466-1-ckeepax@opensource.cirrus.com>
 <20190626133336.12466-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190626133336.12466-2-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Charles Keepax wrote:

> GPL-2.0-only is the preferred way of expressing v2 of the GPL, so switch
> to that. Remove some redundant copyright notices and correct some
> instances where the wrong comment type has been used in header files.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/cs47l15-tables.c         | 2 +-
>  drivers/mfd/cs47l35-tables.c         | 6 +-----
>  drivers/mfd/cs47l85-tables.c         | 6 +-----
>  drivers/mfd/cs47l90-tables.c         | 6 +-----
>  drivers/mfd/cs47l92-tables.c         | 2 +-
>  drivers/mfd/madera-core.c            | 6 +-----
>  drivers/mfd/madera-i2c.c             | 6 +-----
>  drivers/mfd/madera-spi.c             | 6 +-----
>  include/linux/mfd/madera/core.h      | 6 +-----
>  include/linux/mfd/madera/pdata.h     | 6 +-----
>  include/linux/mfd/madera/registers.h | 6 +-----
>  11 files changed, 11 insertions(+), 47 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
