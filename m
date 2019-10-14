Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A302C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B7A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571073411;
	bh=WwxRmyZCVQ0YdhVtIkCm2b6uk68MMp9bxpCDv97pc1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tnHmx1Ltt+4V0hRXlRAuKHcJNfT5qfcaQ4ez3aWPr9ry7LpjZ1EsQRRPk1Wt4iU2V
	 Rub1OMsamaT+1dbjwcoGsypvAWDJETGAmW/NeV3OCrzWHO0k9idrtfB1hQhW/WI/OQ
	 uZ052MiHlwl8rZjuxGyHtC5zNi/jkAf/9tzjdMYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbfJNRQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:16:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37998 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731347AbfJNRQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:16:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id m16so14378359oic.5;
        Mon, 14 Oct 2019 10:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8hIcdl2e+um++/nUAcgtky3A53BnPYT6tM1T8gzirE=;
        b=a5YY3un9uEsTMCl/kR36NUSzGiT/+e9QP3/dvH0dzeXeI4DiLFaVw1c+6SCVKn9bw3
         2Xgzq97+n4h9b/lBs8mqeeB2tH478vaBY+H0K+Lria173U3G0Kvz7ohV6L/FPa7GDePR
         uHh09V5MlYYgMOwSIDVTBtpzm0XaX0Q/KrBnd7UUhsWfob7MZq2F35teW9ReeYxquCw8
         cV4qOcSVLkQIO+f3n54w9QbUwyEDKj4zDC6I93fn1fe/rOyrFbHGt8Vr92+XxzEzgZQN
         lCKpBUvnnIA1Mn0rtEEkqC7w2IBxJ1YyZHRiuw7HGZkhupfZr38SGz3gK3Gbb2v6QoGV
         x41Q==
X-Gm-Message-State: APjAAAWSAHug4LTBFvrYrO9ozSG9d+ixwUnN5guIVWbYMnC29Gi0qcbL
        8JyT7UShLDHDN2r7FdMnCW0c+uw=
X-Google-Smtp-Source: APXvYqzQz9wZdnGUi/ME0QUo9eS9TqcibXX1bHdajNQOR2xvzskepx0v/CFKXkThQgariekycHrvyQ==
X-Received: by 2002:aca:b841:: with SMTP id i62mr24164992oif.123.1571073405919;
        Mon, 14 Oct 2019 10:16:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z185sm5729184oia.50.2019.10.14.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:16:45 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:16:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] dt-bindings: hwlock: Convert stm32 hwspinlock
 bindings to json-schema
Message-ID: <20191014171644.GA4140@bogus>
References: <20191014091756.23763-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014091756.23763-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2019 11:17:56 +0200, Benjamin Gaignard wrote:
> Convert the STM32 hwspinlock binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> change in v3:
> - use (GPL-2.0-only OR BSD-2-Clause)
> 
> change in v2:
> - use BSD-2-Clause license
> - use const for #hwlock-cells
> - add additionalProperties: false
> 
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ----------
>  .../bindings/hwlock/st,stm32-hwspinlock.yaml       | 50 ++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.yaml
> 

Applied, thanks.

Rob
