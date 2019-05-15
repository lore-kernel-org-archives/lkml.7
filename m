Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF32C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF2B20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEOQU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:20:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E137985A03;
        Wed, 15 May 2019 16:20:57 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54516608B9;
        Wed, 15 May 2019 16:20:55 +0000 (UTC)
Date:   Wed, 15 May 2019 12:20:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     dm-devel@redhat.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>
Subject: Re: dm ioctl: fix hang in early create error condition
Message-ID: <20190515162054.GA14934@redhat.com>
References: <20190513192530.1167-1-helen.koike@collabora.com>
 <20190514013716.GA10260@lobo>
 <78dda04b-925f-49eb-f88a-6d940bcc4754@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78dda04b-925f-49eb-f88a-6d940bcc4754@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 15 May 2019 16:20:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15 2019 at 12:12pm -0400,
Helen Koike <helen.koike@collabora.com> wrote:

> Hi,
> 
> On 5/13/19 10:37 PM, Mike Snitzer wrote:
> > On Mon, May 13 2019 at  3:25P -0400,
> > Helen Koike <helen.koike@collabora.com> wrote:
> > 
> >> The dm_early_create() function (which deals with "dm-mod.create=" kernel
> >> command line option) calls dm_hash_insert() who gets an extra reference
> >> to the md object.
> >>
> >> In case of failure, this reference wasn't being released, causing
> >> dm_destroy() to hang, thus hanging the whole boot process.
> >>
> >> Fix this by calling __hash_remove() in the error path.
> >>
> >> Fixes: 6bbc923dfcf57d ("dm: add support to directly boot to a mapped device")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>
> >> ---
> >> Hi,
> >>
> >> I tested this patch by adding a new test case in the following test
> >> script:
> >>
> >> https://gitlab.collabora.com/koike/dm-cmdline-test/commit/d2d7a0ee4a49931cdb59f08a837b516c2d5d743d
> >>
> >> This test was failing, but with this patch it works correctly.
> >>
> >> Thanks
> >> Helen
> > 
> > Thanks for the patch but I'd prefer the following simpler fix.  What do
> > you think?
> > 
> > That said, I can provide a follow-on patch (inspired by the patch you
> > provided) that encourages more code sharing between dm_early_create()
> > and dev_create() by factoring out __dev_create().
> 
> Sounds great.
> 
> > 
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index c740153b4e52..0eb0b462c736 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -2117,6 +2117,7 @@ int __init dm_early_create(struct dm_ioctl *dmi,
> >  err_destroy_table:
> >  	dm_table_destroy(t);
> >  err_destroy_dm:
> > +	(void) __hash_remove(__find_device_hash_cell(dmi));
> >  	dm_put(md);
> >  	dm_destroy(md);
> >  	return r;
> > 
> 
> This doesn't really work for two reasons:
> 
> 1) __find_device_hash_cell() requires a mutual exclusivity between name,
> uuid and dev. In dm_early_create(), dmi can have more then one of these.

__find_device_hash_cell's exclusivity requirements are strange; I'll try
to understand what requires this.

> 2) I can fix (1) by calling __get_name_cell(), as the name is mandatory
> anyway, but this function also grabs another reference to the md object,
> so I need to add an extra dm_put(md) there:
> 
>  err_destroy_table:
>         dm_table_destroy(t);
> +err_hash_remove:
> +       (void) __hash_remove(__get_name_cell(dmi->name));
> +       dm_put(md);
>  err_destroy_dm:
>         dm_put(md);
>         dm_destroy(md);
> 
> 
> What do you think? Is this ok?

I think so.  Please submit a v2 and I'll rebase my followon patch
accordingly and will get it posted.

Thanks,
Mike
