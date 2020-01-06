Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB99C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8546207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348414;
	bh=nlWE6LryXYaTp2LUNB968TEa+zRV7r2QsFPA1k6zHI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rdvHoE0RJvTA7bGo9RGp1pbvpcPsFLICthwdPtSiXiPJOQSofi+ndG+RxQB3MpnPp
	 mkmrO1EMlyZ0FNkIpcHol3bcyCdpD2jjlGoApPwzcrqoKv2hHSE8WfB6meQUELwDmx
	 UGAtS4OiZpk8yQ2yI49G0eUJuQSkf0yCzZ2gs/lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgAFWGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:06:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36150 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFWGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:06:53 -0500
Received: by mail-ot1-f66.google.com with SMTP id 19so61059467otz.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+PYNm7dQL8K14ScybU+6pQ9OSx67pufTIOMHAwIfCo=;
        b=ceo7QIVv+4NqgalkROVFotLGh6yUqRKkmSyKZS683t0E7ASw8hRASH0kZA4UuXZn45
         de8j+65cmboyqmHhymsu2D8JXiLDsvb5YNxP7XVPr457HVOztiDbXUAacQEh4n6u2aA0
         cajJYQsoS51sZI05Qyep/a57Wec0xmUHlUoqZjQDK4qQGA3hcEirGA73DGrKgXqQYtIG
         cSQn4F0fF++WilHjpajJ3RBwTlywfiQyz01y2h1ii2gRydGe/Qq/FLy2OvMHDqWWGwyx
         9Bo4biKnetdWZcU5hBIzz3FaTKo3pbTo4C7qHQYYPhFS8vxwTOYG8Tgk/hSA72djmtfM
         ioQw==
X-Gm-Message-State: APjAAAXEOb6ea0rg4Exuqv2uO8aBFsSacCk8UypACFUSj8G/5e5fxGKw
        99V8abnfTmI1apvnOO3a5kjILVo=
X-Google-Smtp-Source: APXvYqz+nOQd5gOcFyktYXGEx96xtZ65hp17dLip76c/cfIbXcBuksRAYRuxs6ZkkAYTR9WNMAC2tg==
X-Received: by 2002:a9d:4902:: with SMTP id e2mr16308830otf.116.1578348412621;
        Mon, 06 Jan 2020 14:06:52 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id j186sm16797328oih.55.2020.01.06.14.06.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:06:52 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2207cd
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:06:49 -0600
Date:   Mon, 6 Jan 2020 16:06:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 08/12] dt-bindings: media: venus: Convert sdm845 to DT
 schema
Message-ID: <20200106220649.GA15045@bogus>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-9-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154929.4331-9-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 17:49:25 +0200, Stanimir Varbanov wrote:
> Convert qcom,sdm845-venus Venus binding to DT schema.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,sdm845-venus.yaml     | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
