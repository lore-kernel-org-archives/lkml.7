Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D958C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0182085A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 11:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="m9aJEqB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390159AbfGRLiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 07:38:12 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:45164 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbfGRLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1563449891;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=xWVA8lsMEzKAdMagd2kfoiEHBMGzewwRgNqmEIy/2Rw=;
        b=m9aJEqB6b/1X8K3XpFwzGXp3UjJognrWDaP+nhgc5YMHZPUQ+jV84Zilt5nBS0t8
        zn0b1O7AYnfXJvggzlsCa4XZ+C22Gj2jzs90cUpCPwdPcSeeznIrScvUIUt5uO5Jxk3
        whHhZdArsxSZAJUEkRzOim1yrj1Y0H/kKp1TBUPI=
Date:   Thu, 18 Jul 2019 11:38:11 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Waiman Long <longman@redhat.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] mm, slab: Extend slab/shrink to shrink all memcg
 caches
In-Reply-To: <20190717202413.13237-2-longman@redhat.com>
Message-ID: <0100016c04e0192f-299df02d-a35f-46db-9833-37ba7a01f5f0-000000@email.amazonses.com>
References: <20190717202413.13237-1-longman@redhat.com> <20190717202413.13237-2-longman@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.18-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019, Waiman Long wrote:

> Currently, a value of '1" is written to /sys/kernel/slab/<slab>/shrink
> file to shrink the slab by flushing out all the per-cpu slabs and free
> slabs in partial lists. This can be useful to squeeze out a bit more memory
> under extreme condition as well as making the active object counts in
> /proc/slabinfo more accurate.

Acked-by: Christoph Lameter <cl@linux.com>

>  # grep task_struct /proc/slabinfo
>  task_struct        53137  53192   4288   61    4 : tunables    0    0
>  0 : slabdata    872    872      0
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            3936832 kB
>  SReclaimable:     399104 kB
>  SUnreclaim:      3537728 kB
>
> After shrinking slabs:
>
>  # grep "^S[lRU]" /proc/meminfo
>  Slab:            1356288 kB
>  SReclaimable:     263296 kB
>  SUnreclaim:      1092992 kB

Well another indicator that it may not be a good decision to replicate the
whole set of slabs for each memcg. Migrate the memcg ownership into the
objects may allow the use of the same slab cache. In particular together
with the slab migration patches this may be a viable way to reduce memory
consumption.

