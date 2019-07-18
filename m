Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73232C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0F20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbfGRJhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:37:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389805AbfGRJhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:37:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so27892490wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 02:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vums2zz+KqGmXaH/Vl3B9M8z+ViEwY48CergeYbypPk=;
        b=hRO0dsLsYua+xEeK2HMtc7+l7wIv9NSQnb2uxl3mw5tr1OS2G12KVbcLS7pkkNAckq
         GCW0a0tq9Zgq1FTTS7UOMyf2uW9RXQqPvbrseieuv8Sgg8atns7Fy6bDWvhfe50UBQup
         lgBVEG9tS8hjDMwIqyfWRPMDEQCW539VchxRU+uDXcz4SQU4jepYDSw6xmkJ0PqxEekW
         1xmjdyhgCcFZXjLLk/8yCZA652gl133pNe2vut6Fia2mYkA9aJTNPX9pX7eKDn9e9poP
         tvMNhvmWu0fVUS3JMJMyX/ao6CbgzY5ACd5gsCy3glkae/beyPoQ/0ep4NIRto1Pn1jl
         bSDQ==
X-Gm-Message-State: APjAAAUG0GtAV7UvyH/COYOlK/7Vb/zn8zjvhb+b/QZB+qWF72zOxARk
        ocrjQJkWYspEZVy2FHNZNnEe0A==
X-Google-Smtp-Source: APXvYqxYCA1EVl1T2DVO3iZedENcjrNB6Hslgz4pOwp4UFAclSWI8asScK5ZYvkj/r17GyN6S1B6Kg==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr13474237wrn.165.1563442659406;
        Thu, 18 Jul 2019 02:37:39 -0700 (PDT)
Received: from steredhat ([5.171.190.136])
        by smtp.gmail.com with ESMTPSA id q18sm27647509wrw.36.2019.07.18.02.37.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 02:37:38 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:37:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
 buffers
Message-ID: <CAGxU2F6oo7Cou7t9o=gG2=wxHMKX9xYQXNxVtDYeHq5fyEhJWg@mail.gmail.com>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-5-sgarzare@redhat.com>
 <20190717105336-mutt-send-email-mst@kernel.org>
 <CAGxU2F45v40qAOHkm1Hk2E69gCS0UwVgS5NS+tDXXuzdF4EixA@mail.gmail.com>
 <20190718041234-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718041234-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:13 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Jul 18, 2019 at 09:50:14AM +0200, Stefano Garzarella wrote:
> > On Wed, Jul 17, 2019 at 4:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> > > > If the packets to sent to the guest are bigger than the buffer
> > > > available, we can split them, using multiple buffers and fixing
> > > > the length in the packet header.
> > > > This is safe since virtio-vsock supports only stream sockets.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > So how does it work right now? If an app
> > > does sendmsg with a 64K buffer and the other
> > > side publishes 4K buffers - does it just stall?
> >
> > Before this series, the 64K (or bigger) user messages was split in 4K packets
> > (fixed in the code) and queued in an internal list for the TX worker.
> >
> > After this series, we will queue up to 64K packets and then it will be split in
> > the TX worker, depending on the size of the buffers available in the
> > vring. (The idea was to allow EWMA or a configuration of the buffers size, but
> > for now we postponed it)
>
> Got it. Using workers for xmit is IMHO a bad idea btw.
> Why is it done like this?

Honestly, I don't know the exact reasons for this design, but I suppose
that the idea was to have only one worker that uses the vring, and
multiple user threads that enqueue packets in the list.
This can simplify the code and we can put the user threads to sleep if
we don't have "credit" available (this means that the receiver doesn't
have space to receive the packet).

What are the drawbacks in your opinion?


Thanks,
Stefano
