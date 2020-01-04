Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D7C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB84222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578172269;
	bh=Ey9Bf2rpgsWriEz5luLeq+6EFn7bLo7uG30LAOFErJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pCcLZlcXkNWeb4h0gL9xPrjzaZuwIibhkq+rQnb6xxpuW95W42QnNBv3OUom90M/k
	 nAvAcBk5Ytf3ZWTFWXwPMJSmMhCNhDxcF0R+ZVnUqrYpu86fmkvBfCx8j7IAU5yf/y
	 ZSPuzfR9KwRKRky63ZOTQoWmfVvHb6t+eCmyYipc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgADVLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:11:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35389 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgADVLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:11:07 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so44763681iol.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qyoQKQJfODTyZbS5URI1sv4NTniZDyCb+lWHf5D5y/M=;
        b=GSDugfBnYdQIPv5oP+bTtu7yW49RMvgRybHSrgowIYtgVaZWAsGYNGOdK5WEWMut6i
         t1nWtrVQqFsnLX73/mfF3R84WcZuXPHe2JO1XgLT+s4YqOIgRp15GjnMChuOukP411wo
         S0utcaqIBwCXNrBqy3dbMN8INHRYqLfqtUiyEK7JoQgJUjTJ3/apLhE3aA59Cj/FkxRx
         FbyF3YCLCqhxLEkJNnee1eD14m5dozZdVjP7PgcEsdb2fjmn2nQpyVbqNYCOdcmwRMDC
         dFEUFnMBc50YR6Ub0bhVbEQWHDM6bYgqtkk/lKMwl0rzW9jLAMVNAL5+EEbSutXLowY0
         wUYw==
X-Gm-Message-State: APjAAAU29kp3ugBp2LmpPtb/Jj/Rw+CjGliaImwIc2oxnHp2ZjlGeO0R
        GZ5xnbwVNSx8FnkNjEGmt/q/XtU=
X-Google-Smtp-Source: APXvYqzJG7Nw5J/+qODE1zllcaHuiuehZTQ09XaSxWt07Fj1qPjst3UtRxqO2ru9/tmXYgLafAsVeg==
X-Received: by 2002:a5e:df47:: with SMTP id g7mr51959375ioq.31.1578172266887;
        Sat, 04 Jan 2020 13:11:06 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n22sm15896645iog.14.2020.01.04.13.11.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:11:06 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:11:04 -0700
Date:   Sat, 4 Jan 2020 14:11:04 -0700
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt: bindings: lm3692x: Add ti,ovp-microvolt
 property
Message-ID: <20200104211104.GA19869@bogus>
References: <cover.1578134779.git.agx@sigxcpu.org>
 <e6d0ef33f264c4ae679e586a1533fc7a97975db7.1578134779.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d0ef33f264c4ae679e586a1533fc7a97975db7.1578134779.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jan 2020 11:54:17 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> This allows to set the overvoltage protection to 17V, 21V, 25V or 29V.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
