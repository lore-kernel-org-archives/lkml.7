Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B8C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AA22084E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfDNQtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:49:15 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17236 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfDNQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:49:14 -0400
X-IronPort-AV: E=Sophos;i="5.60,350,1549926000"; 
   d="scan'208";a="378569733"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 18:49:12 +0200
Date:   Sun, 14 Apr 2019 18:49:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [11/12] ARM: OMAP2+: add missing of_node_put after
 of_device_is_available
In-Reply-To: <903ec107-46ed-f19f-56a7-c20031247503@web.de>
Message-ID: <alpine.DEB.2.21.1904141848390.2496@hadrien>
References: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr> <903ec107-46ed-f19f-56a7-c20031247503@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Apr 2019, Markus Elfring wrote:

> > @@ -250,8 +250,10 @@ static int __init omapdss_init_of(void)
> >  	if (!node)
> >  		return 0;
> >
> > -	if (!of_device_is_available(node))
> > +	if (!of_device_is_available(node)) {
> > +		of_node_put(node);
> >  		return 0;
> > +	}
> >
> >  	pdev = of_find_device_by_node(node);
>
> Is there a need to put the node also in subsequent if branches
> for complete exception handling in this function implementation?

Yes, it looks like this is indeed missing.  I will try to send a better
patch when time permits.

julia
