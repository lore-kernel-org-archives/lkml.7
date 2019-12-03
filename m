Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F75C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8F2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575410549;
	bh=keVXt5Dqnkw78Vt0cAvfU2626c0DWW2+SjWv/uBoC7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eQAyddAAvxggvnDnaCSH+TIk/gJNQMmwqoV5KhSrrUjVSRsLVysuu+gSTnArit4iC
	 d3vkp2vsoP8FVC4BAfP0jIti2DNOCfmZvlXullvlqKfszYxE5GTvtRS9DRRdktXQXX
	 8nw9UNvenm2aU/mbxOZyOCH8Bv+JUsT/+U6rzfyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLCWC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:02:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37283 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfLCWC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:02:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id x195so4887737oix.4;
        Tue, 03 Dec 2019 14:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=90kwbqDcp7UEOW069UgJZG7CeERSPfvM2e/4IVBQtmg=;
        b=QYOlkSWRkkDvZ9P/VRtt/JhR9JZtVOp/Oy9BNK8f+3oG+/VvoqjVS1cFH4J56czoBw
         se1VTkJ1ckCYzEF8FXXCb8WNC1NfOI3TTV4uAq4tF79jCdNaSVIIWbVXYIwH3EL6EIl7
         Tfrxq2Ga4PJQxiQGCtgx0CQ4ODep6FutOqtwZVg3X35lZKN+7giRxkEzaECN8cjhWxJF
         W4/Rbk0j0eoFi949WQ3lj7uixPCpC9w0BS6nbCbozQG7uHpFTG0thD44Xu2M2KzCPFib
         Dp0LEC46i1jPaWXG6br5O6gInL5hsosOes/xyw00rCcDV8D/NOrQAfxxGzlwFe2cpgDq
         mE8Q==
X-Gm-Message-State: APjAAAUOcWkRkaV95NrGg6Isr+1Jx4SCbl8ZS0xlNbYLqbazlFCsXszi
        MmNKx+M/cNfXKieV1d5T4g==
X-Google-Smtp-Source: APXvYqxrRfI0UN95eqjO4C8gSA0I9sLWnVvsUts8X9Qr0NL09XMOoPTbWgGcEBLbzFgRiTnhvrIi8w==
X-Received: by 2002:aca:5cc4:: with SMTP id q187mr155936oib.45.1575410546786;
        Tue, 03 Dec 2019 14:02:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n15sm1488396otr.67.2019.12.03.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:02:26 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:02:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org, jonathan@marek.ca, ohad@wizery.com,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 10/16] dt-bindings: remoteproc: qcom: SM8150 Add ADSP,
 CDSP, MPSS and SLPI support
Message-ID: <20191203220225.GA22560@bogus>
References: <20191118214250.14002-1-sibis@codeaurora.org>
 <0101016e8078dad4-458c8501-93fd-4daa-8938-d01027f248cb-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e8078dad4-458c8501-93fd-4daa-8938-d01027f248cb-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 21:43:54 +0000, Sibi Sankar wrote:
> Add ADSP, CDSP, MPSS and SLPI compatibles for SM8150 SoC.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.txt   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
