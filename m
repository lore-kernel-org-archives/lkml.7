Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EE1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0ABE2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zxlp/In8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfH2N5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:57:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44318 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfH2N5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:57:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so1603625plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L/fpSI4uM40s3DtKV21QFlzEvXiHzEXWBGn7ZlQCExg=;
        b=Zxlp/In8ihfnhFT7qhAH2R05a3spmau5U90iJ7hTdtkHjQZY3eF6Ow334HIBgk1z6q
         Q671PJ/FC4BFrkm6pYSDFZfRUHxZABFe+DKE4gpwyc9RLdv2odedstcl2EWH7RlzCOtG
         itlcxTQTa6o4RuvHRBTBpBB77xOyuEDEzMUAbcsvdFvWVLmSUWagjTD3Mkui+jCOIYae
         gsnuy0nwI3xIXRsx/XSyJHhmAstMlBE/BONdafIFbpmAHqBexmGYAx2cUMqKC2//hdHC
         yC9htbtyMjdoCTLIV47cBc89SgohGd4JxVY5W9LWLlN6P7i5ssCs8vrw7hY9DH+7pBNJ
         n6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L/fpSI4uM40s3DtKV21QFlzEvXiHzEXWBGn7ZlQCExg=;
        b=B13ikAVfQMUXBTO03tRNlO9ofNWuQfDtSYI02E5XtozMyOGU1T1T/Q3qtZ6S39VvEs
         OvwgvwvtyhQsbGJ3y01WUMpgl699o5c6eQIANN3HWOPthwLdWRPUsWXchjwGOMx5xPUs
         ke+aR3Zd0wMqD0WQjHXFfQrzYo3oaYFWsAX/zjE4n1uqiZxxbfAAwc28JunjBtuPsBrf
         MUyNQRjWKhKBj35hO10SILXHuotYOQgqaIiqMw1rn9Cp2yDHM1/7wLmUVcv35s7PkJ3M
         e/BckPESY34HP2A1wCI4hdqmoIf9jkj2cHobMO0Llh9/zKWcKlv24BOd5ksQX1x0J4vw
         Y3+Q==
X-Gm-Message-State: APjAAAVQQUXqj1bGk3ECOuCKh/3Gf+MG1Mwxwp9Tf9kjef9eOhKL6RF1
        s+hbmams9ukmIInl2/aT1g53xA==
X-Google-Smtp-Source: APXvYqxm+AgQTYebWGBMOQFJ9WB+XGmtaCiDndt9/NWaE7skuV6+wfzm+5jNo5nLCEF9aVYHKO6mtw==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr9999672plq.108.1567087070623;
        Thu, 29 Aug 2019 06:57:50 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b30sm7138756pfr.117.2019.08.29.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 06:57:50 -0700 (PDT)
Date:   Thu, 29 Aug 2019 06:59:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     sboyd@kernel.org, agross@kernel.org, jassisinghbrar@gmail.com,
        niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mbox: qcom: add APCS child device for QCS404
Message-ID: <20190829135944.GI26807@tuxbook-pro>
References: <20190829082759.6256-1-jorge.ramirez-ortiz@linaro.org>
 <20190829082759.6256-2-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829082759.6256-2-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Aug 01:27 PDT 2019, Jorge Ramirez-Ortiz wrote:

> There is clock controller functionality in the APCS hardware block of
> qcs404 devices similar to msm8916.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Nice, I like this version.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 705e17a5479c..d3676fd3cf94 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -47,7 +47,6 @@ static const struct mbox_chan_ops qcom_apcs_ipc_ops = {
>  
>  static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
>  	struct qcom_apcs_ipc *apcs;
>  	struct regmap *regmap;
>  	struct resource *res;
> @@ -55,6 +54,11 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  	void __iomem *base;
>  	unsigned long i;
>  	int ret;
> +	const struct of_device_id apcs_clk_match_table[] = {
> +		{ .compatible = "qcom,msm8916-apcs-kpss-global", },
> +		{ .compatible = "qcom,qcs404-apcs-apps-global", },
> +		{}
> +	};
>  
>  	apcs = devm_kzalloc(&pdev->dev, sizeof(*apcs), GFP_KERNEL);
>  	if (!apcs)
> @@ -89,7 +93,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	if (of_device_is_compatible(np, "qcom,msm8916-apcs-kpss-global")) {
> +	if (of_match_device(apcs_clk_match_table, &pdev->dev)) {
>  		apcs->clk = platform_device_register_data(&pdev->dev,
>  							  "qcom-apcs-msm8916-clk",
>  							  -1, NULL, 0);
> -- 
> 2.22.0
> 
