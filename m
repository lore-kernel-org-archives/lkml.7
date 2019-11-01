Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A4CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534E621D71
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572621015;
	bh=DHRnWs2HEw45y8XEgwbogs3D/xEvwtlHB376bpTsRNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NYQXbjC3/4nlD108B/PZKhjXlUdpTex3I7Iqewj0FrWliq6bF5PvzpsNru9TbnKzA
	 uS+bz3hi9Jz+HV2S6Hm8GXCXCipmfmVDqYfWnAG/rgX8uu3ljpeOOSqOvYGAIuuIBs
	 sRSJnXaPysZ8xL/WJqpDVozgMyOopJb5KKAuZiGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfKAPKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:10:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45499 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfKAPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:10:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id y7so7770956edo.12;
        Fri, 01 Nov 2019 08:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4KZq3kGQPspcz1DGYOZ1s842werTKqCk1PLcvS+4sE=;
        b=BcLPg4RjbUWMpuGD3GoDbtG2Qq87I4qA3tzox2Lw3gwlQrXvSDLsm0mmMJ6Gdo5xXN
         5w+HPRhhCLKIFL5AXNPZod7fDfNQDaxeg2n8NKEq9GKScNxslx/0QWo8QGAUp4wQR3w7
         KWbXwLaAYcjz+weRDz3uPra4JK8pxYZMOfIKqMsTlXfSUOCOj8FL9mMyujEpxamFGqQm
         ME9UecGBgHvRyT/4ErXHzw00mbC4MC8BXJKNew7uq6u+afGnjNbcK9f991pQ25NyEa9k
         sgKnX9ncOXpV2KmrbBM8H5Q6QhKMiu+U4QneMIZYLb62g2BtBb9Qq3yx9FtxAH2cXzAV
         /9Sw==
X-Gm-Message-State: APjAAAWte6eR+bwvKhpwB7cRe0TLT3Hp+kf5GGLPnV2a7h1N/Z/IpJ9V
        1iHf+8f6/iM/9JEJVkhLD1A=
X-Google-Smtp-Source: APXvYqz26adyYVDJfuaglBMs7RfG0GkthAgsMv06HnH23SGBLY/s4NlPYr/haLEMifj8RhJT0FDQoQ==
X-Received: by 2002:a50:ef0d:: with SMTP id m13mr12973589eds.210.1572621012012;
        Fri, 01 Nov 2019 08:10:12 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id c15sm202871edl.16.2019.11.01.08.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 08:10:11 -0700 (PDT)
Date:   Fri, 1 Nov 2019 16:10:09 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com,
        lee.jones@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: power: supply: Max17040: Add low
 level SOC alert threshold
Message-ID: <20191101151009.GB28931@pi3>
References: <CAJKOXPdCtbsPaAgYp5iVBhkAsjXzOYWwttQBptgiUgzhbKi09w@mail.gmail.com>
 <20191031184134.30621-1-matheus@castello.eng.br>
 <20191031184134.30621-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031184134.30621-3-matheus@castello.eng.br>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:41:32PM -0300, Matheus Castello wrote:
> For configure low level state of charge threshold alert signaled from
> max17040 we add "maxim,alert-low-soc-level" property.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../power/supply/max17040_battery.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/max17040_battery.txt

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

