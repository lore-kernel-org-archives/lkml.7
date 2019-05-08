Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4877020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lddLuZVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfEHMAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:00:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45489 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfEHMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:00:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so26814824wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T2xeg31dc/ZBxbHIWbLjD7H7dpFG60OUVvj7Jdv7Xl8=;
        b=lddLuZVKAOCm0oNoAZabWRrPTrQLvKaJc5kF2VVKskKXhvcrEUDOEVo/RyTR7uD3qz
         y5fj8XKkU33TYD4YN769APsn+8TLLeb7kcWEcTS8h8/n1BXSpfXkNkoJdxn8d39StcaH
         p2es9TYQdtE4kgMyWuQZnJ3NMeuzwp2PcLC+5UAxLQsKz2qkkne+uLMvD9mLRcHdar2Q
         PsGXQ9Y+I9wfk7agt+2TwGzbjuIJTtR1fzjuyFIADx6efyD1Ck7z+TNwGxQGfoUVEob+
         J5CE6BGS8l1f6wPauF+pnMt55WliRejkwYYU8ofh/qlIZPCmcx0hPmqLTPDTt3OIIRO6
         zJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T2xeg31dc/ZBxbHIWbLjD7H7dpFG60OUVvj7Jdv7Xl8=;
        b=rPqJeXwH+qXRd14bLtEbe10MrUFeIpVtJDz9EF9eAZIRD29oTXwZYNKbiOgDWNsa1L
         mojNPuPdbArHOZFu3pahFFZ9tmnZwpRX8fHi9tr9Dqu4jJpqX6KM0BPwN0OKJi/5BAJu
         Mxvf+hS+HQjNEBs7ZkUDQeHfTpF6ig2I/bh8M1X4ofPi+OrvnVC0zpjuwzsjWNYWA2re
         BgeTZ1gt7ez6CHTNn8kQTnaseKcqGQ2bWNikZnoOB6mGxhbuEI3Ang1Rss0xKkowGTkC
         Qr8RGS19IZvKtg1nQp6F4/UedlAb8A2wpMUo8g/MgwNLqxV3ZJOIv7Cesnswaf6S65nF
         7zQQ==
X-Gm-Message-State: APjAAAXXSb/aXUZzf9WalkvGw8/0nZl5MafcjxmP3WfK+02POxbElKgW
        0Nomyfw2VhmXXd2S9L+MNerArA==
X-Google-Smtp-Source: APXvYqxRuCEUzS1gZxeZM5OrxzKmdyoIu5v2RZFS3HTBuepBiL+UmrEDPkLGW4yU1rpRZIepP+f1Fg==
X-Received: by 2002:adf:c611:: with SMTP id n17mr3105122wrg.101.1557316807797;
        Wed, 08 May 2019 05:00:07 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id m8sm28445372wrg.18.2019.05.08.05.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 05:00:07 -0700 (PDT)
Date:   Wed, 8 May 2019 13:00:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: Re: [PATCH v4 1/3] mfd: cros_ec: Update the EC feature codes
Message-ID: <20190508120005.GQ31645@dell>
References: <20190508091956.5261-1-enric.balletbo@collabora.com>
 <20190508091956.5261-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508091956.5261-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 May 2019, Enric Balletbo i Serra wrote:

> Update the feature enum for the Chromebook Embedded Controller to the
> latest version. Some of these enums are still not used in the kernel but
> we might be also interested on have these enums up to date. Userspace
> can use them to query the features to the EC via the cros-ec character
> device.
> 
> While here, also fix a typo in one comment in the enum.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4:
> - Removed the patch to instantiate the ISH device as was already applied.
> - Rebased on top of for-mfd-next branch.
> 
> Changes in v3:
> - Fix Andy Shevchenko email.
> 
> Changes in v2:
> - Add a patch to introduce the required enums to build.
> 
>  include/linux/mfd/cros_ec_commands.h | 32 +++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
