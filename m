Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866DDCA9ED0
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACD621855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="LvJWdLOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKBQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:02:57 -0400
Received: from mail-ua1-f101.google.com ([209.85.222.101]:38807 "EHLO
        mail-ua1-f101.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfKBQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:02:56 -0400
Received: by mail-ua1-f101.google.com with SMTP id u99so3792591uau.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ef9ou+qj0vagMx1XNPM66HwZ5oa8tbdOa32pNN49rmM=;
        b=LvJWdLOfXa28+18z0vfIwt2vXO10BiJMLLj1cghAiBcYuUCfXtVKu+qQDkJuNiIsv2
         eg1QR09wz+rMzdgxFRcKQZHEuFmmsjf6ywdbbgGETt88yEgQvC3oFTsM6E2Ex0iCrTv1
         QcSSJgi0P+WBF8w8p3kW1exS+wO22ORwxawtc2wMk2xBPZS/Bf64+msLGc/BYX5H+xs8
         V7lPow+YCJoRbFlqGt3uBDaIQt9FpU6i4+/vE5m4j4Hd/ajoaeCjlywmBpqxCB+rbjKZ
         FecRb5+ftAldNmWA7D1jiQftbb2nUm3LlxyP/8W3YTmIe37KgZZqFlAn1lbQI8nlTl4V
         u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ef9ou+qj0vagMx1XNPM66HwZ5oa8tbdOa32pNN49rmM=;
        b=RIp8myoo44dYUWnwNhExME1WyM08pDIMHwlm58n5okgWQLWd1mnEHrvgouVt75tN7d
         XgMuLKXmSzDsEsHJ+uRCMGfyFeFviAk+O3gKt6zuiymw6PpRz9wqdIuuyT3A/0GiwisP
         U+K9rTzDuoEmiK9vLlvn+oCo7Yf+JWGsQ6Ii7zNf7AI/RTURfkBTQ3lZ6AlPo7wf2hSp
         s18+h3nnor957+VJtxgx4Y18IyIgC7OVVnKI+vNCR1vrD2AfhPjTfoA9gW4zTY8xpwis
         6lXVMM1VZKetR6iEp3Ra/QpMCAJp4PKGOxCecmdtzrp/pyqN0jydZOWr4lDvB8XuvkqF
         mIYQ==
X-Gm-Message-State: APjAAAXgBAXoZUj1QS5H11nOA/SyreQjjCa1ge+zk2bYX+gfXnuOhmBq
        WD4YBSz2AJVW7Q1Sdkc/jRMqCYA1fDhfdZiatGxVBGnfdzsmIg==
X-Google-Smtp-Source: APXvYqwK1xgX5mnhSKjTMChk8ZE8+bx2G7d8kJb50m9VZnFRyUHlvIALEEITytHRFgZmXCB2+L8VVq1/W6Zv
X-Received: by 2002:ab0:6044:: with SMTP id o4mr6464044ual.119.1572710574360;
        Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
Received: from familie-tometzki.de (freebsd.familie-tometzki.de. [18.210.29.142])
        by smtp-relay.gmail.com with ESMTPS id j184sm1051649vkh.1.2019.11.02.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
X-Relaying-Domain: familie-tometzki.de
Received: from freebsd.familie-tometzki.de (localhost [127.0.0.1])
        by freebsd.familie-tometzki.de (Postfix) with ESMTP id 70195278CC;
        Sat,  2 Nov 2019 17:02:53 +0100 (CET)
Date:   Sat, 2 Nov 2019 17:02:53 +0100
From:   Damian Tometzki <damian.tometzki@familie-tometzki.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
Message-ID: <20191102160252.GA19103@freebsd.familie-tometzki.de>
Mail-Followup-To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02. Nov 18:16, Konstantin Khlebnikov wrote:
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
Hello Konstantin,

iff --> if :-)

Best regards
Damian


> +		shortage has happened inside page fault, random
> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> +		failed memory cgroup allocation invokes oom killer and
> +		keeps retrying until it succeeds.
>  
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order
> 
