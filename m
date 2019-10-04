Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FC2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F6B222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfJDH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:59:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725932AbfJDH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:59:41 -0400
X-UUID: 144424648c3244ed8d0c6c7f5cadc265-20191004
X-UUID: 144424648c3244ed8d0c6c7f5cadc265-20191004
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1001643015; Fri, 04 Oct 2019 15:59:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Oct 2019 15:59:33 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 4 Oct 2019 15:59:33 +0800
Message-ID: <1570175974.23700.0.camel@mtkswgap22>
Subject: Re: [PATCH] mm/page_owner: fix incorrect looping in
 __set_page_owner_handle()
From:   Miles Chen <miles.chen@mediatek.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Michal Hocko <mhocko@suse.com>
Date:   Fri, 4 Oct 2019 15:59:34 +0800
In-Reply-To: <f5027e93-7cf3-3a90-f1f8-b829ea4b75b9@suse.cz>
References: <20191004073755.3228-1-miles.chen@mediatek.com>
         <f5027e93-7cf3-3a90-f1f8-b829ea4b75b9@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 09:57 +0200, Vlastimil Babka wrote:
> On 10/4/19 9:37 AM, Miles Chen wrote:
> > In __set_page_owner_handle(), we should loop over page
> > [0...(1 << order) - 1] and setup their page_owner structures.
> > 
> > Currently, __set_page_owner_handle() update page_ext at the end of
> > the loop, sets the page_owner of (page + 0) twice and
> > misses the page_owner of (page + (1 << order) - 1).
> > 
> > Fix it by updating the page_ext at the start of the loop.
> > 
> > In i == 0 case:
> > for (i = 0; i < (1 << order); i++) {
> > 	page_owner = get_page_owner(page_ext); <- page_ext belongs to page + 0
> > 	...
> > 	page_ext = lookup_page_ext(page + i); <- lookup_page_ext(page + 0)
> > }
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > Fixes: 7e2f2a0cd17c ("mm, page_owner: record page owner for each subpage")
> 
> Thanks. Kirill spotted it earlier and there's a fix pending:
> https://lore.kernel.org/linux-mm/20190930122916.14969-2-vbabka@suse.cz/

Great. thanks for the information.


Miles
> 
> > ---
> >  mm/page_owner.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_owner.c b/mm/page_owner.c
> > index dee931184788..110c3e1987f2 100644
> > --- a/mm/page_owner.c
> > +++ b/mm/page_owner.c
> > @@ -178,6 +178,7 @@ static inline void __set_page_owner_handle(struct page *page,
> >  	int i;
> >  
> >  	for (i = 0; i < (1 << order); i++) {
> > +		page_ext = lookup_page_ext(page + i);
> >  		page_owner = get_page_owner(page_ext);
> >  		page_owner->handle = handle;
> >  		page_owner->order = order;
> > @@ -185,8 +186,6 @@ static inline void __set_page_owner_handle(struct page *page,
> >  		page_owner->last_migrate_reason = -1;
> >  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
> >  		__set_bit(PAGE_EXT_OWNER_ACTIVE, &page_ext->flags);
> > -
> > -		page_ext = lookup_page_ext(page + i);
> >  	}
> >  }
> >  
> > 
> 


