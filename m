Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFBCC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4D21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kNIQt2GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfDENVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:21:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:21:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so7197956wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kSx9mh5b7b6ARzAObtfWNQU4v3sEVl6a3sIbayKaOpQ=;
        b=kNIQt2GAnpL6SInmmxO6ujW7Ahcd69ywtmVV4PJ7eWJ1trfVx0Gf/YOUqe2z8c1iWx
         +/Djx293TN7PXO2KMBWkEl3QkOQNUa2ieeOV7H9F04QOXHZIc3fy5FqeGmcuJTCOcioF
         O2yHvVWpxIsms545A80iQXQ9ntakOiQLySA7/+HEwRiopddqqV203ivMIXIG5Xioo/pS
         8oDlYlB6ZDW4OlQPvOL2qcVGCK+BH0TC/j7PzRKpOgi55hfExamWUh3SsY5z+Ao9PpAC
         YC6nCKM3YJ98v+J44VqZsnybAnVTpxH3qdkjd2UfyMMUHKVkJOYJVgqUjNfY2192Vc1U
         0zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kSx9mh5b7b6ARzAObtfWNQU4v3sEVl6a3sIbayKaOpQ=;
        b=AKodQOf8zn3JSKE7f5iLTTvPCewf1iYR24NKFlfWk8PfNeEQviOUljacuHPgqZupw3
         aP18IBeF9BHizS+SUicTAM9sceCvE4gxmZ4+sceMZKBr4ewoek61njeXRnlOseSY1krJ
         VG2wiiDkoOtGllUg18L4V7y2rMSa2nn9N52zlhmrilIegni7XEuaNPT3X14q40tOLxxo
         gkGaaXzjcp825skRVWI8byR+Jrs450cv8qNWK80gUtGc6BBRLiwg/KITNNaoNQZYXbta
         QJa2ILDZWx+iyhmvsOO+2tW0eI8YIfd+LFVmqZ24y+dT8QQ3zyZRviYyPmw8MbEDHHn7
         OIEA==
X-Gm-Message-State: APjAAAXNhWcCdIrax6lXGT6UaaddyCxSc2LlwSNl16VEDdQTe1OaBBWz
        32JTFp0PbD2v6Iyjpf3AHr7oDA==
X-Google-Smtp-Source: APXvYqyyBhoJpfwNMz7AjUR0CO335m1tsYKHADDjtuXxv1u+XNUdWoOJb9V5FhBEHx4ZXxTMuvuYgg==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr8365626wme.72.1554470498603;
        Fri, 05 Apr 2019 06:21:38 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id v16sm41444018wro.48.2019.04.05.06.21.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 06:21:37 -0700 (PDT)
Message-ID: <c1393b7d289c83197f8ff83e9d58fa5e5ac9487f.camel@baylibre.com>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 05 Apr 2019 15:21:35 +0200
In-Reply-To: <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com>
         <20190325111200.15940-2-jbrunet@baylibre.com>
         <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
         <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
         <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com>
         <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 23:58 +0100, Jerome Brunet wrote:
> On Fri, 2019-03-29 at 15:14 -0700, Stephen Boyd wrote:
> > > > We actively discourage using init callbacks. Can you do this some other
> > > > way?
> > > 
> > > Yes I'm aware of that but init it the right place to do this.
> > > To be clear, this is not initializing the clock to some particular rate, the
> > > rate is preserved.
> > > 
> > > It just applies the necessary settings that needs to be done only once to make
> > > sure the clock is in working order and that the rate calculated is actually
> > > accurate. 
> > 
> > Ok, but can you do that in your driver's probe routine instead of
> > attaching to the init callback? We want to get rid of "init" at some
> > point so throwing the init sequence stuff into the driver probe around
> > registration is a solution. Or we should think about not discouraging
> > the init callback
> 
> Is is callback really a problem after all ?
> I think we should actively prevent using it to set a particular rate.
> 
> Here, the goal is put the clock in working order. The bootloader does not
> always do that for us. I could put this in controller driver, but I would have
> to repeat the init pattern for each instance of the clock...not nice 
> Using the callback clearly shows the relationship between the init and the
> clock. I think it is a lot better.
> 
> In the same series, I have added some init for the controller. In this case
> the init target a group of clocks, so having the init in the controller makes
> sense for that
> 
> 

Hi Stephen, Is it ok if we go ahead with this ?

BTW, it is not the only Amlogic clock using the .init callback (the pll and
sclk use it as well). It is not an excuse and I agree, there is always another
way to do things.

Still having an init() callback is really convenient for several cases.
Reworking those 3 drivers to do without it would not help maintainability.


