Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80807C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E5620652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="A3LbihFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfFXPg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:36:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40325 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:36:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7115861pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upsId6Vhif+67AuSTB0k4laTu+PhcFeGh6g0cqmGnTY=;
        b=A3LbihFiTe9ZG3DU1IAcQmfPF7GqeiQGPZCCXikYXnQq2a/E7wkelz5+Ozr5k2wfO8
         kk7xhaGXLO9Fg9BgudhryLQnqb70N4e8cSrcrkvDkJCare25vJA6yyv51RgyAl1eu41C
         hcBcyWF767a1VIOT28pDx0SQ4euR09KTjw2Azq6CONRdqHcT42iGx2FNKvIbrkAmz2pV
         V3DV1rVI+dKvpOvdcVJfrZObTIO+HI6DCK25gLGYh4l6/3tTwG3E0sNp0BKNs2WNMhBB
         U2fp5hUmDxS04b1sfkx2HD9iFgKDn4cEyIUu87/VpcTUvych47ytJG6Aae/kcccNUPw3
         QFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upsId6Vhif+67AuSTB0k4laTu+PhcFeGh6g0cqmGnTY=;
        b=jHGA4hDcs/pzcgvgy4wKHI/7ki8+QXzpjYA9/h3W7Hv3fV3X78wYa38EYC6kzOV9B1
         TcmBJBu7mid7vxdpjBIvZzhfwkCdIjFg9+CaBNP8BNu/ihtiyUmhnJKGvirq0uZd74vN
         xKcut5up5huVMhdsIDEEOry+3GA/3Ns8vVEFtxyKghYjJLnvjhoYU3jJWBmMwbOgJUjB
         clYjXCvR9xfLH5fwF1guJdZuE6CJhbsNEikAVn6rXGMD1JGJGWnGsuHtizgfsWbWU4mm
         FiANgef4bjwAxD3zkLrEj2Em1cFJC4bMuDjKg/ml9WuFFdKGCTdHWeIqclj9WkrOcwzj
         kbOw==
X-Gm-Message-State: APjAAAUoHORQOoBpgCZ942aEN/RUo88B9xMJ4M3fk0wXKHd8OGAvh5fJ
        pDfd6QI07xz5EUah9TiTSFu+YQ==
X-Google-Smtp-Source: APXvYqzlVdtYCEtp+WwmRDQsKjoJOLdH7qTXsLIxNx9SjFlPbqhHNTujte9mWbck0bwYR3rk+NToPQ==
X-Received: by 2002:a17:902:9b94:: with SMTP id y20mr133470830plp.260.1561390585039;
        Mon, 24 Jun 2019 08:36:25 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id y193sm11282875pgd.41.2019.06.24.08.36.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 08:36:24 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:36:18 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Octavio Alvarez <octallk1@alvarezp.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiang Biao <jiang.biao2@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Nicolai Stange <nstange@suse.de>,
        Mirko Lindner <mlindner@marvell.com>
Subject: Re: PROBLEM: Marvell 88E8040 (sky2) fails after hibernation
Message-ID: <20190624083618.28cfd30a@hermes.lan>
In-Reply-To: <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
        <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
        <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
        <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
        <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jun 2019 14:54:13 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Octavio,
> 
> On Sat, 22 Jun 2019, Thomas Gleixner wrote:
> > On Wed, 19 Jun 2019, Octavio Alvarez wrote:  
> > > On 6/13/19 3:45 PM, Thomas Gleixner wrote:  
> > > > Can you please provide the content of /proc/interrupts with the driver
> > > > loaded and working after boot (don't hibernate) for the following kernels:
> > > >   
> > > 
> > > $ cat linux-master-after-boot.txt
> > >            CPU0       CPU1       CPU2       CPU3  
> >   
> > >  27:          1          0          0          0   PCI-MSI 3145728-edge eth0  
> >   
> > > >    Linus upstream + revert  
> > > 
> > > $ cat linux-master-reverted-after-boot.txt
> > >            CPU0       CPU1       CPU2       CPU3  
> >   
> > >  27:          1          0          0          0   PCI-MSI 3145728-edge eth0  
> >    
> > > Meanwhile, here it is for 4.9, which is the latest Debian-provided kernel and
> > > worked:
> > > 
> > > $ cat linux-4.9-after-boot.txt
> > >            CPU0       CPU1       CPU2       CPU3  
> >   
> > >  24:          1          0          0          0   PCI-MSI 3145728-edge eth0  
> >    
> > > I will keep trying 4.14, unless you say otherwise.  
> > 
> > It would be interesting though I don't expect too much data.
> > 
> > So all of the above use PCI/MSI. That's at least a data point. I need to
> > stare into that driver again to figure out why this might make a
> > difference, but right now I'm lost.  
> 
> One other data point you could provide please:
> 
>  Load the driver on Linus master with the following module parameter:
> 
>    disable_msi=1
> 
> That switches to INTx usage. Does the machine resume proper with that?
> 
> Thanks,
> 
> 	tglx


Suspend/resume and hibernation issues are often related to BIOS issues.
