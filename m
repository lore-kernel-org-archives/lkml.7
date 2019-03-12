Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560EF214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfCLJSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:18:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfCLJSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:18:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EEF3AC8A;
        Tue, 12 Mar 2019 09:18:11 +0000 (UTC)
Date:   Tue, 12 Mar 2019 10:18:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: kmsg_dump: Mark registered flag as private
Message-ID: <20190312091810.gm6q7ao6u2lpsnqh@pathway.suse.cz>
References: <20190310200302.GA11096@darwi-home-pc>
 <20190311124905.GA416@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311124905.GA416@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-11 21:49:05, Sergey Senozhatsky wrote:
> On (03/10/19 21:03), Ahmed S. Darwish wrote:
> > The 'registered' flag is internally used by kmsg_dump_register()
> > and kmsg_dump_unregister() to track multiple registrations of the
> > same dumper.
> > 
> > It's protected by printk's internal dump_list_lock, and must thus
> > be accessed only from there. Mark it as private.
> > 
> > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > ---
> >  include/linux/kmsg_dump.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> > index 2e7a1e032c71..7c08cb58259a 100644
> > --- a/include/linux/kmsg_dump.h
> > +++ b/include/linux/kmsg_dump.h
> > @@ -36,7 +36,7 @@ enum kmsg_dump_reason {
> >   * @dump:	Call into dumping code which will retrieve the data with
> >   * 		through the record iterator
> >   * @max_reason:	filter for highest reason number that should be dumped
> > - * @registered:	Flag that specifies if this is already registered
> > + * @registered:	Flag that specifies if this is already registered (private)
> >   */
> >  struct kmsg_dumper {
> >  	struct list_head list;
> 
> 
> Do we really do this thing?

Good question.

> $ git grep "(private)" include/linux/
> include/linux/kmsg_dump.h: * @list:     Entry in the dumper list (private)

This is another field in the same structure. There are 4 other fields
that are described as private by extra comment. Thefore this patch
might make it more consistent.

Well, I am not sure if it is worth it. Andrew?

> include/linux/uwb.h: * specific (private) DevAddr (UWB_RSV_TARGET_DEVADDR).

Best Regards,
Petr
