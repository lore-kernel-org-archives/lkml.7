Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBED6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D75208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfDXP5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:57:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36506 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbfDXP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:57:06 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so7072465itc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIId6kCcVcx1AyE55PTDF4Z6iHjQ4rDpUrHBXio3Vqc=;
        b=QAldvC1jwdwaKozQBa5HURtfhNcBoE9Dy5JysgzJicz77F44En28c93nmiKGXT281i
         DAEOzYcofEJCd2u9UGXIQYOuhz8l9kk7+wg09pjXiWj3wyxM1FKvmgTvP/+8tIPsO+Ig
         V4Dd7RKH46swD1wNKVsX9t/tInzUR636FHye5ym1oQjqZHcYCDEoy2+TWxtaLxNx3obp
         zkcqrGiqE1/uOEr9GMdFKVdwG/BXIqR++vZKr+A0aQO+U2yyY+C823VvHX/t0c30pkvX
         k11rI0tEGNXDdwaYbmf8Iv+OU7x1Yyw6+DL8W6gSHilv2rSRcNJCnyqT4txoN7MZSUdY
         k+vQ==
X-Gm-Message-State: APjAAAUep+9FSnbn+lGN3pHUOjd6zJYeVxHYM3TVgYNm3MGqJ2uqFuT+
        H66V0lnGJIqC3wjtizIyMbObSA==
X-Google-Smtp-Source: APXvYqzvpWmji8fsdgcxgGb1QN660dc4otiX92zpCrCXYubfRyskdT0+70MYWaGOTHxZzKrOY+5aRg==
X-Received: by 2002:a24:d003:: with SMTP id m3mr6698926itg.132.1556121425498;
        Wed, 24 Apr 2019 08:57:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id m137sm9135010itb.27.2019.04.24.08.57.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:57:04 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:56:59 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "zwisler@chromium.org" <zwisler@chromium.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v2] mmc: core: Verify SD bus width
Message-ID: <20190424155659.GA193321@google.com>
References: <20190416185705.256369-1-rrangel@chromium.org>
 <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925C1C304B992339621808AFC260@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 06:20:26AM +0000, Avri Altman wrote:
> > 
> > The SD Physical Layer Spec says the following: Since the SD Memory Card
> > shall support at least the two bus modes 1-bit or 4-bit width, then any SD
> > Card shall set at least bits 0 and 2 (SD_BUS_WIDTH="0101").
> > 
> > This change verifies the card has specified a bus width.
> > 
> > AMD SDHC Device 7806 can get into a bad state after a card disconnect
> > where anything transferred via the DATA lines will always result in a
> > zero filled buffer. Currently the driver will continue without error if
> > the HC is in this condition. A block device will be created, but reading
> > from it will result in a zero buffer. This makes it seem like the SD
> > device has been erased, when in actuality the data is never getting
> > copied from the DATA lines to the data buffer.
> > 
> > SCR is the first command in the SD initialization sequence that uses the
> > DATA lines. By checking that the response was invalid, we can abort
> > mounting the card.
> > 
> > Acked-by: Avri Altman <avri.altman@wdc.com>
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> 
> Thanks,
> Avri
Thanks for the review. Should I rebase this on master so it applies
cleanly without the MMC trace patches?

Raul
