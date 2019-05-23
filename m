Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB83C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730B3206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyB5smpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfEWOsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 10:48:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfEWOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 10:48:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so6576356wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 07:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ckXbhMxVptMY6LVeqIsAfsudm6ALnBUEQ58+S9KXj0=;
        b=fyB5smpXxQ9KIxobbDS0TRfpJeXoeZWx06EKZqy1KuSTst6qLOanF1sHYWgCHFAFIq
         xIMk6rHIda9kxLH1MgsK5762Ye7n7Q4p/wLlelf46E5M5B4Zk7PqdyYy9Ku/yeo8Cxbl
         vqeU6msoM9GJ7T8xYGsRZLDHXoMoqUeykdQjoD0RMe7wjL5meZsEO4k3hu+daQiQYj66
         5nKa8c0XwZorE1pCZ+42S6lZo6W1FDtfkd3hTKDos6yww7SF8fhlHC/nWbvbqRP9wsQb
         jL7cw1WAoQYnE+ZBQnWDTmf5uEC63a8WRie1e614QCWAiXnHv/4eUeRmogmddPiotw9o
         Kedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ckXbhMxVptMY6LVeqIsAfsudm6ALnBUEQ58+S9KXj0=;
        b=VmtJFO0ENjo1fq0oBtmnYNr4ieyMwQTl+Y+5oAaUBtBosStXl2o82Kz2Ce2qaCdS1K
         59AoWdbYBgmQJ+fNDPden4WekQgZ7E3n1ih9eoNLVzjKfwvAyvXZuef8yJjcC4hurwh7
         K27MXgjr2WscnBzJal0fRohrYjLJXN6ZAqLnEiEWdhOkYXTWwpzAGjXtt1zl/LXCazUO
         Iw+HqnoSuo87F5pr2aqGOrGuKOh+qimT0SFduZhEvLIwXALyTUHf6Xg6PedMZ0+wtgmK
         SmXIRMcClAZrpRdd6nbf8f/h3KjmXBqHFNONmUt+yxehlPcbdib3eGu22i/aOMQb9+va
         e3KA==
X-Gm-Message-State: APjAAAUt+trcjcFGVnifUXIaH+ylofA3Tud5uTVyJyfqw3GktRBn3JZg
        wuiWLz2EN11hXysj/Vv1k/qzkH/YvmgMBmiwVNA=
X-Google-Smtp-Source: APXvYqzJaa74jk0r/RYkks9NQS+a3OOWeFm+UyuWzIklKLTRV3IuVue8Qa5l6wrV/GBiRXApv/glEAm4BNsMi7Js+CU=
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr1385664wrp.67.1558622900872;
 Thu, 23 May 2019 07:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190423102512.72265-1-benbjiang@tencent.com>
In-Reply-To: <20190423102512.72265-1-benbjiang@tencent.com>
From:   Stefan Hajnoczi <stefanha@gmail.com>
Date:   Thu, 23 May 2019 15:48:07 +0100
Message-ID: <CAJSP0QXwRESqPjV6HJEffY-t8z7LC5ZZQeKsqinap4yWy_T3dg@mail.gmail.com>
Subject: Re: [PATCH] virtio/virtio_ring: do some comment fixes
To:     Jiang Biao <benbjiang@tencent.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 5:17 PM Jiang Biao <benbjiang@tencent.com> wrote:
>
> There are lots of mismatches between comments and codes, this
> patch do these comment fixes.
>
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  drivers/virtio/virtio_ring.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
