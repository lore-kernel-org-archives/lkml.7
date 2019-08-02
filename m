Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F43C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D47205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HudlbV72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbfHBHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:41:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44942 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfHBHll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:41:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so35643404pgl.11;
        Fri, 02 Aug 2019 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Bu5B09gqik8ty3n7lRXyWL5jRpSFheUe4BaXX6kR88=;
        b=HudlbV72c1Gey+g3bBwqwEVVs4x1lqg2LR9EPalQ4SZ5gFrC6j0xxl7qCBYKedapAz
         43ryaJrLKtLRNsrWKkTvuHRQ+OXrABbw0+VXgE6WN0Ou2g46OCg+G1x4wPpMf8wozXZB
         G8SknMGnszFXKJx6ItQ6fL+OsXQNkr5QL21kEqy1R2ZiJ6OOD8zoKH/uDJxcOwdBelkM
         o2PU5yuUIr+seNy+RfLQ1469jmpN3T7vJT2lWrdyBJiGyNYTBoVuUGIolb9BSRatAPEp
         3qoWuZWaQth7ubMHtRgKpACQgOTDHOmEaX93uqRLJSlAA+LT1dZxJQzwe8Q+35wBKNkU
         xAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Bu5B09gqik8ty3n7lRXyWL5jRpSFheUe4BaXX6kR88=;
        b=BkPH456ORQxcHhbUKS98XlicgcTsVsr2Tu1UQ+Jk3PRqMVXtoa4ixOF/PmugGsm73Z
         IDDPzuRrMTl66AjjwQCCHKRoB/Eaw/Tj41qV1RPXu1rmBn5ZY2bGhK8lFhR6PvStS0IO
         zWKNOZ7pQhdXTA71KNE0GnXb3TUazVI654021/dcKsn9bdyCvh5WSfk1LquOPrMinNOO
         N+gzrSUxAuOM7M8j9Mb5D5DBKGOma1eUwOQyKEVFavt42eMlX8PimSJhb0zguddXcOxB
         KE0iTinGCq8yVXJ+jd5iZK0Sc6iWVXiT1mF+qRQGon7PEOuVaHMTfWeh0G8Mcvut6cR4
         WKcg==
X-Gm-Message-State: APjAAAWruHocLb6ZVPmEwa/UliykbFo1lnX4UdLIHhqJRF0iUedgBBuk
        AB8DkKBImhX/dWoT+fQMpkdbzIYE
X-Google-Smtp-Source: APXvYqxZS7gNBvSYXD8UCDRGi8CGSQYsynxcTeR3RF2QJOBArAKJlfgjIiTBQGhzjWPYQ/SdfonQdQ==
X-Received: by 2002:a62:ac11:: with SMTP id v17mr58294776pfe.236.1564731701156;
        Fri, 02 Aug 2019 00:41:41 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.gmail.com with ESMTPSA id x7sm10070265pga.0.2019.08.02.00.41.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:41:40 -0700 (PDT)
Date:   Fri, 2 Aug 2019 16:41:36 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usbip: Implement SG support to vhci
Message-ID: <20190802074136.GA19534@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <20190705164355.14025-3-suwan.kim027@gmail.com>
 <7c697904-53e3-b469-c907-25b8fb7859bc@kernel.org>
 <20190729145241.GA4557@localhost.localdomain>
 <787051b9-579d-6da5-9d04-3dd0ae3c770b@kernel.org>
 <20190801063859.GA9587@localhost.localdomain>
 <e581b566-65fb-c4d8-74fc-1c1b35b57b9f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e581b566-65fb-c4d8-74fc-1c1b35b57b9f@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:03:59AM -0600, shuah wrote:
