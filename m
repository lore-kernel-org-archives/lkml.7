Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B0CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B721215EA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0grKuDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKBXzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:55:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKBXzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:55:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id e3so3859940plt.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=z0bgko71g/IEmBKD3Kro6mR4U+O8GKl/Z/Ms7dBzsH4=;
        b=Y0grKuDcaYtkpumf209OEt0taRJ7Y6eOtn7rvFJPq1VMFZ+BoXqfMZNRq9rLCrW12u
         D8VNlbfWEqIKt3A1Wl+k1SxaU9X2kXhZXXesNApA/aYan2qyIkNS8pgyMMfIvkD0w4VS
         U6msNXpe1KK9KZZGIiGmJNMpwNFaKC+VtlKzW5GbBSjRIjnen7Tk66LtCmd6uh5QJN6G
         8oIubEqXAwVIFxaXfQiQrJEYD0VQHXDkafpol8yjZhyMnR0FWJGrB2uvS0BHdLFhgof7
         K7QbS5Styk3SYEeVaUYq45g2bzeTAhcNl2Lg/i35OjWCROKCu7YX5GPeBPv+2Rq222E3
         dl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=z0bgko71g/IEmBKD3Kro6mR4U+O8GKl/Z/Ms7dBzsH4=;
        b=WRkQf5ZbkQzSnrU+2fO1RP0i4QaqAkIIU+fruhDFUGPUYwtlfAKezype+gvAU5A1ev
         PMXZimIfK15Dj6aRI9b8vDCB60uT2oyK+cu0nJjlBb1iV0HPYjBf2JG2MYfrJcXjgZB4
         0Vl0TES7RQI2+7TlS+i5ufxvQTwAMSbpRPSYN7LXa/1axQAeihuLrw4VG+vrsIK3mVpn
         Yb5es9mrxTXzmHRX/3V5U25ECKJLIcwM8sc3OjynquiArRyn1SFfjfGQdvWd9IoDEj3Y
         j/gOVUoe4sukea75+mTCv3HjaEmr5/gFTa7e+Ylp8Mcix4ZY9ttmQNWeePwXMPg1cgC4
         SvVg==
X-Gm-Message-State: APjAAAU2DMg6u/lyNcb0wI9YzP+HpgclgphRqLK4C9HInQ8cSdKs6d5Z
        HPZjTaN5XRfsLvQpvJuCk/gS8w==
X-Google-Smtp-Source: APXvYqw7xUJMFwKAO6VdFjMCpsRiabe8H2rE/jwkyhOUOIw7HwwCAPhxRAcxaZmTJgrYrlWPCCdchQ==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr19271681plk.276.1572738938992;
        Sat, 02 Nov 2019 16:55:38 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c66sm11767706pfb.25.2019.11.02.16.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 16:55:38 -0700 (PDT)
Date:   Sat, 2 Nov 2019 16:55:37 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
In-Reply-To: <157270779336.1961.6528158720593572480.stgit@buzz>
Message-ID: <alpine.DEB.2.21.1911021654020.34229@chino.kir.corp.google.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2019, Konstantin Khlebnikov wrote:

> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
> charge path") memcg invokes oom killer not only for user page-faults.
> This means 0-order allocation will either succeed or task get killed.
> 
> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5361ebec3361..eb47815e137b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
>  
>  		Failed allocation in its turn could be returned into
>  		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> +		disk readahead.
> +
> +		Before 4.19 OOM in memory cgroup killed tasks iff
> +		shortage has happened inside page fault, random
> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> +		failed memory cgroup allocation invokes oom killer and
> +		keeps retrying until it succeeds.
>  
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order

The previous text is obviously incorrect for today's kernels, but I'm 
curious if we should be conflating the documentation here by describing 
the pre-4.19 behavior.  OOM killing no longer happens only on page fault 
so maybe better to document the exact behavior today and not attempt to 
describe differences with previous versions?
