Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B837C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399DD2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHJRwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 13:52:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44428 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfHJRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:52:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so67956208qtg.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 10:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66SEGc5TGIf1NyUu+jEpEXEpotUOCLnMVCZU4G+UmoQ=;
        b=N7EPlGS0oIhLxQzS9jiUUGFCu8BJE968WoFou6uedErTnVHJZoVDz4cfZVYfsZgkuF
         2efdGAWQwrwscCKAdOKaU/BQU881iD8i1ZJjankF8NuKVu8ek8mXEphD0JZ1CBLKQ4VR
         yIxfguBhFsBWIX/boq6NRhVuqt5pN8hM8Igj0rLzRrJnluRLJe7LSVrhtPjqwnt/bO9j
         9uLAfmCMWvfanXar8XSjFD+Zc0vtk+WxitgJ1bC3MCrP4tzgYUosrdqKL7ePifGzNZut
         8ziV3itVdraqfwLCjif6S7nSjKTcemjay4q546/XGBv+9bP17FXrRSabRukOejuG1TT1
         zteg==
X-Gm-Message-State: APjAAAUqrojdD2dOG0HICD6Mzi9EJujPeixAmpPQ2tIYGookuNQRk5ei
        qgCo4lqWCo23PTrwBCfMmMh/wg==
X-Google-Smtp-Source: APXvYqyu+J3eoZAKc/L0K7nzHrnvjWmGtHdW7l8r8vj9yQS0QK9zcmeYBT3jtDeUTZAm2K2OrM0azQ==
X-Received: by 2002:ac8:2fc8:: with SMTP id m8mr23627567qta.269.1565459564445;
        Sat, 10 Aug 2019 10:52:44 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id a135sm45568245qkg.72.2019.08.10.10.52.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 10:52:43 -0700 (PDT)
Date:   Sat, 10 Aug 2019 13:52:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jgg@ziepe.ca
Subject: Re: [PATCH V5 0/9] Fixes for vhost metadata acceleration
Message-ID: <20190810134948-mutt-send-email-mst@kernel.org>
References: <20190809054851.20118-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809054851.20118-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:48:42AM -0400, Jason Wang wrote:
> Hi all:
> 
> This series try to fix several issues introduced by meta data
> accelreation series. Please review.
> 
> Changes from V4:
> - switch to use spinlock synchronize MMU notifier with accessors
> 
> Changes from V3:
> - remove the unnecessary patch
> 
> Changes from V2:
> - use seqlck helper to synchronize MMU notifier with vhost worker
> 
> Changes from V1:
> - try not use RCU to syncrhonize MMU notifier with vhost worker
> - set dirty pages after no readers
> - return -EAGAIN only when we find the range is overlapped with
>   metadata
> 
> Jason Wang (9):
>   vhost: don't set uaddr for invalid address
>   vhost: validate MMU notifier registration
>   vhost: fix vhost map leak
>   vhost: reset invalidate_count in vhost_set_vring_num_addr()
>   vhost: mark dirty pages during map uninit
>   vhost: don't do synchronize_rcu() in vhost_uninit_vq_maps()
>   vhost: do not use RCU to synchronize MMU notifier with worker
>   vhost: correctly set dirty pages in MMU notifiers callback
>   vhost: do not return -EAGAIN for non blocking invalidation too early
> 
>  drivers/vhost/vhost.c | 202 +++++++++++++++++++++++++-----------------
>  drivers/vhost/vhost.h |   6 +-
>  2 files changed, 122 insertions(+), 86 deletions(-)

This generally looks more solid.

But this amounts to a significant overhaul of the code.

At this point how about we revert 7f466032dc9e5a61217f22ea34b2df932786bbfc
for this release, and then re-apply a corrected version
for the next one?


> -- 
> 2.18.1
