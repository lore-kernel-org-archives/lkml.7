Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7820C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AE520718
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 23:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577834184;
	bh=T1TP9OS5NPYDy/yeJXg2yUzaWY4igVKAIiTXgalOvCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QksKi65g/U3gHlLl+rlINl+forTuHoGNvjbWfISrYmU1pLcvMK7e0vntxPKtJKWpb
	 R4HRQOq2es2CQDGRgTywVWUE6Zw1QnIyWahkdUPefPpdphh0bAy0DIdzSwEj0mjzdS
	 XwrkQeQ8S0pWaLOrHORDIYd67lWLumBbRWazkrBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLaXQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 18:16:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfLaXQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 18:16:23 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1117B206E6;
        Tue, 31 Dec 2019 23:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577834182;
        bh=T1TP9OS5NPYDy/yeJXg2yUzaWY4igVKAIiTXgalOvCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H8M60uzpbqD2/72X0HwITZluZ6clbGOPd0ijAz1VhVr5Z3LM/3znM7GQRZUzyjNBR
         xvZ7i5CxutBqkLsKTIoT323gNM9oT82/jm2X97XHDvrHW2KzDaxjgLPiE3uwaTW9W9
         rk/vwiiwutPleNfxOzsVVXKrv0aHHhiWL2fqqikU=
Date:   Tue, 31 Dec 2019 15:16:21 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-Id: <20191231151621.8f1565ef8736233dbf60bca7@linux-foundation.org>
In-Reply-To: <1577252208-32419-1-git-send-email-teawater@gmail.com>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019 13:36:48 +0800 Hui Zhu <teawater@gmail.com> wrote:

> Even if cgroup2 has swap.max, swappiness is still a very useful config.
> This commit add swappiness to cgroup2.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
>  		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
>  		.seq_show = swap_events_show,
>  	},
> +	{
> +		.name = "swappiness",
> +		.read_u64 = mem_cgroup_swappiness_read,
> +		.write_u64 = mem_cgroup_swappiness_write,
> +	},
>  	{ }	/* terminate */
>  };

There should be a Documentation/ update with this?




