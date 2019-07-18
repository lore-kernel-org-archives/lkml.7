Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D49C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460D0208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbfGRHuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:50:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35524 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:50:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so27554434wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKtb4eNPTM8gmdHfl+ucaMw83dCy0zFFLk8YD1DYgwA=;
        b=rlCPFb0wdqFIH4zrUVY6Rx2jbSAY3FdjHX1Qj6zTtVS4ug4+4YeX4pfJT9mZnJSLRf
         e2zvpjhRAWQWV+DXKzlqAdS9mmhFHvREYIfYv5qUuWnDdocIg2GU/Hb6j1d+C72vqgPt
         1fV51a9LxMnU9Fussi1JXa8JWQEP3cNg4rWmw5bInxHxvdJ2eVArZzoeJ5ur7jxVxJBD
         VdhK/iKaPREHxTJpWYbe4/9QskCE7yMqZNb8gwgKi+20n7QD5lONDmjVfCESRURq1Leq
         T7BvIdiZltHHDIzY+X/I0wD/9Re8D75l+ENdXWA7Pwn5DkPKfMcpYwO6ralUaRglJ5Ot
         0GlA==
X-Gm-Message-State: APjAAAUICQ1WNEE0u1wxNgBclB+/fHC5zpcVO1iDUO7dSUIEUTPu+jNE
        4Hdzmhh6+Qj+4uIa3JQ5nERiUkstUAQ=
X-Google-Smtp-Source: APXvYqwhtjfQPOZEcza8kvYxdthj0IlRokH67HGXPivPJMSfA2tEdGbKSTgLCbWYotwEWVmgu0HbJw==
X-Received: by 2002:adf:cf0d:: with SMTP id o13mr69099wrj.291.1563436218259;
        Thu, 18 Jul 2019 00:50:18 -0700 (PDT)
Received: from steredhat ([5.170.38.133])
        by smtp.gmail.com with ESMTPSA id b2sm33517958wrp.72.2019.07.18.00.50.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 00:50:17 -0700 (PDT)
Date:   Thu, 18 Jul 2019 09:50:14 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
 buffers
Message-ID: <CAGxU2F45v40qAOHkm1Hk2E69gCS0UwVgS5NS+tDXXuzdF4EixA@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-5-sgarzare@redhat.com>
 <20190717105336-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717105336-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> > If the packets to sent to the guest are bigger than the buffer
> > available, we can split them, using multiple buffers and fixing
> > the length in the packet header.
> > This is safe since virtio-vsock supports only stream sockets.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
> So how does it work right now? If an app
> does sendmsg with a 64K buffer and the other
> side publishes 4K buffers - does it just stall?

Before this series, the 64K (or bigger) user messages was split in 4K packets
(fixed in the code) and queued in an internal list for the TX worker.

After this series, we will queue up to 64K packets and then it will be split in
the TX worker, depending on the size of the buffers available in the
vring. (The idea was to allow EWMA or a configuration of the buffers size, but
for now we postponed it)

Note: virtio-vsock only supports stream socket for now.

Thanks,
Stefano
