Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66937C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314D2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giRris/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDAK1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:27:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35411 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDAK1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:27:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so4353631pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/Xgo3CYftHa5akC5Lryyxb3IyaO1XP3Lq0Ze4av3KsY=;
        b=giRris/lHKar4gfI5SdpTGFoZMbr02DsMky04ik7PUR4DDLMN0X5Q7SNwMMUZLMVhv
         xvsL95iB1EYMHjEyNetfPrkvl+0evP0m9IOS3G1WEB6ANK6G5zkgKI2uRXuzH7bVQ0y6
         kHTTP0kEo19rAlHHZcqt+ZssXlZsqh4IZgEf6yRRbjUadZaGGa/XuUi1L0wQ2n9DIcd8
         3DBMesLJe9DDOiRPtqe1g0ZbAs9r6ZneQ7iGGaddjCYjpJoXJG8aea05Alni7fUofNL6
         nZ0qlN7ZRP/7db8+0dBfyzTBy4UVhC8N6tcreZ1ZWZsMkasyQQ7RYUR7roIJCmy8qj4F
         WDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/Xgo3CYftHa5akC5Lryyxb3IyaO1XP3Lq0Ze4av3KsY=;
        b=Z+KkmZJVF+M76cB59duC0aHoXXuCT6QBRTC1cFldkqkpRjI7GX6d37pCky3zieegIe
         /+xfAXvswzhWO7Cwr8z5wBv8h3/W01xZFB3yAZtmSO4Jafiz3M7mlTl06XqogBHAfD/K
         n6KCFeBx4c2cmGr8fPcePFepolO0x+aYuwnExxi1jkFei9kuyWPflSdCc7MNUBLj8orf
         e0PENsq+ItFsfZsKW2PlHUdTyp3j6va2E7L/KGS7k2/E8wYQLD8o8xEe2uPOfjxJbZqW
         Fky+cllXBumPMN/vIhGdKrY2K7JEkW/q87SmZEogqkXW8bDxvJiOLHJAkkJEexKY+5pC
         YrBg==
X-Gm-Message-State: APjAAAVYaBExrUIGkbRZSGRT8eoGVToNWaflE7050cneCtz1AaKKqi38
        Bo5hDdoo/ZF9QwZtKL44G3sWDg==
X-Google-Smtp-Source: APXvYqzAe4+7gxEu94yZoLT1Zk7a+VCUMS9tsKB8Uau2DdaQ483ztY+Jjvq/xeCAuWkAA7MzPGXWtQ==
X-Received: by 2002:a63:fb16:: with SMTP id o22mr58569167pgh.209.1554114457891;
        Mon, 01 Apr 2019 03:27:37 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id n65sm30600050pfb.160.2019.04.01.03.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:27:36 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:27:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: linux-next: Tree for Mar 27 (sunxi clk & mfd)
Message-ID: <20190401102732.GD4187@dell>
References: <20190327145020.2fff97b8@canb.auug.org.au>
 <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
 <20190328095036.734adbba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328095036.734adbba@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Stephen Rothwell wrote:

> Hi Randy,
> 
> On Wed, 27 Mar 2019 13:32:26 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > on i386 or x86_64:
> > 
> > WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
> >   Depends on [n]: HAS_IOMEM [=y] && ARCH_SUNXI
> >   Selected by [y]:
> >   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
> 
> I reported that a while ago (x86_64 allmodconfig after the merge of the
> sunxi tree).  Apparently there is a fix out there but it hasn't been
> applied yet.

Where is the fix to be applied?  SUNXI or MFD?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
