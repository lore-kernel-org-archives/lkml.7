Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B459C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E370205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wj2bf/uK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfEGJgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:36:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54104 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEGJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:36:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id 198so1680720wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 02:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uE2M2CQ9LEuDMyLV2Q+GshWDt/l2YHXSXQ5t4J55xgY=;
        b=Wj2bf/uKutxHgePbEwCm/tSEl5nTHc/d1jQ01aLy4a1bgY3TnNnzSoKnDu1BVBSEQS
         NAPWhrSCEN7tbUau6BJ/7oDUqzYfRrv9QrKsL1feb32CiEw4eksR/TTIXvanaFNRv0Sl
         GYmqFXJIFm8zUoxIGc7cjMW93Xtu8aOT4eDYXyRB3428f54qbjrLRtrZIgoj7SRE33ya
         FEWSJiTYuiaZSIy+6rmyKPDSc0dxYsQAAHQ/LNWg1fksvkJVgiT/EbTzblQ6J89vajSI
         aN9/mA6t+zlX4seZxy0ABrQJY74OlFPKRP2Lh2QrXlxqB4838ynkZrk3piuByPLhtSBI
         DSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uE2M2CQ9LEuDMyLV2Q+GshWDt/l2YHXSXQ5t4J55xgY=;
        b=R35Jxr/2td6WVcQPhGE/0Vx1KwLNq0zujG1IeVu68w2sYCnSd62ESE95dTEEvfbGxn
         AOXOSQeguYXEYRxPo16x1q32w1xchiD+UsNgEg3Vik/tPWO70UYqKctQj2rJt9iHyZI5
         9b0e3Kf0k4OeCgVT8IKKo/MUwA8I37puU7hKDeXkRV8OHGuWAhBXiIsaaURM96D05J3V
         /mrkclDeviGzoO06sxbBDYXObppNuHw8KxeFHvaDv5lFAFVAC6IIN0cte7V1K0wRJyPo
         Se3m7FKNGP8YihgXq/swmy+FQop9cHZoToToaUyVGHfvdSKA1JbcV1ZDYygTCicSk5b+
         JNEg==
X-Gm-Message-State: APjAAAWkggOZQsSI8PvGV+1FKtdao4wTNOIrMlyX+wvn0SuG3xXqiD9H
        QeITIHlL5OCXpkmQqcMom8x/qg==
X-Google-Smtp-Source: APXvYqwFbqyq4uDmTmgmPoJOzCNR9jZ1AeLgobxyYN9+khWFcDyltl91Y8aRSvS65sWNXTBGqE6XFQ==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr19466090wmm.25.1557221794073;
        Tue, 07 May 2019 02:36:34 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id o16sm18967073wro.63.2019.05.07.02.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:36:33 -0700 (PDT)
Date:   Tue, 7 May 2019 10:36:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190507093631.GC4529@dell>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507093239.GB4529@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 May 2019, Lee Jones wrote:

> On Thu, 02 May 2019, Esben Haabendal wrote:
> 
> > Hi Lee
> > 
> > Could you help clarify whether or not this patch is trying to do
> > something odd/wrong?
> > 
> > I might be misunderstanding Andy (probably is), but the discussion
> > revolves around the changes I propose where I change the serial8250
> > driver to use platform_get_resource() in favour of
> > request_mem_region()/release_mem_region().
> 
> Since 'serial8250' is registered as a platform device, I don't see any
> reason why it shouldn't have the capability to obtain its memory
> regions from the platform_get_*() helpers.

Not sure which device you're trying to enable, but if it's booted
using Device Tree, you could always use 'of_serial'.

It does seem a little odd that the 'serial8250' IP block has been
incorporated into an MFD.  Which device is it you're trying to enable
exactly? 

> > In my understanding, use of platform_get_resource() is the right thing
> > to do in order to integrate properly with with MFD drivers that splits a
> > common memory resource in mfd_add_device() using the mem_base argument.
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
