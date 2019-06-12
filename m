Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D73C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C86D206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KqIcPP4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfFLIkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:40:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfFLIke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:40:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so15913322wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jvm2cXxD836du/9Q0GoZYqu9SjdzfijtLuIQeM/4dwc=;
        b=KqIcPP4Q11BclQy9JX76y4ge6UO3PUxOJJGfjqcQNRLQpFBVg0yhKrM8OAdMZseIs0
         HpVn+cSKGwcGf4FGEQZKVZNfBF8zSBBAKdtP/agE1SmXV1gsWuqfvf6iNZEPjeMTPB7Q
         5RPUJpKSvzZqGy4oXQTW78DCoXy+ovVr9tn+eRfmJ96JJWRCywtK/NBoogiasLYYi2KP
         TijWJXbxJyR1dOR1J66FtfDoxDgXqizYQ7wVKNpkvVWYkEhhrbjFImEkWiMaedYeqnJa
         VJuPrXAn3ba9WkIHhEcjBK1ROoIfOapAvOVQrQtMqFMl0gfk8A4aQseTZTpJJHXEZ8QP
         Rd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jvm2cXxD836du/9Q0GoZYqu9SjdzfijtLuIQeM/4dwc=;
        b=hBSlopkJChe3MTZZxCd8YNiv1M1DHtzQP5TzCKEYIXUPOUE5bSGS3Xt23vzhafF74F
         u5ajXel87wMtGnXigDjNXEmObswYiykKh0hnDelmCaI8UIv9sHWn4qanJphBN2fs3qWY
         LTj2se90736HBb25TOWAJ6PrivslznMHEXi2mbHpgQYEoXXWOSVw9EkEC2/RxzUyxUXg
         rxKlTco4qH/PIfYib04jOBG7IpNi2Iic0grdxUEXg/HnbBAH+OF61tcDqB2+s6PvB9F3
         E+zZAJ4m2HQYuS+maaNZ1j3U3y6kMrcnzk6+b/4Kwu20MT1TQKxUwq8QsWLeStQNWWXD
         yXSQ==
X-Gm-Message-State: APjAAAVUrMfnc2JFMup1G1cDVLBEZGEo8vpIRgE2o4uiHEuDLNv0YlLo
        O/vinKfDRJNxU0YSyi8/bguyjujjrio=
X-Google-Smtp-Source: APXvYqwvffT9zDjm+/wNOMnBMqAGh/6+u0ZEpF1tQC6gY9fVrW25Z+xCvtiqZ6yqEIBrxUJsBrAgBQ==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr25390805wrn.285.1560328832504;
        Wed, 12 Jun 2019 01:40:32 -0700 (PDT)
Received: from dell ([2a01:4c8:f:9687:619a:bb91:d243:fc8b])
        by smtp.gmail.com with ESMTPSA id o15sm22067448wrw.42.2019.06.12.01.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 01:40:32 -0700 (PDT)
Date:   Wed, 12 Jun 2019 09:40:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 6/7] mfd: cros_ec: differentiate SCP from EC by
 feature bit.
Message-ID: <20190612084029.GB4797@dell>
References: <20190603034529.154969-1-pihsun@chromium.org>
 <20190603034529.154969-7-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603034529.154969-7-pihsun@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2019, Pi-Hsun Shih wrote:

> System Companion Processor (SCP) is Cortex M4 co-processor on some
> MediaTek platform that can run EC-style firmware. Since a SCP and EC
> would both exist on a system, and use the cros_ec_dev driver, we need to
> differentiate between them for the userspace, or they would both be
> registered at /dev/cros_ec, causing a conflict.
> 
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Changes from v9:
>  - Remove changes in cros_ec_commands.h (which is sync in
>    https://lore.kernel.org/lkml/20190518063949.GY4319@dell/T/).
> 
> Changes from v8:
>  - No change.
> 
> Changes from v7:
>  - Address comments in v7.
>  - Rebase the series onto https://lore.kernel.org/patchwork/patch/1059196/.
> 
> Changes from v6, v5, v4, v3, v2:
>  - No change.
> 
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c   | 10 ++++++++++
>  include/linux/mfd/cros_ec.h |  1 +
>  2 files changed, 11 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
