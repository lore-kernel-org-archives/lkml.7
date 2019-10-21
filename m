Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2884ECA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5F2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfJUSJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:09:04 -0400
Received: from gentwo.org ([3.19.106.255]:45082 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUSJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:09:03 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id A09753EEDA; Mon, 21 Oct 2019 18:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 9FC4D3E9BF;
        Mon, 21 Oct 2019 18:09:02 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:09:02 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in struct
 per_cpu_nodestat
In-Reply-To: <20191021011550.GA8869@castle>
Message-ID: <alpine.DEB.2.21.1910211808350.8743@www.lameter.com>
References: <20191018002820.307763-1-guro@fb.com> <20191018002820.307763-3-guro@fb.com> <alpine.DEB.2.21.1910202243220.593@www.lameter.com> <20191021011550.GA8869@castle>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Roman Gushchin wrote:

> Sp far I haven't noticed any regression on the set of workloads where I did test
> the patchset, but if you know any benchmark or realistic test which can affected
> by this check, I'll be happy to try.
>
> Also, less-than-word-sized operations can be slower on some platforms.

The main issue in the past was the cache footprint. Memory is slow.
Processors are fast.

