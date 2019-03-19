Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56112064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfCSQbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:31:48 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:37448 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSQbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:31:48 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2JGVLNb025570;
        Tue, 19 Mar 2019 16:31:22 GMT
Date:   Tue, 19 Mar 2019 16:31:21 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Chris Brannon <chris@the-brannons.com>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190319163121.5e7ab8c7@alans-desktop>
In-Reply-To: <20190316093543.w4i6djt5uuqtx5xr@function>
References: <20190315130035.6a8f16e9@narunkot>
        <87ef77obtg.fsf@cmbmachine.messageid.invalid>
        <20190316093543.w4i6djt5uuqtx5xr@function>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 10:35:43 +0100
Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> Chris Brannon, le ven. 15 mars 2019 18:19:39 -0700, a ecrit:
> > Okash Khawaja <okash.khawaja@gmail.com> writes:  
> > > Finally there is an issue where text in output buffer sometimes gets
> > > garbled on SMP systems, but we can continue working on it after the
> > > driver is moved out of staging, if that's okay. Basically we need a
> > > reproducer of this issue.  
> > 
> > What kind of reproducer do you need here?  It's straightforward to
> > reproduce in casual use, at least with a software synthesizer.  
> 
> The problem is that neither Okash nor I are even casual users of
> speakup, so we need a walk-through of the kind of operation that
> produces the issue. It does not have to be reproducible each time it is
> done. Perhaps (I really don't know what that bug is about actually) it
> is a matter of putting text in the selection buffer, and try to paste it
> 100 times, and once every 10 times it will be garbled, for instance.

paste_selection still says

/* Insert the contents of the selection buffer into the
 * queue of the tty associated with the current console.
 * Invoked by ioctl().
 *
 * Locking: called without locks. Calls the ldisc wrongly with
 * unsafe methods,
 */

from which I deduce that with everyone using X nobody ever bothered to
fix it. So before you look too hard at the speakup code you might want to
review the interaction with selection.c too.

Alan
