Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61698C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CCC2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8RGyzYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfEUR0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:26:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37403 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUR0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:26:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so1304084pff.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ji0VdzU5OHK1F6Sbp+YSXpK8rtBxFsIqpzSG7ymRqzo=;
        b=R8RGyzYX+KVy8m3zJtD+38A1CQR4ZeKD7IZ8knX4UBdcazCt+USKTWOEB5MTkdw/Fd
         f7WTG412wUr9M4tY1MwLdCYXU6mls6g0h6SjAl87o5Sbg45Q6T+ILmFXeg1SiNZF+J2+
         ms3TSb7ib9ND/W7bLRjuENhi8gH2ZooMHWYrdw2pkJMTOeCyXMNp4xWd+c+GCHg5LgO6
         odQztXqLSb63vlLYPkqUvg/k5+WXoxmJE0alaqzhkDfeCD4L5vvTLe49ZQGxICd2tXUL
         Tr7hW4wirXJwpclHYlkq2VP7GHXvJ5Y1PFcsWqwgS14g5h+A8XLIgwtj9Dw8OhyMQrIu
         mc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ji0VdzU5OHK1F6Sbp+YSXpK8rtBxFsIqpzSG7ymRqzo=;
        b=RIIMjEskUWW9xtqc2JQ0/m/JmNxAgeQPIxNdIHuoaJIdwxhoR08Jf4cTuctybbIK7f
         u6MgJJ3zJOm45XRYnmouFl9j48zFUqvbmngvh6DXG3oBjrOZfCIvR/Jhzixi5BgIaLRs
         NUKZLIVAuPYmNeMp1tTrjOznzC6OEa96eawiU1XBwHeGzSZKpxgV9q3fEkSHh2QFJZkf
         lkbS9qaCXuMMERd5GU/ZYsAB1agwH9jL3JER+wKpYKeAhGSX0k/DBDiLclgkQSqrvpP2
         V398QOo7SfT64AJgJnu36QtrXInqYEK9XBhLlfFuL/CFJpgBNHq3mjc3Jo6E2wLs4PUO
         hDzA==
X-Gm-Message-State: APjAAAWRYHYpExtE5hLhh72JQL9v3yjnpxLyvwYfXvRVkYpMNXkkc03V
        1CwTfDyqMO8zAdyYSMru+uUiVA==
X-Google-Smtp-Source: APXvYqxHPRhrUt8LyBPdVgl0BaXABlTIZ1JBG/HpULhXJEwb7w0zzAA5be0uaHu+Y/y1a/7Kx3iCuQ==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr81880080pgk.19.1558459572511;
        Tue, 21 May 2019 10:26:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k192sm21751525pga.20.2019.05.21.10.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 10:26:11 -0700 (PDT)
Date:   Tue, 21 May 2019 10:26:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org,
        jcrouse@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: qcom_spmi: Document PM8005 regulators
Message-ID: <20190521172639.GB2085@tuxbook-pro>
References: <20190521164932.14265-1-jeffrey.l.hugo@gmail.com>
 <20190521165244.14321-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521165244.14321-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 May 09:52 PDT 2019, Jeffrey Hugo wrote:

> Document the dt bindings for the PM8005 regulators which are usually used
> for VDD of standalone blocks on a SoC like the GPU.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
>  .../devicetree/bindings/regulator/qcom,spmi-regulator.txt     | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> index 406f2e570c50..ba94bc2d407a 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> @@ -4,6 +4,7 @@ Qualcomm SPMI Regulators
>  	Usage: required
>  	Value type: <string>
>  	Definition: must be one of:
> +			"qcom,pm8005-regulators"
>  			"qcom,pm8841-regulators"
>  			"qcom,pm8916-regulators"
>  			"qcom,pm8941-regulators"
> @@ -120,6 +121,9 @@ The regulator node houses sub-nodes for each regulator within the device. Each
>  sub-node is identified using the node's name, with valid values listed for each
>  of the PMICs below.
>  
> +pm8005:
> +	s1, s2, s3, s4
> +
>  pm8841:
>  	s1, s2, s3, s4, s5, s6, s7, s8
>  
> -- 
> 2.17.1
> 
