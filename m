Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45161C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1903F2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565021105;
	bh=FqPsMxXFAXq13j2rnYkg+520lazJ5+jVziVCLNt2XHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i6dscUi7BQxpAbzKCTN3O/V6kMgIjWZCvSkPr+PuJuBXkrcqaBd4djSagBoutPq/u
	 oPxd77PDDzHV7ByW7N+3kN/XCHP/c3LYJh+J3Zc/BJnbFR4XALOLV/IqfN4axXUcll
	 ECJgc6+iOKV8ZEmTezVr4PHXwGiYvnvB8gBxhb2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfHEQFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 12:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHEQFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF742064A;
        Mon,  5 Aug 2019 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565021102;
        bh=FqPsMxXFAXq13j2rnYkg+520lazJ5+jVziVCLNt2XHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f20/yiyzyf1lpxwMavwiopzjT0OadO53cbAWLd6SsC5LgZwi9xq4SXHq38ahbKtZI
         V+meA/OYSKyHbI0NcDa6znVWyQsM4ND1dSLSvazwOIsYJEynFQZBP2NjIAunS0h4mu
         UQXL0cybrILCvJqTAIGSzwOxWpk1a398wESP+4CI=
Date:   Mon, 5 Aug 2019 18:05:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 28/57] pcie-gadget-spear: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190805160500.GA29507@kroah.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-29-swboyd@chromium.org>
 <CAK8P3a3Zi=GMvV3=QYBDza4--CV9J_-qNCTBXthCm__-b52Beg@mail.gmail.com>
 <5d41a2b7.1c69fb81.c8d56.edb6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d41a2b7.1c69fb81.c8d56.edb6@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 07:16:22AM -0700, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2019-07-30 11:29:45)
> > On Tue, Jul 30, 2019 at 8:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > We don't need dev_err() messages when platform_get_irq() fails now that
> > > platform_get_irq() prints an error message itself when something goes
> > > wrong. Let's remove these prints with a simple semantic patch.
> > 
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >
> > > Please apply directly to subsystem trees
> > 
> > The patch looks coorrect
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > I wonder if we should just remove that driver though, it's been marked
> > as 'depends on BROKEN' since 2013, and it has never been possible
> > to compile it.
> 
> I'm happy to replace this patch with a deletion patch.
> 
> -----8<-----
> From: Stephen Boyd <swboyd@chromium.org>
> Subject: [PATCH] misc: Remove spear13xx pcie gadget driver
> 
> This driver has been marked broken since 2013, see commit 98097858ccf3
> ("misc: mark spear13xx-pcie-gadget as broken"). Let's remove this file
> now that it's been more than 5 years of existing in a broken state.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Good idea, I've now queued up this deletion patch instead, thanks!

greg k-h
