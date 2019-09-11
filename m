Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA01EECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD51121928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568182028;
	bh=NyFgLdAtL7G7r4VwV0PMLVYuv4D/PpdH1+bqEr6kBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQeUv6PGQ1NiOTHhY7seLuTpcBlbWYYja7Ty6C7lQNueZee+B74NYWH2r6+28DCY3
	 y4SUOlZ3M0V7yxRX7PE7nzgt23IRoLoiZSdxf/FXKMtgTSQCFh0nYMinKy1x683z6f
	 5glzeFhfQ0L+QvGVz4SFONY8CLfKBps9t1wQX7nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIKGHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:07:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34930 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfIKGHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:07:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id g7so23101936wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WfMAZ45br/Di2RY5jgIjhxqqeQk5rlQZL/Ma6yQGV2w=;
        b=G0+ibcruLLFVXgwzGOifA/mXRgBnp7n9juLLu6caUueN/7sVmTQRtosDg8+K4O3QXA
         qPoFMpSzPpFULdkmSYrKMVbugWgazUUnkLqujuwjg/sojtBA8Sz4b+pn1PL9cjy67APm
         TvBO9trOeSIgCW8pCU+oqcI/TbgcEyXzPSug0xK0WA6p7SOJO16zHoH4ZqvdsmNrWQiX
         jWnKyIXyfMZpmdj2HVJdfg5BNxyQZU7FPD6wa+55G+D1zXzNsyTBkPao19IzlP0kV1DS
         7h2jRuIy2k44NnuknyuLD0PKsM7cskdnY7kCCDUb6sDSSShuUYIary0RVdlAE2YxJaC/
         yBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WfMAZ45br/Di2RY5jgIjhxqqeQk5rlQZL/Ma6yQGV2w=;
        b=QzFj8CUv/WSv6iCyJdXH0PSaLVAVqQHksnq3lQ6p/pl5u7jJE0bVKMojp8Pg7qk/fY
         5TBsixzAfKmMguCe9EzRbwEhFOuQtCBBeC7TZSG5AEygOhBqVHRh1LkUTJxYaEquwdCw
         GzxFK0Mt410ETy+Y+rma07Xvav+n0Nt0yhYg9rzKg60hmxdNPBra+UqGN9X0Obag472X
         5URdgz5xLvt4luR7E48tWbb/1Bd8TpefCMtg1+rbLe7ZiITybUPeVlSAoTcKN85UnZn2
         5y8MrLH2QqdVbTATzSpyp0Ni0usox/7H2Ji/iS1tZZBSi7dXF2vKi6IKh6zb8uNm4AFj
         MMKQ==
X-Gm-Message-State: APjAAAXbV5B0qGxeoMq8NUwN8lXRD4XC3sd0JblHN5tLgdEcdxwCAKBE
        7n/IvjE8EdO13on9C/4dJD8=
X-Google-Smtp-Source: APXvYqyZVOUkPGs97UVwQ35ctn0ys/nsz7s0hl3kwHBc8r+CMtC2xYcmEzBWNmcsNaa6QbNGNsZYXw==
X-Received: by 2002:a5d:54cd:: with SMTP id x13mr5753758wrv.12.1568182025419;
        Tue, 10 Sep 2019 23:07:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y3sm18570625wrw.83.2019.09.10.23.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 23:07:04 -0700 (PDT)
Date:   Wed, 11 Sep 2019 08:07:02 +0200
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
Subject: Re: [PATCH 4/8] x86/platform/uv: Setup UV functions for Hubless UV
 Systems
Message-ID: <20190911060702.GD104115@gmail.com>
References: <20190910145839.604369497@stormcage.eag.rdlabs.hpecorp.net>
 <20190910145839.975787119@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910145839.975787119@stormcage.eag.rdlabs.hpecorp.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Travis <mike.travis@hpe.com> wrote:

> +/* Initialize UV hubless systems */
> +static __init int uv_system_init_hubless(void)
> +{
> +	int rc;
> +
> +	/* Setup PCH NMI handler */
> +	uv_nmi_setup_hubless();
> +
> +	/* Init kernel/BIOS interface */
> +	rc = uv_bios_init();
> +
> +	return rc;
> +}

Am I the only one who immediately sees the trivial C transformation 
through which this function could lose a local variable and become 4 
lines shorter?

And this function got two Reviewed-by tags...

Thanks,

	Ingo
