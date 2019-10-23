Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017BCC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD08A21928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 13:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxHFS4h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405793AbfJWNoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 09:44:17 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46709 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392056AbfJWNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:44:17 -0400
Received: by mail-lj1-f180.google.com with SMTP id d1so21135043ljl.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVWT8LOX7hiMjzmwaVkkcwJWIfsHuA36zoSZSTB0yuM=;
        b=NxHFS4h2zxcr3PyzhLh0Qk9xOCqJL026hwR5FNmCyixHEVD0e4yCc909qhJLWtZeUZ
         H1qF87BDiynS9cV8CLEYWhoizZdJ3Tmnpc5iBaED04sqTeqtnbuuLJl/xAJmILJqMWaW
         syhtRcFRp1DlALraodSUrtNeJZjhhMc93jsvZ7ZWdMyajqhVxWJ88/8tmTjFAzHap9As
         6GpHUUomwMjlnj8BcpEDjTuNFo4ifhGv4pBzOsexIWTFDInb1sJ6mWsimYwHtLvlh60S
         H0epGqYjqPxvO+jgcm94cGSjkzx9yE68irp9JNkAZbhL31WmM7c9gK1KVlQUnonTC0F0
         pc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVWT8LOX7hiMjzmwaVkkcwJWIfsHuA36zoSZSTB0yuM=;
        b=Hn8ahiyUcNDwc9IRhUHFpelC/j3FQcviccbSrrRtZbjQ4wParU+FlHQcgZNMVVzXuV
         bKGPNVhejx8L89vhFe7X/UyVaG6agcKpGVMx93L/hqoRBQd0lXnwvnkVUXyTFQePl40v
         AbU4QfspsINwgaxW0J5xqdrH5skkT311U5sZyl7I4ZrXTTc/cO6+R1tYKkiW1khenxdn
         SNETffSFzijKXxM4TILfl1nlTomGbLVzNuF3Z0xl+smo+4ojvwA3wv6bNSxKKWZc9oP3
         22v7xUSjJt91EipdGr5G+sQi7kKT381xobTpKqcIEYuo2525fCrif2xDuEr2vfR2z3ld
         oeSA==
X-Gm-Message-State: APjAAAVJDTTdRvjAmh5p+r98puu/jMzt2u6A5yAjdnZPbrOiQrkSKkWf
        pXkfJXRIoLBh23JJ0HzeYQd7hJi1
X-Google-Smtp-Source: APXvYqxJ14Zwj0CcAv5ywhBjFN4Mtan5pZ6k/oKrgQiJlZi0Sv2tbD/Q4jWuGGXpxXVVkCuT5qlJqQ==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr14588261ljq.100.1571838255226;
        Wed, 23 Oct 2019 06:44:15 -0700 (PDT)
Received: from uranus.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id n11sm13123511lfd.88.2019.10.23.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 06:44:13 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4C2A34610AC; Wed, 23 Oct 2019 16:44:13 +0300 (MSK)
Date:   Wed, 23 Oct 2019 16:44:13 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [BUG -tip] kmemleak and stacktrace cause page faul
Message-ID: <20191023134413.GI12121@uranus.lan>
References: <20191019114421.GK9698@uranus.lan>
 <20191022142325.GD12121@uranus.lan>
 <20191022145619.GE12121@uranus.lan>
 <alpine.DEB.2.21.1910231457400.2308@nanos.tec.linutronix.de>
 <20191023133204.GH12121@uranus.lan>
 <alpine.DEB.2.21.1910231536220.2308@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910231536220.2308@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 03:38:40PM +0200, Thomas Gleixner wrote:
> > > 
> > > [0,2,4,5,6,8,10,12] are guard pages so 0 is not that crappy at all
> > 
> > Wait, Thomas, I might be wrong, but per-cpu is initialized to the pointer,
> > the memory for this estack_pages has not yet been allocated, no?
> 
> static const
> struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
>         EPAGERANGE(DF),
> 	EPAGERANGE(NMI),
> 	EPAGERANGE(DB1),
> 	EPAGERANGE(DB),
>         EPAGERANGE(MCE),
> };
> 
> It's statically allocated. So it's available from the very beginning.

Indeed, thanks! I happened to overlooked this moment.
...
> And as I explained to you properly decoded the values _ARE_ correct and
> make sense.

Yes, just posted the diff itself to be sure. Thanks a huge for
explanation, Thomas!
