Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B82085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfCSOa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:30:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfCSOa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC0B0307EA87;
        Tue, 19 Mar 2019 14:30:27 +0000 (UTC)
Received: from ovpn-112-62.rdu2.redhat.com (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44E942854C;
        Tue, 19 Mar 2019 14:30:26 +0000 (UTC)
Message-ID: <6c89938b00ad289e1802f675bd00e288b1458d73.camel@redhat.com>
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
From:   Dan Williams <dcbw@redhat.com>
To:     Johan Hovold <johan@kernel.org>,
        =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc:     =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:30:25 -0500
In-Reply-To: <20190319124358.GK6124@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
         <20190227083342.GJ4747@localhost> <yw1xpnrdv3z7.fsf@mansr.com>
         <20190227131315.GO4747@localhost> <yw1xlg21uwrp.fsf@mansr.com>
         <20190319102840.GI6124@localhost> <yw1xd0mn16ev.fsf@mansr.com>
         <20190319110819.GB3178@localhost> <yw1x8sxb125q.fsf@mansr.com>
         <20190319122719.GC3178@localhost> <20190319124358.GK6124@localhost>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 19 Mar 2019 14:30:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 13:43 +0100, Johan Hovold wrote:
> On Tue, Mar 19, 2019 at 01:27:19PM +0100, Johan Hovold wrote:
> > On Tue, Mar 19, 2019 at 12:25:53PM +0000, Måns Rullgård wrote:
> > > Johan Hovold <johan@kernel.org> writes:
> > > 
> > > > On Tue, Mar 19, 2019 at 10:54:00AM +0000, Måns Rullgård wrote:
> > > > > Johan Hovold <johan@kernel.org> writes:
> > > > > > > Regardless, setting the NCTRL flag should be harmless.
> > > > > > 
> > > > > > Well, there are devices that depend on getting these
> > > > > > requests, at least
> > > > > > for the QMI interface. But we can always revert if anyone
> > > > > > complains.
> > > > > 
> > > > > The QMI interface doesn't even pretend to be a uart.  The
> > > > > other ones do,
> > > > > but there isn't actually any real uart behind them.  For
> > > > > instance, it
> > > > > doesn't matter what baud rate one sets.
> > > > 
> > > > Sure, but some devices still require "DTR" to be set for the
> > > > QMI
> > > > interface, so there not being any real uart is no guarantee
> > > > that there
> > > > is no firmware that expects these calls.
> > > 
> > > Now I'm thoroughly confused.  The QMI interface has a completely
> > > separate driver that creates a network device (if I'm reading the
> > > code
> > > correctly).
> > 
> > I was just giving an example of firmware sometimes doing unexpected
> > things.
> 
> See 93725149794d ("net: qmi_wwan: MDM9x30 specific power management")
> for some background.

TLDR; some firmware uses the DTR signal as an indicator to come out of
low-power mode. Without doing so you cannot talk to the modem over any
of it's ports, QMI, net, or serial.

Dan

