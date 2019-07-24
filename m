Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C01C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3589C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000422;
	bh=oFnN17iv8U4rG2AZdLOCDkpUBj1bEEnYUPwoCvW33QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gNDtPSyc3/jgUCvNZPMhCTxQEWrnnF5IrwACs94H/70irtaCK+QWeBvFZYMvelljv
	 cWL11wlSY4WChqcFCu6MF0thodahezSQAozJQt0oTPWdNGrpuyCa8rWbbOXmEiE08b
	 W1t7r5YUzQk6AY2LCyEYiyZtDv71NDkjvdngoWeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfGXUdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:33:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37551 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGXUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:33:39 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so92410444iog.4;
        Wed, 24 Jul 2019 13:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hWxG43uUzUPGcDAeTJWX9/ElhRTOT4ivffhul3s+rgA=;
        b=e26qGOhbJnebGG2ZkYbqPJapzxvogyzmT7VqydGVJcp0E1CdHv1wcg8AZUzz7aw7df
         MfXB6UVYiqx4roQfnJmVejtHGNum2rN/aKrVzrYmzgsRODGt/qrwH0AK0Zyb3SV2URRl
         jCvpJZ6Gd6pZAOtadj52i0PWEualwukHXVbZ6Xx9YANu+FCZbpnuMh4DO/CfAlZAQdu1
         CNtyvuhgxqqQUfnoPEbmGrP6FDvgYyg3QBhzMNbi3cDB1XIeGjuZ8qhYUFeo3wGtk4c7
         ex8QhZW1lzLGQQ1l1kU0Sxf+aajXMFF2/Ts/QcIY11JEqm1OHzqHHXMReETuhbfRhOiE
         H90Q==
X-Gm-Message-State: APjAAAVa+OqlDVZsbztkF2Pd0A4Exlbt6g+AoXT2sY2lVdl5M5YeuShN
        4s/pDNvz1eSMOg3sbZo6zQ==
X-Google-Smtp-Source: APXvYqy956/3Br9VEhD6l1nrDo5N42Sw/FVSNlfk7v1cZXU6Bmsg2phvVL23Wpj7HoceLR69D9he5A==
X-Received: by 2002:a02:c7c7:: with SMTP id s7mr27166379jao.37.1564000418767;
        Wed, 24 Jul 2019 13:33:38 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c17sm35498762ioo.82.2019.07.24.13.33.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:33:38 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:33:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20190724203337.GA20268@bogus>
References: <20190710134346.30239-1-gregory.clement@bootlin.com>
 <20190710134346.30239-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710134346.30239-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 15:43:41 +0200, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
