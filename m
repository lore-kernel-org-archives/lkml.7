Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED14C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A712084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfCAQHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:07:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60352 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:07:20 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1397327DC83;
        Fri,  1 Mar 2019 16:07:18 +0000 (GMT)
Date:   Fri, 1 Mar 2019 17:07:15 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Tokunori Ikegami" <ikegami_to@yahoo.co.jp>
Cc:     "'liujian \(CE\)'" <liujian56@huawei.com>,
        "'Tokunori Ikegami'" <ikegami.t@gmail.com>,
        <keescook@chromium.org>, <bbrezillon@kernel.org>,
        <ikegami@allied-telesis.co.jp>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Message-ID: <20190301170715.68d89e84@collabora.com>
In-Reply-To: <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
        <016001d4cf71$865e7b60$931b7220$@gmail.com>
        <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
        <20190228164228.734ede80@collabora.com>
        <005a01d4d03e$39b0e0f0$ad12a2d0$@yahoo.co.jp>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ikegami,

On Fri, 1 Mar 2019 23:51:16 +0900
"Tokunori Ikegami" <ikegami_to@yahoo.co.jp> wrote:

> > Except this version no longer does what Vignesh suggested. See how you
> > no longer test if chip_good() is true if time_after() returns true. So,
> > imagine the thread entering this function is preempted just after the
> > first chip_good() test, and resumed a few ms later. time_after() will
> > return true, but chip_good() might also return true, and you ignore it.  
> 
> I think that the following 3 versions will be worked for time_after() as a same result and follow the Vignesh-san suggestion.

Let me show you how they are different:

> 
> 1. Original Vignesh-san suggestion
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}

--> thread preempted here
==> chip_good() test becomes valid here
--> thread resumed here, but timeout has expired

> 
> 	if (time_after(jiffies, timeo)) {

you enter this branch

> 		/* Test chip_good() if TRUE incorrectly again so write failure by time_after() can be avoided. */
> 		if (chip_good(map, adr, datum)) {

chip_good() returns true

> 			xip_enable(map, chip, adr);
> 			goto op_done;
> 		}
> 		break;
> 	}
> 
> 2. Liujian-san v3 patch
> 
> 	/* Test chip_good() if FALSE correctly so write failure by time_after() can be avoided. */

--> thread preempted here
==> chip_good() test becomes valid here
--> thread resumed here, but timeout has expired

> 	if (time_after(jiffies, timeo) && !chip_good(map, adr))

You do not enter this branch because the chip_good() test is done once
more in case of timeout.

> 		break;
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}
> 
> 3. My idea
> 
> 	/* Save current jiffies value before chip_good() to avoid write failure by time_after() without testing chip_good() again. */
> 	unsigned long now = jiffies;
> 
> 	if (chip_good(map, adr, datum)) {
> 		xip_enable(map, chip, adr);
> 		goto op_done;
> 	}
> 

--> thread preempted here
==> chip_good() test becomes valid here
--> thread resumed here, but timeout has expired

> 	if (time_after(now, timeo))

You do enter this branch, and erroneously report a failure.

> 		break;
> 

See now why your version is not correct?

Regards,

Boris
