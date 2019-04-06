Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903ADC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5596521855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530824;
	bh=fbJXGQw+CXQPGRL7h2czh5y4BhbdyEChydp7naWFFlY=;
	h=Date:From:Subject:References:In-Reply-To:Cc:To:List-ID:From;
	b=0kYa5WS0kOGx6qGdbP3+ILyt2/JykTKX+MRufEUAL0qsACxboA77Bdvo1txxhnxLK
	 qtqVsqUw8HiDgr+q6OEmSb+dNNUWSLvIsLcFuhMPBSsiOaZuIAQ8L4BAFXADx2H85i
	 ArLbyDYVQ/4liaJLD78YPvPHGpLSP30yfDGjUEWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDFGHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:07:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46371 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDFGHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:07:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so4180247pgv.13;
        Fri, 05 Apr 2019 23:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:to;
        bh=IUdwaQ0yz2qixEEPWlhvybnFm4a0FWR9cVbVzioBsw4=;
        b=H2YS/AjILaHnxN4BihfTru2rgpABQ36c5a5/7WwpMMLkItb/BBADf0GxePMd2tS7nC
         LuJhb0KKy+1Xw8UHWfDr1wHH4omF7vCgvCA/ZpuEDzaPhEr3Ia22xWk+nGdydYSLddKI
         UJSBRz0xQUqAvDWiOkdkR7U1TJZXvVNZz3CZ1tIoNB2lr85qmuE/x9lb2QG9ZSkDuR3u
         YtRVA7CcI4ibuE87mre9mKsJL0TdqhRGlU4Y8P1K9qu2X2SqNDo6fAIYONeWMgscHXjj
         kKbe46aMDne73CJq1mvHNyZHWnJ2jfwSVZvKMzVemISVyBoL+XQ4uDybccXKOjE/kqZe
         5P2A==
X-Gm-Message-State: APjAAAV6scKCU0afIcnYCRS7vyigawYnGX5CRr3xUvlhv1g4VzmYmOLs
        pgVlzXwqfhzn/XhsAcSrog==
X-Google-Smtp-Source: APXvYqw4kUMgebY2wzGLKmyWky702/wDfzCuhmzxYDIa8x5+ZL+b+cFuzkLlvDfYxjDDRFhqL5iYaQ==
X-Received: by 2002:a63:5c56:: with SMTP id n22mr5638926pgm.108.1554530821482;
        Fri, 05 Apr 2019 23:07:01 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id d11sm26302848pgq.6.2019.04.05.23.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:07:00 -0700 (PDT)
Message-ID: <5ca84204.1c69fb81.1c8ee.7f46@mx.google.com>
Date:   Sat, 06 Apr 2019 01:06:58 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: display: stm32: add supply property to DSI controller
References: <1554279389-27377-1-git-send-email-yannick.fertre@st.com> <1554279389-27377-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1554279389-27377-2-git-send-email-yannick.fertre@st.com>
Cc:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To:     =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 10:16:25 +0200, =?UTF-8?q?Yannick=20Fertr=C3=A9?= wrote:
> This patch adds documentation of a new property phy-dsi-supply to the
> STM32 DSI controller.
> 
> Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> ---
>  Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

