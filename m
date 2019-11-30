Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9A9C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D5E2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AJPT1F66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfK3GEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:04:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33103 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3GEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:04:52 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so6560793pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 22:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=I+UGpdIXNr8v7drCCgj6CSr/PvndKx70EiWQ/dbfpjM=;
        b=AJPT1F66ZluKCDft9O1xmcX6cGgjMmH1YpFwzhc2uV+U2aIoL72Hcj4mFQEuGbBFgj
         ME35eTBfkK/oUnsXH4ztIE0GtBmGT+R4fyANRSK4nhH03c21U/L6uSS0KTT1WJO6Bcrn
         MzSia7Ub1NcnsMN6KtxAjVP4KGDx0n+mg+u44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=I+UGpdIXNr8v7drCCgj6CSr/PvndKx70EiWQ/dbfpjM=;
        b=pNjnMAKxRf521RLHEDOb3L/968O4OWtUpUOxxutFUKfFOzrjMCqLKw975pxGG57fvY
         UbPbSgZw0VK2SJF8dlcYluLtJKCiQ6oqwoaWMqSiS2vYvnJGZ75oZNLvflm8cD94Xate
         gCzZsRSdWxu3nPuL+JIiq+rsfbJeIeTggrOsYtOgpQ3KNwneLQtH7V0n1WwxjHxrkBEP
         a8ZL5SXvKrYtIo3VzxzkyZE8OP5zPBMjWFv8jhTK0bl8gRV2RpyAyvf4dZkVPmx9sxNv
         b6M0muNdmeYTJbbkMDyOedl/f5qTepcZKnYG6+k3VUCBC5GfMP5IU1Esv58OF337lrrl
         JQfw==
X-Gm-Message-State: APjAAAVsQDQL5MGTsGjNvN6rOBy6RUK6TmGS6Mxkk3xtGSwKNdkqYlWN
        KMR8P2Mz7OJOfvvt43SmEspEWBmW7hY=
X-Google-Smtp-Source: APXvYqyOz1eFIc5UhQbOZYZuFCcxy0TBGCy9INsqZnIafIclOjjhDKQ93aIMf2fAzVGYiJi4GbFbtg==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr17499736plo.223.1575093890084;
        Fri, 29 Nov 2019 22:04:50 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-4092-39f5-bb9d-b59a.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4092:39f5:bb9d:b59a])
        by smtp.gmail.com with ESMTPSA id o8sm12389519pjo.7.2019.11.29.22.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 22:04:49 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     akash.goel@intel.com, ajd@linux.ibm.com,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: Re: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
In-Reply-To: <20191129013745.7168-1-dja@axtens.net>
References: <20191129013745.7168-1-dja@axtens.net>
Date:   Sat, 30 Nov 2019 17:04:45 +1100
Message-ID: <87v9r1ew76.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> --
>
> There's a syz reproducer on the powerpc syzbot that eventually hits
> the bug, but it can take up to an hour or so before it keels over on a
> kernel with all the syzkaller debugging on, and even longer on a
> production kernel. I have been able to reproduce it once on a stock
> Ubuntu 5.0 ppc64le kernel.
>
> I will ask MITRE for a CVE - while only the process doing the syscall
> gets killed, it gets killed while holding the relay_channels_mutex,
> so it blocks all future relay activity.

CVE-2019-19462 has been assigned.

Regards,
Daniel


> ---
>  kernel/relay.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/relay.c b/kernel/relay.c
> index ade14fb7ce2e..a376cc6b54ec 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -580,7 +580,13 @@ struct rchan *relay_open(const char *base_filename,
>  	if (!chan)
>  		return NULL;
>  
> -	chan->buf = alloc_percpu(struct rchan_buf *);
> +	chan->buf = alloc_percpu_gfp(struct rchan_buf *,
> +				     GFP_KERNEL | __GFP_NOWARN);
> +	if (!chan->buf) {
> +		kfree(chan);
> +		return NULL;
> +	}
> +
>  	chan->version = RELAYFS_CHANNEL_VERSION;
>  	chan->n_subbufs = n_subbufs;
>  	chan->subbuf_size = subbuf_size;
> -- 
> 2.20.1
