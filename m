Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCD5ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E006521925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="y5eyFIzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfJONxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:53:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34583 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfJONxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:53:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so30709893qta.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdFD1ySM7snbTlYVusRsUK5w8tupUNVkhhCAYZ7l2Pc=;
        b=y5eyFIzUZPf7JNQjTnetQoWn3BAyiwEjxA5Z4qE2NKrnEC5SXIMN2+3NTw9lnNtQpl
         8jXl1nYoG97Myed+YXA4VidWTzzkb728WjXDdyiTxMAnQnJCgfOxgYm+hXr813ku/ApS
         D/V/R44Njsqn3oEV6/kJ7kxFhqWh4qQzvA/G0IpIq0MYI9ymag/1KcZjH4FecF15gYer
         FWTe0oBPGVvjex692yOemBosnoB8ax+5iL9DTQF+3g1QQvhV+wm+0euRJZqpsxIc5fHh
         t7R60n9eCfBoflqA7J0pr4mOMAlD6cCJW5kjSZJkYio+WNor05cV2ad46SLhRD6o/TXk
         48kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdFD1ySM7snbTlYVusRsUK5w8tupUNVkhhCAYZ7l2Pc=;
        b=jFjMPQvqjk/fOVMZgRPWeMbJEA0j2eag6F97BTzmrWmpj+PIa+SxVgAsoKBKurJ1M3
         MDiKdtStGaA3W6IzPe0IhJlKjyq841O1Z5jPBntMyPLMMXf7bJxHKFMRqvtmX0Qqaa3l
         NO490Kd1uCxMG78Z9EPQdRv3hiok8CKoE5yFp/T1L/Q/lSWbCV/95agOvsOQpDBIKlQN
         C1zMRn5nDFPdmDCZhjWv9kdhIX0MMMRkt5movbc8fuKmL3QDQzro4q0usAkr59hiw+ZH
         20gMohSSS1rJUryoA0A86O+lnlW0yEIqIz7XqMQPCoP3xybTYdRRkYX7zb9hXcyXJnxN
         fk0A==
X-Gm-Message-State: APjAAAWyd6UL3QJhF/L9s5IJG+u7xMmDPaFyFUdathCZNeCpukI2Gc0i
        h7b4eHTHNNFc5KRpf+su6yrAIg==
X-Google-Smtp-Source: APXvYqyhlPRXzOnBK2H9VoOhhErMUW+uFAJUl6CEm6oB8pyKripwSp26aw+YsSeqMP5Lxhsfcz7ugA==
X-Received: by 2002:a0c:b068:: with SMTP id l37mr28886665qvc.36.1571147630166;
        Tue, 15 Oct 2019 06:53:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d056])
        by smtp.gmail.com with ESMTPSA id t17sm14675129qtt.57.2019.10.15.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 06:53:49 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:53:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015135348.GA139269@cmpxchg.org>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157112699975.7360.1062614888388489788.stgit@buzz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:09:59AM +0300, Konstantin Khlebnikov wrote:
> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> These counters needs update when page is moved between cgroups.
> 
> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Please mention in the changelog that currently is nobody *consuming*
the lruvec versions of these counters and that there is no
user-visible effect. Thanks
