Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D2BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0620717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vKvw+2Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390747AbfJ1P4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:56:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37920 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730109AbfJ1P4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:56:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id t26so5212617qtr.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+oVyHGwOHNWyoBXA1OJvT64Ll72Qyn+h/rilXVin2s=;
        b=vKvw+2Qoar3/HPbIdHr8xSut0Z//5biMVB/Q8OmS6BJwlVkgqUFgW6dCio2Zk/mYUp
         vLZazr0F0yN2/i7CKag2kenLrdAub0fw1+oU+dVyoU61hpb6Em9cpzTGul5uIV+NC86h
         c3C69ZRZ0V5ChouD1WyWiV1dPHA32ShChQb3mBcgynN2hpSIB2zzai3K0MO12HWL+gsf
         rMd/P0eeVujkLc59En1DPYihGovvQtlgww+1/w+MWZgHl7c7EhfhSisrZZhkcWImt4GR
         yGTkhQmjfuO5rI3jZQlUdn/VcmexeSilhaZlIVpU1aK3U8xHjtce20z3WZuufXzqtGZY
         6suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+oVyHGwOHNWyoBXA1OJvT64Ll72Qyn+h/rilXVin2s=;
        b=Dk86JamTtAx14W5YT5hyOSiyUaOG6PpDbzOj0xOOGGRyQuh6qg6tcCpiuNeK0Nt+xu
         RQ0+6U7exY4OP2kYQ2VrnmASfSzxjCcYQTnfmXA1xb/j0332F3pRK8cE0esSBKB1oK6b
         eylZK4lrfC5kQ1EkLVTCPJVhH99KSXnpx5dAQCY69pLlgpxJUd8LBLna7dz5oTvvN9cj
         g0OuUyXdpBrUHneMYKXQ6rhGrrGDlpGbfy5/WRGFsMVXLDk2COsOgB2PhNKSmgW1AaWB
         OyspYPgfhYeSzGnX9nOUaqVCIjpz8ltAgwvvUy99g8enNlNLwE0kVrlLyQpC3uf5rzsg
         1cWA==
X-Gm-Message-State: APjAAAVIzrchsmdaceEX7IUMGYbN7ooee2V7p3uAwbclqqv1aNALTxE/
        SekN6KDcPiv9K0fYlejEOHacnw==
X-Google-Smtp-Source: APXvYqwI2x6YJ5JZqZ7aWNVaxYvjj2xliLFgGj2bKqgA36cdsGDCOqrgbSEDrDuWmR9RZXzacKlzXw==
X-Received: by 2002:ac8:548f:: with SMTP id h15mr18225602qtq.176.1572278179077;
        Mon, 28 Oct 2019 08:56:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:831b])
        by smtp.gmail.com with ESMTPSA id w24sm3520903qta.44.2019.10.28.08.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 08:56:18 -0700 (PDT)
Date:   Mon, 28 Oct 2019 11:56:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2] mm: add page preemption
Message-ID: <20191028155617.GA3156@cmpxchg.org>
References: <20191026112808.14268-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 07:28:08PM +0800, Hillf Danton wrote:
> 
> The cpu preemption feature makes a task able to preempt other tasks
> of lower priorities for cpu. It has been around for a while.
> 
> This work introduces task prio into page reclaiming in order to add
> the page preemption feature that makes a task able to preempt other
> tasks of lower priorities for page.
> 
> No page will be reclaimed on behalf of tasks of lower priorities

... at which point they'll declare OOM and kill the high-pri task?

Please have a look at the cgroup2 memory.low control. This memory
prioritization problem has already been solved.
