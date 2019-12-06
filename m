Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7594C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8D42173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="g6jomj8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFK3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:29:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41073 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:29:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so7168935wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DgBRjaEd7n/ouF4jWFhOqcv4trFILLXjFYFdBdgSVGw=;
        b=g6jomj8rLvrP0rEhFRuwikiUx+OhdsE2+p4tZ0twrtBpALCpG+vjZ3odJMNrtbcIpJ
         MvgBiO5haw63vuE0gSgR2lWywOGt05S2Gmauw5/xbaNK0Se580TWKIAxdxINKU1d08NK
         X0QJPqe+ieiApCc/pma2+seLDbygH5EupSdA0AwoqeGFWJcszeGRGaPW7YUCZmSy02QA
         YndPftdh6I0jbsIGGbb/cwybpt3kjl5dRKohXwgPgOvaUB32v8WsMaFNebn39Ub4xuWC
         M8ApnxBYlY4h9UqweaXLZU+UrlvtcElwCZwKQi2qBAUy+Pm48fUMHmD0Qoo/G186IE30
         OtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgBRjaEd7n/ouF4jWFhOqcv4trFILLXjFYFdBdgSVGw=;
        b=eT4t859VoBuC28tnZV/qbZjejJq2m/OVcvIEg+a3dtF+ycRL9cG7emgRZNe7u9ceij
         N/NMbkM19S53WznBei8yNVr7FcbCPC16vXWlbPmoggHz6TePM/pQdddAIAHdZS6B3QZ5
         4L2hYMqSUpbO97VVY+KDvUrIl7xBCEliAdp9b10hM16AmjEMxJr9Wv+f0cieLgw/EcvR
         fqkMm8dOn9fA1zctgQWzroTQklSAkWH7IRapudYnhR8G64g22fqQS8bFp/uEPPd6WEwS
         hk6czBGM8H+9QEqVu8+G3Y7DURbU7syB9sc4CpEv2v3l5rXdTMjcTFYJi7z708ljslkz
         xgYw==
X-Gm-Message-State: APjAAAWiMXdMN6XgEUdF0pvKUyevroR5C+XjpKlxXQ8Qd7tumd7MDgfV
        2NxRhIp4WackxZzdIKjbysMUgg==
X-Google-Smtp-Source: APXvYqyP1fC7xhtDfhxT5Yt2U1H+X14HenFJ5ybUOqf4/jrGxoax9KqbnJSb12bzIVJM0v3GTWn9AQ==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr15505384wro.216.1575628180708;
        Fri, 06 Dec 2019 02:29:40 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id h2sm16186780wrt.45.2019.12.06.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:29:40 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:29:39 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        devicetree@vger.kernel.org, Rocky Liao <rjliao@codeaurora.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: net: bluetooth: Add compatible string for
 WCN3991
Message-ID: <20191206102938.GD27144@netronome.com>
References: <20191205122241.1.I6c86a40ce133428b6fab21f24f6ff6fec7e74e62@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205122241.1.I6c86a40ce133428b6fab21f24f6ff6fec7e74e62@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 12:22:59PM -0800, Matthias Kaehlcke wrote:
> Commit 7d250a062f75 ("Bluetooth: hci_qca: Add support for Qualcomm
> Bluetooth SoC WCN3991") added the compatible string 'qcom,wcn3991-bt'
> to the Qualcomm Bluetooth driver, however the string is not listed
> in the binding. Add the 'qcom,wcn3991-bt' to the supported compatible
> strings.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
> 
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 68b67d9db63a3..999aceadb9853 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -11,6 +11,7 @@ Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
>     * "qcom,wcn3990-bt"
> +   * "qcom,wcn3991-bt"
>     * "qcom,wcn3998-bt"
>  
>  Optional properties for compatible string qcom,qca6174-bt:
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 
