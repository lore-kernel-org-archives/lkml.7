Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D75FC00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AAF24679
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576272263;
	bh=W3AOarlRoMNMCAbhrI5bz1eU9Cp/AwpFySYwtlMmWCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ZnWTq5459oYnnaPSh3R2jvaHyx0s0lwfCirjz6XRWJYIPd/MZrZokwz5Mp6wzjy/
	 pFV482X1uYpTlPsD2CoB+yk3ccP/NIf52hDSTmDw0shrq2szWHx/SbS3xSG5ODfx5v
	 U/S/krA4FEedWbF3wlYBJA6GEOTZwI3pT19rTpSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLMVYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:24:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38698 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMVYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:24:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id b8so1931087oiy.5;
        Fri, 13 Dec 2019 13:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ydBGATu/G6BCa2T8zgoKRGxjtzBRIPiwmZUK6g3t6E=;
        b=PhLx/Rx2brwF6UONvsvCn+pC3kq2loPfNNfYIOh0l5VLLZ1C0xxzOuhKRBCbIjKTim
         4NK7chovqJPzsHToDaB0wpZQOnfpSjQJ8Tb1RFEknSPMvYJ9IJjlbXvr44uFKQSZxCQg
         +w+k3J+T/cmOMU9eyyWLexeDj5FnMTlDRAMe54w0kFGv45UblBiOcIYtR54AYrkVJWdV
         vTMFMOp2S4by0POH0vyLvW5JHKHDe7wAlMwN5cSGmXZTnQYrZONq7ALg6BqcC6x4vFHM
         IvoKdMs9AEXGPPHHndfv9OgLT+/UZrc4rf7FktX67cJemylLdzVj11h1F5hgTldSUD6O
         Am/A==
X-Gm-Message-State: APjAAAUlOInfWGCkX/j7+mkgZRA6EOva99Y2wl47qXT1TABFXvIP2dAG
        iUVy+xvqEtVxUB3plB2CyQ==
X-Google-Smtp-Source: APXvYqwo0Jh4yTE66y4sJn/aUtkBVXHXEHpW/fP2/UJ9cY5JA7W+Bm1CecnsxiD40w3KgM5ypQ2u7A==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr7510316oic.37.1576272261119;
        Fri, 13 Dec 2019 13:24:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 47sm3835989otf.54.2019.12.13.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 13:24:20 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:24:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: usb: qcom,dwc3: Add compatible for
 SC7180
Message-ID: <20191213212420.GA17181@bogus>
References: <1574940787-1004-1-git-send-email-sanm@codeaurora.org>
 <1574940787-1004-4-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574940787-1004-4-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 17:03:07 +0530, Sandeep Maheswaram wrote:
> Add compatible for SC7180 in usb dwc3 bindings.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
