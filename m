Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A21C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 20:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0746420836
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGFUuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 16:50:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59844 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfGFUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 16:50:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjrdD-0004QF-CW; Sat, 06 Jul 2019 20:50:03 +0000
Date:   Sat, 6 Jul 2019 21:50:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Mathieu Malaterre <malat@debian.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipc/sem: Three function calls less in do_semtimedop()
Message-ID: <20190706205003.GP17978@ZenIV.linux.org.uk>
References: <ba328a83-63ac-c3a3-cbc0-81059012c555@web.de>
 <3c5d5941-63bf-5576-e6eb-17ca02a6a8a3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5d5941-63bf-5576-e6eb-17ca02a6a8a3@canonical.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 09:13:46PM +0100, Colin Ian King wrote:
> On 06/07/2019 13:28, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 6 Jul 2019 14:16:24 +0200
> > 
> > Avoid three function calls by using ternary operators instead of
> > conditional statements.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  ipc/sem.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/ipc/sem.c b/ipc/sem.c
> > index 7da4504bcc7c..56ea549ac270 100644
> > --- a/ipc/sem.c
> > +++ b/ipc/sem.c
> > @@ -2122,27 +2122,18 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
> >  		int idx = array_index_nospec(sops->sem_num, sma->sem_nsems);
> >  		curr = &sma->sems[idx];
> > 
> > -		if (alter) {
> > -			if (sma->complex_count) {
> > -				list_add_tail(&queue.list,
> > -						&sma->pending_alter);
> > -			} else {
> > -
> > -				list_add_tail(&queue.list,
> > -						&curr->pending_alter);
> > -			}
> > -		} else {
> > -			list_add_tail(&queue.list, &curr->pending_const);
> > -		}
> > +		list_add_tail(&queue.list,
> > +			      alter
> > +			      ? (sma->complex_count
> > +				? &sma->pending_alter
> > +				: &curr->pending_alter)
> > +			      : &curr->pending_const);
> 
> Just no. This is making the code harder to comprehend with no advantage.
> Compilers are smart, let the do the optimization work and keep code
> simple for us mere mortals.

If anything, that would've been better off as

		int idx = array_index_nospec(sops->sem_num, sma->sem_nsems);
		struct sem *curr = &sma->sems[idx];
		struct list_head *list;	/* which queue to sleep on */

		if (!alter)
			list = &curr->pending_const;
		else if (sma->complex_count)
			list = &sma->pending_alter;
		else
			list = &curr->pending_alter;

		list_add_tail(&queue.list, list);

perhaps with better identifier than 'list'.  This kind of ?: (ab)use makes
for unreadable code and more than makes up for "hey, we are adding to some
list in all those cases" extra information passed to readers...
