Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE2DCA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7135520717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 01:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572919180;
	bh=dWaY5SQUWq41rGukZgzbwhsTaulbW71IutjO2p3j70M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NwutalUr2qCui968dTyvDiIiYvotxierPV8bShHAJxMXmC4zGKZxF5oJ/yYKhC6q8
	 krub0ibpRXf5fUQSi7KEOqjdGbBVI0pAXZsxb6sAqUeIRpAh5zg/onGjLeATcsXkcO
	 xonNND0u1j7CYc+jU8oErzixnfMOnix5g67OKuUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfKEB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 20:59:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33030 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbfKEB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 20:59:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id u13so16306924ote.0;
        Mon, 04 Nov 2019 17:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cp6fhNM7KdYvvK5b7iPPVRi7PA69F5kheAydJPVgeXA=;
        b=Uobnl6ebnQ6gW/4p37qXPuc/33JqWqz0lm0T2+phnzUiwTOI2ZzL1XG0Ttq+DVzmyp
         rwfEWTLx5880bhn9Us2HPM8YmDbKcLHM/2fswjWsr5I1UlPPfx3rXn4Aa7OZdGf8IofP
         SNUtY4F15vHoJrrfyWARvL9fe5Pw9jBUP8Aa0EKF5lKsj2IBqOWDSYDFpkDDuUWM1Yvq
         r1vNltlbmygmINUB8DRsi1/guk0n+8USgwMIr1ZryjrRA2A8FefxyT9OD6Z6rJE3QqlC
         ds8nLJd4Z4nbUeurTpvhCl5whaXahTIkNjIsMNOQCR8JFwefowHQCWiV0j5gDQ7fAdSW
         qBKw==
X-Gm-Message-State: APjAAAWs5pA0QSHfuLvMvpJSji645kmV1FouexBmxR7oO36f0281PhvB
        QKquqFduU1zixklS1OPtioNNpwA=
X-Google-Smtp-Source: APXvYqyAqEZxKaDBS7/K7JVSPoKNZ/QDCcAAP8gainROJM3u3UZb6yb2XdytdU+zur7E59YO27Bvpg==
X-Received: by 2002:a9d:5e06:: with SMTP id d6mr20196663oti.242.1572919178130;
        Mon, 04 Nov 2019 17:59:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm5217744oic.29.2019.11.04.17.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 17:59:37 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:59:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     vincent.cheng.xh@renesas.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Cheng <vincent.cheng.xh@renesas.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: ptp: Add device tree binding for IDT
 ClockMatrix based PTP clock
Message-ID: <20191105015936.GA17377@bogus>
References: <1572578407-32532-1-git-send-email-vincent.cheng.xh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572578407-32532-1-git-send-email-vincent.cheng.xh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 23:20:06 -0400, vincent.cheng.xh@renesas.com wrote:
> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
> 
> Add device tree binding doc for the IDT ClockMatrix PTP clock.
> 
> Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>
> ---
> Changes since v3:
>  - Reported-by: Rob Herring:
>    1. Fix dtbs_check error: Warning (reg_format):
>           /example-0/phc@5b:reg: property has invalid length
> 
> Changes since v2:
>  - As suggested by Rob Herring:
>  - Replace with DT schema
>  - Remove '-ptp' from compatible string
>  - Replace wildcard 'x' with the part numbers.
> 
> Changes since v1:
>  - No changes
> ---
>  .../devicetree/bindings/ptp/ptp-idtcm.yaml         | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idtcm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
