Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492ADC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1683D20869
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfKIXQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 18:16:30 -0500
Received: from gentwo.org ([3.19.106.255]:39124 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfKIXQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 18:16:29 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id F39EA3EC14; Sat,  9 Nov 2019 23:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id F15353E886;
        Sat,  9 Nov 2019 23:16:28 +0000 (UTC)
Date:   Sat, 9 Nov 2019 23:16:28 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Yu Zhao <yuzhao@google.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 2/2] mm: avoid slub allocation while holding
 list_lock
In-Reply-To: <20191109230147.GA75074@google.com>
Message-ID: <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
References: <20190914000743.182739-1-yuzhao@google.com> <20191108193958.205102-1-yuzhao@google.com> <20191108193958.205102-2-yuzhao@google.com> <alpine.DEB.2.21.1911092024560.9034@www.lameter.com> <20191109230147.GA75074@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2019, Yu Zhao wrote:

> >  	struct page *page, *h;
> > +	unsigned long *map = bitmap_alloc(oo_objects(s->max), GFP_KERNEL);
> > +
> > +	if (!map)
> > +		return;
>
> What would happen if we are trying to allocate from the slab that is
> being shut down? And shouldn't the allocation be conditional (i.e.,
> only when CONFIG_SLUB_DEBUG=y)?

Kmalloc slabs are never shut down.

The allocation does not hurt and CONFIG_SLUB_DEBUG is on in most
configurations.


