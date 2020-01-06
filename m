Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F8C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7742072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578348360;
	bh=95BPPFdIitwGbLU6o/a9R4aINAqJd6YKUkp0l8oQvz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dct1Q/z2FZxBZZ95qD/Tqx4ArZPGcOTX0r9r66aUXUzrQMQFVSXuYy3kZt605z2R5
	 gyDGTf10achHeuzNKjOd+60Elsc1b9na2OEqzAEsDHM8jRvkOUvT3bQTtFrm0tZbc/
	 dUXrJf+rjRQo8nnelPHd+FDrCGE1Y/rSA1yMr26o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgAFWF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:05:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32841 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFWF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:05:59 -0500
Received: by mail-oi1-f196.google.com with SMTP id v140so16987457oie.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOrlWUldD83XBK01h071I64wECD6WdEMkunkhAq43Js=;
        b=enrdvfspuLMKGJNkVmMyPITwAP1Pe0qftSEfQuF7Q0yj2nqUnawI3ctc+jyAai4gBa
         gJXFRxh4fYTUoyGVseqhIm+tjfhnEDt0GM0Uv1Wo40BPTwnZDSA8adaLrTyTgREHmbtR
         Jlv6xXIJv9YRiJAWTeyyXQiSF8fchkAo4QEd3BBvagdQRUpm0Gu9IRlFYGwokPrI9gVh
         EusrR2zlMfQjQg0Wg15b3pfQbmCpzLGawkogS8keqlB584Oo/cP+76xjGugIV7SMm0IA
         8NxvCDC2KwWQSeYnrM9oDd05175bddYbAdd1XUauzxjEoUm+719MFxwZjY4YVTO0SIZr
         u40Q==
X-Gm-Message-State: APjAAAWT8xzmp8LY7p7NyFWk9TCtGia2xaZrZzkRIeGmljv+4h7sKIow
        6laqynAUy/TYmJOOF7dKWP5shbM=
X-Google-Smtp-Source: APXvYqzXgWOW+kfMQnfXRndoUnQrfqDRKRz2A1unA/RKOanV8RVIIfc3i04m+IsiUbKEXOgkj4APLg==
X-Received: by 2002:aca:4309:: with SMTP id q9mr6641567oia.158.1578348357872;
        Mon, 06 Jan 2020 14:05:57 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id e6sm24477696otl.12.2020.01.06.14.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:05:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2208aa
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:05:54 -0600
Date:   Mon, 6 Jan 2020 16:05:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: Re: [PATCH v4 07/12] dt-bindings: media: venus: Convert msm8996 to
 DT schema
Message-ID: <20200106220554.GA13282@bogus>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-8-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154929.4331-8-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 17:49:24 +0200, Stanimir Varbanov wrote:
> Convert qcom,msm8996-venus Venus binding to DT schema.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../bindings/media/qcom,msm8996-venus.yaml    | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
