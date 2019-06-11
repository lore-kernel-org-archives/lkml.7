Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A1C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB36521721
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5nFuUQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406432AbfFKXXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:23:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46426 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405384AbfFKXXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:23:43 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so5755436pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4enqIBMnxmfNla3OgthjfzC+JEL8arxQKAIvidMiX7I=;
        b=K5nFuUQsN7VQO+zSl9vqwaxq21RiKWxVyA7za3Wuty4C2/wORzeC9FQqNxJLLCRjdR
         dijNEhp6cnt7nOBQCNdjHxsV6NqvlsPUn5newHxrwTreg8HoXbIiQzPoUhZU1jGWM/gv
         yEHJonPqWhGrPPTJGnSxjza4infoEeKmcxRmyuaUdgUB67MN3r2MbvpNc7UJFNdi/7Sh
         Ek4ub/eLAMOz470XvbKmzXlwZKhfT3Bsv7obWfp24RPFvVSlnFAp9hmN7yTcI0w1uxYi
         ebfVf1UMl2qBbOVykcM7sTuQucjYkTDnpkpWcm1Vlk2fvvFIcD9/TwH29rJvfdKV/Lu4
         AdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4enqIBMnxmfNla3OgthjfzC+JEL8arxQKAIvidMiX7I=;
        b=FEfqXxEHrUk9kU7P5xESp/M/akFlCDUCTs7LlO9WrG2S/Q/6EPujlzV2nsm+vnGO6v
         0Y2FySrU8fJ9UCFJXA5S0BMHI45DuNy01eI+SSoC3RIMPtI1jrFapxdVJPTe2cG3vM+M
         CberTq5GjkLzMs8dt52ws/HE4QAzj5yF3E6Nwbo97Z+7h066B2sCv0gSC6/IWD1sYCw6
         0x9sW8nNOlLc1OUwDF7mH7f9+YaA3QMfbHZ9icFKbw/ZNWbVvzLdcoaSCOg2+nFfnszp
         jINylPsx46RKpcVqDr0tlEadr+JKc30d/AHJWSvJkT/mRe+a9JquGFfuFWKrjwRQUWy1
         eeig==
X-Gm-Message-State: APjAAAV+MW5/3qIfHFKZQvhqmFOR/EFlHN7vBFKp8G/va+pOuQTDKax4
        e9uodx0v2wuWT207jVVt02wv8Q==
X-Google-Smtp-Source: APXvYqzITd2m4KxJ8pfadlI4Wwi/NqUG+384O2TzyHbUMFflAFd9VN23N+hXtlskx6SjaadeLaFXBg==
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr53522648plt.263.1560295422245;
        Tue, 11 Jun 2019 16:23:42 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a16sm26468426pfd.68.2019.06.11.16.23.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 16:23:41 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:23:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/5] soc: qcom: smd-rpm: Create RPM interconnect proxy
 child device
Message-ID: <20190611232339.GU4814@minitux>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
 <20190611164157.24656-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611164157.24656-4-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Jun 09:41 PDT 2019, Georgi Djakov wrote:

> Register a platform device to handle the communication of bus bandwidth
> requests with the remote processor. The interconnect proxy device is part
> of this remote processor (RPM) hardware. Let's create a icc-smd-rpm proxy
> child device to represent the bus throughput functionality that is provided
> by the RPM.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v3:
> - New patch.
> 
>  drivers/soc/qcom/smd-rpm.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 9956bb2c63f2..a028250737ec 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -27,12 +27,14 @@
>  /**
>   * struct qcom_smd_rpm - state of the rpm device driver
>   * @rpm_channel:	reference to the smd channel
> + * @icc:		interconnect proxy device
>   * @ack:		completion for acks
>   * @lock:		mutual exclusion around the send/complete pair
>   * @ack_status:		result of the rpm request
>   */
>  struct qcom_smd_rpm {
>  	struct rpmsg_endpoint *rpm_channel;
> +	struct platform_device *icc;
>  	struct device *dev;
>  
>  	struct completion ack;
> @@ -201,6 +203,7 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
>  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  {
>  	struct qcom_smd_rpm *rpm;
> +	int ret;
>  
>  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
>  	if (!rpm)
> @@ -213,11 +216,23 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  	rpm->rpm_channel = rpdev->ept;
>  	dev_set_drvdata(&rpdev->dev, rpm);
>  
> -	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> +	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> +						 NULL, 0);
> +	if (!IS_ERR(rpm->icc))

This will be IS_ERR() only if the struct platform_device couldn't be
allocated or registered, it does not relate to that driver's probe. As
such it makes sense to fail the probe if this failed.

So flip this around and return PTR_ERR() here.

> +		platform_set_drvdata(rpm->icc, rpm);

It's possible that the device_register above finds the driver and calls
it (pending initcall ordering etc), in which case the child's drvdata
wouldn't yet be set.

In the other drivers where we do this we have the child to request the
drvdata of its parent, so I think you should do the same here.

Apart from this, this patch looks good!

Regards,
Bjorn

> +
> +	ret = of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> +	if (ret)
> +		platform_device_unregister(rpm->icc);
> +
> +	return ret;
>  }
>  
>  static void qcom_smd_rpm_remove(struct rpmsg_device *rpdev)
>  {
> +	struct qcom_smd_rpm *rpm = dev_get_drvdata(&rpdev->dev);
> +
> +	platform_device_unregister(rpm->icc);
>  	of_platform_depopulate(&rpdev->dev);
>  }
>  
