Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C83218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWgglrbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfC2SfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:35:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37567 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfC2SfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:35:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so1452534pfr.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kSCQAW7dq7IFUwoEXSQ34/U4lmIJq7WYV2MIl57mkY=;
        b=AWgglrbK0gxXBUIwWnQgzqqyZCGSvsZTn+lEr15EjzOFLBkEIRXAJBmEEQ4sHW9bXv
         rLGnXarow7a377CZ97tjmjNuZUrUYKiq+J0weJNbT6VdHBubZPSSMLqRNFD9JXU9cv/4
         CaR5lsRSpCntml74J7Z1G09lT5Ft92GccbIBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kSCQAW7dq7IFUwoEXSQ34/U4lmIJq7WYV2MIl57mkY=;
        b=lVmcLEzg/+4n7iE1vJLq/4XdOuG6NQJdmQNU7nYzKk9Opm4Q2pi/a6Hhrv8DICY0ZT
         fj0kXxqebSd/MHMNiuX+pI5SoXCYLxs8wDtXLuTmKllTqcsZf6zjPPtV+JSH0Py5d46p
         3x2lUPGR1gWpmZA0yP8LBM5u5fRiaM1RLr+6xKy1zvfTSiuaTnR3g2MwC4XtL0i+5HDK
         fwMElizsM5aMQb8XiRlebPT2V3JuqXncAf/K2raeizrUsY9SxMQVRsAdsp5+PNS6SpEy
         cYdM1cWz1SSo044FwklPcMKDqsp0KOzwh9EWW+zQIYuSSAQ+2/F91nd+kqkO3ZsRhlFU
         mjCA==
X-Gm-Message-State: APjAAAUl+GUyxMaWYy0RK41L5iMkuNI44PpirqJL1x9ccUk/PxqMvT+w
        QQQXrB2WlCp0TfzkY42ZTS+LJA==
X-Google-Smtp-Source: APXvYqxm7ynm/UPgaZm7TQbR1bnYlP3UB2+8vrZm7DBoTg8sA4VmWrHCT8nN5ICsogVvClyJtBs5nQ==
X-Received: by 2002:a63:e310:: with SMTP id f16mr45879432pgh.93.1553884503699;
        Fri, 29 Mar 2019 11:35:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y23sm3805783pfn.25.2019.03.29.11.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 11:35:03 -0700 (PDT)
Date:   Fri, 29 Mar 2019 11:35:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: vctrl: Remove unneeded continue statement
Message-ID: <20190329183502.GG112750@google.com>
References: <20190329014631.17999-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329014631.17999-1-axel.lin@ingics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Fri, Mar 29, 2019 at 09:46:31AM +0800, Axel Lin wrote:

As Mukesh already mentioned, there should be a short description.

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/vctrl-regulator.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
> index 78de002037c7..259864520a06 100644
> --- a/drivers/regulator/vctrl-regulator.c
> +++ b/drivers/regulator/vctrl-regulator.c
> @@ -334,10 +334,8 @@ static int vctrl_init_vtable(struct platform_device *pdev)
>  		ctrl_uV = regulator_list_voltage(ctrl_reg, i);
>  
>  		if (ctrl_uV < vrange_ctrl->min_uV ||
> -		    ctrl_uV > vrange_ctrl->max_uV) {
> +		    ctrl_uV > vrange_ctrl->max_uV)
>  			rdesc->n_voltages--;
> -			continue;
> -		}

indeed, the 'continue' is pointless here. I guess at some stage of
development something else was done in the loop and this is a
leftover.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
