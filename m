Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F577C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BB421882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573012828;
	bh=EGN2Lrh3me+FAqx+ox1JwNnU297H3BtLLGtjLCglSss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ncmKjBaMzCqmEEMWT9yxkeio2CKCvl76lAfrPY+ziwp6EnxppMmpuMAzuMgZLVGJs
	 uf/PTfMy3Itle9j1EFjJwfe0eAEthWmAu6/XeNqJBwqdJvsEHqzSx6/Zp4C+3g1PKz
	 v6WaXoEScdejGpXvhGucr3siQj/Ega3o8V2FqyOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbfKFEA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:00:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45498 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFEA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:00:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id k2so19710918oij.12;
        Tue, 05 Nov 2019 20:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ysqS9rcdYrTtEuoWI9nbxHqCjwSJ2N3Q7Hvz5EM+mmA=;
        b=Qry9BVoYDD8cxzLSjE/RKrBpCIwYoCdorOgRkAE8ePauvrZKkqPVSiv9aTmaasgnje
         Xw8nbu2faNbSO7RQfp3085YljoANOOaPLbl3XDj0eK1pE7cbKkVR9UgJnfkVyiUQWcZ4
         3gW2xv/X9ANuvl3rvnguqu2ICj89ugNCpYzucKgDGd+i0bbRLLmjlV5K9G9JCRaBdQqV
         Ob9eGJZR0X5R0afKO1LdfhKbpdBLSJVxijVkKfOsLYjqhyJtvQX+lgf7PYDAE/vuRDBy
         LHTS+IONBbaEQtC4m23SbE9p07tqcyQU+wcw5OxeKMfecf1dZxaf3qK03p0cdhg/m7+H
         oxzg==
X-Gm-Message-State: APjAAAUOzYx3Josg1ZdH7LjmbWSv2iw+bcGMrR7yY3hhowg2WRMFvh9L
        qdSG9BzuqEAibRv4RyIJgg==
X-Google-Smtp-Source: APXvYqyT5mAWFh8aqygKOd9JM7fV1DLfzWIErkA64Ibng0c8MMAJ375J/TSg1ewt4VmCOvZwOVxrFw==
X-Received: by 2002:aca:5104:: with SMTP id f4mr407777oib.40.1573012825074;
        Tue, 05 Nov 2019 20:00:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p18sm6244401oip.18.2019.11.05.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:00:24 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:00:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1 5/7] dt-bindings: clock: Add YAML schemas for the QCOM
 VIDEOCC clock bindings
Message-ID: <20191106040023.GA4519@bogus>
References: <1572524473-19344-1-git-send-email-tdas@codeaurora.org>
 <1572524473-19344-6-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572524473-19344-6-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 17:51:11 +0530, Taniya Das wrote:
> The VIDEOCC clock provider have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,videocc.txt     | 18 -------
>  .../devicetree/bindings/clock/qcom,videocc.yaml    | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
