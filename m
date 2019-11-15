Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA96E20723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRGzE+YF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKOU51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:57:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbfKOU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573851444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dtdHS3hNTi80U2lS2ee30H71MuBUQr4CKOdjoMCLxHw=;
        b=WRGzE+YFKGiU18ms4lC/mGz8OsQrnhybPNkR8sIT7Y4KV0FKGocNiBRQ52hHxaRMcJonRh
        q9khdqgVuCuE70kAJYNmC6A6n2elIsxXFX2YPH9xMmWVY4y+gAS012SEAC6HToZzgeZMtz
        +NKddKRud1ZeSpfn9HXd2q4T9k9j/tM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-dPLdeRlwNHqUMrx2aGfu2A-1; Fri, 15 Nov 2019 15:57:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 829861005502;
        Fri, 15 Nov 2019 20:57:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FECD28DF4;
        Fri, 15 Nov 2019 20:57:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9D71E220C26; Fri, 15 Nov 2019 15:57:14 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        miklos@szeredi.hu
Subject: [PATCH 0/4] [RFC] virtiofs: Add a notification queue
Date:   Fri, 15 Nov 2019 15:57:01 -0500
Message-Id: <20191115205705.2046-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dPLdeRlwNHqUMrx2aGfu2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are RFC patches for adding a notification queue to allow sending
notifications from host to guest.

It also adds support for blocking remote posix locks using the newly
introduced notification queue.

These patches apply on top of 5.4-rc8 plus following patch series I had
posted a while back.

https://lkml.org/lkml/2019/10/30/493

These changes require virtio spec changes as well. I have yet to do
that.

Thanks
Vivek

Vivek Goyal (4):
  virtiofs: Provide a helper function for virtqueue initialization
  virtiofs: Add an index to keep track of first request queue
  virtiofs: Add a virtqueue for notifications
  virtiofs: Support blocking posix locks (fcntl(F_SETLKW))

 fs/fuse/virtio_fs.c            | 328 ++++++++++++++++++++++++++++++---
 include/uapi/linux/fuse.h      |   7 +
 include/uapi/linux/virtio_fs.h |   5 +
 3 files changed, 310 insertions(+), 30 deletions(-)

--=20
2.20.1

