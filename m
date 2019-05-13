Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B79C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C449B208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YguDFwQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfEMOGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:06:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46549 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfEMOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:06:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id r18so1782747pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFTVOemihi9Y/ybUHoKE6WPrQqKRWGsjPa+RThuNPJY=;
        b=YguDFwQxxbQysZNVchZDs2o4+DUSWuunvES7JkNU4ESIaDfofMcLQrCJg4rZPMtkEG
         zGe/+1AU+lMHjEY/W86b0Q1KiZM0XSmjQcHW5yuy0LMT4gEYKO76LS3jwCNItGhJ4H3r
         8i+tv0vi+Qekkzkd59vD/ESQ1UuV76fO8oz3eTuDcP4ZC0UJvaNa7A4QZtSimhCra7vB
         vC2DSUeCgI8WrsVy3Or+F/SfRLH3XO25o3cMUqA+NFpQ8Y6j8Anshulkzg0ohoQzDWn4
         QqNCWG4xIzshEdiwsewWNuF4/SuUd7x+RNPb5VDPrqQliR40UnSZotQI12rMVjEcsrYa
         BEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFTVOemihi9Y/ybUHoKE6WPrQqKRWGsjPa+RThuNPJY=;
        b=AhX50LVsg6Ir6UFhaprbQVbFUROXVPPatbCg3AiIkq1uSVKPkDPI2npdHwOVY6U4mb
         5ml6w6qk8Llirc1CGobOcrExl8+tkJnx+rjxBshU60JqYXAWPIIC0CR+4vLbolD8ZVq/
         VGj1vSfXuL5yh4cbyjX/1Ard5AvuXQ9OnaLulKVuRHimN1/x6/byr/DYLmQaq8oOCZ5I
         mwCn6TvgVICZDhzgbV5a+Rb3G6qyiXYvu0XJomryepMC2ZOpo7EhaH0QOwMkWDIVx3bY
         T9XRzC6prrfyDFT65rQatqHi8LwsXUEI568gFixbradkNZw6JMQa9zaO5S2SP3SMRiVt
         nZnA==
X-Gm-Message-State: APjAAAWWd+/uuH3uMcs6ngl8TNJ+chRszEx/Igiv5QIK83kHvOD8Ytt3
        tEqyr4dyrBvUZS9PAEEbnq8Q
X-Google-Smtp-Source: APXvYqz4VLebjlmI/Dtm6WX8eMjt8XKoSB8c0yipsVgkqQ040qq1P2HKOvddgMuEgSK7VK6TcrW8Ow==
X-Received: by 2002:a17:902:2aab:: with SMTP id j40mr7336987plb.238.1557756403532;
        Mon, 13 May 2019 07:06:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:7240:500:85c2:3660:4904:9fef])
        by smtp.gmail.com with ESMTPSA id h13sm14931843pgk.55.2019.05.13.07.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 07:06:42 -0700 (PDT)
Date:   Mon, 13 May 2019 19:36:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, haitao.suo@bitmain.com,
        darren.tsao@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v3 0/4] Add reset controller support for BM1880 SoC
Message-ID: <20190513140637.GA19120@Mani-XPS-13-9360>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
 <1557745589.4442.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557745589.4442.5.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, May 13, 2019 at 01:06:29PM +0200, Philipp Zabel wrote:
> Hi,
> 
> On Sat, 2019-05-11 at 00:15 +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This patchset adds reset controller support for Bitmain BM1880 SoC.
> > BM1880 SoC has only one reset controller and the reset-simple driver
> > has been reused here.
> > 
> > This patchset has been tested on 96Boards Sophon Edge board.
> > 
> > Thanks,
> > Mani
> > 
> > Changes in v3:
> > 
> > * Removed the clk-rst part as it turned out be the clock gating register set.
> 
> Thank you, I'd like to pick up patches 1, 3, and 4.
> 
> Since patch 2 depends on patch 1, you could either temporarily replace
> the constants with their numerical value, until patch 1 is merged, or I
> could provide a stable branch that contains patch 1 after v5.2-rc1.
> 

I can use the numerical value in meantime, please pick those patches and I'll
take the dts through arm-soc tree.

Thanks,
Mani

> regards
> Philipp
