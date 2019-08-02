Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE4DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E8121851
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564748788;
	bh=kIIZtblZbuCqo9WjiJ5UtNU7pGxfSPAyt6llS1XpeDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rOeHZew8apUh/fQT21tlEgizSpshC9s52xrGnF/UgJD854hjF9Mc37Pg+Jz46owI/
	 +FNuM7sp6Smt3oxZlvJlu1dZ2y3LM7WSH5hlBEn8ON1MWE6/N5oc/OhbeeRj9zRgbg
	 DlJns9M+DGmCXSB7I10c0SZQIkf46YJh2wiNCH/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbfHBM00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388599AbfHBM00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:26:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0FE216C8;
        Fri,  2 Aug 2019 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564748785;
        bh=kIIZtblZbuCqo9WjiJ5UtNU7pGxfSPAyt6llS1XpeDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1i6+doQ/3AOnD2X9uXKlqS4o84ghqoa7PcKwYwDLDHYODITX9nuK5skmW84+YeBUY
         X+OnOcBA3HtRVTfvUMIQmdCA0VxUiCbWGwhxlewdEGFsp6g9WXI7KcjdG4uVWn7Tzr
         E2mU+rqr8v4Xrfrch4f+GW7oJJlFWcqm7yNG3x6U=
Date:   Fri, 2 Aug 2019 14:26:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] serial: 8250: Don't check for mctrl_gpio_init()
 returning -ENOSYS
Message-ID: <20190802122623.GA25281@kroah.com>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-4-frieder.schrempf@kontron.de>
 <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:15:55PM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 02, 2019 at 10:04:11AM +0000, Schrempf Frieder wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> > if CONFIG_GPIOLIB is disabled, we can safely remove this check.
> > 
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> @greg: This patch doesn't depend on patch 2; ditto for patch 3. So only
> taking patches 1, 3 and 4 should be fine. This way Frieder's v4 only
> have to care for patch 2. (Assuming noone objects to 1, 3 and 4 of
> course.)

Sounds good, I'll do that, thanks.

greg k-h
