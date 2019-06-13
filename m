Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BB206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNrHcY49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfFMPkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:40:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34206 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388619AbfFMPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:40:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so5319135pgn.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BtWWHY6GZ+irdemUSJWfYrXBvNRLu0hF7sjwfuTufnI=;
        b=aNrHcY49yqaTJyE6Q+tcq+ByCZETc9h8PDkWq0+W++gEKy7j2NPlZU6hV1EbcwU5JD
         syMpCXwkWs5TvSjhBj0dlJ8OXOaPSIsvf+OeD+GtfT3U268ILHAHQv/IX5IenGtrARRe
         mw+Ixy3ns7L4JoriCdM9WDixKKSjBC1QwWOzr04uPPGdniZZ20O9mJrXgTFfJEgih5Gq
         xsZhXhsh3x6OiapwDDjUOYQy93/jGkxq9tl2mVQ9P8CLhEp+jPdJrfN163CeRm/3rsoz
         TFjq6hvlCZNEg2z5CsU7QsTd45nxBa2cAmJybVe9j+wsW1GqeFwLtlvc1VgptDh06dal
         us+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BtWWHY6GZ+irdemUSJWfYrXBvNRLu0hF7sjwfuTufnI=;
        b=gavhkDGls9JA78IajtGI6UcGWKlQiAdmVVl15edngqK8hsMhkxP17qRAgkXah6SCFy
         tSp+f4yEmikUr2AdzY9BT8magCAEGEjVafI5wPwFqVRO97USUSBbEIVlg1JUe1r4w4Pp
         e5BUjXt2A47ntTaDk44PNY/X6lmpjDq3eMeZ3GsmKvYwkm6y+4caEw6yAeZpeDwilxGw
         vgXKsRGnBlqsDccJK9Qx0SZTBGPmHwBrMjgiLUEAkXmhrg4JV8TOR44zR4OBClXYqdDU
         EqMUhrk74GEyB3gekaitflXDU1KDjOYa7/zpKcjtks48u5zzLMPeS4xRerbpi3ETqPFW
         qOgA==
X-Gm-Message-State: APjAAAUUndCvDQLIwVfWSv0yNFjwyuGVpXP9IsnacU4J14n+sV0TwDS9
        IlWbXaOyOR3//iL6lXKRt7+PAg==
X-Google-Smtp-Source: APXvYqxpwqyIFRk1hDuFYbqTrSYVOaA6be2OguON7QeZLUcNj0n7XkLaM6Wv3ud0JFfz6qT8pE7nUw==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr15241596pff.69.1560440405094;
        Thu, 13 Jun 2019 08:40:05 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u20sm54807pfm.145.2019.06.13.08.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:40:04 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:40:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/5] soc: qcom: smd-rpm: Create RPM interconnect proxy
 child device
Message-ID: <20190613154002.GH6792@builder>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613151323.10850-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Jun 08:13 PDT 2019, Georgi Djakov wrote:

> Register a platform device to handle the communication of bus bandwidth
> requests with the remote processor. The interconnect proxy device is part
> of this remote processor (RPM) hardware. Let's create a icc-smd-rpm proxy
> child device to represent the bus throughput functionality that is provided
> by the RPM.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v4:
> - Return error if platform_device_register_data() fails
> - Remove platform_set_drvdata() on the child device.
> 
> v3:
> - New patch.
> 
>  drivers/soc/qcom/smd-rpm.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index fa9dd12b5e39..34cdd638a6c1 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -19,12 +19,14 @@
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
> @@ -193,6 +195,7 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
>  static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  {
>  	struct qcom_smd_rpm *rpm;
> +	int ret;
>  
>  	rpm = devm_kzalloc(&rpdev->dev, sizeof(*rpm), GFP_KERNEL);
>  	if (!rpm)
> @@ -205,11 +208,23 @@ static int qcom_smd_rpm_probe(struct rpmsg_device *rpdev)
>  	rpm->rpm_channel = rpdev->ept;
>  	dev_set_drvdata(&rpdev->dev, rpm);
>  
> -	return of_platform_populate(rpdev->dev.of_node, NULL, NULL, &rpdev->dev);
> +	rpm->icc = platform_device_register_data(&rpdev->dev, "icc_smd_rpm", -1,
> +						 NULL, 0);
> +	if (IS_ERR(rpm->icc))
> +		return PTR_ERR(rpm->icc);
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
