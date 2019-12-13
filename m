Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503BC33CA7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACAD24735
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnMg/nbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfLMOfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:35:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29230 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727778AbfLMOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 09:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576247729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=K16O3uoMoq1X7RVCymy3uF4s1barxs0V/Dkj4PdUFYc=;
        b=VnMg/nbS4WLIfz9pzROj7NhtJ+T8bS4q7p43VNINsfGcthTJ0gzHuKdNvUujFeABQmT07v
        /sBKFDEymBQCaHrCXwiTGfqcU3nXhm3L0gph82GjC5NLz2O5LtoBk9ZlCTxqNwACUO+bmd
        7ALyVfVI4h2L5Zis0Iu8IWP4KqhB0NM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-U_G4IoFhNzeun0v-G5cMWg-1; Fri, 13 Dec 2019 09:35:26 -0500
X-MC-Unique: U_G4IoFhNzeun0v-G5cMWg-1
Received: by mail-qt1-f197.google.com with SMTP id o24so1896011qtr.17
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 06:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K16O3uoMoq1X7RVCymy3uF4s1barxs0V/Dkj4PdUFYc=;
        b=Rtj18BSbqF2LjyierBLElsYHD1alPXrVCbGGBgeU3bwYs31kTPQw9//GH4j9PCLWp5
         glHFIK9nG94PPFzuwPhCZXfBApG/D0+ueTiC5MaE4Q/q9t6U85dLGfhJDdEILfbzUivQ
         yfWxzYZKxCBursKvG5n15yaapD+XPjS4MmPgmIIXvPS0dvpC3ixefWtpLd7/ke0pH71X
         3hWul2sCHOP0jfL9iyh8rSksz0EAQUKpV3B7TPZuLZ8aNHpMdDdBEl0nG/8yQedqUCsd
         MuCbTz0nKxChOCDK6jS4YYPl6QTtoR1x/lYWDa2km8JULa7xTPj4BcZRHr4abEFIY8QE
         IqSg==
X-Gm-Message-State: APjAAAWQPkypeaidxXcbi4hmzqsWN256100pIKE84Ykw8I2/YaTvI6Jn
        9p/IrXi4Yp54woAnkRjvQs+aJTXM+m/9vFshWwgZM8lr8pmaUvDcKhhVAPx16aXZATLbAlkgv7K
        SDSAkLMzff7bgIheLz1bc+dyR
X-Received: by 2002:a37:5d1:: with SMTP id 200mr13575572qkf.492.1576247725619;
        Fri, 13 Dec 2019 06:35:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgq1bbRToA9P95foPk8oGS2OI8ibHY6a72vmEjljgya2qgJqTa4/Xh04URKGN+H8Bz4Y3K4g==
X-Received: by 2002:a37:5d1:: with SMTP id 200mr13575555qkf.492.1576247725393;
        Fri, 13 Dec 2019 06:35:25 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id l62sm2885132qke.12.2019.12.13.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:35:24 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:35:19 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@redhat.com, imammedo@redhat.com,
        jasowang@redhat.com, liuj97@gmail.com, mst@redhat.com,
        stable@vger.kernel.org, yuhuang@redhat.com
Subject: [PULL] virtio: cleanups and fixes
Message-ID: <20191213093519-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 63b9b80e9f5b2c463d98d6e550e0d0e3ace66033:

  virtio_balloon: divide/multiply instead of shifts (2019-12-11 08:14:07 -0500)

----------------------------------------------------------------
virtio: fixes, cleanups

Some fixes and cleanup patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      virtio-balloon: fix managed page counts when migrating pages between zones

Michael S. Tsirkin (2):
      virtio_balloon: name cleanups
      virtio_balloon: divide/multiply instead of shifts

 drivers/virtio/virtio_balloon.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

