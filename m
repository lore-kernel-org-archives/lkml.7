Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2DAC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 19:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E63206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgAATX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 14:23:26 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64649
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727170AbgAATX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 14:23:26 -0500
X-IronPort-AV: E=Sophos;i="5.69,384,1571695200"; 
   d="scan'208";a="334543739"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 20:23:24 +0100
Date:   Wed, 1 Jan 2020 20:23:24 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Takashi Iwai <tiwai@suse.de>
cc:     Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] ALSA: ml403-ac97cr: use resource_size
In-Reply-To: <s5hmub72dh3.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2001012022380.3262@hadrien>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr> <1577900990-8588-3-git-send-email-Julia.Lawall@inria.fr> <s5hmub72dh3.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2020, Takashi Iwai wrote:

> On Wed, 01 Jan 2020 18:49:42 +0100,
> Julia Lawall wrote:
> >
> > Use resource_size rather than a verbose computation on
> > the end and start fields.
> >
> > The semantic patch that makes this change is as follows:
> > (http://coccinelle.lip6.fr/)
> >
> > <smpl>
> > @@ struct resource *ptr; @@
> > - ((ptr->end) - (ptr->start) + 1)
> > + resource_size(ptr)
> > </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> Unfortunately this doesn't apply cleanly on my tree.  I guess you
> worked on linux-next which contains a change outside the sound git
> tree that converts ioremap_nocache() to ioremap().
>
> We may apply it in sound git tree and let conflicts resolved at the
> merge time.  OTOH, it's no urgent fix at all and can be postponed
> after 5.6-rc1 merge, too -- then everything can be applied in a
> cleaner way.
>
> Let me know your preference.

It's from linux-next.  No hurry.  Postponing it is fine.

thanks,
julia
