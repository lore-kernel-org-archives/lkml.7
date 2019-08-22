Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E67C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B556E20578
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566516788;
	bh=fxxrOYIlqSS2AAabfmgkps2lg0LsrpP95HyS47QwquQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nPOLSEgla/QzAbBlZJ+H6VwVk4fmFbe4RYqCU7nZJ/7PtxixleqPYkEpQs/SrraLH
	 fDP+IZoWZmUAwT4YrnQXvXJXQUpBPfJJfsgq8IOnr14D1zGy2FnlKmvCQJijTzo1ke
	 ONZEy+cdly5PG5NAcxhmU9qDof/iprpVaXsxkIdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHVXdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfHVXdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:33:07 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16D2E2339F;
        Thu, 22 Aug 2019 23:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566516430;
        bh=fxxrOYIlqSS2AAabfmgkps2lg0LsrpP95HyS47QwquQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WR4Xr/LiXmwcMbud2bhg3CPCNpY/3utY6/8/OtrA5OtzL7AHSPXFqYjD1rYojkqBu
         5BhalLzEkV6nMuDSsK5mRGw/KloE5O4yijuLnwXBS//FhamXeoeW/z6buCBgFyQ4fD
         qpYFV/L0+saum1HWybd/MaUqQrjJniXXhnBQjl0Y=
Date:   Thu, 22 Aug 2019 16:27:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v3 0/3] vmstats/vmevents flushing
Message-Id: <20190822162709.fa100ba6c58e15ea35670616@linux-foundation.org>
In-Reply-To: <20190819230054.779745-1-guro@fb.com>
References: <20190819230054.779745-1-guro@fb.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 16:00:51 -0700 Roman Gushchin <guro@fb.com> wrote:

> v3:
>   1) rearranged patches [2/3] and [3/3] to make [1/2] and [2/2] suitable
>   for stable backporting
> 
> v2:
>   1) fixed !CONFIG_MEMCG_KMEM build by moving memcg_flush_percpu_vmstats()
>   and memcg_flush_percpu_vmevents() out of CONFIG_MEMCG_KMEM
>   2) merged add-comments-to-slab-enums-definition patch in
> 
> Thanks!
> 
> Roman Gushchin (3):
>   mm: memcontrol: flush percpu vmstats before releasing memcg
>   mm: memcontrol: flush percpu vmevents before releasing memcg
>   mm: memcontrol: flush percpu slab vmstats on kmem offlining
> 

Can you please explain why the first two patches were cc:stable but not
the third?

