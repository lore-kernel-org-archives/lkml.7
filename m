Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF414C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39B6206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfKQPqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:46:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51339 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726069AbfKQPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:46:20 -0500
Received: (qmail 8613 invoked by uid 500); 17 Nov 2019 10:46:19 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Nov 2019 10:46:19 -0500
Date:   Sun, 17 Nov 2019 10:46:19 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Ikjoon Jang <ikjn@chromium.org>
cc:     linux-usb@vger.kernel.org, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>
Subject: Re: [PATCH 0/2] usb: override hub device bInterval with device node
In-Reply-To: <20191117033149.259303-1-ikjn@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1911171043060.7716-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019, Ikjoon Jang wrote:

> This patchset enables hard wired hub device to use different bInterval
> from its descriptor when the hub has a combined device node.
> 
> When we know the specific hard wired hub supports changing its polling
> interval, we can adjust hub's interval to reduce the time of waking up
> from autosuspend or connect detection of HIDs.

In fact, _all_ hubs support changing the polling interval.  The value 
given in the USB spec is just an upper limit; any smaller value is 
equally acceptable.

So why are you doing this only for hard-wired hubs?  Why not for all 
hubs?

And is 250 ms really too long to wait for remote wakeup or connect 
detection?  What's the real motivation behind this change?

Alan Stern

