Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4307C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFD92072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348261;
	bh=K8sSGCEA4gLNwt6qs0f0N6cwbqEMGwN2lQ+Jv6wFCSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dkB1H5Ry9DpQKUhjsz0D3A0GNe8hTYB40eY1PECw4GxPeJP4Kx7AowFr1bRws6NyU
	 00OPkFT8DPjhcKQ5V2Aq8Y6XnwzCQ/C6TnB+b/3gwlOTjlC08+dJhlyk3tiR5O08DA
	 VzdyRlHFj8G/Lzdi22iciTwUMfwSkH4+EuNGBfkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAFWEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:04:20 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41608 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgAFWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:04:20 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so16949727oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFftcAxBxD84neD4s5xVO4mH7xPSROdINRJxfvD8MYA=;
        b=B0WcPd8s7GEwq3uFcqatP4lR61qH9diDquszZrs0V8cV4hvEcO9wyXJQbnNL9jESh6
         kcrsZloMEoCzf5MZ+NBnncnbUwZQKF6/14Sysdaphg8BN7SMtA2UQlCFB6bduXiwqE9q
         sgjoRD+hPLItVLkeJL+QNZY+O9MaM81IXJ0ihEsNuKwa4pU2ZJxrf4LMbLFJQRmEZrDk
         kdpgCU23G/Mv1b3UfMKHm74fJXJmygj2+btbtoEo6eEAULR9WQfLibKhHJrnkxUIGv6E
         cwwBdt10GcF49nOhBIjMwZTMfwzXomzkeKWxgQcK7620VBjHwx/KtgIQBTJda/Cp9e2t
         d6Jg==
X-Gm-Message-State: APjAAAUDbkConi29auuEz3DYYasOmPY1y0iJ8Iqxf/K5FJ9J7av0Jce+
        p4chDrfN4UjB4ECXtzj1QXkgAfM=
X-Google-Smtp-Source: APXvYqwkqCNd9AWcpkU8VyFrcE5jzL0Y+NYh4AWFSGzvmVtVowWuAHJ1mKu98Mdy5Eu28Q6/ZRLWhw==
X-Received: by 2002:aca:b7c5:: with SMTP id h188mr6604689oif.100.1578348259293;
        Mon, 06 Jan 2020 14:04:19 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id r63sm18998921oib.56.2020.01.06.14.04.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:04:18 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220d32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:04:14 -0600
Date:   Mon, 6 Jan 2020 16:04:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 06/12] dt-bindings: media: venus: Convert msm8916 to
 DT schema
Message-ID: <20200106220414.GA10744@bogus>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-7-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154929.4331-7-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 17:49:23 +0200, Stanimir Varbanov wrote:
> Convert qcom,msm8916-venus Venus binding to DT schema
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,msm8916-venus.yaml    | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
