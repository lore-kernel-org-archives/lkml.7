Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC144214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552396188;
	bh=PX650x90Bhz98ZoPKVYQLCrxLpyDGvLwe1QSH76azFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DW8cEpp4fsQbbKBJpNUVUEy4+Rr8PAwSNvcvYIE+1SNfhS3M7BONo8W7SJ36dSzRd
	 ne9Tvp6G9dXYdhPQVQZzkWy8XilX3+VTbMILy0jNjJD0dodBaz7RQVdg4t/Og00lIi
	 fCBEzO3tKlU6WCqzjG6gffMYyY3VdpjvdRBVdB2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCLNJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:09:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46341 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:09:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id c18so2341613otl.13;
        Tue, 12 Mar 2019 06:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6cWu7mCQK4yHxmb1PZh2AHixxCfb0dETjCGN2iq84C0=;
        b=Rk5kc9joIzw96LZKoLl/RKLBbCA4ZlwlDxnwQrfTZJbyfsGYUfSCzKxfKabzuXv6yp
         jOMMC6BNRWnWVvLoSoXnq9g4BuF55JvMeq9Yn1ueRY9qSfWNm69OUwZqYQTlMwMlgOZA
         lVd8wyGtVOPBiz6wM2MW+8dd2eQgxzGGlPwuSQs8zBek8uIFGUeUWpizf0OAJGf3VItf
         MGZDllpZu++0u8be6MMc1j6r/kvRZAHislTPnJ9p+/kOBOSf9QSUKTegl8Lx9tCm7mpi
         FNuqSPqkOazDJDe6CSG7lahjfp47OlyH1xTuVLX9fW1i9QwkIfeFyZr5rZZTsvrzNg/2
         tmxw==
X-Gm-Message-State: APjAAAXAkwuHaN/j2TwWBjEtGIjB7q7WkUSU47m/63l0sBDnd6+iv1eg
        43ZYyLYAGkLIwqvi6ZiDEQ==
X-Google-Smtp-Source: APXvYqy97UOlHRxO+tmQz9AnJPpgkCeb1CCuO4HFaL8VUuvZyIBLe+g/c63M8KOhlc+cyDyxF+BsFg==
X-Received: by 2002:a9d:4b17:: with SMTP id q23mr25393otf.35.1552396186345;
        Tue, 12 Mar 2019 06:09:46 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id i8sm3428575oib.44.2019.03.12.06.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 06:09:45 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:09:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/4] dt-bindings: memory-controllers: freescale: add
 MMDC  binding doc
Message-ID: <20190312130945.GA31098@bogus>
References: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 02:24:08 +0000, Anson Huang wrote:
> Freescale MMDC (Multi Mode DDR Controller) driver is supported
> since i.MX6Q, but not yet documented, this patch adds binding
> doc for MMDC module driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V4:
> 	- update mmdc1 example.
> ---
>  .../bindings/memory-controllers/fsl/mmdc.txt       | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
