Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA4C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DC521855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530757;
	bh=shfBci4s4Mb8JaOapTN1kZyc7SHXQSBYlwhFMIXUkwc=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=W0bUnbNzXDrw1Zn2NsDVmKKQrvleWToVi5RlFvto5oOLwx8PVNmNjIwFTqZoVdBes
	 mQkobBW44jFPQkMyweCgZDSDQftWTNNnvgVA01bcfib/DN+yTdX1Vl3N7u7/RB41WI
	 lsP1eoaFoEK+GPDcIRzUUfnUA/ghY18qnaAc5Sj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDFGFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:05:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43772 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:05:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so1269879pgu.10;
        Fri, 05 Apr 2019 23:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=2rS5dxlM+I+HbCox3AhVK42CM/mW/5wJmozmgACgE40=;
        b=GsjMkFmIqJh0ZxSQ18oqRgLURUCuAu/R35XdqP6pYIOeEWaZh/rkXfszivCyniAfkf
         u5p2SgnB536m8s5I2Tto/TCXtxo1wReDOmIKqMnicME0zLceieE68f1d6MEu7ghIYthg
         tq8Bq1Jp7Xrk7wldZOvfL383YBdN1+uJapxM4dRdu1WdmMs5D6HxK3KO40nuE0G7FklM
         usfUF6ssgpY4nsxeTjiXPvYThxIBviGb64Pk4CM61Mc2Y0KJZdkQq7C5IGJ0+BewB3Zb
         5a9pvvX20IdTkxnESUsFoKWEM1Ilc4PLBdHUxdx1RC7XQQCBnobcaE9WdYjQSg8ek7cD
         0pTw==
X-Gm-Message-State: APjAAAXc98Vpp/952g6vs6PBcn3kC7/yDSrWc540Z2Etk6Vd3WeRzgZW
        Zl0MvlP0yE6WHg5VEg1WRw==
X-Google-Smtp-Source: APXvYqyNRw/JqNCHgdpApW0s1wEL633I5rY79NwIHZF5NsceiBGQZ8xrUReyG6qT17fxfCZIeF1VGQ==
X-Received: by 2002:a63:945:: with SMTP id 66mr15532470pgj.128.1554530751584;
        Fri, 05 Apr 2019 23:05:51 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id j6sm31178545pfe.107.2019.04.05.23.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:05:50 -0700 (PDT)
Message-ID: <5ca841be.1c69fb81.9bbef.2ef4@mx.google.com>
Date:   Sat, 06 Apr 2019 01:05:49 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-binding: mtd: physmap: Add example using addr-gpios property
References: <20190329021322.6833-1-chris.packham@alliedtelesis.co.nz> <20190329021322.6833-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20190329021322.6833-3-chris.packham@alliedtelesis.co.nz>
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 15:13:22 +1300, Chris Packham wrote:
> Add an example showing how to use the addr-gpios property to deal with a
> system with limited IO space.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - None
> 
>  .../devicetree/bindings/mtd/mtd-physmap.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

