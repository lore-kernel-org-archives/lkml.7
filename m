Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F34C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A6206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukzC1YlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfHAOfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:35:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46528 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbfHAOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:35:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so11050016pfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DBbtWFIFaoHfS1Xw8mVY2gGo1qmmgDJlGuvygEHXUSo=;
        b=ukzC1YlMrKl2Zkd5ltLu7k38qHxpiayU5PA7l4B3HV4Ggt7CMpLcPXepfvfa4mCAx6
         hsDWKt/DJD1zmpEooC/6Jfx9xzftaBHk92AXK9e4HivbgwDr73UwFaluSm6Gy1uAtI7H
         FUjGfO93eEafY6Kw9UYJN+aib0XGSsR1s2jJn53hob72yPf3Sx7GqVrObZlPQrJITD17
         ezgCxQoiSyqF/lwBINmAVySErBakC4cjvvZ4x4lBIHS02tRcPdUPLMhaWRXkbptlX99U
         CJPnu53ZP5q+XqIhpb742rx3MqeaNAFfi0Jh1f1X7Hoc8kmv513sBhnSQ8lVXA4u0q4r
         w8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBbtWFIFaoHfS1Xw8mVY2gGo1qmmgDJlGuvygEHXUSo=;
        b=IjaV4Ci7X6wjEAY6quiySROQmUxXbVPj21kXnCYYRCSye1HhjHSxDnkamZordQGt/i
         khFE4sUz+y7BSTuMf6YQcvQDDe1SFjUz+xOrukBapE9ZiYLt4TuOlOK3FTlmmpY81vaf
         HvSccbuWjVA3Qj6QhwUdBzm4JiS+I+YJLvPTzxLiHqr4MQwNoxPb9OeVdOnfVFjm3NdG
         G1jnnM647hyS1jJmS2ZqIHbBHloXpFWlXYXecGZjNjgMWcEXLuaSNh6URy3x3PQJ31it
         Dc6T5OmrE7ZhkNUF+aSsJAMOBdRYphZXdHGQXS2zjyGeg0AycUIkYe4j3H8vvmphxOxi
         fxeA==
X-Gm-Message-State: APjAAAUIeswi7NKgCU9CrsJoq3SThe5F7byjFAcfkNmarruPqskaApDu
        eyRewQQ8e7lJXThbTgKQY0fkqQ==
X-Google-Smtp-Source: APXvYqwXjf/7RCgtzVuCUVWsIvbZmbJwE7lAnb0Yae4AD1ql1RRC/pTcWA7lSmMxEe40EKRwaGIa+A==
X-Received: by 2002:a62:1b0c:: with SMTP id b12mr53059309pfb.17.1564670107026;
        Thu, 01 Aug 2019 07:35:07 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o14sm5101778pjp.29.2019.08.01.07.35.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:35:06 -0700 (PDT)
Date:   Thu, 1 Aug 2019 07:36:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jitendra Sharma <shajit@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add SC7180 pinctrl driver
Message-ID: <20190801143637.GY7234@tuxbook-pro>
References: <20190801100717.23333-1-rnayak@codeaurora.org>
 <20190801100717.23333-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801100717.23333-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Aug 03:07 PDT 2019, Rajendra Nayak wrote:

[..]
> +static const struct msm_pingroup sc7180_groups[] = {
> +	[0] = PINGROUP(0, SOUTH, qup01, cri_trng, _, phase_flag, _, _, _, _, _),
> +	[1] = PINGROUP(1, SOUTH, qup01, cri_trng, _, phase_flag, _, _, _, _, _),
> +	[2] = PINGROUP(2, SOUTH, qup01, cri_trng, _, phase_flag, _, _, _, _, _),
> +	[3] = PINGROUP(3, SOUTH, qup01, sp_cmu, dbg_out, qdss_cti, _, _, _, _, _),
> +	[4] = PINGROUP(4, NORTH, sdc1_tb, _, qdss_cti, _, _, _, _, _, _), [5] = PINGROUP(5, NORTH, sdc2_tb, _, _, _, _, _, _, _, _),
> +	[6] = PINGROUP(6, NORTH, qup11, qup11, _, _, _, _, _, _, _), [7] = PINGROUP(7, NORTH, qup11, qup11, ddr_bist, _, _, _, _, _, _),

5 and 7 deserve to be on their own line :)

Apart from that:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
