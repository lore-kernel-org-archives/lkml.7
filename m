Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29803C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2F0208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554180093;
	bh=haWLIS9MQn3ltFCj+gBOx5qF7RvqrkMkIA67FwI1jWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bJDuvPQo3nknytau2hnxkNX9G/7fi4qIRgdPAQ/NPYwMxp/D+R3nwucczyeMrC382
	 e3cpU08fHght2p4VtNC+upDm02U6KuhRuMwcz+ddm/8labe7U2AuQQJDV7Tmv/gtrx
	 DSNOkmOfm5Ud/24JxntIcyB+l49krlB94BADaKYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfDBElb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:41:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBElb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:41:31 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4A47CAF;
        Tue,  2 Apr 2019 04:41:29 +0000 (UTC)
Date:   Mon, 1 Apr 2019 21:41:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     LKP <lkp@01.org>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] slob: Only use list functions when safe to do so
Message-Id: <20190401214128.c671d1126b14745a43937969@linux-foundation.org>
In-Reply-To: <20190402032957.26249-2-tobin@kernel.org>
References: <20190402032957.26249-1-tobin@kernel.org>
        <20190402032957.26249-2-tobin@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 14:29:57 +1100 "Tobin C. Harding" <tobin@kernel.org> wrote:

> Currently we call (indirectly) list_del() then we manually try to combat
> the fact that the list may be in an undefined state by getting 'prev'
> and 'next' pointers in a somewhat contrived manner.  It is hard to
> verify that this works for all initial states of the list.  Clearly the
> author (me) got it wrong the first time because the 0day kernel testing
> robot managed to crash the kernel thanks to this code.
> 
> All this is done in order to do an optimisation aimed at preventing
> fragmentation at the start of a slab.  We can just skip this
> optimisation any time the list is put into an undefined state since this
> only occurs when an allocation completely fills the slab and in this
> case the optimisation is unnecessary since we have not fragmented the slab
> by this allocation.
> 
> Change the page pointer passed to slob_alloc_page() to be a double
> pointer so that we can set it to NULL to indicate that the page was
> removed from the list.  Skip the optimisation if the page was removed.
> 
> Found thanks to the kernel test robot, email subject:
> 
> 	340d3d6178 ("mm/slob.c: respect list_head abstraction layer"):  kernel BUG at lib/list_debug.c:31!
> 

It's regrettable that this fixes
slob-respect-list_head-abstraction-layer.patch but doesn't apply to
that patch - slob-use-slab_list-instead-of-lru.patch gets in the way. 
So we end up with a patch series which introduces a bug and later
fixes it.

I guess we can live with that but if the need comes to respin this
series, please do simply fix
slob-respect-list_head-abstraction-layer.patch so we get a clean
series.

