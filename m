Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CAEC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AC020823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfmT9G1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfFSEoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:44:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45337 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSEoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 00:44:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so8957969pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 21:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0g2bMiYO6BRA2joCaPp5+9aQYPyjIoLsu+QBVbjEMxA=;
        b=sfmT9G1yEzmffemmyEunK8elvz+2NW6YF1tMii6so/sAc+fZaH4JOs35gAhHTLzI3X
         LCuobRsUJaG2GWVFihuAbjj1ocW2m5V9b9GKLYjgLXYzvO/4R2eOuNYwLl5Axdn9lUgt
         oOOL9Osd3aHQu5kgm1rJ2GN1g/12SI+nxTplRMXdtDRXaKkzT5FCABI6euK5DSPTJTwl
         +j0K7Dt5MxV75IYzB/EpayG+fZfs1rW3BWkKYmY37cwdOAaPAf+Xv9FPQuUan8ENCAMG
         ik1Vda/Dz+F8i6DfAM1QgeNq0eec2CrcSa2faP2mCIY6oZJmGFvnQet1lymfDb0457Fp
         58OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0g2bMiYO6BRA2joCaPp5+9aQYPyjIoLsu+QBVbjEMxA=;
        b=pSlh+5fkRntOb/SHnArnE6Pls4xxAYyZUodfTURSkS8CelQBV37JHt/ZMGW0yq9I04
         Q62440O2PYtvmmnJzAsxbEAIYmxhol5V5iWcFSOV5DmtpJJDTI5GHhumm47s+ZC+/SUk
         5w9GA3AOC4ZZflEAwRZUAh4LGKTEahSDaqhmqvjBV65r2tvK3rqk3q01IjhiE+Yj2erb
         BjapxWiNLeEXVszr7bJf86Xai+i9GUEdI770DuaI6Zsp+tisWlrsehEU+fQJrnDjE74X
         UsZBsgqrwtZZvVHvQAw9qeaMszwkeQGqMt+jqQ0oBympq52+j/BR3fOrImrs85V01LJE
         aFaQ==
X-Gm-Message-State: APjAAAX5Qtxh68/B3qfUqXXIbeePfYVFm5qJyX/3H/l4CWU0splX3mzg
        JBBvLRtYzHY7UgfnjycJNJs=
X-Google-Smtp-Source: APXvYqzRg6obEwd9JJxwejjjACMV+5VfM+yMhhfcGZ+vgly7KUUyNnkpdlWaxypx9XVf3RKLVGEm1A==
X-Received: by 2002:a63:f50d:: with SMTP id w13mr5977079pgh.411.1560919471616;
        Tue, 18 Jun 2019 21:44:31 -0700 (PDT)
Received: from xhdnagasure40.xilinx.com ([149.199.50.129])
        by smtp.gmail.com with ESMTPSA id y14sm341083pjr.13.2019.06.18.21.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 21:44:30 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:44:24 -0600
From:   Naga Sureshkumar Relli <nagasureshkumarrelli@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20190619044424.GB28766@xhdnagasure40.xilinx.com>
References: <20181212100931.149b0cac@xps13>
 <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181212141825.69711c57@xps13>
 <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181217174114.24196d17@xps13>
 <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20181219152647.76f77711@xps13>
 <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
 <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
 <20190128102720.70a52da7@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128102720.70a52da7@xps13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:27:39AM +0100, Miquel Raynal wrote:
Hi Miquel,

> Hi Naga,
> 
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Mon, 28 Jan 2019
> 06:04:53 +0000:
> 
> > Hi Boris & Miquel,
> > 
> > Could you please provide your thoughts on this driver to support HW-ECC?
> > As I said previously, there is no way to detect errors beyond N bit.
> > I am ok to update the driver based on your inputs.
> 
> We won't support the ECC engine. It simply cannot be used reliably.
> 
> I am working on a generic ECC engine object. It's gonna take a few
> months until it gets merged but after that you could update the
> controller driver to drop any ECC-related function. Although the ECC

Could you please let me know that, when can we expect generic ECC engine
update in mtd NAND?
Based on that, i will plan to update the ARASAN NAND driver along with your
comments mentioned above under this update,
as you know there is a limiation in ARASAN NAND controller to detect
ECC errors.
i am following this series https://patchwork.kernel.org/patch/10838705/

Thanks,
Naga Sureshkumar Relli
> engine part is blocking, raw access still look wrong and the driver
> still needs changes.
> 
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
