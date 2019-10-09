Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A132BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D4F20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfJIPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:22:23 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42699 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbfJIPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:22:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iIDn9-0000BE-3A; Wed, 09 Oct 2019 17:22:19 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iIDn8-0004d5-10; Wed, 09 Oct 2019 17:22:18 +0200
Date:   Wed, 9 Oct 2019 17:22:18 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] recordmcount: Rewrite error/success handling
Message-ID: <20191009152217.whklst5vwrwvsjc4@pengutronix.de>
References: <cover.1564596289.git.mhelsley@vmware.com>
 <8ba8633d4afe444931f363c8d924bf9565b89a86.1564596289.git.mhelsley@vmware.com>
 <20191009104626.f3hy5dcehdfagxto@pengutronix.de>
 <20191009110538.5909fec6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191009110538.5909fec6@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:05:38AM -0400, Steven Rostedt wrote:
> On Wed, 9 Oct 2019 12:46:26 +0200
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> 
> > uwe@taurus:~/arietta/kbuild$ ./scripts/recordmcount "arch/arm/crypto/aes-cipher-glue.o"
> > arch/arm/crypto/aes-cipher-glue.o: failed
> 
> Thanks for the report.
> 
> > 
> > I didn't debug this further, if you have problems reproducing or need more
> > infos tell me. The defconfig I'm using is attached.
> > 
> 
> Does this fix it for you?
> 
> -- Steve
> 
> diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> index 3796eb37fb12..6dbec46b7703 100644
> --- a/scripts/recordmcount.h
> +++ b/scripts/recordmcount.h
> @@ -389,11 +389,8 @@ static int nop_mcount(Elf_Shdr const *const relhdr,
>  			mcountsym = get_mcountsym(sym0, relp, str0);
>  
>  		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
> -			if (make_nop) {
> +			if (make_nop)
>  				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + _w(relp->r_offset));
> -				if (ret < 0)
> -					return -1;
> -			}

Yes, this patch fixes building for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
