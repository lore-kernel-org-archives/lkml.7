Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53274218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfB1Pmf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:42:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53646 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbfB1Pme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:42:34 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E1BBA278659;
        Thu, 28 Feb 2019 15:42:31 +0000 (GMT)
Date:   Thu, 28 Feb 2019 16:42:28 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "liujian (CE)" <liujian56@huawei.com>
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Message-ID: <20190228164228.734ede80@collabora.com>
In-Reply-To: <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
        <016001d4cf71$865e7b60$931b7220$@gmail.com>
        <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 15:12:15 +0000
"liujian (CE)" <liujian56@huawei.com> wrote:

> > -----Original Message-----
> > From: Tokunori Ikegami [mailto:ikegami.t@gmail.com]
> > Sent: Thursday, February 28, 2019 10:26 PM
> > To: liujian (CE) <liujian56@huawei.com>; dwmw2@infradead.org;
> > computersforpeace@gmail.com; bbrezillon@kernel.org;
> > marek.vasut@gmail.com; richard@nod.at; joakim.tjernlund@infinera.com;
> > ikegami@allied-telesis.co.jp; keescook@chromium.org; vigneshr@ti.com
> > Cc: linux-mtd@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c do_write_buffer
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: linux-mtd [mailto:linux-mtd-bounces@lists.infradead.org] On
> > > Behalf Of Liu Jian
> > > Sent: Tuesday, February 26, 2019 11:01 PM
> > > To: dwmw2@infradead.org; computersforpeace@gmail.com;
> > > bbrezillon@kernel.org; marek.vasut@gmail.com; richard@nod.at;
> > > joakim.tjernlund@infinera.com; ikegami@allied-telesis.co.jp;
> > > keescook@chromium.org; vigneshr@ti.com
> > > Cc: linux-mtd@lists.infradead.org; liujian56@huawei.com;
> > > linux-kernel@vger.kernel.org
> > > Subject: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
> > > do_write_buffer
> > >
> > > In function do_write_buffer(), in the for loop, there is a case
> > > chip_ready() returns 1 while chip_good() returns 0, so it never break
> > > the loop.
> > > To fix this, chip_good() is enough and it should timeout if it stay
> > > bad for a while.
> > >
> > > Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write buffer to
> > > check correct value")
> > > Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > > Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
> > > ---
> > > v2->v3:
> > > Follow Vignesh's advice:
> > > add one more check for check_good() even when time_after() returns true.
> > >
> > >  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > index 72428b6..3da2376 100644
> > > --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > > +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > > @@ -1876,7 +1876,7 @@ static int __xipram do_write_buffer(struct
> > > map_info *map, struct flchip *chip,
> > >  			continue;
> > >  		}
> > >
> > > -		if (time_after(jiffies, timeo) && !chip_ready(map, adr))
> > > +		if (time_after(jiffies, timeo) && !chip_good(map, adr,
> > > datum))  
> > 
> >   Just another idea to understand easily.
> > 
> >     unsigned long now = jiffies;
> > 
> >     if (chip_good(map, adr, datum)) {
> >         xip_enable(map, chip, adr);
> >         goto op_done;
> >     }
> > 
> >     if (time_after(now, timeo) {
> >         break;
> >     }
> >   
> 
> Thank you~. It is more easier to understand！
> If there are no other comments, I will send new patch again ): 

Except this version no longer does what Vignesh suggested. See how you
no longer test if chip_good() is true if time_after() returns true. So,
imagine the thread entering this function is preempted just after the
first chip_good() test, and resumed a few ms later. time_after() will
return true, but chip_good() might also return true, and you ignore it.
