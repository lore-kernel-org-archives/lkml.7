Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9292120722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="dj9kUX7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLYOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 09:05:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 09:05:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so21798632wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PaDmMxkiRy/WmC12erbAUHsnmEtdYs1r3ps1zkcgWAw=;
        b=dj9kUX7cO9CfQ0vYnu5g3KXmO6JhCagGhOV4IqNaW87UuclAEzzGxEeHbcInmbtxqV
         OTO0VWnbb+87Kf8YZB5UqxkkEHoCB1F/RLgqzLcQJiMEBmz9yznlTFDsFGo9tW626Hnj
         O3+BJexc5zq7YN4nzlzC/8FHKHufQKUeyGKzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaDmMxkiRy/WmC12erbAUHsnmEtdYs1r3ps1zkcgWAw=;
        b=CR3f1BetYqWVedBwFPS2sgFfQl1GZDN3ghpBp5kXeQH5T04XM6/21ALCWbkEtCakpo
         M//BJWRgKBUadBl5U5ECsVckLExGQmHv1t/stBJGD1O4LR3066hdr9G6wXdjV958/UtT
         IzHFcRTl4uSIke234/O9cYRpqZKtzz5die5nrmifUt0rEYRC1INqp61iLW+V8ecuJaoi
         8kZmwKcQKmpf2+DFjexeWPhid2LOweR4Cnpjw447LK2XFa4+3sbpAM5H0kYlW+Hbhd/6
         V/G+iS1pyxRTFsMiB8zQUq3beDyX5Y8eWxTP95tgkIZ9Y0BufrIRpdpBRWpj5Y0t1LC0
         MK2w==
X-Gm-Message-State: APjAAAUpTOVpouI9l13nKzzBn38HD/Ukc221jbQmK99RNJ+j6ORwnD//
        nUqGO47YBj2Os6bCzLbsQYcJcg==
X-Google-Smtp-Source: APXvYqz5NZ/Z9pXVDdxcMgmQvd60J/zQ3ZAGiDufUZ/QmKwuXQsKbS8TnZLdl3bs9e8BAZqJmF/8dg==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr41544340wrv.358.1577282748332;
        Wed, 25 Dec 2019 06:05:48 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id u22sm28958411wru.30.2019.12.25.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2019 06:05:47 -0800 (PST)
Date:   Wed, 25 Dec 2019 14:05:46 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20191225140546.GA311630@chrisdown.name>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1577252208-32419-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

Hui Zhu writes:
>Even if cgroup2 has swap.max, swappiness is still a very useful config.
>This commit add swappiness to cgroup2.

When submitting patches like this, it's important to explain *why* you want it 
and what evidence there is. For example, how should one use this to compose a 
reasonable system? Why aren't existing protection controls sufficient for your 
use case? Where's the data?

Also, why would swappiness be something cgroup-specific instead of 
hardware-specific, when desired swappiness is really largely about the hardware 
you have in your system?

I struggle to think of situations where per-cgroup swappiness would be useful, 
since it's really not a workload-specific setting.

Thanks,

Chris

>Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
>---
> mm/memcontrol.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index c5b5f74..e966396 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
> 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
> 		.seq_show = swap_events_show,
> 	},
>+	{
>+		.name = "swappiness",
>+		.read_u64 = mem_cgroup_swappiness_read,
>+		.write_u64 = mem_cgroup_swappiness_write,
>+	},
> 	{ }	/* terminate */
> };
>
>-- 
>2.7.4
>
>
