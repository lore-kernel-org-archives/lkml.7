Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE8420717
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 05:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4C6n5EJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFFFUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 01:20:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFFUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:20:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so923269wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MtXzwtsPXMZuGm5S7Wt5QqtWB5p6F/HX65Y8+M45wGE=;
        b=p4C6n5EJHuI9vL+mnsfJhnxJhd2W6xHIE6RgPzS8Kin29QH0SWW8SrHd+/MkNiNgIx
         c0Q61roJTynhbgtXMouySryytcLFvX8mD0RvO7tBbZ6zj3O2/T6QqZULHJ9/8HwEun4j
         3kbwkoCMb3e8jKORTTf45GJTbW+PxWYrwGogre9RZ1n+1cU+2J+MphYPrJgC1uUrYHSH
         Zj4k1TnWRYS4wOgNTPOx3GQXY6Fz3oHlq8cAT7DZxUdrUfhnH1hu8MeiOAlLw2dHvSDy
         Kr20iC+BWnkx1UoaMTkzd5Ebaxo8Ny1nl89ECFnbsbmjOdYtwdGVgWizjSMGmrblF16Z
         yp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MtXzwtsPXMZuGm5S7Wt5QqtWB5p6F/HX65Y8+M45wGE=;
        b=SXBN/zMgucp9yjHs9brIucFiN7bUYmkoM5i2Xfu8KqxNir65ZKbTA/+49D/dM5Mu30
         Hztz9lHXnvv5Z2gEq4l28k1TZGTa+2cETbKKGmWiORtgJCi0ECaoy9u7RH5ZFtTy8Bs2
         U7VbEuDillHCFvqc+3GZ3Y79e4rJnOduy+8gdsyVuiJwpSSOoFQ3pVr6m6qqEW9oO+uk
         6IwGjMu6v9BRexh1+7wjp0CqB8nm8lm1Swot5XAcz5db1UiCBurBwXgh+ZkfFBVBVIS4
         XRz6wMkQvRysrTtXP+m9kFfni/RdnWBlMppkdfFPXfBAF2YUkQG/4SPhhj5TFuq3jmry
         dQog==
X-Gm-Message-State: APjAAAWvx3l6UH8jTO7/6TPpTjh1KvyFFnlFLN0NoZzg1aNnPMWZysvl
        xxshnpEa0AjlTn8ZkswtB7YtOA==
X-Google-Smtp-Source: APXvYqyO8Cc5NUJHvSF2a5vtpvToysuHvLAYz5b06+CRZQGvcWsO4Er19RBs9HCmzQT1bhXinH8ngw==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr1392999wrt.197.1559798431594;
        Wed, 05 Jun 2019 22:20:31 -0700 (PDT)
Received: from dell ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id k10sm600470wmj.37.2019.06.05.22.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 22:20:30 -0700 (PDT)
Date:   Thu, 6 Jun 2019 06:20:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org,
        david.brown@linaro.org, hdegoede@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] HID: quirks: Refactor ELAN 400 and 401 handling
Message-ID: <20190606052028.GY4797@dell>
References: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
 <20190423160605.9970-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423160605.9970-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Jeffrey Hugo wrote:

> There needs to be coordination between hid-quirks and the elan_i2c driver
> about which devices are handled by what drivers.  Currently, both use
> whitelists, which results in valid devices being unhandled by default,
> when they should not be rejected by hid-quirks.  This is quickly becoming
> an issue.
> 
> Since elan_i2c has a maintained whitelist of what devices it will handle,
> use that to implement a blacklist in hid-quirks so that only the devices
> that need to be handled by elan_i2c get rejected by hid-quirks, and
> everything else is handled by default.  The downside is the whitelist and
> blacklist need to be kept in sync.
> 
> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  drivers/hid/hid-quirks.c            | 64 ++++++++++++++++++++++++-----
>  drivers/input/mouse/elan_i2c_core.c |  4 ++
>  2 files changed, 58 insertions(+), 10 deletions(-)

Reviewed-by: Lee Jones <lee.jones@linaro.org>
Tested-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
