Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85374C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7012085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561583880;
	bh=WkouDlKcGfRDupE8pa064J/H/SIOtz6YGD3E2av0728=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=szwCEKtgpB0eek3tFI9MTxMf/yLZMAtTMHEgSPf0F1DUoz80PjINiHf0FkqrXDKRG
	 MXpLliFyqkx10qtXxdKCv3FB2wUoEnQNptSqFjNJXm61mYb80tHnnTTWTh9a7Hnglq
	 pijwpJPd6jHOO2Ou0/NIYY2ubmASh2RFN1NW5cno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFZVR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:17:59 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50348 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:17:58 -0400
Received: by mail-wm1-f42.google.com with SMTP id c66so3560505wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2lvyZqU21k4mPoXF2lyDip1wrvu0SHHkYd2jp05DEKw=;
        b=cn5IQNBmk1xnNgTf6RXdnb2JTVHmQyYoqqdIJySj2+0bAetmU3Vg+9+VTTOmmREjac
         4B+fsVuJe1eJZAD78mSyDWyHgIIvFaMjg06xcG99EuAbGdw7DEeC8MnbIXXpYxij/71V
         E+cqWMQ1YXcO6QXCUyssazvSURRCPf6gVgLXy6QvF+Vm2yDwcKX9UId/NJCgCg+hwmjO
         vak0ViV7mny92ofVDZiGfF9b4LnKJufV0kDukOmK7Cq69Txv1PNwNnmtj149rZ+91y7K
         vyaFSqMx3M6KF3hgTFfxSJYjMTqI/vC4H54NAchJnKd8GOVSWTVC4BFvvHFuXR/wYEsH
         oLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lvyZqU21k4mPoXF2lyDip1wrvu0SHHkYd2jp05DEKw=;
        b=liZMvNfTuqZAVcTjZ8kY/S86NvnEkqo0YEvZ+EmKg1aDRrIifU4+d6dkGHzcEzJ8yi
         rKdER5Zs4TnaHjrBZJkeBpukslHRmvoYKPh+h9ioZV1pZ5ZMAub+qO/jWDx60HQKmD6a
         P5CjNQAoPcyIO9TuIFY1grFNjGqn+cUd2x3993UL9374jUAFJgYNp5uwu0oLCamTWQ0N
         nrxFchTQ2dNBXvJSpXiXf53K0IHTFgFIRuDa9JsUPGMYHzcenlMUhgTEnNdvttzJBlHj
         h3A0UPbuT8lIxucFylvbbQrKqdv+e3hNf0vpVuy2TukbGym5ukkjHGHYStPazAn5j7QI
         tXuw==
X-Gm-Message-State: APjAAAUuHMkrglS7uENJwbNN4002xsbWjXxgfdjV1wdIBMDeUfui2Oeg
        WtjKL8N0IQEtjWc0WVKAkc8=
X-Google-Smtp-Source: APXvYqwuLmkSGe8intuzKj8MOdor50H5xmqjc7QeVDWSkqoRSmPKfRNs7h9WBtMuisc2BEFf+4WzjA==
X-Received: by 2002:a1c:18d:: with SMTP id 135mr575464wmb.171.1561583876086;
        Wed, 26 Jun 2019 14:17:56 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h90sm74300wrh.15.2019.06.26.14.17.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:17:55 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:17:53 +0200
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
Message-ID: <20190626211753.GB101255@gmail.com>
References: <20190623132340.463097504@linutronix.de>
 <20190623132436.461437795@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623132436.461437795@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> @@ -440,11 +419,11 @@ static struct hpet_channel hpet_channel0
>  		.name			= "hpet",
>  		.features		= CLOCK_EVT_FEAT_PERIODIC |
>  					  CLOCK_EVT_FEAT_ONESHOT,
> -		.set_state_periodic	= hpet_legacy_set_periodic,
> -		.set_state_oneshot	= hpet_legacy_set_oneshot,
> -		.set_state_shutdown	= hpet_legacy_shutdown,
> -		.tick_resume		= hpet_legacy_resume,
> -		.set_next_event		= hpet_legacy_next_event,
> +		.set_state_periodic	= hpet_clkevt_set_periodic,
> +		.set_state_oneshot	= hpet_clkevt_set_oneshot,
> +		.set_state_shutdown	= hpet_clkevt_shutdown,
> +		.tick_resume		= hpet_clkevt_legacy_resume,
> +		.set_next_event		= hpet_clkevt_set_next_event,
>  		.irq			= 0,
>  		.rating			= 50,

> -	evt->set_state_shutdown = hpet_msi_shutdown;
> -	evt->set_state_oneshot = hpet_msi_set_oneshot;
> -	evt->tick_resume = hpet_msi_resume;
> -	evt->set_next_event = hpet_msi_next_event;
> +	evt->set_state_shutdown = hpet_clkevt_shutdown;
> +	evt->set_state_oneshot = hpet_clkevt_set_oneshot;
> +	evt->set_next_event = hpet_clkevt_set_next_event;
> +	evt->tick_resume = hpet_clkevt_msi_resume;
>  	evt->cpumask = cpumask_of(hc->cpu);

My compulsive-obsessive half really wants this to look like:

> +	evt->set_state_shutdown	= hpet_clkevt_shutdown;
> +	evt->set_state_oneshot	= hpet_clkevt_set_oneshot;
> +	evt->set_next_event	= hpet_clkevt_set_next_event;
> +	evt->tick_resume	= hpet_clkevt_msi_resume;
>  	evt->cpumask		= cpumask_of(hc->cpu);

:-)

Also, maybe harmonize the callback names with the local function names, 
like hpet_clkevt_set_next_event() already does and 
hpet_clkevt_set_oneshot() almost does:

 s/hpet_clkevt_shutdown
  /hpet_clkevt_set_state_shutdown

 s/hpet_clkevt_set_oneshot
  /hpet_clkevt_set_state_oneshot

 s/hpet_clkevt_msi_resume
  /hpet_clkevt_tick_resume

... unless the name variations have some hidden purpose and meaning?

With that fixed:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
