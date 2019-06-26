Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FE321726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561583615;
	bh=BspelnOI843ZHyggMGPxDf2rEXCtmCII7O/LPCS6Ivw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MMWVksuh9a0Z5X0a/pvwG0sUFjgivNlnX6GAAhG4+EkmQ2cbwo7p6YsaUSysun6gU
	 YLN6VgyhBkCtsAPark/qmnMcffyqm8m/LIUFOpS0t/HBsLPfsf3H1Pc+c00HiEYffI
	 pzItBc7Ox8udfZCdiwz+nqblR1tvTUYWXq9YNa+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFZVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:13:34 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36727 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfFZVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:13:33 -0400
Received: by mail-wm1-f52.google.com with SMTP id u8so3503984wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FgbGY1FAlgUp4w+m/9QdM/lGpUtmQ61o6YTTp9Mkjrc=;
        b=l2S7+RPjUCCw1zOAzVIR3oj8HC5bZK9bMIqmyTZnW+mvZjffYpi5pJXOkBvA3KoTPW
         xMuD4WFqa4ox0HR9zhEl7b3x3GxpfdQZv4N9xt9uNSJ0iiOeRDRXckTNgJ3e4ISNoydi
         KhNvW5jXW3ETeYW7XtymMKueHd6ZokJ4t4oQo3LfAi/zqK9jYQsyN6e+TiYomdKyBrhK
         Y0ZoldbguRdTJ/YlWQZyzie/RK3xkv6xm9L8p+kJVFASc4SziH92PDZkSiFkgg0zZPom
         5draIbW9ZoYA0Qp0NsBvRCPoF9IeUE7hZqeoZ8F1Y95peJiCKJ0EvPchWz4OgM+gDawU
         HLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgbGY1FAlgUp4w+m/9QdM/lGpUtmQ61o6YTTp9Mkjrc=;
        b=LyXnYDYrxU9Cxc8hOo+lBK3/3neDo56x3NWO9Da4R8GnL/2QeNfXeB4eaCE+HVbfWT
         CMSmAr8JP2dLLukzcA7pxd3pXTjLP82TUDKvNE1ivdz1Hf83lEThqF6AiDkS1wv5vwrv
         QjfTBmjyZ9lhcLr3gmbq6ioSifb0JY9SFkJipwpCWPwSmRWC0ngwN5ZghPG71ib/ESVM
         LH5l9cCoNdydmnfcygfCru7Ou4O3ZVwQCMk8qK5XuC7IY9k02GnOfIYay47c9uTfvAz3
         idjGqvrdws+I1fq8lURtW2mr+Y2G8f9BcGFG9H0+KGcqI/q98g1yqOIWRo1YOUVavCyb
         Gvcg==
X-Gm-Message-State: APjAAAW7LrcJVF+TbV9Sm/iJMaQwvHkKcVUA08tfN2xBGfMFfwZJzfVx
        5xl9rDmD1JEPPFMTdwaZ0eA=
X-Google-Smtp-Source: APXvYqzp736pJdplm1J5wmpbzh4FYXrN/uYuy2xPXOtX+C/mXzPVQVW+Bi8s+daVop6hECRPXEBRwQ==
X-Received: by 2002:a05:600c:114f:: with SMTP id z15mr555226wmz.131.1561583612097;
        Wed, 26 Jun 2019 14:13:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k125sm3711544wmf.41.2019.06.26.14.13.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:13:31 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:13:29 +0200
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
Subject: Re: [patch 28/29] x86/hpet: Use common init for legacy clockevent
Message-ID: <20190626211329.GA101255@gmail.com>
References: <20190623132340.463097504@linutronix.de>
 <20190623132436.646565913@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623132436.646565913@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
> +{
> +	/*
> +	 * Start HPET with the boot CPU's cpumask and make it global after
> +	 * the IO_APIC has been initialized.
> +	 */
> +	hc->cpu = boot_cpu_data.cpu_index;
> +	strncpy(hc->name, "hpet", sizeof(hc->name));
> +	hpet_init_clockevent(hc, 50);
> +
> +	hc->evt.tick_resume	= hpet_clkevt_legacy_resume;
> +
> +	/*
> +	 * Legacy horrors and sins from the past. HPET used periodic mode
> +	 * unconditionally for ever on the legacy channel 0. Removing the

s/for ever
 /forever

With that typo fixed:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
