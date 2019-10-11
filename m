Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC44C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4EC2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 13:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJKNqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 09:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfJKNqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:46:00 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6CC085538
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:46:00 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id 59so9475337qtc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 06:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=o/nkRYTONx73WsD7MC8B77Hivj8w35ee4nLVJzmSYdg=;
        b=Z8gQIUqyVMdZkxl5nmYT7ScR/Ry/YQT9Q9slOKwvslOdm5IJ4GSUBEAe8pZv9zIll+
         Dr0qjyItvdO4vi5xeyGfa6DREJ34C6bI/5fnaFchgGF/r/Kb64MhcdGVoi1p3/kv6dnE
         KZXH+GJsIOi7+DVuv/fd9Bh1+pUQg3+QhB1hfTbHRHg5AUlCjwi+7G4tFakUYq4vzWQe
         7yHCCwhXferHZzDvl6UNAOs68f6Cm0kTU2w/EY3mLeM/8rvOCZLlmZxnPT1sFHvE1zQD
         MuzXMZQzQuo2fqDaOnotc7lTynqgTXpWbp6KTdVmgfNENHpIEr365WZ/eAz86l9wCOMz
         +UOg==
X-Gm-Message-State: APjAAAW/KZhXjHMymWUaQkV+kLgQoBO/8doz9kNF+msxvHJUMfDxCel5
        gp/hCqizi7nCkXCWaQ/aE0w8h2fYprMM1WIVf6veMS55twaAT+6cOU73T3zDn54wpJTz4+RN0ov
        2DVTKQLloIVnu9ozccToYFsKm
X-Received: by 2002:ac8:2e10:: with SMTP id r16mr17460324qta.62.1570801559693;
        Fri, 11 Oct 2019 06:45:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNkV+IdP+Wd7WKMbrFt0Q607s9maou4ckQQ4vu7F/qkVJUOjLTGMKOgQL8yhEDf1yVy213sQ==
X-Received: by 2002:ac8:2e10:: with SMTP id r16mr17460293qta.62.1570801559470;
        Fri, 11 Oct 2019 06:45:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id w6sm3944120qkj.136.2019.10.11.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:45:58 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:45:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v1 0/2] vhost: ring format independence
Message-ID: <20191011134358.16912-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

And perhaps more importantly, this is a very good fit for the packed
ring layout, where we get and put descriptors in order.

This patchset seems to already perform exactly the same as the original
code already based on a microbenchmark.  More testing would be very much
appreciated.

Biggest TODO before this first step is ready to go in is to
batch indirect descriptors as well.

Integrating into vhost-net is basically
s/vhost_get_vq_desc/vhost_get_vq_desc_batch/ -
or add a module parameter like I did in the test module.



Michael S. Tsirkin (2):
  vhost: option to fetch descriptors through an independent struct
  vhost: batching fetches

 drivers/vhost/test.c  |  19 ++-
 drivers/vhost/vhost.c | 333 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  20 ++-
 3 files changed, 365 insertions(+), 7 deletions(-)

-- 
MST

