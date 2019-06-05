Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202CBC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E941E2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B72Gaciq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFEIfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:35:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45062 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFEIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:35:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so13315745qtr.12;
        Wed, 05 Jun 2019 01:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HG+CIt6o8yGGbLnlsmSij7gPt1dv9dO42aZ62jE5d9w=;
        b=B72Gaciqkdjdtm7MB2ws3CYsjdDuK9zAYhageiUCfgwWkx3FDHWDckjRAYQNE5sJbN
         K7A3eISAk79YAociLc0xKRWyJcrOnP/rH5Ift4b1Dvu8XoqPUMKGZTwH7/N2cfed3kHZ
         SwMw9WEKlGX1ILrop25xS0cnh3KEkA98TuvwDR3BCkUAYWekfR6cZX0KwemzZlV+JJHy
         I3LPazBAbAnbvyIYINzZZEXmGEqoBs13Z+jdD+5ys5AhMY+ZvOCMkt3ZNKZzip5wRLwm
         DNv1IyCYGshCBAYdW/+YOYPPcDq00Q/NTsnK6bHHme+zHAuxKQVPjYdjz731ttzM/wTx
         HXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HG+CIt6o8yGGbLnlsmSij7gPt1dv9dO42aZ62jE5d9w=;
        b=nGfMyQ69i9/A5XOOoiixNx0VJL9U1Ud6sp6Y20F84FOWt+zoqt2g5JfaQ6R2CV2wFc
         L2bYkMIDeYjxf6qASddhpTxESWPhlZyE/6kRmS4EE1fXbdep2Jd5M8Nj2vFpQM6MOvYA
         HvY0j1VxMcoWozgKBwxK8uxbxR/P88f5fFSFqyQynj7grkSuO4zuMJ0RAc7AHBmjjQlv
         TrbdAne1kEo/1huKHojqfn+cFkbMXO8yCjG/5F+LitNoLb1D/J+5n68PwAQG8Y4SqY6a
         ubNmunXxjgUccLq8Ozfqgeu74svTSZmznDy9tIK1X5rmW/2yeb5VQ+1WmmkSUZJcpxi/
         OjtA==
X-Gm-Message-State: APjAAAVL1xinoLFHPn6NSqGfSmFlHSWuVkkfXj79aibevD7t6iR/A6uI
        kJ20uyZ+iyUBzk2gKOVRUM8WzJ+B6wbrUe5xgEM=
X-Google-Smtp-Source: APXvYqxR8YkP6kHq8kFTJ1Do5N/qhuvAcp4wrlpJiebKCCoRjCKpI9qQ0dP+ENUM2f/ksjfFr19uRhOSE5i/Upx+Izg=
X-Received: by 2002:ac8:3d51:: with SMTP id u17mr10223327qtf.53.1559723711675;
 Wed, 05 Jun 2019 01:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190605043452.GI22737@tuxbook-pro> <2d60dd1e-f7a0-ea63-9fda-0ea97aab0406@st.com>
In-Reply-To: <2d60dd1e-f7a0-ea63-9fda-0ea97aab0406@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 5 Jun 2019 16:35:00 +0800
Message-ID: <CAH2Cfb-sv3SAL8bcczC-Dc3_r58MYZCS7s7zGtn1Qfo3mmBqVg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben Cohen <ohad@wizery.com>, wendy.liang@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 3:33 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>
> Hi Bjorn,
>
> On 6/5/19 6:34 AM, Bjorn Andersson wrote:
> > On Thu 31 Jan 07:41 PST 2019, Xiang Xiao wrote:
> >
> >> Hi,
> >> This series enhance the buffer allocation by:
> >> 1.Support the different buffer number in rx/tx direction
> >> 2.Get the individual rx/tx buffer size from config space
> >>
> >> Here is the related OpenAMP change:
> >> https://github.com/OpenAMP/open-amp/pull/155
> >>
> >
> > This looks pretty reasonable, but can you confirm that it's possible to
> > use new firmware with an old Linux kernel when introducing this?
> >
> >
> > But ever since we discussed Loic's similar proposal earlier I've been
> > questioning if the fixed buffer size isn't just an artifact of how we
> > preallocate our buffers. The virtqueue seems to support arbitrary sizes
> > of buffers and I see that the receive function in OpenAMP has been fixed
> > to put back the buffer of the size that was received, rather than 512
> > bytes. So it seems like Linux would be able to send whatever size
> > messages to OpenAMP it would handle it.
> >
> > The question is if we could do the same in the other direction, perhaps
> > by letting the OpenAMP side do it's message allocation when it's
> > sending, rather than Linux pushing inbufs to be filled by the remote.
>
> IMHO, both could be useful and could be not correlated.
> On-the fly buffer allocation seems more efficient but needs an
> allocator.This can be a generic allocator (with a va to da) for system
> where large amount of memories are accessible from both side.
>
> Now what about system with small shared memory? In this case you have to
> deal with a limited/optimized memory chunk. To avoid memory
> fragmentation the allocator should have a pre-reserved buffers pool(so
> similar to existing implementation). This serie seems useful to optimize
> the size of the pre-reserved pool.
>

Maybe we can reuse rxbuf_size/txbuf_size to trigger the different
allocation policy:
1.If buf_size equal 0xfffffff, turn on the dynamic allocator
2.If buf_size equall 0, turn on the fixed allocator with the default buffer size
3.otherwise, turn on the fixed allocator with the configed buffer size
So, both requirement could be satisfied without breaking the compatibility.

> >
> > This would remove the problem of always having suboptimal buffer sizes.
> >
> > Regards,
> > Bjorn
> >
> >> Xiang Xiao (3):
> >>   rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
> >>   rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer separately
> >>   rpmsg: virtio_rpmsg_bus: get buffer size from config space
> >>
> >>  drivers/rpmsg/virtio_rpmsg_bus.c  | 127 +++++++++++++++++++++++---------------
> >>  include/uapi/linux/virtio_rpmsg.h |  24 +++++++
> >>  2 files changed, 100 insertions(+), 51 deletions(-)
> >>  create mode 100644 include/uapi/linux/virtio_rpmsg.h
> >>
> >> --
> >> 2.7.4
> >>
>
> --
>
> Regards,
> Arnaud
