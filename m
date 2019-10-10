Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3287D2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJJQXZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 12:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:23:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D989B214E0;
        Thu, 10 Oct 2019 16:23:23 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:23:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] recordmcount: Rewrite error/success handling
Message-ID: <20191010122321.7329329f@gandalf.local.home>
In-Reply-To: <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
References: <cover.1564596289.git.mhelsley@vmware.com>
        <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
        <20191009104626.f3hy5dcehdfagxto@pengutronix.de>
        <20191009110538.5909fec6@gandalf.local.home>
        <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 17:22:18 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > index 3796eb37fb12..6dbec46b7703 100644
> > --- a/scripts/recordmcount.h
> > +++ b/scripts/recordmcount.h
> > @@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
> >  			mcountsym = get_mcountsym(sym0, relp, str0);
> >  
> >  		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> > -			if (make_nop) {
> > +			if (make_nop)
> >  				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
> > -				if (ret < 0)
> > -					return -1;
> > -			}  
> 
> Yes, this patch fixes building for me.

May I add to my patch:

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

?

-- Steve
