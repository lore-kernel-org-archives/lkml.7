Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F0C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD89214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfHHMTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731788AbfHHMTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:19:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C4F27E426;
        Thu,  8 Aug 2019 12:19:25 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B9321001284;
        Thu,  8 Aug 2019 12:19:25 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 08FA618089C8;
        Thu,  8 Aug 2019 12:19:25 +0000 (UTC)
Date:   Thu, 8 Aug 2019 08:19:24 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     amit@kernel.org, mst@redhat.com, arnd@arndb.de,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Message-ID: <1593246032.7424344.1565266764494.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190808115555.GA2015@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com> <20190808113606.19504-2-pagupta@redhat.com> <20190808115555.GA2015@kroah.com>
Subject: Re: [PATCH v2 1/2] virtio_console: free unused buffers with port
 delete
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.132, 10.4.195.30]
Thread-Topic: virtio_console: free unused buffers with port delete
Thread-Index: 3j1KCI3vfTqn3wC0i4fDgfcUSG+LwQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 08 Aug 2019 12:19:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Thu, Aug 08, 2019 at 05:06:05PM +0530, Pankaj Gupta wrote:
> >   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> >   deferred detaching of unused buffer to virtio device unplug time.
> > 
> >   This causes unplug/replug of single port in virtio device with an
> >   error "Error allocating inbufs\n". As we don't free the unused buffers
> >   attached with the port. Re-plug the same port tries to allocate new
> >   buffers in virtqueue and results in this error if queue is full.
> > 
> >   This patch removes the unused buffers in vq's when we unplug the port.
> >   This is the best we can do as we cannot call device_reset because virtio
> >   device is still active.
> 
> Why is this indented?

o.k. will remove the empty lines.

> 
> > 
> > Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> 
> Fixes: b3258ff1d608 ("virtio: Decrement avail idx on buffer detach")
> 
> is the correct format to use.

Sorry! for this. Commit it fixes is:
a7a69ec0d8e4 ("virtio_console: free buffers after reset")

> 
> And given that this is from 2.6.39 (and 2.6.38.5), shouldn't it also be
> backported for the stable kernels?

Yes.

Thanks,
Pankaj

> 
> thanks,
> 
> greg k-h
> 
