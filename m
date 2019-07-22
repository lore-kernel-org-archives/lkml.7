Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6432C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FC2218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563796125;
	bh=eykSHfnl91fm/zvBMeCc8yWb/8vQuZ0jAGDMw66izu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mlllODcBFnOzNt4RSrmwWA/g6N0vzFTD+7XNuUnlbqJ4+rPuRZPNtH5FieFkq2tY/
	 vCwR7qIvbDwtnm/QTqBX7YDrCPsG4kkYiBADaWfddH50CrDRruYQ4UsKc5wJZcw2x2
	 Y20UB3WPgPaqBsnxTicRKqRbn7IDU9AadqzzdVuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfGVLso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbfGVLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:48:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75ACC2184E;
        Mon, 22 Jul 2019 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563796122;
        bh=eykSHfnl91fm/zvBMeCc8yWb/8vQuZ0jAGDMw66izu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uv5zT+EqBSp94cqvlDWja0OoZzX7VHMHStJ55fF9xDfUyJp5wkjCZHVt/lkYa8gbp
         1jLNgfCbnnVlmS+Lgzptnb6354tj0wiH6Vj+PazxHCANwZ9C0Oq1O6yRJQiGiUAIjC
         e4As2VJxRuv8exrTj/unnYx3ytDLRzU6kR/8yiKE=
Date:   Mon, 22 Jul 2019 13:48:39 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
Message-ID: <20190722114839.GA10515@kroah.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:58:42AM +0000, Pawel Laszczak wrote:
> Hi, 
> 
> >
> >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> >>
> >> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> >> Host Only (XHCI)configurations.
> >
> >I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI...
> >
> >Is that good idea?
> 
> Yes driver allows selecting dr_mode by debugfs. Controller also support such functionality 
> so I don't understand why would it not be a good idea. 
> 
> I personally use this for testing but it can be used to limit controller functionality without 
> recompiling kernel. 

debugfs is ONLY for debugging, never rely on it being enabled, or
mounted, on a system in order to have any normal operation happen.

So for testing, yes, this is fine.  If this is going to be the normal
api/interface for how to control this driver, no, that is not acceptable
at all.

thanks,

greg k-h
