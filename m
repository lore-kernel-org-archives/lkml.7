Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00646C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B657C23BB5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="CEz/AAKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfE2Pov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:44:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36962 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfE2Pou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:44:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so136698pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5rb0csxEYpq6VfGz5/QVGNKPlo9rHsx48NwguhVphjA=;
        b=CEz/AAKkGLOaVc6lKqbFaOc50JrPG1TariHgp5nHwAf4jc9op0iyz3MxM7nZQO/ymz
         TKSA2wwMayYrX89UdiTQxgkG4S2uhqZZfbfJxJVrGdU/vGSjR0D9qbnlCv3hPvxbf04h
         Ptmo3H9PVCcjr5mewqD05lu0+wKuy3MLedN6FiIdjWSRebWK1w/ufeqTcilgHIHBazbc
         tyoemTy21uGhYOqr9lyIgiAn/tR8SfT65+AmsE1LktTtLpWu7PLifc6+sL7ywovtk1bi
         74jY3Z9dWSAxMmcGS8tt10gNmMq+Ozl+YJCCkookIzFLu2enYs7QRr8eHmDBbvyKGl4B
         9HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5rb0csxEYpq6VfGz5/QVGNKPlo9rHsx48NwguhVphjA=;
        b=XUSGvNLUGg7iYFQVbiqaiThjtVF7cIp+qLtQTeknMfeESgJtvavX1/TSU2NLyXVWHV
         UORJyXn11ehv8yHu6fk6OIt2qvgJnrzdLd1ZpCdNiDN6evS2HSGUnTOG7q72kmWwGur9
         R763bIpDue405abjLKQD4My3Zdq0GwE5XiKzuVezoYeCND9yGr9JhH5tlreJvckqU7Rb
         xKH38In233XSbOJgoxAy5C13H9IZ0yewiBDdFYapDRKR8ZudXwAAhNwLaHDiVodHNJDI
         28dd+Da2F2fn8rtc5U5T3vUTtCDkt7gwbP8R3XDArTxdq3yYgpIRitOp0fmcU1FEjNXU
         re8Q==
X-Gm-Message-State: APjAAAWsUwOF2Wu8fiQjcprZV32bbDDJxSyJA2WwI5mRECKR7FkC+Cpm
        f6AK7Sl/5mYS//NvyJnp66cFxw==
X-Google-Smtp-Source: APXvYqwzUrKfcPoy1hsbTCw6ESg7o3qVXGDDyPIfLq5La7nokllnQ2NESefsdh56kWG23ear160irQ==
X-Received: by 2002:a63:e953:: with SMTP id q19mr14654295pgj.313.1559144690141;
        Wed, 29 May 2019 08:44:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:a47c])
        by smtp.gmail.com with ESMTPSA id u123sm34317pfu.67.2019.05.29.08.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 08:44:49 -0700 (PDT)
Date:   Wed, 29 May 2019 11:44:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix recent_rotated history
Message-ID: <20190529154447.GA28937@cmpxchg.org>
References: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155905972210.26456.11178359431724024112.stgit@localhost.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 07:09:02PM +0300, Kirill Tkhai wrote:
> Johannes pointed that after commit 886cf1901db9
> we lost all zone_reclaim_stat::recent_rotated
> history. This commit fixes that.
> 
> Fixes: 886cf1901db9 "mm: move recent_rotated pages calculation to shrink_inactive_list()"
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
