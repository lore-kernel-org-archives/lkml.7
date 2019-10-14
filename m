Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481BECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5078E20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfJNIim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfJNIil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:38:41 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EAE6C0568FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:38:41 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o188so6835273wmo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zgV9pC+zt0gI/V422zTkhHPL1PoCXjjbpPu+KeAB0w0=;
        b=oXn4BbJRhYEeUuWd0snXJhOlXwwk80OAR0sPcfaxqWTwC4CljRQhGcSzQWRhQ9Uzdr
         wnUD0DdsVIato0nw3bsFNNQtREOXKXZ36NhrwCto8N270ilnLc0n7F1tOJECu1lMIKmp
         nWfVTunvRxdW59g2Cc6pY3MB8zwZy1qYLzocGs9PgNWGHgkX4y7WudjwPGSfVquSabx7
         fiDeHMW9E6TeJaNJSB8a11FvCyYfPFwPqWhEoen6UiS9M0tnY0uLjzxSfmLEhv0/DucC
         Lv/MItavoTmLBedSgRP20KSYKjCnu9nvivY9EPLjZ7ca20LNyCHs9X/vd7nsW713Y9GY
         7fEg==
X-Gm-Message-State: APjAAAWmiCpuHzPrAWHJWhchGcnsu2wrHrcsMcxvknhc+CQ2F+kPPjVA
        /1bWGqNB3Ty9ej0EdJlkcPBAAjO1zfKS+Ut4G3j+O87zGZQigTLROr5MzZXNTsIMhsNwLo0iXsm
        9oaL/jZs6E3rCYyEXYzZo38qw
X-Received: by 2002:a1c:3284:: with SMTP id y126mr14533750wmy.164.1571042320318;
        Mon, 14 Oct 2019 01:38:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7BekhhYUaPdPVvYSoK18HhJqtlF38AkAYk8aK0SjlT68meT4y2oI/uOqPx7iwjAspulu58A==
X-Received: by 2002:a1c:3284:: with SMTP id y126mr14533736wmy.164.1571042320048;
        Mon, 14 Oct 2019 01:38:40 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id x5sm22881456wrt.75.2019.10.14.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 01:38:39 -0700 (PDT)
Date:   Mon, 14 Oct 2019 10:38:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        kvm <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Message-ID: <20191014083836.fumqbp4sfn5usys6@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-2-sgarzare@redhat.com>
 <20190729095956-mutt-send-email-mst@kernel.org>
 <20190830094059.c7qo5cxrp2nkrncd@steredhat>
 <20190901024525-mutt-send-email-mst@kernel.org>
 <CAGxU2F7fA5UtkuMQbOHHy0noOGZUtpepBNKFg5afD81bynMVUQ@mail.gmail.com>
 <20191014081724.GD22963@stefanha-x1.localdomain>
 <2398c960-b6d7-8af3-fa25-d75344335db7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2398c960-b6d7-8af3-fa25-d75344335db7@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 04:21:35PM +0800, Jason Wang wrote:
> On 2019/10/14 下午4:17, Stefan Hajnoczi wrote:
> > SO_VM_SOCKETS_BUFFER_SIZE might have been useful for VMCI-specific
> > applications, but we should use SO_RCVBUF and SO_SNDBUF for portable
> > applications in the future.  Those socket options also work with other
> > address families.
> > 

I think hyperv_transport started to use it in this patch:
ac383f58f3c9  hv_sock: perf: Allow the socket buffer size options to influence
              the actual socket buffers


> > I guess these sockopts are bypassed by AF_VSOCK because it doesn't use
> > the common skb queuing code in net/core/sock.c:(.  But one day we might
> > migrate to it...
> > 
> > Stefan
> 
> 
> +1, we should really consider to reuse the exist socket mechanism instead of
> re-inventing wheels.

+1, I totally agree. I'll go this way.

Guys, thank you all for your suggestions!
