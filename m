Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8AAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65472208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556726612;
	bh=mnIuvBhXvxVWCM0Ol0pmBbWXdrP8m+9JSsiDpeKY73c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WmmuJh2U2ZWnnxdSwEV+M3SmSKzfDUrXSzbzaGeoUMgpJTn0c3X3pjzAPFfllXmzS
	 4FYQua6SVA+UAMvOcwOi0C9+9eq9FujMLDLSXBEU74/ngxoStXUjW5EpduGZk630Yr
	 26xoGOP16Ncgoj6ajcQppU1GlDlNTTUJ3ucMMz3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEAQDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:03:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfEAQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:03:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C9BD20644;
        Wed,  1 May 2019 16:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556726609;
        bh=mnIuvBhXvxVWCM0Ol0pmBbWXdrP8m+9JSsiDpeKY73c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLclv/xBs7sULBQxUJBEM3Rm71LyF6Vr2eP3uj2I8azsljZeE65MyWuVrOLFSGHFq
         /3f42R/PHJJAO00qE5f62GRIEGp66OzEPC938WAltr4+LPqsN1r3UUyjqsGhanh4/b
         KpGRT2VEiRXhEaQWsmo5PDnue8GAcarApCKEdUi8=
Date:   Wed, 1 May 2019 18:03:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arvid Brodin <arvid.brodin@enea.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: isp1760-hcd: Fix fall-through annotations
Message-ID: <20190501160327.GA19281@kroah.com>
References: <20190501153934.GA20025@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501153934.GA20025@embeddedor>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 10:39:34AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/usb/isp1760/isp1760-hcd.c: In function ‘collect_qtds’:
> drivers/usb/isp1760/isp1760-hcd.c:788:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>       mem_reads8(hcd->regs, qtd->payload_addr,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         qtd->data_buffer,
>         ~~~~~~~~~~~~~~~~~
>         qtd->actual_length);
>         ~~~~~~~~~~~~~~~~~~~
> drivers/usb/isp1760/isp1760-hcd.c:792:5: note: here
>      case OUT_PID:
>      ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comments are modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Notice that this code has been out there since 2011, and who
> introduced the question mark was the original developer.
> 
> It'd be good if someone can confirm that the fall-through
> has been intentional all this time.

Yes, it looks intentional.  Messy, and as no one has complained since
2011, let's leave it alone, I'll queue this up.

thanks,

greg k-h
