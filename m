Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6F3C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1F206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576147271;
	bh=G5dWhTA8yXw0fcvJ7dmJ0Yzd87sWKpxCPFgwWJQb2Rs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PGkIl+Xm9rWPQyfZbBzssIdLIqEAFfA5wnEcnehmj49TKKaanR/J9GVttye3u5tO9
	 3TmP7oLed+0mpAFyuSkP4rMFAQTH7pc+iQZo1WO+rLyIDv6VPN0Mn2ykA89PWb2k1q
	 66ba+qpDl5pR7HWOtOnX8XHsmIHAk8EKETY3wDqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfLLKlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:41:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfLLKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:41:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so2136303wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1F+4TtH6sI5cY7070NYFBNoEudVsb5hE0A8Xjrz5eo=;
        b=IoFTsowcKg00Iz0WKrEvjoKZLOSi2ZqpF99/sCBHGd5DKtMjKOw1Tp9WmMpWY4Uyc1
         pjpjQALGqvEyTdP0ShRSigI1zjN3alf3G63cxsFJEcwiSyfAm4u1/1E4njifOoCWMrGo
         wBlElywR6HBU9TEbPJ/dRt4zpBx93FgyGMcJFrjW7wl8vHA4RBhVyOpFwBacbmTJKFMJ
         ZNTo2HDaNhTw4Cy3bn41+QpAfoa6bt8X7vDT60PdzeFSODSt1fcxjMYbDFBdyf9JB38t
         hgudH22TocRCL2sFW4BT4j7GynyeIqkEKivOJTnz+weeYqkeZ5h8kD8/iGTnvnadcGfc
         E/Jw==
X-Gm-Message-State: APjAAAX+mdqrAeRNZpDXCyNzRk4JQ9X2fxNHoUB4lTkJmTIslZMz42zB
        /YGUqfNRp8W/+bsqkrdl4Ms=
X-Google-Smtp-Source: APXvYqxOce3OTxugq2NkVg7LzBetfJZWQP02bBZN2IlNy0Ymm6100zVdUAOzD2ENCSn8R+WsdvEx0A==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr5367757wrw.319.1576147267915;
        Thu, 12 Dec 2019 02:41:07 -0800 (PST)
Received: from localhost (ip-37-188-179-200.eurotel.cz. [37.188.179.200])
        by smtp.gmail.com with ESMTPSA id w20sm5587444wmk.34.2019.12.12.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:41:06 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:41:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Edward Chron <echron@arista.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/oom: fix pgtables units mismatch in Killed process
 message
Message-ID: <20191212104105.GB12165@dhcp22.suse.cz>
References: <20191211202830.1600-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211202830.1600-1-idryomov@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-12-19 21:28:30, Ilya Dryomov wrote:
> pr_err() expects kB, but mm_pgtables_bytes() returns the number of
> bytes.  As everything else is printed in kB, I chose to fix the value
> rather than the string.
> 
> Before:
> 
> [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> ...
> [   1878]  1000  1878   217253   151144  1269760        0             0 python
> ...
> Out of memory: Killed process 1878 (python) total-vm:869012kB, anon-rss:604572kB, file-rss:4kB, shmem-rss:0kB, UID:1000 pgtables:1269760kB oom_score_adj:0
> 
> After:
> 
> [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> ...
> [   1436]  1000  1436   217253   151890  1294336        0             0 python
> ...
> Out of memory: Killed process 1436 (python) total-vm:869012kB, anon-rss:607516kB, file-rss:44kB, shmem-rss:0kB, UID:1000 pgtables:1264kB oom_score_adj:0
> 
> Fixes: 70cb6d267790 ("mm/oom: add oom_score_adj and pgtables to Killed process message")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Ups, I have missed that when reviewing 70cb6d267790.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 71e3acea7817..d58c481b3df8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -890,7 +890,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  		K(get_mm_counter(mm, MM_FILEPAGES)),
>  		K(get_mm_counter(mm, MM_SHMEMPAGES)),
>  		from_kuid(&init_user_ns, task_uid(victim)),
> -		mm_pgtables_bytes(mm), victim->signal->oom_score_adj);
> +		mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_adj);
>  	task_unlock(victim);
>  
>  	/*
> -- 
> 2.19.2
> 

-- 
Michal Hocko
SUSE Labs
