Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9747CA9EAB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92821897
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7CTcHee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfJUDcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:32:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33998 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfJUDcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:32:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so6892971pgi.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 20:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5isXOORphLUvrMfHKnVOGpBGKkTOkoPX8pGWFrNDV6M=;
        b=B7CTcHeewVhJ8PJ4T2Xy3W1oc8teseNmlcEKmJwiOSX+AE9BBht8hxCbvmNba1BtW/
         HT5JSKMoaSwpjq1oi1p7ccQkdFNx4MpnzTCmSGY1iqYDQ17kmoUZn1PRp5z8onrgvalO
         O6ZCyAm/1leCWkg7LleltdNnpTqBtFu5AqwB1eRAyKUQL1l/hRTQg8X0tMjo/CrLpCbe
         I/7hLc1cON111+NEaqITzUiryaGr2dKwUWvQgLqeKaJj+10cGjJAT303SwSdIt5kqaiq
         PFhla/rFdW0+7cmsVBNdFvX98tkdYqpcVbjYTU4chE0PJ9yer5n9mCf+PKN4K5VSGdxh
         yeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5isXOORphLUvrMfHKnVOGpBGKkTOkoPX8pGWFrNDV6M=;
        b=KE1RLPNjAAMA4eNXgIAyWvfLYq1WDomIVUNwKJQc6xEbF/Aj3rgeNZ/i1ivxt7+lZB
         /uu86NbypHh0TGpxgFq/fhjbM6eNQRFFvmdhqiOgFzJb9z2/DgyrLfzLt2NxWCNajVWP
         /7UGKIu7HlO0UsHlmqyme6v4YfFjSRXE98G5YLMwcfZnjYfce+yApgufXZZYRFD8+sQe
         UAmwx4T0zkPmZDfPF2vgXY9t8a/4c8tetqP8uAmCSbRFV76oDpNfnhaGxgfvb9ZfNL3U
         OyJaRPZrudlGEw7hoFsRqgSSLXC7NDKY9Im37rGDvDNsisizspKXPtdDmUHWPwx8WWiW
         vz2A==
X-Gm-Message-State: APjAAAXD7Flzb9CCfpwWkjYjZD63/fqMG5fG4dGyAeQtkd+ukmf1oIrg
        G+A+0BrcQ4oHvUXZHgsSsVmKHQ==
X-Google-Smtp-Source: APXvYqwr234z/kcG49JDU513eFxregAt47Pn/yB3FCwYgKG5t1iFFWQ3JJdHNv7eru9GzZvT1Us3BQ==
X-Received: by 2002:aa7:8046:: with SMTP id y6mr19860568pfm.222.1571628744255;
        Sun, 20 Oct 2019 20:32:24 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i6sm13809128pfq.20.2019.10.20.20.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 20:32:22 -0700 (PDT)
Date:   Sun, 20 Oct 2019 20:32:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCHv2 0/3] Add LLCC support for SC7180 SoC
Message-ID: <20191021033220.GG4500@tuxbook-pro>
References: <cover.1571484439.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571484439.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 19 Oct 04:37 PDT 2019, Sai Prakash Ranjan wrote:

> LLCC behaviour is controlled by the configuration data set
> in the llcc-qcom driver, add the same for SC7180 SoC.
> Also convert the existing bindings to json-schema and add
> the compatible for SC7180 SoC.
> 

Thanks for the patches and thanks for the review Stephen. Series applied

Regards,
Bjorn

> v2:
>  * Convert bindings to YAML and add compatible for SC7180
>  * Address Stephen's comments on const
> 
> Sai Prakash Ranjan (2):
>   dt-bindings: msm: Convert LLCC bindings to YAML
>   dt-bindings: msm: Add LLCC for SC7180
> 
> Vivek Gautam (1):
>   soc: qcom: llcc: Add configuration data for SC7180
> 
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt | 41 --------------
>  .../bindings/arm/msm/qcom,llcc.yaml           | 55 +++++++++++++++++++
>  drivers/soc/qcom/llcc-qcom.c                  | 15 ++++-
>  3 files changed, 69 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
