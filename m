Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4608204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfHHM2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfHHM2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:28:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 896FC3007F39;
        Thu,  8 Aug 2019 12:28:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7975A19D70;
        Thu,  8 Aug 2019 12:28:46 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 65D5418089C8;
        Thu,  8 Aug 2019 12:28:46 +0000 (UTC)
Date:   Thu, 8 Aug 2019 08:28:46 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     amit@kernel.org, mst@redhat.com, arnd@arndb.de,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
Message-ID: <1512438873.7425183.1565267326035.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190808115630.GB2015@kroah.com>
References: <20190808113606.19504-1-pagupta@redhat.com> <20190808113606.19504-3-pagupta@redhat.com> <20190808115630.GB2015@kroah.com>
Subject: Re: [PATCH v2 2/2] virtio_ring: packed ring: fix
 virtqueue_detach_unused_buf
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.132, 10.4.195.15]
Thread-Topic: virtio_ring: packed ring: fix virtqueue_detach_unused_buf
Thread-Index: 1dZf+nrJonjXypT43ZqdcgxKewv0gw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 08 Aug 2019 12:28:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > This patch makes packed ring code compatible with split ring in function
> > 'virtqueue_detach_unused_buf_*'.
> 
> What does that mean?  What does this "fix"?

Patch 1 frees the buffers When a port is unplugged from the virtio
console device. It does this with the help of 'virtqueue_detach_unused_buf_split/packed'
function. For split ring case, corresponding function decrements avail ring index.
For packed ring code, this functionality is not available, so this patch adds the
required support and hence help to remove the unused buffer completely.

Thanks,
Pankaj  

> 
> thanks,
> 
> greg k-h
> 
