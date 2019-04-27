Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994332067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 07:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDpT+/eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfD0HKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 03:10:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41451 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfD0HKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 03:10:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so4904639lja.8;
        Sat, 27 Apr 2019 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xH2aI9BE/QEgqNVf5dMHr365pT3oBivb8EsWMphbEFM=;
        b=aDpT+/eA2dL2ucnPlNde6w+NnIHaBXz+kO4eXI/IRUQ7rxMCW0dqVsRFR0tMEDoKPe
         r7gm6LxaXWNqSShKewbMSQJQplcYy0/7M7ao6Nqv+PzRUDbD2aRH1vvoHoBPBn9SzwYo
         Ct1lTRZZ3je5vlkI4G+hJXTYftka9tzQvWdTVp5gb5TBslBMm+BxQIT3Vi01mEE7XqWD
         tCHyblOvkCK6rtGPb9dxecYF8qZYlsU1ZaMAAu8wNfvtDVdfqB8KMpaaNkAu2akzr/Ov
         cuENizyoA7zybGcitQh6oHcYjihdF/s2MRVG0AsQo+pCsyaiUq0/FlF9ICbfBgK7SFxT
         a53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xH2aI9BE/QEgqNVf5dMHr365pT3oBivb8EsWMphbEFM=;
        b=lK6WqJW7J/csW+wG3ZhRYL+8azX/MTtZ7p9ogdJ7R38q4vAYSaFtPhZh7K4+3PSKts
         +qfHIAxKRPyVQSiKdPNXEujCLqhDTitJXahN2iLye7z8GLJVRuevLstHbLNzK3d0VNoN
         If0Jw5SxfSc//uDbk0yxIXcGykRKb+WGUf2S6tuIwgaf6+72e4iIdiJORmI1KJCgp5Eo
         8mh5OHmalPNFsqWuX8/DNB1n/zkSI1dK2UaXfeQMCF0TGlgXnDCEatKVz/GJCxeF/KsV
         PtXccG0ixFT1V/Jtdn6I25+aO+UQ9D50s9XarHJBUU4MWa5amg4Mg6MsM4uMdrQXoECP
         qqew==
X-Gm-Message-State: APjAAAUB9OBKxmeSPoICn9BNxNcjnMC4/TLB6SXuQzu5HIpoK1LbhLzb
        cBPXOLxOSR9Q2mMqdw1yjMbNDozQ
X-Google-Smtp-Source: APXvYqxaCWpmRTl6gD1Ly8urnUBkTEQ81NASA7yKW8UrCVCO/tfwrS04CnKT4Li42I5W6QezBWLrlA==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr17043639lji.130.1556349029843;
        Sat, 27 Apr 2019 00:10:29 -0700 (PDT)
Received: from mobilestation ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id 1sm5674917ljw.56.2019.04.27.00.10.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Apr 2019 00:10:29 -0700 (PDT)
Date:   Sat, 27 Apr 2019 10:10:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Richard Leitner <richard.leitner@skidata.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: Lock i2c-bus segment the hub resides
Message-ID: <20190427071025.hdrm3e5abnl4yock@mobilestation>
References: <20190424144914.10580-1-fancer.lancer@gmail.com>
 <20190426104650.30240-1-fancer.lancer@gmail.com>
 <20190427070042.GD28250@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427070042.GD28250@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 09:00:42AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 26, 2019 at 01:46:50PM +0300, Serge Semin wrote:
> > SMBus slave configuration is activated by CFG_SEL[1:0]=0x1 pins
> > state. This is the mode the hub is supposed to be to let this driver
> > work correctly. But a race condition might happen right after reset
> > is cleared due to CFG_SEL[0] pin being multiplexed with SMBus SCL
> > function. In case if the reset pin is handled by a i2c GPIO expander,
> > which is also placed at the same i2c-bus segment as the usb251x
> > SMB-interface connected to, then the hub reset clearance might
> > cause the CFG_SEL[0] being latched in unpredictable state. So
> > sometimes the hub configuration mode might be 0x1 (as expected),
> > but sometimes being 0x0, which doesn't imply to have the hub SMBus-slave
> > interface activated and consequently causes this driver failure.
> > 
> > In order to fix the problem we must make sure the GPIO-reset chip doesn't
> > reside the same i2c-bus segment as the SMBus-interface of the hub. If
> > it doesn't, we can safely block the segment for the time the reset is
> > cleared to prevent anyone generating a traffic at the i2c-bus SCL lane
> > connected to the CFG_SEL[0] pin. But if it does, nothing we can do, so
> > just return an error. If we locked the i2c-bus segment and tried to
> > communicate with the GPIO-expander, it would cause a deadlock. If we didn't
> > lock the i2c-bus segment, it would randomly cause the CFG_SEL[0] bit flip.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I signed off on this?  Where?  When?
> 
> never add a s-o-b line that you did not create, that implies a legal
> agreement.
> 

Ah, shit. Sorry. I should have added Acked-by. That's what I was going to do,
since you already added the first version of this into linux-next tree. But
apparently copy-pasted and left as is...

-Sergey

> greg k-h
