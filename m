Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA1FECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F82084B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571159487;
	bh=gTXpt77DEZrCvMycsV0eInW+48K93RuKpyIBaH4Ek4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U+5TQcPQeF+PPX1g7p/1DCp9aZwcp6otr7oEMfgxW+fHQDscVFS7+trx1u+XlfHHn
	 bSo2tw5Evy3ET4ndK/jpeaaDnalKma87Gn3/dU08Mh+kyqvarGxaX8Ac4uA2oNhzS4
	 OZs94uoAu0WnvbjsB2UmLVn5UYtScJSdPkqWEScg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfJORL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:11:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33261 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfJORL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:11:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so17611395otu.0;
        Tue, 15 Oct 2019 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxDGjraqfzXc9uftKDsuNClpdLGxHQLLKEDl6Bl0yGY=;
        b=CX3EbGPaNtb84+kXycX8EEIWm4qZtW8+PM90DNg86GyWWgI+RMpiW/oTxgjqgQPIYW
         pWSu0c0kwwNNR2mzi2W9jdGWrqIM8qyoS4DvMfoKzEFBSdO1Ssazthj/fq5mDKPExnic
         i7Pmo5rQcR+VQyxeh8n1afcKHZ316xLh+8WM6MivSj3V8Lv4tSwGHnobNkDYF7O1gRIB
         j3w8C7BVfzfut+Yaysv3nI4I8LYDNda3/EhYDZdTcY4fwuCNVgyqAM9qDLw5opiBbfkv
         oUMad9iRREQc/cujKn1I6gNT1KcZ3+CT6WLJ/63/lHqSrn3pN6yXninb2l/Ydpe/v9i8
         J91g==
X-Gm-Message-State: APjAAAV36mhGCsVAwowDExcjzUXBWhm5VeNswXUI1n/W1xxW8GIUedJr
        1Xme3VDlDXap2ICYaI80pR9097Q=
X-Google-Smtp-Source: APXvYqy4sZEG/+W6xEOtw6Rd/8zS/h+KMn+CPYcc4g5SttNj/xXlDflbSBhC8AEgrAAvxTNzzBDmEw==
X-Received: by 2002:a9d:2a88:: with SMTP id e8mr30901276otb.188.1571159484997;
        Tue, 15 Oct 2019 10:11:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x6sm6874566ote.69.2019.10.15.10.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 10:11:24 -0700 (PDT)
Date:   Tue, 15 Oct 2019 12:11:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: iio: adc: exynos: Use defines instead
 of clock numbers
Message-ID: <20191015171123.GA11947@bogus>
References: <20191002160744.11307-1-krzk@kernel.org>
 <20191002160744.11307-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-4-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Oct 2019 18:07:44 +0200, Krzysztof Kozlowski wrote:
> Make the examples in Exynos ADC bindings more readable and bring them
> closer to real DTS by using defines for clocks.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
