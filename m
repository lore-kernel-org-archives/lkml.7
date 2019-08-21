Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B193022CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 23:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzsNA61d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfHUXCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 19:02:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36826 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbfHUXCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 19:02:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id f19so2187594plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NpuoQpLKK7WyEkPSccJxDwY6STNHznjukxBqZ31nzB4=;
        b=OzsNA61dc5J+KQA9dM2aHRJYNGKNDPTCblKWMfh4/UWZQleUwplGb5CCKwPToD2cAx
         FcMT/7tDtdVWavTPAWVuj5i6ncwyz/OL+I5ZYxCGCVDAQc6/h0IbKyyzsHuaenGNWz2t
         kVRQWGtQDOvlsg9SnUnKU5a8c7Rl2oVR03N89QrWEiFdqERXBcO8tLGd2qenDJtofH/S
         CTg+KgIqan+qgQUiT+ijzNLnvIBfAYWyyggsooT7jNIIwN8LTAHCRtPosnqlYk1Tdn29
         +heKXNQ+NGewltTzenkU+cpu5vI4OJ5qup2kjb28r5SW2hZ961Aw8oyEZV0ZfLcP/dxf
         WLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NpuoQpLKK7WyEkPSccJxDwY6STNHznjukxBqZ31nzB4=;
        b=Cm6joGwINjH0ZrH9haVypshIGZeIpvmHEpVw4lxrJyN1l9gtdH9lAfRA63fm3NQsHk
         XHfLgq+v9lB58tUfllaqZfOJ4aqEZjCxzuW9SKsj5zgt84moi8ylYWqbr9q/ZLCOsE1q
         N2Ok4Dh+Ah2ZLa7RAgejT6g58FAGRgYhgwf4omFI+2ysk+AglvosYCcK/Iwug6zhBtAP
         oOWFWM+cVPEt3TwBADEZWmw8tV10OqsGnJpqiETaq/ZTXVxLPsnk/RkBqN0HoAsa1E/t
         8X4WKsU+T+6ViZjc9z34/hv3dYyRBZQzjthOIvUfiw92NbsRNoJ3Po1EOTCTdHzr46Ic
         l2bw==
X-Gm-Message-State: APjAAAV/q6V7r3p/wDGAkjlqscxX/0pAwLqbXUWnHgywZ85JlxwposTC
        fqp7AaYYifQkVaECwF1xeyq87A==
X-Google-Smtp-Source: APXvYqxkzHLGY8L8dgDlNxoq4G+xKv8wVs2YvpjbObYmqSCZZWIvjwfgn1krBkgU0vu+qoeM1SVaXg==
X-Received: by 2002:a17:902:4201:: with SMTP id g1mr36449071pld.300.1566428530503;
        Wed, 21 Aug 2019 16:02:10 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 67sm968321pjo.29.2019.08.21.16.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 16:02:09 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:03:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, vkoul@kernel.org, aneela@codeaurora.org,
        mark.rutland@arm.com, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        clew@codeaurora.org
Subject: Re: [PATCH v2 0/7] Add support for Qualcomm SM8150 and SC7180 SoCs
Message-ID: <20190821230356.GB1892@tuxbook-pro>
References: <20190807070957.30655-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807070957.30655-1-sibis@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Aug 00:09 PDT 2019, Sibi Sankar wrote:

> This patch series adds SCM, APSS shared mailbox and QMP AOSS PD/clock
> support on SM8150 and SC7180 SoCs.
> 
> v2:
>  * re-arrange the compatible lists in sort order
> 

Applied patches 1-3 and 6-7.

Regards,
Bjorn

> Sibi Sankar (7):
>   soc: qcom: smem: Update max processor count
>   dt-bindings: firmware: scm: re-order compatible list
>   dt-bindings: firmware: scm: Add SM8150 and SC7180 support
>   dt-bindings: mailbox: Add APSS shared for SM8150 and SC7180 SoCs
>   mailbox: qcom: Add support for Qualcomm SM8150 and SC7180 SoCs
>   dt-bindings: soc: qcom: aoss: Add SM8150 and SC7180 support
>   soc: qcom: aoss: Add AOSS QMP support
> 
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt      | 4 +++-
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt    | 2 ++
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 5 ++++-
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                      | 2 ++
>  drivers/soc/qcom/qcom_aoss.c                                 | 2 ++
>  drivers/soc/qcom/smem.c                                      | 2 +-
>  6 files changed, 14 insertions(+), 3 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
