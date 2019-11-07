Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A6C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E52187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhNMgVR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbfKGMkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:40:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36598 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGMkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:40:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so1353468plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 04:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8jX8dOpYJ1sYbsEashiPOSNbkt7RaXnABrhm5i8Aj9M=;
        b=OhNMgVR1JurtHSg7JRnW5MneUVfZ4N2eyVOh4tyDi/lYeME7yGCak6XJOdDte4Q4FW
         nQvdcHkc6W9ilP5NQU0V4nr15Hd2JJTH30cDrvtEphukn/FZEqkJhZSQsbmg6P7Agtxh
         eMnh5QIz9TVsvyAWr5Iq7dyq7W2wpOE5sQkvIwoUXMZ5IoPAq0GGooUSHcoSmAr72huh
         Mmw3TvhSfzF6YcN9Qz84xQY8CsWgQFJ5MQ+OsRrV5NlNcawn07+d235F5F4QInmuTAwn
         nsclYULSqxe+5XCb30Go59+kGBWspcuisgeeS8NhEmsUOQAdndMu1fPVVvKZmKtImkc/
         ldJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8jX8dOpYJ1sYbsEashiPOSNbkt7RaXnABrhm5i8Aj9M=;
        b=Ppg+gz/ayhviZNllq7pkYQDB3PltKBt3sGPwsYEQ7msn5AvAIHl0PVvw3ynDIrVdMx
         bZTV0MopVwak+cfvDg6J/BNUJ0+Xqr1wnvjumevYvmwQWxl0Dbhk4jzOibbvhsnfhue4
         ri34HHPynUYF82sxcjTOClnXZTq1k4MhYSQ6R8JNBTXq3g77BC4qJFuXm3lQBUKWGSsG
         hCMRiyedTWz+uYQBCGhDl7jBXTM4oxt3HlGu7DgNe5WUBxI+/DPY4rKYJpGimKEH2Nx4
         Q3zqDcOTGvksF9oqEUfvipdSOERXuJDxopCTAyRF4ci8hgANCzUl5EOLWNDse+ud50N4
         kFHw==
X-Gm-Message-State: APjAAAUhViFCAcndcga9EojB5nOQVGvviLhbxd00edWizOMF+QWN8gE8
        XJBOc3Q7ZfLRHz8K731SI+Ty
X-Google-Smtp-Source: APXvYqzLZIcS35G7SY5EiXmg/0cAcZzuoHT0TORHjL6RIHzhpWtlIhCX5uDclrlz3ZQbwSIqPV3S6g==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr4943909pjs.5.1573130435309;
        Thu, 07 Nov 2019 04:40:35 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id c16sm2442334pfo.34.2019.11.07.04.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 04:40:33 -0800 (PST)
Date:   Thu, 7 Nov 2019 18:10:23 +0530
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
Message-ID: <20191107124023.GA11727@mani>
References: <20191030090124.24900-1-manivannan.sadhasivam@linaro.org>
 <20191030090124.24900-5-manivannan.sadhasivam@linaro.org>
 <87e0b459-8dbf-26cc-611f-1b1b5266aa55@microchip.com>
 <20191101145806.GB13101@Mani-XPS-13-9360>
 <beb8e7fc-02c2-8267-3612-20a526ac07fd@microchip.com>
 <20191101160943.GA20347@Mani-XPS-13-9360>
 <ba29a5dd-df80-841b-68cd-66cffd6ae7cf@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba29a5dd-df80-841b-68cd-66cffd6ae7cf@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 12:30:05PM +0000, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 11/01/2019 06:09 PM, Manivannan Sadhasivam wrote:
> >> On 11/01/2019 04:58 PM, Manivannan Sadhasivam wrote:
> >>>>> Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
> >>>>> supports dual/quad I/O mode with 512 blocks of memory organized in
> >>>>> 64KB sectors. In addition to this, there is also small 4KB sectors
> >>>>> available for flexibility. The device has been validated using Thor96
> >>>>> board.
> >>>>>
> >>>>> Cc: Marek Vasut <marek.vasut@gmail.com>
> >>>>> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>>>> Cc: David Woodhouse <dwmw2@infradead.org>
> >>>>> Cc: Brian Norris <computersforpeace@gmail.com>
> >>>>> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> >>>>> Cc: Richard Weinberger <richard@nod.at>
> >>>>> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> >>>>> Cc: linux-mtd@lists.infradead.org
> >>>>> Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
> >>>>> [Mani: cleaned up for upstream]
> >>>> Can we keep Darshak's authorship? We usually change the author if we feel that
> >>>> we made a significant change to what was originally published.
> >>>>
> >>>> If it's just about cosmetics, cleaning or rebase, you can specify what you did
> >>>> after the author's S-o-b tag and then add your S-o-b, as you did above.
> >>>>
> >>> I'd suggest to keep Darshak's authorship since he did the actual change in
> >>> the bsp. I have to clean it up before submitting upstream and I mentioned
> >>> the same above.
> >>>
> >> Ok, I'll amend the author when applying, it will be Darshak.
> >>
> > Ah no. I was saying we should keep both of ours authorship. It shouldn't
> > be an issue because we both are involved in the process.
> 
> There can be only one author in a patch, and multiple signers if needed:
> 
> Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Date:   Wed Oct 30 14:31:24 2019 +0530
> 
>     mtd: spi-nor: Add support for w25q256jw
> [cut]
>     Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
>     [Mani: cleaned up for upstream]
>     Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Please read
> https://www.kernel.org/doc/html/v5.3/process/submitting-patches.html, paragraph
> 11), and tell me if you want me to amend the author to keep Darshak's authorship
> or you want to keep yours.

Just keep me as the author of this patch. Darshak still gets credit with his
signed-off-by tag.

Sorry for the confusion!

Thanks,
Mani

