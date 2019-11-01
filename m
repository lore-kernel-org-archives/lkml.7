Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE02CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F154222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqgUoVGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKAQJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:09:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41656 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKAQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:09:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so4577109plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mRy57XKTw+iRaQ47Zu7gF5ohXFgXAtsfkcxRhCEocfA=;
        b=pqgUoVGB+Pvgs7uB4bZCVL9ddF6mUcusJ+t0IwqeiLrX6+prPEqal1X/OHf+0FpvvS
         roWNNTa/wYh05Pj1boCFGl+442kLqX6wsmlUJ6S1tT+v2BWeeavOniuzuLm/u9bCtQYX
         eQ8WBHmX0f1nkWYHj+8QpAIzUMREW7EDyaD9Ge6rO8FGPPMVtJOpLaI9G4fol8KUW/xi
         TuNBxblEwg3XBK0qlvvnA++b8xIgGdtWlnxQW1qYSBIH1R3mI/GHMuJ9rSUTslOTzqCj
         f3/WBWImyw0L4OrCd7MgfCSjXeIqz8kiJ2F16qgmfg/G1j+OBvwAP/1b9nQrUn+z0eYe
         varw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mRy57XKTw+iRaQ47Zu7gF5ohXFgXAtsfkcxRhCEocfA=;
        b=oYzTlvOG6XGdaZQnkH6KnFr38zIPqBjZKCAk5pwpWZneUqt1a51e7slBA2AWZ91L1U
         Sz6I3cNv/yXJbrQPeloboPePINVBzaN8Yqjwpeo2M7Xpn5KBDaOsckonM0KWo29xxVk8
         RRR41flqlf2hDGu4Le/ppWvEamb9yadtcsmUIo53y3EF603E/08VUpmtEHZUwAR3r3fP
         5dU0zO5c8DEcCJtpHG412EBMHFJ/zwWBKyzW39CpToJ4/VDe/tGqULrYbAREn4B5z6ZC
         d85flN1a2f9kPo9/wTJ2P7jLS/+e9oy4+jdUou2kwQ2JjFyv4U02Vm8bc2Q7zbm62wmO
         6K9Q==
X-Gm-Message-State: APjAAAWXX3ltaY4nE2SM5T4V3gi0+9HXO8bsGgpq7ZQUdbSmf7ydTeY7
        3I4EGo4YI/CPkjr4mhqh7xgC
X-Google-Smtp-Source: APXvYqzfsLFiVzl52QPqi39geGbcUfS4XiTHJYRx20OJF5w9UUz77wUS+JTwJdlus1wJ1HApS5Y8cA==
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr13800479plk.215.1572624596640;
        Fri, 01 Nov 2019 09:09:56 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6413:fc8c:9538:d2ea:eab:d2c0])
        by smtp.gmail.com with ESMTPSA id v63sm6705910pfb.181.2019.11.01.09.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Nov 2019 09:09:55 -0700 (PDT)
Date:   Fri, 1 Nov 2019 21:39:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Tudor.Ambarus@microchip.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 4/4] mtd: spi-nor: Add support for w25q256jw
Message-ID: <20191101160943.GA20347@Mani-XPS-13-9360>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
 <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
 <20191101145806.GB13101@Mani-XPS-13-9360>
 <beb8e7fc-02c2-8267-3612-20a526ac07fd@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb8e7fc-02c2-8267-3612-20a526ac07fd@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:55:01PM +0000, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 11/01/2019 04:58 PM, Manivannan Sadhasivam wrote:
> >>> Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
> >>> supports dual/quad I/O mode with 512 blocks of memory organized in
> >>> 64KB sectors. In addition to this, there is also small 4KB sectors
> >>> available for flexibility. The device has been validated using Thor96
> >>> board.
> >>>
> >>> Cc: Marek Vasut <marek.vasut@gmail.com>
> >>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>> Cc: David Woodhouse <dwmw2@infradead.org>
> >>> Cc: Brian Norris <computersforpeace@gmail.com>
> >>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> >>> Cc: Richard Weinberger <richard@nod.at>
> >>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> >>> Cc: linux-mtd@lists.infradead.org
> >>> Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
> >>> [Mani: cleaned up for upstream]
> >> Can we keep Darshak's authorship? We usually change the author if we feel that
> >> we made a significant change to what was originally published.
> >>
> >> If it's just about cosmetics, cleaning or rebase, you can specify what you did
> >> after the author's S-o-b tag and then add your S-o-b, as you did above.
> >>
> > I'd suggest to keep Darshak's authorship since he did the actual change in
> > the bsp. I have to clean it up before submitting upstream and I mentioned
> > the same above.
> > 
> 
> Ok, I'll amend the author when applying, it will be Darshak.
> 

Ah no. I was saying we should keep both of ours authorship. It shouldn't
be an issue because we both are involved in the process.

Thanks,
Mani

> Thanks,
> ta
