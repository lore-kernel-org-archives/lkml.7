Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D97C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90702084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfDIM74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:59:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:51998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbfDIM74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:59:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49F92AC31;
        Tue,  9 Apr 2019 12:59:54 +0000 (UTC)
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
To:     "Tobin C. Harding" <me@tobin.cc>, Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190402230545.2929-1-tobin@kernel.org>
 <20190402230545.2929-3-tobin@kernel.org>
 <20190403180026.GC6778@tower.DHCP.thefacebook.com>
 <20190403211354.GC23288@eros.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <63e395fc-41c5-00bf-0767-a313554f7b23@suse.cz>
Date:   Tue, 9 Apr 2019 14:59:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403211354.GC23288@eros.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/19 11:13 PM, Tobin C. Harding wrote:

> According to 0day test robot this is triggering an error from
> CHECK_DATA_CORRUPTION when the kernel is built with CONFIG_DEBUG_LIST.

FWIW, that report [1] was for commit 15c8410c67adef from next-20190401. I've
checked and it's still the v4 version, although the report came after you
submitted v5 (it wasn't testing the patches from mailing list, but mmotm). I
don't see any report for the v5 version so I'd expect it to be indeed fixed by
the new approach that adds boolean return parameter to slob_page_alloc().

Vlastimil

[1] https://lore.kernel.org/linux-mm/5ca413c6.9TM84kwWw8lLhnmK%25lkp@intel.com/T/#u

> I think this is because list_rotate_to_front() puts the list into an
> invalid state before it calls __list_add().  The thing that has me
> stumped is why this was not happening before this patch series was
> applied?  ATM I'm not able to get my test module to trigger this but I'm
> going to try a bit harder today.  If I'm right one solution is to modify
> list_rotate_to_front() to _not_ call __list_add() but do it manually,
> this solution doesn't sit well with me though.
> 
> So, summing up, I think the patch is correct in that it does the correct
> thing but I think the debugging code doesn't like it because we are
> violating typical usage - so the patch is wrong :)
> 
> thanks,
> Tobin.
> 

