Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46CC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA743204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698902;
	bh=R1K20MG4Jf68JuB+UlUYTiiRz0yAWnSnIvm/fuNpICY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sf08oOLJRDMTDFhbPYrT93dV+lwC57ZiHVqNBYHzYtdbnnV2iZRf02niuTQ4roXqc
	 unXgdWPDVgZ7R1c4YwGBisOR1/G+wGG/tfRgDL8kObUKM1eK+J3edApGmrqKsaDFxl
	 2AmPB27lpMLO+7brTeXp4kDBYbuQKmyK3zqhHqTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfDSSd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfDSS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF7F22229F;
        Fri, 19 Apr 2019 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555679488;
        bh=R1K20MG4Jf68JuB+UlUYTiiRz0yAWnSnIvm/fuNpICY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxRwrICmB74X81wpIOYPL+yCvuKOZoaNsr5dsnT0OQMveVsr8eh5xReygsF0mcCP5
         77PneGZbWHUMUM1RX6d16F5iuc9gS3Fh4MD018vH3fN7qS5ZI3908Ae825KtA7dF7m
         tEtv+Sl8HSm9yPsmnWak96FXsLENirVMEF8mwFNQ=
Date:   Fri, 19 Apr 2019 15:11:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Gregory Nowak <greg@gregn.net>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Hurley <peter@hurleysoftware.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        Jiri Slaby <jslaby@suse.com>,
        John Covici <covici@ccs.covici.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH v2 0/2] staging: speakup: factor out selection code
Message-ID: <20190419131126.GA23752@kroah.com>
References: <20190404194530.1170-1-okash.khawaja@gmail.com>
 <1555503674-8219-1-git-send-email-okash.khawaja@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555503674-8219-1-git-send-email-okash.khawaja@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:21:12PM +0100, Okash Khawaja wrote:
> Hi,
> 
> The v2 renames set_selection() and do_set_selection() to following 
> more explicit names:
> 
> set_selection_user() /* includes copying data from user space */
> set_selection_kernel() /* no copying from user space */
> 
> The patches also update references to set_selection() to be 
> set_selection_user().
> 
> Original intro:
> 
> Speakup's selection functionality parallels that of  
> drivers/tty/vt/selection.c. This patch set replaces speakup's
> implementation with calls to vt's selection code. This is one of the
> remaining items in our TODO file and it's needed for moving speakup out
> of staging.
> 
> Please note that in speakup selection is set inside interrupt context of
> keyboard handler. Set selection code in vt happens in process context
> and hence expects ability to sleep. To address this, there were two
> options: farm out speakup's set selection into a work_struct thread, or
> create atomic version of vt's set_selection. These patches implement
> the former option.

Very nice, both now queued up!

thanks,

greg k-h
