Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF17C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DAF22312
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574115229;
	bh=23CYkqb1sCbHRS367f6Ef2QNQGacCJPjPowbX7/jTW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JeCraRv4T6nT6YKynA6O3OCqVVIZtdHISYlTIEagnB6x97SNgw4n3Ya7P9u3PwibR
	 MMIsU65bV7L4g48rhnokInkl8GtISH6XVcMjG5ntbCiuc784PUCVNsquVX5uysl3c7
	 AmrXTtz0PXh5RObzqA0z0XE4i9+u7Q9f9tdFVQ0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfKRWNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:13:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36064 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:13:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id f10so16017133oto.3;
        Mon, 18 Nov 2019 14:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uz71LFY9ZiC02xsaXtidPtTM6eY67MbXjszr1DEYBdw=;
        b=pFgn+8AsKjAWtF37c920aeglAtloUtSU2vrVHeVHExMAID3eNXKrOb/kRriW8BaDn2
         JrL4Mv3A7f06YMK16G7EuTJi+xZokHwjCWLjBTi98zQLQilpwzk8YXeehuBqOLG94P//
         hqM/rRC0EtIRkgQCJymQN+NEdkSZTnorcj+AdW/4yq1gjp23Y8pd/aRhG1Sh/S/0+kFI
         4/WekN4Q0ByTY1Nzz0UFk0VMbgZa1Sk+8bzHwEF6tDEsQizjrvUqEA0c4a0Q+0taXXsD
         1QEERtYmoZ+RvHBzRGUASkklWkHS51joWCRaXMVrIzXODhHhcx0wUjGeSilLQPD58yq+
         Q93Q==
X-Gm-Message-State: APjAAAVeU6VkW1xOYTtIHrn/SmXF1aIawi4+k7xQZxoRemrzL+RWEqmE
        qtTbwrphqzQnG4x3c52v9g==
X-Google-Smtp-Source: APXvYqw6QpdZzQirquW55aln+tRJNgakjQaUccKPAVTwfpO/53lbAe+zERpVYHbBdX6++qUYf6kIKg==
X-Received: by 2002:a9d:3b26:: with SMTP id z35mr1175001otb.355.1574115222697;
        Mon, 18 Nov 2019 14:13:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm6519025oie.50.2019.11.18.14.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:13:41 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:13:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Subject: Re: [PATCH v4 3/4] dt-bindings: mtd: Describe mtd-concat devices
Message-ID: <20191118221341.GA30937@bogus>
References: <20191113171505.26128-1-miquel.raynal@bootlin.com>
 <20191113171505.26128-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113171505.26128-4-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 06:15:04PM +0100, Miquel Raynal wrote:
> From: Bernhard Frauendienst <kernel@nospam.obeliks.de>
> 
> The main use case to concatenate MTD devices is probably SPI-NOR
> flashes where the number of address bits is limited to 24, which can
> access a range of 16MiB. Board manufacturers might want to double the
> SPI storage size by adding a second flash asserted thanks to a second
> chip selects which enhances the addressing capabilities to 25 bits,
> 32MiB. Having two devices for twice the size is great but without more
> glue, we cannot define partition boundaries spread across the two
> devices. This is the gap mtd-concat intends to address.
> 
> There are two options to describe concatenated devices:
> 1/ One flash chip is described in the DT with two CS;
> 2/ Two flash chips are described in the DT with one CS each, a virtual
> device is also created to describe the concatenation.
> 
> Solution 1/ presents at least 3 issues:
> * The hardware description is abused;
> * The concatenation only works for SPI devices (while it could be
>   helpful for any MTD);
> * It would require a lot of rework in the SPI core as most of the
>   logic assumes there is and there always will be only one CS per
>   chip.

This seems ok if all the devices are identical.

> Solution 2/ also has caveats:
> * The virtual device has no hardware reality;
> * Possible optimizations at the hardware level will be hard to enable
>   efficiently (ie. a common direct mapping abstracted by a SPI
>   memories oriented controller).

Something like this may be necessary if data is interleaved rather than 
concatinated.


Solution 3
Describe each device and partition separately and add link(s) from one 
partition to the next 

flash0 {
  partitions {
    compatible = "fixed-partitions";
    concat-partition = <&flash1_partitions>;
    ...
  };
};

flash1 {
  flash1_partition: partitions {
    compatible = "fixed-partitions";
    ...
  };
};

Maybe a link back to the previous paritions too or a boolean to mark as 
a continuation.

No idea how well this works or not for the kernel, but that really 
shouldn't matter for the binding design.

Rob
