Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B942CECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908582084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159362;
	bh=dGXF4xatQY/uGvg/j4hq/nIkjbczI6+E4xLbpzWWAws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HP1J1+bLykl0xQCglFmzRuvYVaieF4MnOTa2iUVFEiQusIETo406PyrFL9cc8gG8T
	 xzSyD92Z4CfHJ9opqbuM4qKTEPlse7PrvWf8sj7ajSiP9FnBK8jIUwmEVKq4zVj2ix
	 KMBguoAcqPB4MJ9Ar9/xPs4wNjhRE2keU4fcAzzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJORJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:09:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45400 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfJORJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:09:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id 41so17589780oti.12;
        Tue, 15 Oct 2019 10:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHMlVw4tvcimgqLNE6cW+4izJ5ZEdiASsMVMnyNWIFE=;
        b=koQy+GHTtbCT+IzxVvnGOCZxIBEqWR0dzqDxlOMt2tPU2TzFErwyF2yJnh9gByBrOr
         PQnZQdHPnokIRDzj8yrpdzch4bzFexF8oyoTmAACJFHC6KR+fzXzCswsqT+TWR1zuNZJ
         w6j69mal2a9l4xzngk7Gkch+op+YX+7fNgOuC4XBcKS6gHx6LshtJXGeZpspLkyfkHZ7
         5wKYSKkJGk4ilNdduc4H7lYNAHLLGHmhpmAHNmNCwEo6XGt8QMsI61sMPNgXD9LTLnX1
         dap5/tPe5x9U6H/fQ0Af6MHZF67lVhD+Q1y5fLDB28La1S2AsTLcEDLBokRD3JSzaqk5
         IJWA==
X-Gm-Message-State: APjAAAXm5kIiKNplGnIvvQAqcimlU0yOSWZtQ9HVziX4Dl9f661K45F7
        5Aq6U1t83nQa4CeYYYQX0A==
X-Google-Smtp-Source: APXvYqy2X9I15W25gmPVuvvFHsnO6LRLZtuacdrohlwkKPnx10p92ZlfGBeUKRra5d48a54FxaB9Kg==
X-Received: by 2002:a9d:70c3:: with SMTP id w3mr22943854otj.246.1571159359034;
        Tue, 15 Oct 2019 10:09:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o184sm6585474oia.28.2019.10.15.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:09:18 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:09:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        yannick.fertre@st.com, philippe.cornu@st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4] dt-bindings: display: Convert stm32 display bindings
 to json-schema
Message-ID: <20191015170917.GA8078@bogus>
References: <20191015123151.14828-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015123151.14828-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2019 14:31:51 +0200, Benjamin Gaignard wrote:
> Convert the STM32 display binding to DT schema format using json-schema.
> Split the original bindings in two yaml files:
> - one for display controller (ltdc)
> - one for DSI controller
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in v4:
> - describe interruptions items
> - remove unit address from port property
> - remove dma-ranges (DT patches send too)
> 
> changes in v3:
> - use (GPL-2.0-only OR BSD-2-Clause) license
> 
> changes in v2:
> - use BSD-2-Clause license
> - add panel property
> - fix identation
> - remove pinctrl-names: true
> - remove pinctrl-[0-9]+: true
> - rework ports block to include port@0 and port@1
> - use const for #adress-cells and #size-cells
> - add additionalProperties: false
>  .../devicetree/bindings/display/st,stm32-dsi.yaml  | 151 +++++++++++++++++++++
>  .../devicetree/bindings/display/st,stm32-ltdc.txt  | 144 --------------------
>  .../devicetree/bindings/display/st,stm32-ltdc.yaml |  81 +++++++++++
>  3 files changed, 232 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-dsi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
> 

Applied, thanks.

Rob
