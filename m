Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF128C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8186F2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="s0SiX2cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfGOUkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:40:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbfGOUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:40:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so8273116pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qls07JuEYZRupXWcchkfAXNBITylKMYF1QPYPpCTq8o=;
        b=s0SiX2cunFOcXKRcaUD5Xjo0P+rNZWK2wsXGH4gefFaqZgwDsDLZSENfjHjWyD4DhO
         RE8z0IRP11Que6OE4HY4lBikNF2U87AUhWA0biN+3Q/lZcfO9ui/d25KnqFHvm6ZvUIT
         vB53/o1KfDcHXxOnE0u3b7Ljs7KBLBWmIbsTMQVUNWsWOkJiLGUN/IavF3ArXa0nDv9i
         NDXg8zYdyJ1BOS1Ahc9t723PjLucuh6ZcxaJxsju8YeGr21vdyOBvHcLhcyzDQcC4Ka5
         qqOShJqUmmq/PJJQj9XBDXvkATOPQlmnr6AI3uRWElNBbiSb/OOc4j1JyZdiGXm+00P4
         trMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qls07JuEYZRupXWcchkfAXNBITylKMYF1QPYPpCTq8o=;
        b=hvAUqlF7PKp1M/jDoowasUGXK9wdftfhuHuAnoQS3wZjT4v7o2PaCFhPdpBUIU3eAA
         Y1WKX7sjQkNl+3vogJfFMlxpz2xVsThcTxDs0jJvi0D1P2NuAIcJJkoZKt3/HJkGVmue
         cGkeI7HR7UhBhCHL1lWGWNQXHMWiKMt979S7U3M8onEN2ml3mWfSRs5zi9nPux43swZH
         NkqCkrhWeNU6oYhFfdxGzNcsXxWHTgYbtE7TPZSdtudsvPTBozC9SFssiWfmw4VVrm+u
         SIw29AEH2KGgmiXRdSl18EQp3Ow5dWfRTGFcwus9dWxeILIZPguillvhSui46w+Q8OfN
         H9AQ==
X-Gm-Message-State: APjAAAVv4Ww5AwUpKppEPmI8KxJxIQd4e/8EvQg4Ere+kQfffSfB31fq
        BkXZbWP7QZTYA9K49xILTuk=
X-Google-Smtp-Source: APXvYqze0nqn6Hh3RbS/HEoaWUvUX+F3y0W1jaUgnSfh/67ir/48Pic4+xsZJHso8sdX2nKbfTjBgQ==
X-Received: by 2002:a17:90a:2627:: with SMTP id l36mr32141041pje.71.1563223240100;
        Mon, 15 Jul 2019 13:40:40 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id o12sm14692268pjr.22.2019.07.15.13.40.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:40:39 -0700 (PDT)
Date:   Mon, 15 Jul 2019 13:40:32 -0700
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
Message-ID: <20190715134032.5a70782f@hermes.lan>
In-Reply-To: <alpine.DEB.2.21.1907152055430.1767@nanos.tec.linutronix.de>
References: <aba1c363-92de-66d7-4aac-b555f398e70a@alvarezp.org>
        <2cf2f745-0e29-13a7-6364-0a981dae758c@alvarezp.org>
        <alpine.DEB.2.21.1906132229540.1791@nanos.tec.linutronix.de>
        <95539fd9-ffdb-b91c-935f-7fd54d048fdf@alvarezp.org>
        <alpine.DEB.2.21.1906221523340.5503@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1906231448540.32342@nanos.tec.linutronix.de>
        <098de4c3-5f71-f84d-8b49-d2f43e18ed91@alvarezp.org>
        <alpine.DEB.2.21.1906271632300.32342@nanos.tec.linutronix.de>
        <82fa0f47-ccb9-18fc-e35d-af02df37e3fb@alvarezp.org>
        <alpine.DEB.2.21.1907152055430.1767@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019 21:09:44 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Octavio,
> 
> On Mon, 15 Jul 2019, Octavio Alvarez wrote:
> > If I reboot with sky2.disable_msi=1, then I get IO-APIC and the bug does not
> > occur:
> > 
> >  19:          0          0          0          0   IO-APIC  19-fasteoi eth0
> > 
> > However, if I reboot without sky2.disable_msi=1 it properly starts as PCI-MSI
> > and then, after re-modprobing it it goes to IO-APIC, but the bug occurs
> > anyway:
> > 
> > $ cat /proc/interrupts | grep eth
> >  27:          0          1          0          0   PCI-MSI 3145728-edge
> > eth0
> > 
> > $ sudo modprobe -r sky2
> > [sudo] password for alvarezp:
> > 
> > $ sudo modprobe sky2 disable_msi=1
> > 
> > $ # hibernating and coming back hibernation
> > 
> > $ cat /proc/interrupts | grep eth
> >  19:          0          0          0          0   IO-APIC  19-fasteoi  eth0
> > 
> >   
> > > Also please check Linus suspicion about the module being reloaded after
> > > hibernation through some distro magic.  
> > 
> > This is not happening. Each time the driver is loaded the message "sky2:
> > driver version 1.30" is shown.
> > 
> > I confirm only 1 line for the sky2.disable_msi=1 from kernel boot and only 2
> > lines for re-modprobing.  
> 
> Odd. I still fail to make a connection to that commit you identified
> which merily restores the behaviour before the big changes.
> 
> As we cannot revert that commit by any means and as the hardware is known
> to have issues with MSI, the only option we have is to avoid MSI on that
> particular machine. I suspect that the fact that it is 'working' on some
> older kernel version does not necessarily mean that it works by design. It
> might as well be a works by chance thing.
> 
> Thanks for all the detective work you put into that and sorry that I can't
> come up with the magic cure for this.
> 
> Thanks,
> 
> 	tglx

In the past, I had one ASUS motherboard with broken MSI and updating the
BIOS did fix it.
