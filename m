Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F62C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78822071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKVPx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:53:58 -0500
Received: from gentwo.org ([3.19.106.255]:39220 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKVPx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:53:58 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 5EDB93F3D6; Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5DE683EBFD;
        Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
Date:   Fri, 22 Nov 2019 15:53:57 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pengfei Li <fly@kernel.page>
cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        iamjoonsoo.kim@lge.com, guro@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
In-Reply-To: <20191122234907.4da3bc81.fly@kernel.page>
Message-ID: <alpine.DEB.2.21.1911221551570.10063@www.lameter.com>
References: <20191121151811.49742-1-fly@kernel.page> <1bb37491-72a7-feaa-722d-a5825813a409@redhat.com> <20191122234907.4da3bc81.fly@kernel.page>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Pengfei Li wrote:

> I am sorry that I did not make it clear. I want to express this series
> of patches will benefit NUMA systems with multiple nodes.

Ok but that benefit needs to be quantified somehow.

> The main benefit is that it will be more efficient when traversing all
> nodes (for example when performing page reclamation).

And you loose the prioritization of allocations through these different
zones. We create zonelists with a certain sequence of the zones in
order to prefer allocations from certain zones. This is in particular
important for the smaller DMA zones which may be easily exhausted.

