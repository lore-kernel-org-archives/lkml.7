Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289CCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1822087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi6vvKlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfJ2OAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:00:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40988 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2OAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:00:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id l3so9641480pgr.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3RWz9l3/B7SltQRtqxThazj72fG6HLPCrRBSHamwG2Y=;
        b=gi6vvKlZNFvT2TfBgGbjsE0fNq7TOPfVljNx5UiQBpHr53URR+V1J4LJgv3Zh00tUR
         2VJgWOGXtIhFvYiDZB0bCUTNEMfbclaL7v/Ca/Rl7FOH34LPgAU7BBL6fuxAnGAEwavE
         n7O1KSsQufR0DXWwEpfFZMF/yq4pIWE5iwz5gFtm8EdiCRQmRXIN+eyl24ufo4o8VPqW
         ZZEl2C2Sr3fOXS4AChtJ7SwEI+J6RK8qizGITJ9dPNlzX3fMOSrKIBIz5PUUlFkrp3Wz
         NEjjVVfEe+EfNvi0utyx+i6B4rTFVAJ+eEFT0VPASxlZTciv62Exr7hAViUAvAjoQvr4
         eulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RWz9l3/B7SltQRtqxThazj72fG6HLPCrRBSHamwG2Y=;
        b=EIq9Knrx6uigjN6W8UTpRwiyouzWM1YRI+QaiV9MH36yifm14K4uP4zfHIyYSMKUX/
         OQU3r3KXpIOrRYqRXWgdWGh230h2RR3PCtd+GuBIO54ScRqVeC8WTgyEW07M79Q5Hglt
         joJx4vCkCR6/fsHyE2/KghK2OuH/VuCosMcXr47RDsvNhRbisK+KdhoUEkTSdrQu76MD
         xZu+zevS99f5Ikr5a22fibNqU0C680NJUmuezEy1k13p0TsPvUYUgNxdlIBk95wKGldR
         eRxhuOP3YMH71vApS53MOm/WWWJzp6SiiJgaaDANNi+MyA+TkGidA7UUl0/JggkeADfJ
         EdKw==
X-Gm-Message-State: APjAAAVZ5+UkqJLUchOi4Nnd9SHi/LnLVtfZlYb0VjALoow2h+3TX5WT
        IVT+HFLt5tgO0e9M6pw+h+4=
X-Google-Smtp-Source: APXvYqzMgIYYjOPJnIWQ0ODCJG9vYNsNP7C4LA+We6RWcFKY4ibzXz4QdblaFYdr8tYTJSlg5hrLIw==
X-Received: by 2002:a65:4247:: with SMTP id d7mr27474764pgq.107.1572357611059;
        Tue, 29 Oct 2019 07:00:11 -0700 (PDT)
Received: from saurav ([117.232.226.35])
        by smtp.gmail.com with ESMTPSA id y129sm15557518pgb.28.2019.10.29.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:00:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 19:30:02 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] mtd: devices: phram.c: Fix use true/false for bool type
Message-ID: <20191029140002.GB4943@saurav>
References: <20191029032142.GA6758@saurav>
 <20191029091433.GG25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029091433.GG25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 09:14:33AM +0000, Russell King - ARM Linux admin wrote:
> On Tue, Oct 29, 2019 at 08:51:42AM +0530, Saurav Girepunje wrote:
> > Return type for security_extensions_enabled() is bool
> > so use true/false.
> 
> This doesn't seem to bear any resemblence to the subject line.
> 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> >  arch/arm/mm/nommu.c         |  2 +-
> >  drivers/mtd/devices/phram.c | 11 +++++------
> >  2 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> > index 24ecf8d30a1e..1fed74f93c66 100644
> > --- a/arch/arm/mm/nommu.c
> > +++ b/arch/arm/mm/nommu.c
> > @@ -56,7 +56,7 @@ static inline bool security_extensions_enabled(void)
> >  	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
> >  		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
> >  			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
> > -	return 0;
> > +	return true;
> 
> This isn't explained in the commit.  You explain why it should return
> true or false, but you don't explain why converting this from returning
> 0, aka false, to returning true is necessary.
> 
> >  }
> >  
> >  unsigned long setup_vectors_base(void)
> > diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> > index 86ae13b756b5..931e5c2481b5 100644
> > --- a/drivers/mtd/devices/phram.c
> > +++ b/drivers/mtd/devices/phram.c
> > @@ -239,27 +239,26 @@ static int phram_setup(const char *val)
> >  
> >  	ret = parse_name(&name, token[0]);
> >  	if (ret)
> > -		goto exit;
> > +		return ret;
> >  
> >  	ret = parse_num64(&start, token[1]);
> >  	if (ret) {
> > +		kfree(name);
> >  		parse_err("illegal start address\n");
> > -		goto parse_err;
> >  	}
> >  
> >  	ret = parse_num64(&len, token[2]);
> >  	if (ret) {
> > +		kfree(name);
> >  		parse_err("illegal device length\n");
> > -		goto parse_err;
> >  	}
> >  
> >  	ret = register_device(name, start, len);
> >  	if (!ret)
> >  		pr_info("%s device: %#llx at %#llx\n", name, len, start);
> > +	else
> > +		kfree(name);
> >  
> > -parse_err:
> > -	kfree(name);
> > -exit:
> >  	return ret;
> >  }
> 
> At least this partially matches the subject line but it looks unrelated
> to the other changes.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
Please igonre this patch. Suppose to send for only one file nommu.c. I have seperated and submitted the patch for chnages in file phram.c and nommu.c. Thanks for review ... :-)
