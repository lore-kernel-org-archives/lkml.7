Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA8AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD58420820
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=eikelenboom.it header.i=@eikelenboom.it header.b="bWAl55VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbfFKLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 07:03:07 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:47512 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbfFKLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 07:03:06 -0400
X-Greylist: delayed 1180 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2019 07:03:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Cc:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QCeifO9zUtS8lYIt9Z5aMEE1UvJc3aqVFQ5sSYZy3wY=; b=bWAl55VNpppr1nSo99UKErndpK
        HtURPpZZCzodH4vv5P6FsZPU8B+Y6Z/6IAmv4pPwx7gJzAHD/FQxJzaTZt6vCXFKun6A2PYR7LBeI
        VkI7/h1SzUFiNGScDR/jsW/ZDn8uE0HvTAN4nwIeYvzWfApRqR6NRVualXRKKYQ4hAdw=;
Received: from ip4da85049.direct-adsl.nl ([77.168.80.73]:38780 helo=[10.97.34.6])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@eikelenboom.it>)
        id 1haeFO-0001Qx-Nx; Tue, 11 Jun 2019 12:43:22 +0200
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
To:     Kirill Smelkov <kirr@nexedi.com>,
        Miklos Szeredi <mszeredi@redhat.com>, gluster-devel@gluster.org
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: Linux 5.2-RC regression bisected, mounting glusterfs volumes fails
 after commit: fuse: require /dev/fuse reads to have enough buffer capacity
Message-ID: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
Date:   Tue, 11 Jun 2019 12:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L.S.,

While testing a linux 5.2 kernel I noticed it fails to mount my glusterfs volumes.

It repeatedly fails with:
   [2019-06-11 09:15:27.106946] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
   [2019-06-11 09:15:27.106955] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
   [2019-06-11 09:15:27.106963] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
   [2019-06-11 09:15:27.106971] W [fuse-bridge.c:4993:fuse_thread_proc] 0-glusterfs-fuse: read from /dev/fuse returned -1 (Invalid argument)
   etc. 
   etc.

Bisecting turned up as culprit:
    commit d4b13963f217dd947da5c0cabd1569e914d21699: fuse: require /dev/fuse reads to have enough buffer capacity

The glusterfs version i'm using is from Debian stable:
    ii  glusterfs-client                3.8.8-1                      amd64        clustered file-system (client package)
    ii  glusterfs-common                3.8.8-1                      amd64        GlusterFS common libraries and translator modules


A 5.1.* kernel works fine, as does a 5.2-rc4 kernel with said commit reverted.

--
Sander