> On 8/1/19 12:38 AM, Suwan Kim wrote:
> > On Mon, Jul 29, 2019 at 10:32:31AM -0600, shuah wrote:
> > > On 7/29/19 8:52 AM, Suwan Kim wrote:
> > > > Hi Shuah,
> > > > 
> > > > On Tue, Jul 23, 2019 at 06:21:53PM -0600, shuah wrote:
> > > > > Hi Suwan,
> > > > > 
> > > > > On 7/5/19 10:43 AM, Suwan Kim wrote:
> > > > > > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > > > > > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > > > > > into multiple URBs and it causes error that a transfer got terminated
> > > > > > too early because the transfer length for one of the URBs was not
> > > > > > divisible by the maxpacket size.
> > > > > > 
> > > > > > In this patch, vhci basically support SG and it sends each SG list
> > > > > > entry to the stub driver. Then, the stub driver sees the total length
> > > > > > of the buffer and allocates SG table and pages according to the total
> > > > > > buffer length calling sgl_alloc(). After the stub driver receives
> > > > > > completed URB, it again sends each SG list entry to vhci.
> > > > > > 
> > > > > > If HCD of the server doesn't support SG, the stub driver breaks a
> > > > > > single SG reqeust into several URBs and submit them to the server's
> > > > > > HCD. When all the split URBs are completed, the stub driver
> > > > > > reassembles the URBs into a single return command and sends it to
> > > > > > vhci.
> > > > > > 
> > > > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > > > ---
> > > > > >     drivers/usb/usbip/stub.h         |   7 +-
> > > > > >     drivers/usb/usbip/stub_main.c    |  52 +++++---
> > > > > >     drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
> > > > > >     drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
> > > > > >     drivers/usb/usbip/usbip_common.c |  60 +++++++-- >   drivers/usb/usbip/vhci_hcd.c     |  10 +-
> > > > > >     drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> > > > > >     7 files changed, 372 insertions(+), 121 deletions(-)
> > > > > 
> > > > > While you are working on v3 to fix chekpatch and other issues
> > > > > I pointed out, I have more for you.
> > > > > 
> > > > > What happens when you have mismatched server and client side?
> > > > > i.e stub does and vhci doesn't and vice versa.
> > > > > 
> > > > > Make sure to run checkpatch. Also check spelling errors in
> > > > > comments and your commit log.
> > > > > 
> > > > > I am not sure if your eeror paths are correct. Run usbip_test.sh
> > > > > 
> > > > > tools/testing/selftests/drivers/usb/usbip
> > > > 
> > > > I don't know what mismatch you mentioned. Are you saying
> > > > "match busid table" at the end of usbip_test.sh?
> > > > How does it relate to SG support of this patch?
> > > > Could you tell me more about the problem situation?
> > > > 
> > > 
> > > What happens when usbip_host is running a kernel without the sg
> > > support and vhci_hcd does? Just make sure this works with the
> > > checks for sg support status as a one of your tests for this
> > > sg feature.
> > 
> > Now I understand. Thanks for the details!
> > As a result of testing, in the situation where vhci supports SG,
> > but stub does not, or vice versa, usbip works normally. Moreover,
> > because there is no protocol modification, there is no problem in
> > communication between server and client even if the one has a kernel
> > without SG support.
> > 
> > In the case of vhci supports SG and stub doesn't, because vhci sends
> > only the total length of the buffer to stub as it did before the
> > patch applied, stub only needs to allocate the required length of
> > buffers regardless of whether vhci supports SG or not.
> > 
> > If stub needs to send data buffer to vhci because of IN pipe, stub
> > also sends only total length of buffer as metadata and then send real
> > data as vhci does. Then vhci receive data from stub and store it to
> > the corresponding buffer of SG list entry.
> > 
> > In the case of stub that supports SG, if SG buffer is requested by
> > vhci, buffer is allocated by sgl_alloc(). However, stub that does
> > not support SG allocates buffer using only kmalloc(). Therefore, if
> > vhci supports SG and stub doesn't, stub has to allocate buffer with
> > kmalloc() as much as the total length of SG buffer which is quite
> > huge when vhci sends SG request, so it has big overhead in buffer
> > allocation.
> > 
> > And for the case of stub supports SG and vhci doesn't, since the
> > USB storage driver checks that vhci doesn't support SG and sends
> > the request to stub by splitting the SG list into multiple URBs,
> > stub allocates a buffer with kmalloc() as it did before this patch.
> > 
> > Therefore, everything works normally in a mismatch situation.
> 
> Looking for you add a test case for that. Please include this
> in the commit log.

I'm confused about the test case. Do I add the test case for each
SG support status of vhci_hcd and usbip_host in usbip_test.sh?
Or, do I implement the test logic in vhci_hcd code that asks if
usbip_host supports SG when attaching a remote device?
I'm sorry but I don't know what exactly you want to add.

Regards
Suwan Kim
