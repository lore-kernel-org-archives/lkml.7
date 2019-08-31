Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF92CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F58422DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfHaPs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbfHaPs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:48:59 -0400
Received: from oasis.local.home (rrcs-24-39-165-138.nys.biz.rr.com [24.39.165.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7134F22D37;
        Sat, 31 Aug 2019 15:48:58 +0000 (UTC)
Date:   Sat, 31 Aug 2019 11:48:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah.kh@samsung.com>
Subject: Re: [PATCH] tracing: silence noisy warnings about struct inode
Message-ID: <20190831114856.26b0a1d7@oasis.local.home>
In-Reply-To: <20190831114633.0ea3a8ca@oasis.local.home>
References: <27a4b48e-9a63-d04e-64a1-081c1f6cab36@infradead.org>
        <20190831114633.0ea3a8ca@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 11:46:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Aug 2019 14:34:18 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix 30 warnings for missing "struct inode" declaration (like these) by
> > adding a forward reference for it.
> > These warnings come from 'headers_check' (CONFIG_HEADERS_CHECK):
> >   CC      include/trace/events/iomap.h.s
> > 
> > ./../include/trace/events/iomap.h:49:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration
> > ./../include/trace/events/iomap.h:77:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>  

Hmm, I don't have this in my tree (I Cc'd Shuah, because I mistaken it as iommu.h.

Please send this to the appropriate maintainer that added this file.

-- Steve

> 
> Thanks!
> 
> -- Steve
> 
> > ---
> >  include/trace/events/iomap.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- linux-next-20190829.orig/include/trace/events/iomap.h
> > +++ linux-next-20190829/include/trace/events/iomap.h
> > @@ -44,6 +44,8 @@ DECLARE_EVENT_CLASS(iomap_page_class,
> >  		  __entry->length)
> >  )
> >  
> > +struct inode;
> > +
> >  #define DEFINE_PAGE_EVENT(name)		\
> >  DEFINE_EVENT(iomap_page_class, name,	\
> >  	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \  
> 

