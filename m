Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0D7C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEF82073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575410492;
	bh=CjAtNLvatWMyCh1wq8TD0V7SPlhIpHzJSF6rmpMcBsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AxuSCWG8o7+YxSYHR7Ed69M+LTp4c6kFzQn9a7qjR0qDrYoX1sja6crUv+EbbOKpn
	 Lt9a3jRVaJnBgl9vgZ5AranXOfYTMZl03P1xhFSYRsvhuw27bXl22gpRNUQCff8vf0
	 k+siqb7Eci8K3eHRbq6I4+q1Us4zj3bl4dyQwwj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfLCWBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:01:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43784 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfLCWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:01:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so4390152oth.10;
        Tue, 03 Dec 2019 14:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ssHKSGoKkEHtJdMwxpp+yPyrEs5401UP7IvVXv37ViI=;
        b=mBh+xuSNhhtH8dNUZkav6LqzH/vnyNwFPHXgyu9ymYo1P6NbTLSMihdDNMHFMVNg5R
         lkib5RxIitTPwNaMr2l5ts4kiLw/C012jzkqiM/A5vmSxVd18OkqXTccKRaRwnyz4Vvw
         +JOZSZJZIeiv8BB+sNub8Ovu7SIRqSUDEWRAbUw8M9kQN/LiQuhBb9h3WCoh6ccsb9Mg
         cjgtbryWRDbogKlBj/RCZpi+3dYe3PEooozV13AgmoCjPCsKeD5jRxtUfkI35htr/3Ey
         YaDBD1SSNc5Bg2JI7XNAw0qs5jIXHEGsyJAYyhsOUEIMluX9RML8AjWzcBc14JfuNm9m
         p4Mg==
X-Gm-Message-State: APjAAAVfx39uiMvoqD4Y+BR3aXahkiiWtfw622KFun/WhgBHPKCbe2w7
        mzwpswbgI+c688kZQARnYA==
X-Google-Smtp-Source: APXvYqwMnq80UUBpDV2cXHegMQxK9aSYFb9RTYgEkBBHBCKWiXTuW+DruOeNtwJhZGi7U4zduIKUSg==
X-Received: by 2002:a9d:53cb:: with SMTP id i11mr70500oth.158.1575410490238;
        Tue, 03 Dec 2019 14:01:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a74sm1599237oii.37.2019.12.03.14.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 14:01:29 -0800 (PST)
Date:   Tue, 3 Dec 2019 16:01:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jhugo@codeaurora.org,
        robh+dt@kernel.org, jonathan@marek.ca, ohad@wizery.com,
        mark.rutland@arm.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH 08/16] dt-bindings: remoteproc: qcom: Add ADSP and SLPI
 support for MSM8998 SoC
Message-ID: <20191203220128.GA21208@bogus>
References: <20191118214250.14002-1-sibis@codeaurora.org>
 <0101016e8078b957-e3cf34ad-0bd0-41b0-9d92-ec1d86df352c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101016e8078b957-e3cf34ad-0bd0-41b0-9d92-ec1d86df352c-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 21:43:45 +0000, Sibi Sankar wrote:
> Add ADSP and SLPI compatibles for MSM8998 SoC.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
