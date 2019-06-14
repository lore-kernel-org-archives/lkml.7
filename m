Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86638C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599E02173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560542456;
	bh=oGVpjh0HlUF01vcSUKpa8MsFCc9t82Javn73bbdv0Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNbxn5g3wRlMFLdjnrh9PNVFdxs/CoMsagI6M3HhSBoEJt4j23hbnGYNsTn4zl8ym
	 Zvd7Sc6oy0B4BvWbIydLq6ZRbYHua+HxVbJsgxZ5e8VS7i3UGwj0au0GLLJEIlSeeS
	 gAa4GheH+uxd5kwefi5eK/3IBhaEV0XUZa5bdmTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFNUAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:00:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46809 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfFNUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:00:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so3860915qtn.13;
        Fri, 14 Jun 2019 13:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eB18U3DxOdsmPtgK5EfLEq54rx6Rwk5ZlbGeYQvoBGc=;
        b=KtqKU+s08mqzhyZAa8BDozcKDmJFAZQUonOKllQKkQh0ValzFgsAMsO4bvOZaMEBJ1
         OPmpUA+80detOo3LsefNMlGi59pXbEgS+66Ufmy22xv+P0f5b2vWrHzSUsNBHHNBxr1P
         yEjoahwORtYzoRJJutw8lrm09AhKMX6b1be3oEhykC+siAK8rPUV0Gk93mcTqsW16HjO
         n0Vri6HC/Aduj07EL0XevfpdWVJGlzZ+4nByv778urlZUkBvEbEAiT1HAxpnhEs56dvh
         n2Ev1dU1H7o3fc9MvFCJIkPYSi25q8KSDbv7kAdg/zWS1sI27/xm6CtsLDC8+e1B5paR
         sWCA==
X-Gm-Message-State: APjAAAXhjIfKz3YeqIA/Vaj8FeZdBv5Uv3sEuDnAYN5r3r7UgE8bK1ul
        gvhSiO0SwrZbZgU8YDc1bw==
X-Google-Smtp-Source: APXvYqzW+x16AqmtwTMocoooXQV8wwZ0g2afvcGwk5AwhPvYq70dh12nNiLJH569SFP7sRSoYwKl4Q==
X-Received: by 2002:a0c:afa4:: with SMTP id s33mr9531897qvc.194.1560542453169;
        Fri, 14 Jun 2019 13:00:53 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id a11sm2039583qkn.26.2019.06.14.13.00.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:00:52 -0700 (PDT)
Date:   Fri, 14 Jun 2019 14:00:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: sound: Clarify the usage of clocks in
 SAI
Message-ID: <20190614200051.GA12858@bogus>
References: <20190528132034.3908-1-daniel.baluta@nxp.com>
 <20190528132034.3908-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528132034.3908-3-daniel.baluta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 13:21:01 +0000, Daniel Baluta wrote:
> SAI might have up to 4 clock sources selected by an internal
> CLK mux.
> 
> On imx6/7 mclk0/mclk1 are the same, while on imx8 mclk0 and
> mclk1 are coming from different sources.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
