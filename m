Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B76BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641D92087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564672453;
	bh=abPguqKEOMLTrCcU2P2/jVixA9k9aQ63IoisxRSIwBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PgzQTE7SOrJY/6fBrzJTRv4Lz5B4FC40T3dP5GhvgpRqZfkWaBcTRyO4bwdcghMyW
	 f0KuHawkwq3eb10LhY2otsO7VephOmoloNUq4CJ+8aZweH6hwscTp6o8XdISkD3gc3
	 GDdGBR3Q3VwrAZxhntN/IhifzvSm6rMJE8kugGVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfHAPOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfHAPOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:14:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9EBE206B8;
        Thu,  1 Aug 2019 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564672451;
        bh=abPguqKEOMLTrCcU2P2/jVixA9k9aQ63IoisxRSIwBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z49Q/dNnsW4m/Vs0lHcUASw5PJAlp8W6hfuITfIg0qpsCoo61kxziMx4EKLRiS8Y+
         MzLxDr4ItWUbUotJgD6iWxhOa5FrJouUedzlKPOyoBj6bJ08i9j1APCM3tx22vGWBP
         MqFH5lmLUbfbU13MnZ/Ik45s4tAkr37DSNfI2PcU=
Date:   Thu, 1 Aug 2019 17:14:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-serial@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/23] LPUART fixes and improvements
Message-ID: <20190801151409.GA4508@kroah.com>
References: <20190731173045.11718-1-andrew.smirnov@gmail.com>
 <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BL1BO7XGNgwqZRRCeWNURemZEVzP26kVBacyw__0=RBA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 02:59:59PM -0300, Fabio Estevam wrote:
> Hi Andrey,
> 
> On Wed, Jul 31, 2019 at 2:53 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Everyone:
> >
> > This series contains fixes/improvements to LPUART dirver I came up
> > with recently as well as fixes picked up from Toradex and NXP Vybrid
> > repos.
> >
> > Feedback is welcome!
> >
> > Changes since [v1]:
> 
> Greg has already applied some of these patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/log/?h=tty-testing
> 
> Please rebase on his tree and send the remaining ones.

Yes, I can't drop patches I have already applied.  Andrey, just resend
the ones that I have not applied.

thanks,

greg k-h
