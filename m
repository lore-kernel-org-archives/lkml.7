Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A78C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABB120693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWoMlYKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbfGHQTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:19:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41256 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbfGHQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:19:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so7842252pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjxNl+aiJVwEFW037TdFYNIV+aj3YXwaO56vKokp4fg=;
        b=nWoMlYKCccZZ2MjCx59nKlI6EYqkKIeBd3VbbpagSDmMYpRzp/OD3BgiOWEYuxCbHp
         hshG8hoxEOe+kukeVrh4/jx/TZ68YiQ66RN87l3xj4+ZHxgfZDiyKl8IZWSvBbLTAAhf
         PgVHA7EibMHH0dxw6zx2gu7c5ZpZcCE2yj/5kied+vHtvPfLpLoEGJ+dTcM46zew/26S
         2H7uqEwqttTzFLDDGyeaU15G3izIPwX1r4mDmI0TffWtxdrEyVFmBEpAEu+ADT4u1d9t
         +8FRZg7hem0ic92FEHU09XqaNFM+SsZnN9nnke+wZ7B5eTYn/uDMvQrkg5OlP8KeOdD8
         CvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjxNl+aiJVwEFW037TdFYNIV+aj3YXwaO56vKokp4fg=;
        b=KsBLkYIzeOFiWDofZnuEJYOA9RfFKdJ9jy9yCZqdR1ToU3UMBO0q4MhbTSAnQZbP7x
         9V0Y0WnV/X97HA8oIu83Ly6V9SJ58u+46L+ptXPHkQ4XDY2c/pggVsvMXgfyx1M0k6Pm
         G5D4PGXMNR7nLaMAGBMjvCntJkhO7e/pTa6Q+JPNSx/ZyAFtk6+hQlqRS+VXsBxK1jyl
         42K1QjsvBdrU813ZoBxS3jvZElrkF7Y2ftIfFY1lVBgCBdpeTx926GO92k9XL3WOzoPB
         oh5GDlBj1StfYDMbyFsxhAqsuPu0FB5Cx5gP3HzcM1cpRy85WLqRnf9/btnIpY5/9rl6
         3FQg==
X-Gm-Message-State: APjAAAXGA+Ib5LmZOaAqGHJ8acbTbuFZTlVraJNVWZd2uP9BTfvfAY74
        hyc4yEHREvsZ1klBoLhAbon+pA==
X-Google-Smtp-Source: APXvYqwij11T4wwzyudmfil9rmzXYXboSTKEP6zw+14xHbmF42E/H/8UkklpLuq3ltX0xpIwSD4NLg==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr26270251pjb.138.1562602794573;
        Mon, 08 Jul 2019 09:19:54 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h9sm4072165pgh.51.2019.07.08.09.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 09:19:53 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:19:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/14] phy: qcom-qmp: Replace devm_add_action() followed
 by failure action with devm_add_action_or_reset()
Message-ID: <20190708161951.GD27383@builder>
References: <20190708123401.12173-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708123401.12173-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Jul 05:34 PDT 2019, Fuqian Huang wrote:

> devm_add_action_or_reset() is introduced as a helper function which 
> internally calls devm_add_action(). If devm_add_action() fails 
> then it will execute the action mentioned and return the error code.
> This reduce source code size (avoid writing the action twice) 
> and reduce the likelyhood of bugs.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index cd91b4179b10..677916f8968c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -1837,9 +1837,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  	 * Roll a devm action because the clock provider is the child node, but
>  	 * the child node is not actually a device.
>  	 */
> -	ret = devm_add_action(qmp->dev, phy_pipe_clk_release_provider, np);
> -	if (ret)
> -		phy_pipe_clk_release_provider(np);
> +	ret = devm_add_action_or_reset(qmp->dev, phy_pipe_clk_release_provider, np);
>  
>  	return ret;
>  }
> -- 
> 2.11.0
> 
