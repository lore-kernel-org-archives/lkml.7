Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D13C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB0220872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfFEQzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:55:46 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:53358 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfFEQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:55:45 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id EFE583C00DD;
        Wed,  5 Jun 2019 18:55:42 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4PIzeykYxjEW; Wed,  5 Jun 2019 18:55:34 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 4C9EC3C00D1;
        Wed,  5 Jun 2019 18:55:34 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 5 Jun 2019
 18:55:34 +0200
Date:   Wed, 5 Jun 2019 18:55:30 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     David Howells <dhowells@redhat.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
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
        <yuichi.kusakabe@denso-ten.com>, <yohhei.fukui@denso-ten.com>,
        <natsumi.kamei@denso-ten.com>, <yasano@jp.adit-jv.com>,
        <sliu@de.adit-jv.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: hub: report failure to enumerate uevent to userspace
Message-ID: <20190605165530.GA15790@vmlxhi-102.adit-jv.com>
References: <20190605090556.17792-1-erosca@de.adit-jv.com>
 <20190605100337.GA9350@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190605100337.GA9350@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

We really appreciate your feedback.

On Wed, Jun 05, 2019 at 12:03:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 05, 2019 at 11:05:56AM +0200, Eugeniu Rosca wrote:
> > From: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> > 
> > When a USB device fails to enumerate, only a kernel message is printed.
> > With this patch, a uevent is also generated to notify userspace.
> > Services can monitor for the event through udev and handle failures
> > accordingly.
> > 
> > The "port_enumerate_fail_notify()" function name follows the syntax of
> > "port_over_current_notify()" used in v4.20-rc1
> > commit 201af55da8a398 ("usb: core: added uevent for over-current").
> > 
> > Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> All we need is one special notifier!  ...
> 
> {grumble}
> 
> This can end up causing loads of new kobject change events to be added,
> overloading what uevents were supposed to be in the first place
> (add/remove of sysfs objects).

I guess that's the case for every other kobject_uevent*(*, KOBJ_CHANGE)
call in the USB subsystem (in case of either HW or code misbehavior).
JFTR, there are around 120 such calls in the entire v5.2-rc3 kernel.

> 
> I just talked with David Howells, and this type of thing really should
> be tied into the new "notifier" interface/api.  That way you can
> register for any specific type of event and just get notified of them
> when they happen.  No need to mess with uevents.
> 
> See his posts on linux-api starting with:
> 	Subject: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
> for the proposal.
> 
> If we added USB (or really any hardware events) to that interface, would
> it solve the issue you are trying to solve here?

I checked this patch series in linux-fs.git [3], as well as shared my
thoughts with our security and RFS experts, and we came up with the
following questions/remarks:

 - Looking at commit [4], it seems that the new "notifier" interface/api
   forces userspace applications to link against -lkeyutils [5].
   Assuming the latter is designed for ("Kernel key management") [6],
   it may look like the keyutils library is being abused to handle
   the "USB (or really any hardware events)". Do you really plan to
   extend the scope of the library to handle these new tasks?

 - Currently, to be able to get kobject uevent notifications, our
   applications must include "libudev.h" and must link against -ludev.
   By using the feature implemented in [3], we would significantly
   increase the complexity of those applications, particularly because
   they would need to arbitrate between two different categories of
   events received via two different APIs.

 - It is also my assumption that the existing KOBJ_CHANGE events cannot
   be easily converted to the new API, since this would hurt a dozen of
   userland applications relying on them.

Overall, I am quite clueless how to proceed with this patch, except to
keep it in our internal tree, most likely forever. Any
comments/recommendations would be appreciated.

> 
> thanks,
> 
> greg k-h

[1] linux (v5.2-rc3) git grep KOBJ_CHANGE -- drivers/usb/
drivers/usb/core/hub.c:	kobject_uevent_env(&hub_dev->kobj, KOBJ_CHANGE, envp);
drivers/usb/gadget/udc/core.c:	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
drivers/usb/gadget/udc/core.c:	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
drivers/usb/phy/phy.c:	kobject_uevent_env(&usb_phy->dev->kobj, KOBJ_CHANGE, envp);
drivers/usb/typec/class.c:	kobject_uevent(&adev->dev.kobj, KOBJ_CHANGE);
drivers/usb/typec/class.c:	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
drivers/usb/typec/class.c:	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
drivers/usb/typec/class.c:	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
drivers/usb/typec/class.c:	kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);

[2] git grep -w KOBJ_CHANGE -- ":\!Documentation" ":\!include" | wc -l
122

[3] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications
[4] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=16a8aad951990
[5] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git
[6] https://lwn.net/Articles/210502/ ("Kernel key management")

-- 
Best Regards,
Eugeniu.
