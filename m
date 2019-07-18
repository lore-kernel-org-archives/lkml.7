Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1605C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D30208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfGRHww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:52:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35852 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfGRHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:52:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so27585630wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rq+59r0RojlnTnigSljktyDPpoq1gf7r9wfF77O5XwQ=;
        b=YlJIvFdK9RTzavLgKitSLvx0MPcv4INNmhWl0fLeGaFgw2dAhRImSVpgs7gnqKdJiv
         FL4YHSnGiDeKlQ4EveDW8uAxRHKXLIghwXCe2kmBOR+yM+2cn9jdLRlAbRrThwxsM9Rg
         8NlSin/0tylm9yYoXDpZYtoYzBhd/hBHuWEiVY2yhTTcR/4sDcu3iE0RbGan7okVB/C1
         2s/l+lxdVviru/H4psOV/EVEmuToKTJOqJvnT0+R0q8Cq9Vi82y9dRLckE5xKDaLobRG
         t/yu0ayca9NAmC0P5CxGcFujGMGEzv7Jsbve8hQu4tJYleFHGjskievIyYCvM9MUstVD
         RR+Q==
X-Gm-Message-State: APjAAAVzcYd1VRdHa+wC9BUbLTvC3b275mKji3CDLy47QLAW1m1+tKje
        G5U2JwUwIldNt9Ae50qP5PbLnQ==
X-Google-Smtp-Source: APXvYqyhGa0Qg+pWCOm2tSbKxPMpCW9SMZnBKSICCaQYntmM+FchtqJbWROJ8PfSDyCUWGkgpEQWRw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr50042800wrm.235.1563436370235;
        Thu, 18 Jul 2019 00:52:50 -0700 (PDT)
Received: from steredhat ([5.170.38.133])
        by smtp.gmail.com with ESMTPSA id 91sm54324185wrp.3.2019.07.18.00.52.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 00:52:49 -0700 (PDT)
Date:   Thu, 18 Jul 2019 09:52:41 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <CAGxU2F5ybg1_8VhS=COMnxSKC4AcW4ZagYwNMi==d6-rNPgzsg@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-6-sgarzare@redhat.com>
 <20190717105703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717105703-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 5:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 01:30:30PM +0200, Stefano Garzarella wrote:
> > Since now we are able to split packets, we can avoid limiting
> > their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
> > Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
> > packet size.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
> OK so this is kind of like GSO where we are passing
> 64K packets to the vsock and then split at the
> low level.

Exactly, something like that in the Host->Guest path, instead in the
Guest->Host we use the entire 64K packet.

Thanks,
Stefano
