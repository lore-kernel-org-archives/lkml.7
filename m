Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82137C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5794120869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556309457;
	bh=zvMIY3ZjlsnK+W8Ojy2hzj1MbYF8LcXtNJYDxM6Omc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtI9uZ4AABFNMVY8LOSXM9uxi53Razx0GBYfyP33Gr+2qLvo+HQpvsOdKwMS98WT6
	 EEVaCG/HsNOc6ZwDtYCJ0c+stcB1Jhst6XHR+fBbQgS9aLODlbwybGPfGbOYTTcSoM
	 v+wgbsPvmWzirHXkam8YVH1M/uHnVC4VwELb1xDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDZUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:10:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46532 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDZUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:10:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so3669429otk.13;
        Fri, 26 Apr 2019 13:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EIrViTHQy/HhbaZAFL1n34DvIIYgJIxX3veMFIez2DQ=;
        b=bGGwFX7X3Z4Vah/Wwmii8LLzIDfJ3nfUEIkz6qkiD2N2TL3Dg88/IhdL2Fg7leWVD6
         qyQ3smQyYVxULC5m+qzW1+6U0BstcBdwBQRicejrb1syGi/ycQRxYwAtpMihIIQKvZcZ
         H+bLYwZj6Dzjn9BpB+2oNAx0IK9odsJ/8leHkwpHZ+3fqUewR5OlKHX/ONKOt4Jk/ha9
         Ss33jskr89tGhC+yXz8ihLM53rXmSaGOQjbTOHTa/lek0l58F9Xz2eb/4Wi8fPndHVfQ
         dLCQDfk5n6bF+5nGq+5klgiJE+TQrnqfSrqN3YvwNxorhfnrZWiZ7O29n7zK5JhyU0wh
         2eIA==
X-Gm-Message-State: APjAAAWNbZKtH7dEyDeIjzV5OrDfn81n2TQdqAb3xMlt/Fk2eVFiLiRk
        zEGb1Fk+yZ+c6uDljDmANA==
X-Google-Smtp-Source: APXvYqz6sJpskQDgC2ryPjI0HgjLYWa/4xq+SyCHkVIXMqM1IxQaTGS+dkK6beNBDWC/ZTfXgB/ueg==
X-Received: by 2002:a05:6830:1342:: with SMTP id r2mr28483459otq.105.1556309454488;
        Fri, 26 Apr 2019 13:10:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 38sm5564328otg.10.2019.04.26.13.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:10:53 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:10:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: mtd: Add binding documentation for
 HyperFlash
Message-ID: <20190426201052.GA24002@bogus>
References: <20190423104814.5762-1-vigneshr@ti.com>
 <20190423104814.5762-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423104814.5762-3-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 16:18:11 +0530, Vignesh Raghavendra wrote:
> Add DT binding documentation for HyperFlash devices.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../devicetree/bindings/mtd/cypress,hyperflash.txt  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
