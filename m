Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4806C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A162133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561710754;
	bh=Y3zOX4QjS97/6U883kdWo4iIWGlNUzZF0xiiCLQxMvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w4feDv+c4wm5l1JOFcIKldw3XzO0WchFxEjV6AzbQyxFjt5T6gM/zUzU+0qdu/SgI
	 bkwVL9sa0AMh/Ms1rkEC4VugkNCpqTEi1Qaa2+bfYC8wY56t21zVmgFENduTNcfBCa
	 ZIf3mr1xn++8A7SGMJPw2SxJtcqVlY1hjEexHEH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfF1Icd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:32:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1Icc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:32:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id w9so8805377wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/IUTxeJg0cdHhhwgdpdWiUMuEMp0fQUvu2hchnWouE=;
        b=NdGxWIREBuow7vpX+Y+GBM7Ohi9wEyyqM6xOtQxyGQcX1evIm/WGud0OcJpeV6M895
         H4lquNMF0qz0IPo4lx2M2oOiQEZwedOdN+ZuJqpXBpPrEzFwoFekNV8lMa+5OekcGDKH
         833YcW584z5wXHWdohTCjp7aCMh8R3G7gfVmqFXC00tdi333SZsrcryW5gGR2tAoS88u
         PP8OvCtqoKWVE42gokzAi0ycLAou6G+Z6B3FvSs7UoxvGP9K/GiIxMxDKF5YE5bVvrXt
         lZ1GjiTUSyQhHy1peW0urQwLDn8AyWfUxSo+QE7K7Dou7WkJCOg8tB6oHo/Dw9lsqFSG
         TqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/IUTxeJg0cdHhhwgdpdWiUMuEMp0fQUvu2hchnWouE=;
        b=ZUTeWxp0FuWcs8M6z646GTVrshMjLeP/GRUCGvUV3ELP0Xa+cGxlnnMlnscZ5YFRg9
         UP1BzIzA7CGlwH41RtT5/8He3tF9WrAWYMrc9fqiHQK5glSPcIjG/d4cskHlBx5wGE5p
         eomOi17Xn17C6/eqoF8Qnwy1P3xpoJp8h6PgXWQtecO7pvqamS2iGUR1qxJUWp6NSNPS
         fkpyc11L01Mhf98TptMuKj1AiKsc/nPBoBXaDDhBSS2MwmFcHlV6M51t/XxpLF31eeM3
         MqhF9fSav4TctLLslYcRulCRfay5Kc1Ec7KYozPOGddOcRafdhlffXzqq2K7DXrwijlF
         Y0oQ==
X-Gm-Message-State: APjAAAUvrjZl2iJhUvv8cjAmEHIPbr7hHTh6sbWYqq/EWhef0+We+i8A
        kpAFmRur4bq5ymDeOz/0FAo=
X-Google-Smtp-Source: APXvYqx0Gq5qOjlDqngCtjivEZswbsjU694MSn6oT/2J1awzq7aH2XJGJxuKVht/6HXWiDJlYz1iYw==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr6265165wmf.139.1561710750759;
        Fri, 28 Jun 2019 01:32:30 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l1sm1201490wmg.13.2019.06.28.01.32.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 01:32:30 -0700 (PDT)
Date:   Fri, 28 Jun 2019 10:32:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [patch 26/29] x86/hpet: Consolidate clockevent functions
Message-ID: <20190628083227.GA21661@gmail.com>
References: <20190623132340.463097504@linutronix.de>
 <20190623132436.461437795@linutronix.de>
 <20190626211753.GB101255@gmail.com>
 <alpine.DEB.2.21.1906280041160.32342@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906280052380.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906280052380.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 28 Jun 2019, Thomas Gleixner wrote:
> > On Wed, 26 Jun 2019, Ingo Molnar wrote:
> > > 
> > >  s/hpet_clkevt_msi_resume
> > >   /hpet_clkevt_tick_resume
> > > 
> > > ... unless the name variations have some hidden purpose and meaning?
> > 
> > Historical but we want to preserve some of the old stuff for sentimental
> > reasons.
> 
> The msi_resume naming actually has a real reason as there is also the
> legacy_resume one.

Makes sense!

Thanks,

	Ingo
