Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09175C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B5F2073F
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 07:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfFWHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 03:35:20 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:57991
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfFWHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 03:35:20 -0400
X-IronPort-AV: E=Sophos;i="5.63,407,1557180000"; 
   d="scan'208";a="311103180"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 09:35:18 +0200
Date:   Sun, 23 Jun 2019 09:35:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kirill Smelkov <kirr@nexedi.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 1/2] coccinelle: api/stream_open: treat all wait_.*()
 calls as blocking
In-Reply-To: <20190623072838.31234-1-kirr@nexedi.com>
Message-ID: <alpine.DEB.2.21.1906230934080.4961@hadrien>
References: <20190623072838.31234-1-kirr@nexedi.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jun 2019, Kirill Smelkov wrote:

> Previously steam_open.cocci was treating only wait_event_.* - e.g.
> wait_event_interruptible - as a blocking operation. However e.g.
> wait_for_completion_interruptible is also blocking, and so from this
> point of view it would be more logical to treat all wait_.* as a
> blocking point.
>
> The logic of this change actually came up for real when
> drivers/pci/switch/switchtec.c changed from using
> wait_event_interruptible to wait_for_completion_interruptible:
>
> 	https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
> 	https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
> 	https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
>
> For a driver that uses nonseekable_open with read/write having stream
> semantic and read also calling e.g. wait_for_completion_interruptible,
> running stream_open.cocci before this patch would produce:
>
> 	WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
>
> while after this patch it will report:
>
> 	ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.

Are you really sure that every word that starts with wait_ in the Linux
kernel has the property you want?  How many of them are there?  Would it
be reasonable to put the names in the semantic patch explicitly?

julia

>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> ---
>  scripts/coccinelle/api/stream_open.cocci | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> index 350145da7669..12ce18fa6b74 100644
> --- a/scripts/coccinelle/api/stream_open.cocci
> +++ b/scripts/coccinelle/api/stream_open.cocci
> @@ -35,11 +35,11 @@ type loff_t;
>  // a function that blocks
>  @ blocks @
>  identifier block_f;
> -identifier wait_event =~ "^wait_event_.*";
> +identifier wait =~ "^wait_.*";
>  @@
>    block_f(...) {
>      ... when exists
> -    wait_event(...)
> +    wait(...)
>      ... when exists
>    }
>
> @@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
>  // XXX currently reader_blocks supports only direct and 1-level indirect cases.
>  @ reader_blocks_direct @
>  identifier stream_reader.readstream;
> -identifier wait_event =~ "^wait_event_.*";
> +identifier wait =~ "^wait_.*";
>  @@
>    readstream(...)
>    {
>      ... when exists
> -    wait_event(...)
> +    wait(...)
>      ... when exists
>    }
>
> --
> 2.20.1
>
