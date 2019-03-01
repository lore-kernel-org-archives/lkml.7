Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A108C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA5E20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388481AbfCARnX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:43:23 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfCARnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:43:23 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5CE33272BD9;
        Fri,  1 Mar 2019 17:43:20 +0000 (GMT)
Date:   Fri, 1 Mar 2019 18:43:17 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Tokunori Ikegami" <ikegami.t@gmail.com>
Cc:     "'Vignesh Raghavendra'" <vigneshr@ti.com>,
        "'liujian \(CE\)'" <liujian56@huawei.com>, <keescook@chromium.org>,
        <bbrezillon@kernel.org>, <ikegami@allied-telesis.co.jp>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>
Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Message-ID: <20190301184317.6bad546f@collabora.com>
In-Reply-To: <000501d4d050$38eca160$aac5e420$@gmail.com>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
        <016001d4cf71$865e7b60$931b7220$@gmail.com>
        <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
        <20190228164228.734ede80@collabora.com>
        <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
        <4b3bc01a-3632-5dde-f683-94744ee7179d@ti.com>
        <000501d4d050$38eca160$aac5e420$@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Mar 2019 01:59:41 +0900
"Tokunori Ikegami" <ikegami.t@gmail.com> wrote:

> > [...]  
> > >>>>> In function do_write_buffer(), in the for loop, there is a
> > >>>>> case chip_ready() returns 1 while chip_good() returns 0, so
> > >>>>> it never break the loop.
> > >>>>> To fix this, chip_good() is enough and it should timeout if
> > >>>>> it stay bad for a while.
> > >>>>>
> > >>>>> Fixes: dfeae1073583("mtd: cfi_cmdset_0002: Change write
> > >>>>> buffer to check correct value")
> > >>>>> Signed-off-by: Yi Huaijie <yihuaijie@huawei.com>
> > >>>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
> > >>>>> Reviewed-by: Tokunori Ikegami <ikegami_to@yahoo.co.jp>
> > >>>>> ---
> > >>>>> v2->v3:
> > >>>>> Follow Vignesh's advice:
> > >>>>> add one more check for check_good() even when time_after()
> > >>>>> returns  
> > >> true.  
> > >>>>>
> > >>>>>  drivers/mtd/chips/cfi_cmdset_0002.c | 2 +-
> > >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>>
> > >>>>> diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c
> > >>>>> b/drivers/mtd/chips/cfi_cmdset_0002.c
> > >>>>> index 72428b6..3da2376 100644
> > >>>>> --- a/drivers/mtd/chips/cfi_cmdset_0002.c
> > >>>>> +++ b/drivers/mtd/chips/cfi_cmdset_0002.c
> > >>>>> @@ -1876,7 +1876,7 @@ static int __xipram
> > >>>>> do_write_buffer(struct map_info *map, struct flchip *chip,
> > >>>>>  			continue;
> > >>>>>  		}
> > >>>>>
> > >>>>> -		if (time_after(jiffies, timeo)
> > >>>>> && !chip_ready(map, adr))
> > >>>>> +		if (time_after(jiffies, timeo)
> > >>>>> && !chip_good(map, adr, datum))  
> > >>>>
> > >>>>   Just another idea to understand easily.
> > >>>>
> > >>>>     unsigned long now = jiffies;
> > >>>>
> > >>>>     if (chip_good(map, adr, datum)) {
> > >>>>         xip_enable(map, chip, adr);
> > >>>>         goto op_done;
> > >>>>     }
> > >>>>
> > >>>>     if (time_after(now, timeo) {
> > >>>>         break;
> > >>>>     }
> > >>>>  
> > >>>
> > >>> Thank you~. It is more easier to understand！
> > >>> If there are no other comments, I will send new patch again ):  
> > >>
> > >> Except this version no longer does what Vignesh suggested. See
> > >> how you no longer test if chip_good() is true if time_after()
> > >> returns true. So, imagine the thread entering this function is
> > >> preempted just after the first chip_good() test, and resumed a
> > >> few ms later. time_after() will return true, but chip_good()
> > >> might also return true, and you ignore it.  
> > >
> > > I think that the following 3 versions will be worked for
> > > time_after()  
> > as a same result and follow the Vignesh-san suggestion.  
> > >  
> > 
> > As Boris explained above version 3 does not really follow my
> > suggestion... Please see below
> >   
> > > 1. Original Vignesh-san suggestion
> > >
> > > 	if (chip_good(map, adr, datum)) {
> > > 		xip_enable(map, chip, adr);
> > > 		goto op_done;
> > > 	}
> > >
> > > 	if (time_after(jiffies, timeo)) {
> > > 		/* Test chip_good() if TRUE incorrectly again so
> > > write  
> > failure by time_after() can be avoided. */  
> > > 		if (chip_good(map, adr, datum)) {
> > > 			xip_enable(map, chip, adr);
> > > 			goto op_done;
> > > 		}
> > > 		break;
> > > 	}
> > >  
> > 
> > 
> > Right, here we check chip_good() once _even when time_after() is
> > true_ to avoid _spurious_ timeout
> >   
> > > 2. Liujian-san v3 patch
> > >
> > > 	/* Test chip_good() if FALSE correctly so write failure
> > > by  
> > time_after() can be avoided. */  
> > > 	if (time_after(jiffies, timeo) && !chip_good(map, adr))
> > > 		break;
> > >
> > > 	if (chip_good(map, adr, datum)) {
> > > 		xip_enable(map, chip, adr);
> > > 		goto op_done;
> > > 	}
> > >  
> > 
> > This is a better version of 1
> >   
> > > 3. My idea
> > >
> > > 	/* Save current jiffies value before chip_good() to avoid
> > > write  
> > failure by time_after() without testing chip_good() again. */  
> > > 	unsigned long now = jiffies;
> > >
> > > 	if (chip_good(map, adr, datum)) {
> > > 		xip_enable(map, chip, adr);
> > > 		goto op_done;
> > > 	}
> > >  
> > 
> > What if thread gets pre-empted at this point and is re-scheduled
> > exactly after timeo jiffies have elapsed? Below check would be true
> > and exit loop  
> 
>   I think that the jiffies value now is save before chip_good() so
> below check would be false and not exit loop.

True, I overlooked that part, and so Vignesh did. This proves one
thing: code is not easier to follow with your version. IMO, if we want
to make things clear, we should add a comment to Liujian's explaining
why the extra test after time_after(jiffies, timeo) is needed.
