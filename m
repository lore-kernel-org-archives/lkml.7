Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F410C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199022073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575486745;
	bh=P9Btc1y/HH6/zBrq5foS/s8V+rj1DSW+EphgHwhqlBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OMHZGyI1kTDxCOi4lhiETwON0753p4iLUn7CFS2yblA5JKkvs1R7Oou9Cu486EJBl
	 oeb20IFO5pZPO1pgVP7gyuQpWRg57XV9PHI2uRw5qLPXgiyOnkHA403RTykG/bQsh9
	 2tYH1Mja24OvtTYDk5ZVo5XHO8lsVl905UIEx/+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfLDTMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:12:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45098 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfLDTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:12:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id v10so253290oiv.12;
        Wed, 04 Dec 2019 11:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJF8QJlqp+vHYH7MET2rR8dZMnoSfUiUrUd7ao63kNg=;
        b=MBaKkPHlFQlkrdlLjznYAR7GtoVkE3n9qHWjXo1KcRV/lGwjhPIXONA8AL1Y2yUOOu
         joldm7GIdmr/evJd8IC3JxElJakSSGM8TGuy4uPErBuJXAVrDehGyYKxD8F9qyjNULqn
         nCWpp0nAggNSgI/AT8QSlvHZ2eKO9tER3Pxy9C28QvCySxNEaQAqlSZueejF52V9nJwr
         Ax2KbJZIr/jr4qj6ppXRxiSVmty+L0qpVyUIBAtgA591MI1AxyJMkc7iBRupNLMmLhfW
         T9JWUqr6zvKt6WOsWWkQiqw+m+Y/V37RF0ISdt3rRDi9lKQ+anck6cvPhzb60tFaFHJS
         vbeQ==
X-Gm-Message-State: APjAAAUYueqhzkc0ZpoS0X23RFFuE+OpaUUoOuvV94dTlHMt8N/5ExOh
        ui61AYecAZewDiUGEkab8VUq/TU=
X-Google-Smtp-Source: APXvYqxZsp6Boueg7LT/zYs+LCC2WL++8X0NkLr1C5Xzy3VXHiOov75J+lJ8eUO8aPzifacC3vNTRA==
X-Received: by 2002:aca:4fcd:: with SMTP id d196mr3997896oib.89.1575486743132;
        Wed, 04 Dec 2019 11:12:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm2601628oii.2.2019.12.04.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:12:22 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:12:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt: bindings: brcmnand: Add support for flash-edu
Message-ID: <20191204191221.GA14944@bogus>
References: <20191120182153.29732-1-kdasu.kdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120182153.29732-1-kdasu.kdev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 13:20:57 -0500, Kamal Dasu wrote:
> Adding support for EBI DMA unit (EDU).
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  .../devicetree/bindings/mtd/brcm,brcmnand.txt          | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
