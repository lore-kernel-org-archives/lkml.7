Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EFFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DE21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYLGm1XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfJYTre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:47:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35055 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfJYTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:47:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id c8so2216715pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ATnBH+fO0d5E9Wqzzop3u/f1RSiDw9WOqJk8YOk0Z1k=;
        b=OYLGm1XBbcR3zvW7QsuaUyvVFB/8ILldOsqj73bWK/5SfxXveRwd2hAtJeeKAr2U97
         cKmZQZ2JX9MsrOF6zRB6TUaxs4bq4Wb1h7JjBoCGodVfKxxYcAZfnTCjLuHkIZd1VIM5
         Iaj6OmGmBNPPjVXWoGoNIzA60tQuRhEhkPUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ATnBH+fO0d5E9Wqzzop3u/f1RSiDw9WOqJk8YOk0Z1k=;
        b=EpRBOZr3XRVRpT0f0RK0J/ZBtbORPJmhS75iHO0+Z5mqyTnakMExeCKCYE4WwH2rD/
         LUFo+LrSiS/56pTi7q5XHZIhwgRvX6E2gH9/1TeYgJGrFs+RM7GmvHeEIOqWuvlZGwFB
         7q3uaSCN/DbamWpPcUhzgo7rfsOFKcEwZpJC0Hr4tuOrUhDUTH6ZWBNmhJ/ZWAItTmJE
         VfTfJgeNTVnBuUj5cZ/cvH2KPoE1c9x8yQHOkxlfGVezHdrcTtRgznZULy/fUTIGqcse
         Dvw1cvBIZMIkyuKy7SoB1MSw794xikqWpJU7UKKkSKt9bNas47JGxL7Q7Yt6ueJK9ojS
         MDQQ==
X-Gm-Message-State: APjAAAX7acRpBCaVAoWEBkA6xhB70JsRQXl2TzOm9na9XBmXGUmPHnOE
        M5PhklrTnQ3bPrpdr7Wph3bVaQ==
X-Google-Smtp-Source: APXvYqwkKVw1bAAQBUi8yqP1MVOYlX5JePdNh+IRgQ/w6eYv3qmLpuUqAW7yQ1Cci4uJUYPWLV5LyA==
X-Received: by 2002:a63:3003:: with SMTP id w3mr6655849pgw.364.1572032852353;
        Fri, 25 Oct 2019 12:47:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 16sm3500789pfn.35.2019.10.25.12.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 12:47:31 -0700 (PDT)
Date:   Fri, 25 Oct 2019 12:47:30 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: sc7180: Add pdc interrupt
 controller
Message-ID: <20191025194730.GM20212@google.com>
References: <20191023090219.15603-1-rnayak@codeaurora.org>
 <20191023090219.15603-12-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191023090219.15603-12-rnayak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajendra/Maulik,

On Wed, Oct 23, 2019 at 02:32:19PM +0530, Rajendra Nayak wrote:
> From: Maulik Shah <mkshah@codeaurora.org>
> 
> Add pdc interrupt controller for sc7180
> 
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> v3:
> Used the qcom,sdm845-pdc compatible for pdc node
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f2981ada578f..07ea393c2b5f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -184,6 +184,16 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		pdc: interrupt-controller@b220000 {

Aren't the nodes supposed to be ordered by address as for SDM845?
If so this node should be added after 'qupv3_id_1: geniqup@ac0000',
not before.
