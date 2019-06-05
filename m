Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A522C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0C20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559729021;
	bh=DZ0Ukqzk/PtCUYtEt5E60AbhRwkMO2p2nJdi/gL5qyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zCHRTv4M69ppTKLxrC4nPubsR2237qdBymXDKQVxDfQ2hP/S9wkEHilXk8aSx7YpN
	 bx2C7AasuReMoL5quw06rGcy6Qdiz39QsIQvnSAhw2KdvxdvdIXD2sU47A097tMgZz
	 J7ZX9KsC1/+HiFUx4DWyJ8t1P1XAqdYf3LLbsuas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfFEKDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfFEKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:03:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B70C4206B8;
        Wed,  5 Jun 2019 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559729019;
        bh=DZ0Ukqzk/PtCUYtEt5E60AbhRwkMO2p2nJdi/gL5qyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwtRstst/Wwsr3Uyq+uM3EesHwq3Yz4mQE5nc0kzZ4kVbLeOOvNfukcxh5c48vAte
         4+ItiIhv5M2VQACAb/95rwCg+Vuqj0fcyfvlVxP1nazYisiT7eGv2wx51aDkcD27a2
         ymDCoaYdP7bueKLRUOYni0tLUGekqTmZjTChEN9g=
Date:   Wed, 5 Jun 2019 12:03:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     David Howells <dhowells@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Kento Kobayashi <Kento.A.Kobayashi@sony.com>,
        Hui Peng <benquike@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jan-Marek Glogowski <glogow@fbihome.de>,
        Bin Liu <b-liu@ti.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jon Flatley <jflat@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        "George G . Davis" <george_davis@mentor.com>,
        yuichi.kusakabe@denso-ten.com, yohhei.fukui@denso-ten.com,
        natsumi.kamei@denso-ten.com, yasano@jp.adit-jv.com
Subject: Re: [PATCH] usb: hub: report failure to enumerate uevent to userspace
Message-ID: <20190605100337.GA9350@kroah.com>
References: <20190605090556.17792-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605090556.17792-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 11:05:56AM +0200, Eugeniu Rosca wrote:
> From: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> 
> When a USB device fails to enumerate, only a kernel message is printed.
> With this patch, a uevent is also generated to notify userspace.
> Services can monitor for the event through udev and handle failures
> accordingly.
> 
> The "port_enumerate_fail_notify()" function name follows the syntax of
> "port_over_current_notify()" used in v4.20-rc1
> commit 201af55da8a398 ("usb: core: added uevent for over-current").
> 
> Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

All we need is one special notifier!  ...

{grumble}

This can end up causing loads of new kobject change events to be added,
overloading what uevents were supposed to be in the first place
(add/remove of sysfs objects).

I just talked with David Howells, and this type of thing really should
be tied into the new "notifier" interface/api.  That way you can
register for any specific type of event and just get notified of them
when they happen.  No need to mess with uevents.

See his posts on linux-api starting with:
	Subject: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
for the proposal.

If we added USB (or really any hardware events) to that interface, would
it solve the issue you are trying to solve here?

thanks,

greg k-h
