Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1CA5206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfC2Qjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:39:46 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:46559 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729740AbfC2Qjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:39:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 62513180C4C54;
        Fri, 29 Mar 2019 16:39:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: able57_54c6223b43207
X-Filterd-Recvd-Size: 1802
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 29 Mar 2019 16:39:42 +0000 (UTC)
Message-ID: <30ce0b8e3743a71870103647b352acbae2328c09.camel@perches.com>
Subject: Re: [PATCH] habanalabs: improve error messages
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 09:39:40 -0700
In-Reply-To: <20190329162955.GA10386@kroah.com>
References: <20190328071313.5306-1-oded.gabbay@gmail.com>
         <20190329162955.GA10386@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 17:29 +0100, Greg KH wrote:
> On Thu, Mar 28, 2019 at 09:13:13AM +0200, Oded Gabbay wrote:
> > This patch improves two error messages to help the user to
> > better understand what error occurred.
[]
> > diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
[]
> > @@ -109,7 +109,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
> >  							page_size);
> >  			if (!phys_pg_pack->pages[i]) {
> >  				dev_err(hdev->dev,
> > -					"ioctl failed to allocate page\n");
> > +					"Failed to allocate device memory (out of memory)\n");
> 
> No need for a message at all here, right?  The core should have already
> told you you had a problem.

I do not understand this code all that well, but I am uncertain
if all the possible pool allocation functions emit an OOM message
on failure.

Also, there is another pool allocation for the contiguous
allocation attempt that has a similar OOM in this function.


