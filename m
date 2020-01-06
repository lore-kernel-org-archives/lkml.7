Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4708FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1692072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578315239;
	bh=ib2qZE3lV6ApqiZTQC2R/FeDbgbc+nJwfdcy/BKeWo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r7vBR/93q/eyNErxpMC6Uo1EA/3YLcv/HaPmiKfPbNI5uUbcZ9KfNfXfkAoeyOdp6
	 Orz/ZDxB2pw1Vad/1bShQi+W3e3QWatK3Dnhd0AmHFl6iOArRgR9Rk/Jh1FyRWM27P
	 TIAqU/+FFW+49/Do/Vf+oQcJFJu9VQpOztWAqzpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgAFMx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:53:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40011 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFMx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:53:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so49459615wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 04:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7xMGOoliqBVH26UmgyuqhQeBnPvckjJ46nheFVxkwA=;
        b=C1MWkeYyWMDJySpE6kOPxy4kZNUq9aPpZV0KTTXP69CfaJ/cfw6rF/CyisgY4OTPD3
         OX3vEl1wsmmEMSEcNVcgQgb6jn/7U2LwLuL2S1hNduyPMpl6frJ7aSQAEnvUFFdl7Iw/
         EaI8rE5RTp4z7TKHqKT7qaCRgaG/awjsmwKiQ1N8xQYHqm9GbqU2YhyTuC75XWgjFR4y
         C3OzVhGOhlfAOxfK5oKAnCVckB0c4/3d6fS/xdFqjEfofVaxSg69pr+AdxMyybUotXKm
         1iq/hz6Ba+n6UUiPZtKwmutl3bD0y+MqXcnuGt2UGxnSmdz8g2Jr5SbLMYCZc5N5msVr
         9CDQ==
X-Gm-Message-State: APjAAAWPAvJYNuSzsUeVCE9T9CRcwBE9HIP2E94GSOFZ28SFSDBNDwHM
        MlIqEtbnas9IyTzza3KJ7A4=
X-Google-Smtp-Source: APXvYqwMxtymrcYWSyOPaGB4Fu00uGPSoY+lbeOVgXNLZZG5MESHuPVBcrKmLcBDvC2u7vK+30vkmg==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr32266890wrj.357.1578315234331;
        Mon, 06 Jan 2020 04:53:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j12sm73100799wrt.55.2020.01.06.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 04:53:53 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:53:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Luigi Semenzato <semenzato@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, akpm@linux-foundation.org, gpike@google.com
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
Message-ID: <20200106125352.GB9198@dhcp22.suse.cz>
References: <20191226220205.128664-1-semenzato@google.com>
 <20191226220205.128664-2-semenzato@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226220205.128664-2-semenzato@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-12-19 14:02:04, Luigi Semenzato wrote:
[...]
> +Limitations of Hibernation
> +==========================
> +
> +When entering hibernation, the kernel tries to allocate a chunk of memory large
> +enough to contain a copy of all pages in use, to use it for the system
> +snapshot.  If the allocation fails, the system cannot hibernate and the
> +operation fails with ENOMEM.  This will happen, for instance, when the total
> +amount of anonymous pages (process data) exceeds 1/2 of total RAM.
> +
> +One possible workaround (besides terminating enough processes) is to force
> +excess anonymous pages out to swap before hibernating.  This can be achieved
> +with memcgroups, by lowering memory usage limits with ``echo <new limit> >
> +/dev/cgroup/memory/<group>/memory.mem.usage_in_bytes``.  However, the latter
> +operation is not guaranteed to succeed.

I am not familiar with the hibernation process much. But what prevents
those allocations to reclaim memory and push out the anonymous memory to
the swap on demand during the hibernation's allocations?
-- 
Michal Hocko
SUSE Labs
