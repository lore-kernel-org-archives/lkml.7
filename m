Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C2C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266E820449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LEcQUq/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfDSSht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40275 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfDSShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so7868484wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=QKlGpXMb0tH6sXLUBD9ZIQCBRut+xvYk+uAsWH/Xqdo=;
        b=LEcQUq/8YocoNv2HI/cxUg2aA407+INpeeYIdnSNzo8djaGCCV6r5gB5a9gddpJ+Ie
         w00jw1O4XooxXbu3erMZ3Dl31r0tIRAPII82oHCglkB/yAYFv5/vmUhpBQ2D9mt3iY0I
         H3ZRfMh9Q9EkAV1HOy22ISb8sezHHDws2QTmOmt1vsLAlYwncEiOlG6xCbCg41W8Bgx1
         z7TioaSIfkhRJ/J4xHKoPVYxxlX+ecjtHTvrYfIrxRBbjmzyIpsdzu9SY6oDB42SCh0q
         NZaFxxwkU+b0rZ96gyzHnMow9WMoPiXDaMlyg20o9hK8dOWflLcOWib7chyBQn+NzoQd
         /mXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=QKlGpXMb0tH6sXLUBD9ZIQCBRut+xvYk+uAsWH/Xqdo=;
        b=gRt+r/AiZg021clKgljJZg+s2WTBLBvbZ+G3hkDDsXdgXM1DQH1W8d/2pApTY1mj3S
         yG88AeddSnnKt+Z1WDdVgIMgb2WhzLT6uphDm43V1We8YDOM+yg+jpMuo1NJ3h/mwpKY
         6NACuvQaCUZmzQtZMjzcMci2B7gQw7IIAZjq0l5ViAe65NiEAHe87dDUyz7kCmKcsYgy
         Z3PfRBn3dRTnDXO4LMgRleLW0QnCNd1ve3zLrffhRHQGM/X0g9XwRqr22JecYGh71yI1
         kdXpdD5m9El/zTiLCHxJXMbp8ltdyrZ5Xtoa9B9wNU/M9Vd4/DcdgLBPskZdb0Suu0Ns
         BtuQ==
X-Gm-Message-State: APjAAAXT6fxSO9Ne8WFkMWrlQa3JwPllU843S55eL0cyWKwg3xn9Ama9
        B6w6iXnUfPvSftua8ca2jtDoFQ==
X-Google-Smtp-Source: APXvYqyaMpH0BzYdCVCZB2jCvkbbbSwap7n2VjNC7yF7/Uq0OJB6wZFnoH4/mW9fZvVyV1jala0oTA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr2043072wro.232.1555663999874;
        Fri, 19 Apr 2019 01:53:19 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z7sm3203946wml.40.2019.04.19.01.53.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Apr 2019 01:53:19 -0700 (PDT)
Message-ID: <5d65cc12e18f9a4b86c097fbade0cef91b3b5d9b.camel@baylibre.com>
Subject: Re: [PATCH 5/7] mmc: meson-gx: avoid clock glitch when switching to
 DDR modes
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Apr 2019 10:53:18 +0200
In-Reply-To: <5b19d32be23fbe630339fd48f93b16e9301385d1.camel@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
         <20190417204355.469-6-jbrunet@baylibre.com>
         <CAFBinCCAbMpWYY6-W+909Q=jLpweC2F6ED6CVf6zVGrRiA1hxg@mail.gmail.com>
         <8316d7875bf0479e91cc11ce5fbf3b2e21f92a2c.camel@baylibre.com>
         <CAFBinCBQPSsqwDSd6nQMLqOuApiESwHXn4wQbOp49WLpXfBk=Q@mail.gmail.com>
         <5b19d32be23fbe630339fd48f93b16e9301385d1.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-18 at 23:15 +0200, Jerome Brunet wrote:
> On Thu, 2019-04-18 at 22:53 +0200, Martin Blumenstingl wrote:
> > Hi Jerome,
> > 
> > On Thu, Apr 18, 2019 at 10:46 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > On Thu, 2019-04-18 at 22:16 +0200, Martin Blumenstingl wrote:
> > > > Hi Jerome,
> > > > 
> > > > On Wed, Apr 17, 2019 at 10:44 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > > Activating DDR in the Amlogic mmc controller, among other things, will
> > > > > divide the output clock by 2. So by activating it with clock on, we are
> > > > > creating a glitch on the output.
> > > > > 
> > > > > Instead, let's deal with DDR when the clock output is off, when setting
> > > > > the clock.
> > > > > 
> > > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > it seems that this patch breaks SD card on my Khadas VIM and Khadas VIM2.
> > > 
> > > The error I see in your logs is with eMMC and hs200, not SD card.
> > sorry, I should have been more clear that there are two errors:
> > eMMC, this is what I have been seeing for a while on my Khadas VIM2
> > (it's probably not related to this patch):
> >    mmc1: mmc_select_hs200 failed, error -84
> >    mmc1: error -84 whilst initialising MMC card
> 
> Following patches were also supposed to help the vim2. 
> ... something I tested numerous time on this particular board.
> 
> > however, then there's this other error:
> >    print_req_error: I/O error, dev mmcblk0, sector 0 flags 0
> >    Buffer I/O error on dev mmcblk0, logical block 0, async page read
> > as result of this the partition table cannot be read and my kernel
> > cannot find the rootfs.
> 
> I don't know what the problem is (probably some CRC error - you can check the log
> in interrupt for this) but I'm pretty sure it is not related to this patch.
> 
> I see in the log SD is indeed in HS mode, so not in any DDR mode.
> I also see that the SDIO fails as well. There something really weird, which can't
> be explained by this patch alone AFAICT.

Ok, I think I got it. It is indeed not linked to DDR, but a more trivial mistake.
It looks like a writel went AWOL during the final rebase (and after the test campaign).

in meson_mmc_set_ios, after:
val |= FIELD_PREP(CFG_BUS_WIDTH_MASK, bus_width);

Could you try adding
writel(val, host->regs + SD_EMMC_CFG);

Without this, the bus width is not changed, which explains why eMMC, SD and SDIO fail
on init.

Let me know if this helps.

