Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6642C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB41233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbfHVNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:37:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60710 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387577AbfHVNhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:37:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9B54ADCB;
        Thu, 22 Aug 2019 13:37:13 +0000 (UTC)
Message-ID: <1566481032.8347.44.camel@suse.com>
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
From:   Oliver Neukum <oneukum@suse.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 22 Aug 2019 15:37:12 +0200
In-Reply-To: <D6E31CB0-BC2B-4B52-AF18-4BE990D3FDA5@canonical.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
         <1566467151.8347.23.camel@suse.com>
         <AD8A4135-0275-45B3-BEB9-031737A2C756@canonical.com>
         <1566470325.8347.35.camel@suse.com>
         <D6E31CB0-BC2B-4B52-AF18-4BE990D3FDA5@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 22.08.2019, 21:23 +0800 schrieb Kai-Heng Feng:
> at 18:38, Oliver Neukum <oneukum@suse.com> wrote:
> > Well, sort of. The USB spec merely states how to enter and exit
> > a suspended state and that device state must not be lost.
> > It does not tell you what a suspended device must be able to do.
> 
> But shouldn’t remote wakeup signaling wakes the device up and let it exit  
> suspend state?

Yes. Have you tested using a button? If they indeed do not work, then
the device lies about supporting remote wakeup. That would warrant a
quirk, but for remote wakeup.

> Or it’s okay to let the device be suspended when remote wakeup is needed  
> but broken?

Again, the HID spec does not specify what should trigger a remote
wakeup. Limiting this to mouse buttons but not movements is
inconvinient, but not buggy.

This is indeed what Windows does. The device is suspended when the
screen saver switches on. That we do not do that is a deficiency
of X.
To use runtime PM regularly you need an .ini file


> > In other words, if on your system it is on, you need to look
> > at udev, not the kernel.
> 
> So if a device is broken when “power/control” is flipped by user, we should  
> deal it at userspace? That doesn’t sound right to me.

If it is broken, as in crashing we could talk about it. If it merely
does not do what you want, then, yes, that is for user space to deal
with.

> > Well, no. Runtime PM is a trade off. You lose something if you use
> > it. If it worked just as well as full power, you would never use
> > full power, would you?
> 
> I am not asking the suspended state to work as full power, but to prevent a  
> device enters suspend state because of broken remote wakeup.

What then would be the difference between suspended and active? A small
delay in data transfer?

> > Whether the loss of functionality or performance is worth the energy
> > savings is a policy decision. Hence it belongs into udev.
> > Ideally the kernel would tell user space what will work in a
> > suspended state. Unfortunately HID does not provide support for that.
> 
> I really don’t think “loss of functionally” belongs to policy decision. But  
> that’s just my opinion.

That is just what we do if, for example, you choose between the configs
of a USB device or when you use authorization.

> Maybe just calling usb_autopm_put_interface() in usbhid_close() to balance  
> the refcount?

No, the refcount is good. If remote wakeup is totally broken, you need
to introduce a quirk that will prevent the kernel from believing the
device when it claims to support it.

	Regards
		Oliver

