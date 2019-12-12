Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2E122527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwT+sfs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfLLMge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:36:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34346 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729157AbfLLMgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576154192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vx9zJGf1oMGJUZXazsjSWnZ1RqAwmrURKhXjqCuTSZw=;
        b=VwT+sfs6UceNQj6e0jUDJOOVFePrIBpY0J7pFkFSwQF0wqWDva1QC5RsRQXih68NzL8h0+
        D/Av0mxnaj/QjULrTUuxAQquRStA7uWTwYn1vnyoiivrHZsjzrnup9VEKq7HeDTN8Aex7h
        gzSW0BmSkTRxW9tjO6RljmvqFYC4i3k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Y82IbFA7MtmGEKQyT3bhjA-1; Thu, 12 Dec 2019 07:36:29 -0500
X-MC-Unique: Y82IbFA7MtmGEKQyT3bhjA-1
Received: by mail-wr1-f71.google.com with SMTP id 90so974271wrq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vx9zJGf1oMGJUZXazsjSWnZ1RqAwmrURKhXjqCuTSZw=;
        b=DmclpJCX7n6GXVn8gOoLT4xsV6BFPJOv6TtWUOHLCTH0uNd2Rx62/iZqlyaJBsdH7V
         Sm7KXhV/lxRk+lYbyQ/uIs/Xvs8vgkVAmjee51ROIvTpEe4E1PN6NsWF6UosyNupD0ZS
         +u3bwfsw0NQa0GBzjt6TAQiwINm/xv/GafJz3aUKgHKfEMUEDQDd9wraeb2jKy6phNuW
         VQYuuc7YWNYZHzhcik9PCWkNuXyX+aypT73EJsYPxw2IsC6a6hhPW6RXLubPnLJiiAxP
         DRGIJu07llXzPk2CzFeoJCJADq8v8fv3CUxygM302Hr4WNPHdKysSgLMCRnB93UGhLEW
         XJpQ==
X-Gm-Message-State: APjAAAWM8NQ7Q1OF705/0fIBuRZVHl5q+Kan5xiEbWqqpCLhNtOs4MDf
        dCn0H2cPT9sc+LeHOneTFoN90zTGG/EONCdiWigQVaTVFifboHWWUTuuuQlp/h2kyDW0m/aMKrj
        Sd7+lFlQ0t8TPSyWJLh1wKLrN
X-Received: by 2002:a1c:9893:: with SMTP id a141mr6328749wme.131.1576154187818;
        Thu, 12 Dec 2019 04:36:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8OuvK7uQUGPj2YPMKShfitWnCo2iXv2VXIudtkzMfeAvfFAzJUBd43fFj7MHbtZkQxZXP5g==
X-Received: by 2002:a1c:9893:: with SMTP id a141mr6328729wme.131.1576154187582;
        Thu, 12 Dec 2019 04:36:27 -0800 (PST)
Received: from steredhat ([95.235.120.92])
        by smtp.gmail.com with ESMTPSA id x10sm5861395wrp.58.2019.12.12.04.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 04:36:27 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:36:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <20191212123624.ahyhrny7u6ntn3xt@steredhat>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191211110235-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211110235-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:03:07AM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > When we receive a new packet from the guest, we check if the
> > src_cid is correct, but we forgot to check the dst_cid.
> > 
> > The host should accept only packets where dst_cid is
> > equal to the host CID.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Stefano can you clarify the impact pls?

Sure, I'm sorry I didn't do it earlier.

> E.g. is this needed on stable? Etc.

This is a better analysis (I hope) when there is a malformed guest
that sends a packet with a wrong dst_cid:
- before v5.4 we supported only one transport at runtime, so the sockets
  in the host can only receive packets from guests. In this case, if
  the dst_cid is wrong, maybe the only issue is that the getsockname()
  returns an inconsistent address (the cid returned is the one received
  from the guest)

- from v5.4 we support multi-transport, so the L1 VM (e.g. L0 assigned
  cid 5 to this VM) can have both Guest2Host and Host2Guest transports.
  In this case, we have these possible issues:
  - L2 (or L1) guest can use cid 0, 1, and 2 to reach L1 (or L0),
    instead we should allow only CID_HOST (2) to reach the level below.
    Note: this happens also with not malformed guest that runs Linux v5.4

  - if a malformed L2 guest sends a packet with the wrong dst_cid, for example
    instead of CID_HOST, it uses the cid assigned by L0 to L1 (5 in this
    example), this packets can wrongly queued to a socket on L1 bound to cid 5,
    that only expects connections from L0.

Maybe we really need this only on stable v5.4, but the patch is very simple
and should apply cleanly to all stable branches.

What do you think?

Thanks,
Stefano

