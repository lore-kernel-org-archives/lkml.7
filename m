Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C71C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B9920675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557392845;
	bh=n76aeCS13uyHvnQiD2qg4NEZe6D0uDhNnWgJ+GPpZmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mC5HxciqukDkBrOuo+9IRlql+PIF8gF7zubbGZOIEpo+fWUnybSwh6AWd7lJ8zcKd
	 yJZu5wUWbhb6X+6stocm64rUSy0E59ZKhmR4uwmGbM1S+RcTKfuBzsafxNcpORQBvK
	 m1jeD0aXlhftqKhH1Q9UbMbl2r2AAYOQieDk/nHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:07:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:07:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so1935854wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KMhKEUpILjGWwct8oo2vu+Nrq2TCOfvu9LH0ziFQipc=;
        b=WsCQVaohUdFFO1EmgEq+Enf55in8dgEDjju5WMuA3vi4w5vCRwjb//WU7MqQSpLkaH
         kVLKr99StRET1wr9UvaeEZrU7xXxLjLr55ZejiLaJ6f2jhjKkOxa3GGM1ccMBl8fNRzC
         fEIw7Fq+M+rW1bBm+2V8bYm4U/Udl7pTXFeMQAvyjjWDuv+vOOnVd30j+hx58IFmWHQF
         MiyjNzeSVl3KMN1kE7aaSEMKtlIQeHtbDGxJTmDnpXSiKxOi0U8PdrrFsumqEbUZ+69O
         9UwHu/RlTTZxSYOc5oebLaG5T48RtqElaBDu4Z9V0RdZVW3HnXOiTi1sLpEU9tTiWJOi
         1ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KMhKEUpILjGWwct8oo2vu+Nrq2TCOfvu9LH0ziFQipc=;
        b=UZkgbSASV5BHmwT3UfvHx3HQRkESoFk1szQaqcSQa79dePVK70JVuo+lDlqCiS4SbX
         uC2MIZnKIzBWC62d6yxE052yPLVKOEkTWmDEs3Nv0VjoQ3qti+GazHKZ1OYfZ6ug3sjo
         a5QNl+CQoA7rdZv8Wu5JkP8kuSPa/mYmXuEsjP5l6WEP5UcWrpK0ygu0v9VYmjsktNHz
         YVghjMqCh/Y6peE5X+lW1QXDy0oDonkakxWVzB1m5Dr+Nyap5SBneHhVcUq/VqMzZ2bs
         4JMMAwAufmEH+BWZ0LaXSz4DWk/3r8qMsPrRTBqDU0har1UUBiFqsUdj0k6V3lewi9rJ
         PHBQ==
X-Gm-Message-State: APjAAAXoRT3b7PB7k0qk5qkYKfq6HV6JGLYTec/qfriFwyW4UdWospP9
        6G4vMS5hyXzl8EGAOP8RVdU=
X-Google-Smtp-Source: APXvYqxWH8vXjMhO44J5jQreTUjSOSTf9JXt+Um2R7yW1XSuJK752azKQ0fzxVXSlKiJjid6wX5Otw==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr2006783wrl.252.1557392842292;
        Thu, 09 May 2019 02:07:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s124sm1696918wmf.42.2019.05.09.02.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:07:21 -0700 (PDT)
Date:   Thu, 9 May 2019 11:07:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Daniel Drake <drake@endlessm.com>, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, rafael.j.wysocki@intel.com,
        linux@endlessm.com, peterz@infradead.org
Subject: Re: [PATCH v2 1/3] x86/tsc: use CPUID.0x16 to calculate missing
 crystal frequency
Message-ID: <20190509090718.GA11209@gmail.com>
References: <20190509055417.13152-1-drake@endlessm.com>
 <alpine.DEB.2.21.1905090924390.1855@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905090924390.1855@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 9 May 2019, Daniel Drake wrote:
> 
> > native_calibrate_tsc() had a data mapping Intel CPU families
> > and crystal clock speed, but hardcoded tables are not ideal, and this
> > approach was already problematic at least in the Skylake X case, as
> > seen in commit b51120309348 ("x86/tsc: Fix erroneous TSC rate on Skylake
> > Xeon").
> 
> ...
> 
> For the whole pile:
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks - applied it to tip:x86/apic, will push it out after a bit of 
testing.

Thanks,

	Ingo
