Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE80C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B515206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfC1Ka2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:30:28 -0400
Received: from foss.arm.com ([217.140.101.70]:42120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfC1Ka2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:30:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F7F15AB;
        Thu, 28 Mar 2019 03:30:26 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03B863F59C;
        Thu, 28 Mar 2019 03:30:23 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:30:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Pekka Enberg <penberg@iki.fi>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        mhocko@kernel.org, willy@infradead.org, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190328103020.GA10283@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
 <c49208bf-b658-1d4e-a57e-8ca58c69afb1@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49208bf-b658-1d4e-a57e-8ca58c69afb1@iki.fi>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:05:31AM +0200, Pekka Enberg wrote:
> On 27/03/2019 2.59, Qian Cai wrote:
> > Unless there is a brave soul to reimplement the kmemleak to embed it's
> > metadata into the tracked memory itself in a foreseeable future, this
> > provides a good balance between enabling kmemleak in a low-memory
> > situation and not introducing too much hackiness into the existing
> > code for now.
> 
> Unfortunately I am not that brave soul, but I'm wondering what the
> complication here is? It shouldn't be too hard to teach calculate_sizes() in
> SLUB about a new SLAB_KMEMLEAK flag that reserves spaces for the metadata.

I don't think it's the calculate_sizes() that's the hard part. The way
kmemleak is designed assumes that the metadata has a longer lifespan
than the slab object it is tracking (and refcounted via
get_object/put_object()). We'd have to replace some of the
rcu_read_(un)lock() regions with a full kmemleak_lock together with a
few more tweaks to allow the release of kmemleak_lock during memory
scanning (which can take minutes; so it needs to be safe w.r.t. metadata
freeing, currently relying on a deferred RCU freeing).

Anyway, I think it is possible, just not straight forward.

-- 
Catalin
