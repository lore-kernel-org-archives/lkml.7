Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81646C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F692064B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554848736;
	bh=SJ7MH/AZUnwSEcYkX82jSA4na1KIVv/G3Zs7Gt/AmdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=A1rNM8/ZSeFAEjISOjIdSMygE7vWum2H7+FMgFYhYnShjBCuWo5R89OQrVP6gwLdK
	 JI6AjhC4fSJlnrv7bqriKLM9uaZ3mXZNNyZYgc3FH8es9r3mOplAJaRnVHmhGQADgV
	 xA+qV09XMGXctaHtz0ZJ6D/8ZeguWpgCYPpFjWT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDIWZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:25:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfDIWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:25:34 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3E3F1073;
        Tue,  9 Apr 2019 22:25:33 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:25:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
Message-Id: <20190409152532.7f3a8168de2ec49aec152bd6@linux-foundation.org>
In-Reply-To: <20190409200649.GD19840@eros.localdomain>
References: <20190402230545.2929-1-tobin@kernel.org>
        <20190402230545.2929-3-tobin@kernel.org>
        <20190403180026.GC6778@tower.DHCP.thefacebook.com>
        <20190403211354.GC23288@eros.localdomain>
        <63e395fc-41c5-00bf-0767-a313554f7b23@suse.cz>
        <20190409200649.GD19840@eros.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 06:06:49 +1000 "Tobin C. Harding" <me@tobin.cc> wrote:

> On Tue, Apr 09, 2019 at 02:59:52PM +0200, Vlastimil Babka wrote:
> > On 4/3/19 11:13 PM, Tobin C. Harding wrote:
> > 
> > > According to 0day test robot this is triggering an error from
> > > CHECK_DATA_CORRUPTION when the kernel is built with CONFIG_DEBUG_LIST.
> > 
> > FWIW, that report [1] was for commit 15c8410c67adef from next-20190401. I've
> > checked and it's still the v4 version, although the report came after you
> > submitted v5 (it wasn't testing the patches from mailing list, but mmotm). I
> > don't see any report for the v5 version so I'd expect it to be indeed fixed by
> > the new approach that adds boolean return parameter to slob_page_alloc().
> > 
> > Vlastimil
> 
> Oh man thanks!  That is super cool, thanks for letting me know
> Vlastimil.

Yes, thanks for the followup.
