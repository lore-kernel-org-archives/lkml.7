Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BAECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018F921928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568181902;
	bh=kKZ9cfPjjcOPIBIJWWKWgXz5lcJqbBU/LEQ//7u5Yzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VgVyoN1kJmrYPAbV8Wygokj4Vvx3J/KnjM4MzmW+8S3Qud+BrkwmCmhXrVuqxY80Y
	 97TuKoe0xpVl/hjycwYOSHTHRYbVnzMbFyrsUN7Xh3kFIYWoLd80II5sWXfIlIHnFP
	 NfQGN8q9tqNHDjR4RFLFTNF5UUmGB3840HoJi4BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfIKGFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:05:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40135 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:05:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id l3so299897wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CqniKMaVGI8AdgOTf9TB0jRG+sfUuB2v9Q5EnHE/5Pc=;
        b=PzP9bVgP7laGiHwJ70Wf2xjdsK931Rh5s62TbIUlk8R+Ddot5ZhEcthgCX4J65Q4Fl
         hS6y+T5XOQxVnk1XL9JNG+fc5QsNrUxGiAPhv6+zYRH8pXOgJd/jEVo2dXwOPYRo7YCZ
         wGFnV9SWhmBD7T9uq5vMjk7KdovDkWsnL1yv3bszsslsmh3JpXgeUijLsVR+Dy18Gl1s
         +sXdUM2UBwitKyvkV0s+iR2Dem/sjuQitXte9S2nsYIfIjB5QkHZa4wkYGnZqcVGwQAv
         1IbV+XAsuWVIjky65DKk/flRNCZ3I+QZ8e1wGAqKrn1jblxrOgYoxhk/ipNh8zrphQGI
         4+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqniKMaVGI8AdgOTf9TB0jRG+sfUuB2v9Q5EnHE/5Pc=;
        b=NnfxBd/n0UPpnwAxCoDYUjDaKhZXMNsrora6Htivvnp0WdNngJ49kVSm9s25WstlQ5
         AhR79Z5iKkUDmWU73uKXhSBjww0OfUQGvyERyhBscf7j1KC9lOwIwmg4MMdHAb4t8xw4
         gdrMUVZODA9c6ffm/qplmZzsSAavMQVvy9LVnY6QmelhIC3zfuqUinTJeuhb8+baJP3K
         fi+dfpj76xYemRvaaaxJ9f05wuzfq708+3WQWgebzbfxGgWxalniyjyUVQj5NoV2REDM
         kRPn7FxQv1El/l6S3VVPMtWLrAiPBTFG52JXZlnZtN2g8vfZEJoFWYWaeR8N4+Mq8NNJ
         WJ4w==
X-Gm-Message-State: APjAAAWXzo4rgCbIEExlI4AhDymD/Grk339ksJ1vb+/7cZ6E0jAE612m
        hp8SEPMr89BJbjhAwg3LR3Q=
X-Google-Smtp-Source: APXvYqwUS8I20u070up33N5STyF2/7lDZPeJqf5rTXVEznsdFjTgOH9eztBA57oNiM1A4y1ImA7wGQ==
X-Received: by 2002:a5d:4dd0:: with SMTP id f16mr27304628wru.85.1568181898927;
        Tue, 10 Sep 2019 23:04:58 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q19sm27696319wra.89.2019.09.10.23.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 23:04:58 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:04:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 5/8] x86/platform/uv: Add UV Hubbed/Hubless Proc FS
 Files
Message-ID: <20190911060456.GC104115@gmail.com>
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
 <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910145840.055590900@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Travis <mike.travis@hpe.com> wrote:

> @@ -1596,7 +1687,7 @@ static void __init uv_system_init_hub(vo
>  	uv_nmi_setup();
>  	uv_cpu_init();
>  	uv_scir_register_cpu_notifier();
> -	proc_mkdir("sgi_uv", NULL);
> +	uv_setup_proc_files(0);

This slipped through previously: platform drivers have absolutely no 
business mucking in /proc.

Please describe the hardware via sysfs as pretty much everyone else does.

Thanks,

	Ingo
