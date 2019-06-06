Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE6C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3210A2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFFC27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:28:59 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:55892 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726454AbfFFC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:28:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B0B5418224D78;
        Thu,  6 Jun 2019 02:28:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: leg41_13e178e1c213e
X-Filterd-Recvd-Size: 3093
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Jun 2019 02:28:56 +0000 (UTC)
Message-ID: <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Date:   Wed, 05 Jun 2019 19:28:53 -0700
In-Reply-To: <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
         <20190605142428.84784-5-wangkefeng.wang@huawei.com>
         <20190605144240.pfrvlgxsdpacpwxf@pali>
         <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 09:08 +0800, Kefeng Wang wrote:
> On 2019/6/5 22:42, Pali Rohár wrote:
> > On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> > > so no need to do that again from its callers. Drop it.
> > Hi! I already reviewed this patch and rejected it, see:
> > https://patchwork.kernel.org/patch/10817475/
> OK, please ignore it.

I think the stated reason of better readability isn't
particularly sensible as the object code produced is
actually slightly larger.

x86-64 defconfig (gcc 8.3.0)

$ size drivers/input/mouse/alps.o*
   text	   data	    bss	    dec	    hex	filename
  29416	     56	      0	  29472	   7320	drivers/input/mouse/alps.o.new
  29432	     56	      0	  29488	   7330	drivers/input/mouse/alps.o.old

Also if this unlikely is _really_ useful, perhaps the
!IS_ERR immediately after could also use likely as the
test seems only done for an OOM condition.

> > > Cc: "Pali Rohár" <pali.rohar@gmail.com>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >  drivers/input/mouse/alps.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > > index 0a6f7ca883e7..791ef0f826c5 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1478,7 +1478,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
> > >  		/* On V2 devices the DualPoint Stick reports bare packets */
> > >  		dev = priv->dev2;
> > >  		dev2 = psmouse->dev;
> > > -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> > > +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
> > >  		/* Register dev3 mouse if we received PS/2 packet first time */
> > >  		if (!IS_ERR(priv->dev3))
> > >  			psmouse_queue_work(psmouse, &priv->dev3_register_work,

