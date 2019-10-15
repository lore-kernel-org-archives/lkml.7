Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C026FECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB1420663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfJOVTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfJOVTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:19:15 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 082E27BDA7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 21:19:15 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id z128so21478669qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=dL6rRUzanF/mngAS+r+PSLw0RQ+CPB/xDAExf30z58I=;
        b=Cv17AZbwisGztlp4AIgDe0z7v/jbVMuYcL6UKR1Cx1Bqiv58ujQPiN+VW8Rz0vEq1Q
         L0tnxw64PPLpm8wk1rJq5IOeYqaMWH46ofHbCabSmB/TXTFvbTUCPnCaaYHXObN917rD
         z/DNX5WAC7cF/1BTgVx4NPgOyRCXVUtTSH+oq6tV4qpwC9oqd3DnizymKF3NueZu7vyW
         IeyI1UWB9oHkQ1pBhF7S9GbT1ZfQVYcznIxSbEQM23nRGgj0iz18IuNhjCMc5+2UNsj2
         MtdslIxMp34o/iE7PjqC1m2w9rH/TqR/WpUqZGTj6yUDw+nmot8ndOB0Tm1emXTsqZE2
         zd7w==
X-Gm-Message-State: APjAAAWp4tEQHFc8RvdjZt31DHOaYOHqlND+Ebd305VuyVylZLIwMqJv
        3W7qia19aw2AErdIFkwm3Uyi+PB9lH1MOnIknsFWrKwyDLjHRW6gjdqd6jZ7Ux65oNOcSXK9xoM
        xjGYZEKVdhq5Dz5AHp3ehMUlG
X-Received: by 2002:a0c:f612:: with SMTP id r18mr38402291qvm.56.1571174353649;
        Tue, 15 Oct 2019 14:19:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMCqTGbwZd7p8eXtvsCO6t1D+F0697yJqDJ1oBBJZwAb7HGPZvXklyA5piJoGL8p8xGUaolQ==
X-Received: by 2002:a0c:f612:: with SMTP id r18mr38402264qvm.56.1571174353431;
        Tue, 15 Oct 2019 14:19:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id q44sm14292649qtk.16.2019.10.15.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:19:12 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:19:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.kiszka@web.de, mst@redhat.com
Subject: [PULL] vhost: cleanups and fixes
Message-ID: <20191015171908-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 245cdd9fbd396483d501db83047116e2530f245f:

  vhost/test: stop device before reset (2019-10-13 09:38:27 -0400)

----------------------------------------------------------------
virtio: fixes

Some minor bugfixes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (3):
      tools/virtio: more stubs
      tools/virtio: xen stub
      vhost/test: stop device before reset

 drivers/vhost/test.c             | 2 ++
 tools/virtio/crypto/hash.h       | 0
 tools/virtio/linux/dma-mapping.h | 2 ++
 tools/virtio/xen/xen.h           | 6 ++++++
 4 files changed, 10 insertions(+)
 create mode 100644 tools/virtio/crypto/hash.h
 create mode 100644 tools/virtio/xen/xen.h
