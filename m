Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2AC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5B720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559756929;
	bh=zf2buIWn/B9J/ORNLgk273vNVVDgkWeyFwS8kkcBxvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bt+zhmKHIa8T/+Gs4SGegXmlPobg17J5E/rFsUBA51IXmvXMJ9IPRY8txy2op/fA0
	 jyL4bcYQjPGtOsIM98aY7IKTGbvaXMSydlctur1LIMfx0fa0fEw9TJbVfJpxUAKP3A
	 SFg4gP2T0BBMUQYbQz8ksKSFHuIQCqHDA+wZtuGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFERss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfFERss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:48:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2205820717;
        Wed,  5 Jun 2019 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559756926;
        bh=zf2buIWn/B9J/ORNLgk273vNVVDgkWeyFwS8kkcBxvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9af5Bnp7tVhbcE4DQcLbQ02X3rVHg/q1mtyur4H7J7ET60Gaf+73qxk2XFvC+7rO
         TP2cBjCJfnKu5qhnzSEUjRRApC51DlS3S+pJDVWmxWMjHh0WIFnqKSx7P9J+dIxX/h
         RZ8X5p0eX25T3ksXVjah8CsPCRxPAjqUjv73da5k=
Date:   Wed, 5 Jun 2019 19:48:44 +0200
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
        Joshua Frkuska <joshua_frkuska@mentor.com>,
        "George G . Davis" <george_davis@mentor.com>,
        yuichi.kusakabe@denso-ten.com, yohhei.fukui@denso-ten.com,
        natsumi.kamei@denso-ten.com, yasano@jp.adit-jv.com,
        sliu@de.adit-jv.com, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] usb: hub: report failure to enumerate uevent to userspace
Message-ID: <20190605174844.GF27700@kroah.com>
References: <20190605090556.17792-1-erosca@de.adit-jv.com>
 <20190605100337.GA9350@kroah.com>
 <20190605165530.GA15790@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605165530.GA15790@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 06:55:30PM +0200, Eugeniu Rosca wrote:
> Hi Greg,
> 
> We really appreciate your feedback.
> 
> On Wed, Jun 05, 2019 at 12:03:37PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 05, 2019 at 11:05:56AM +0200, Eugeniu Rosca wrote:
> > > From: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> > > 
> > > When a USB device fails to enumerate, only a kernel message is printed.
> > > With this patch, a uevent is also generated to notify userspace.
> > > Services can monitor for the event through udev and handle failures
> > > accordingly.
> > > 
> > > The "port_enumerate_fail_notify()" function name follows the syntax of
> > > "port_over_current_notify()" used in v4.20-rc1
> > > commit 201af55da8a398 ("usb: core: added uevent for over-current").
> > > 
> > > Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> > > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> > 
> > All we need is one special notifier!  ...
> > 
> > {grumble}
> > 
> > This can end up causing loads of new kobject change events to be added,
> > overloading what uevents were supposed to be in the first place
> > (add/remove of sysfs objects).
> 
> I guess that's the case for every other kobject_uevent*(*, KOBJ_CHANGE)
> call in the USB subsystem (in case of either HW or code misbehavior).

We only currently have 8 of those in USB:
	- over current notification (the new one added)
	- gadget driver removed
	- gadget driver unregistered (these 2 are odd...)
	- phy charger state change (like other power sources provide)
	- typec alt mode change
	- typec data role change
	- typec power role change
	- typec vconn role change
	- typec power operation change

Only the over current notification is something that is "not normal",
and was just recently added because no one could think of a better way
to do it.

But now we have a better way to do it :)

> JFTR, there are around 120 such calls in the entire v5.2-rc3 kernel.

Most of those are state changes, which is fine.  They are not error
conditions, correct?

> > I just talked with David Howells, and this type of thing really should
> > be tied into the new "notifier" interface/api.  That way you can
> > register for any specific type of event and just get notified of them
> > when they happen.  No need to mess with uevents.
> > 
> > See his posts on linux-api starting with:
> > 	Subject: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
> > for the proposal.
> > 
> > If we added USB (or really any hardware events) to that interface, would
> > it solve the issue you are trying to solve here?
> 
> I checked this patch series in linux-fs.git [3], as well as shared my
> thoughts with our security and RFS experts, and we came up with the
> following questions/remarks:
> 
>  - Looking at commit [4], it seems that the new "notifier" interface/api
>    forces userspace applications to link against -lkeyutils [5].
>    Assuming the latter is designed for ("Kernel key management") [6],
>    it may look like the keyutils library is being abused to handle
>    the "USB (or really any hardware events)". Do you really plan to
>    extend the scope of the library to handle these new tasks?

You can write notifier libraries for any subsystem, no need to link
against any other type of subsystem (i.e. if you only care about USB
ones, you will not need keyutils.)

>  - Currently, to be able to get kobject uevent notifications, our
>    applications must include "libudev.h" and must link against -ludev.
>    By using the feature implemented in [3], we would significantly
>    increase the complexity of those applications, particularly because
>    they would need to arbitrate between two different categories of
>    events received via two different APIs.

What other event do you get today that requires you to use libudev that
a notifier for USB events would not provide you?  Also, given that we
haven't written such code, we can work together to ensure that all of
the events you care about are present.

>  - It is also my assumption that the existing KOBJ_CHANGE events cannot
>    be easily converted to the new API, since this would hurt a dozen of
>    userland applications relying on them.

For USB, there is only one such odd event (as listed above).  For other
kobjects, we can work to implement state change notification as well.

> Overall, I am quite clueless how to proceed with this patch, except to
> keep it in our internal tree, most likely forever. Any
> comments/recommendations would be appreciated.

Please respond to David's patch series if you have any questions/issues
about it.  I do not want to add random new USB event notifications
through KOBJ_CHANGE until we come to a decision as to what this new
event notification framework will look like.  If it is not possible for
USB to fit into that, then I will be glad to revisit this patch.

thanks,

greg k-h
