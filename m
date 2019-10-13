Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FEEC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8873D2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJMIIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:08:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbfJMIH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:07:59 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80A10859FC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 08:07:59 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id c8so14503485qtd.20
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 01:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yhYWl1Umy/1VTjIbbiNd2BN64NH6epCZE/mb8RSLaXM=;
        b=BENCy1Og0buImiVepTIWnDJQaV1s4nzuvwnLv4BrDfWdrwF0kJ+yohiRGSuVrUpRBB
         KZki0rdwu/E41xO7y5hzAfgXD94hCInfYil+dzSnl1xDXzAYHEfys2i3QbhDddZspt66
         XSyx8K+o98pvhZb7WZjKX5pqhLMdFlBusBbvcOHjSW4mycAWP6/FDJWcZsSvpdE7jI8t
         n86+WTLze0ZNlb32S+AbZ2cfUiXRnaB/epilcRT25bIaIZQ/AHl6R8Pi4QNl4Fr/3RDV
         tlBF1KNMYdcuSG22S2qIEz6bIYjrNicwrauYNzJVGkNjgitPfNkNfjVqEO6duI+/Xap8
         OxPA==
X-Gm-Message-State: APjAAAXMWkau+FXjQMSUgUROVAJjDeJCHf+COmxsUE1xd3S9BApj/xhP
        E6R+I18e9pLcRA06FTldPFIaIfSATetX4v73c9yBkWbR+xFEBYPXfVxEfNmfzTA6cq55G1LkCO6
        RtgSUXIyrERcJAOZlAkv0bkGb
X-Received: by 2002:a37:9a05:: with SMTP id c5mr23746938qke.98.1570954078377;
        Sun, 13 Oct 2019 01:07:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdHllinWFJ1shL2L0dscS9heDbinJBHlNcirUbgmYpZ/ksUyJvF3jXeQkMuv9YmookTDp0DQ==
X-Received: by 2002:a37:9a05:: with SMTP id c5mr23746919qke.98.1570954078076;
        Sun, 13 Oct 2019 01:07:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id q8sm7301621qtj.76.2019.10.13.01.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 01:07:57 -0700 (PDT)
Date:   Sun, 13 Oct 2019 04:07:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v3 0/4] vhost: ring format independence
Message-ID: <20191013080742.16211-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds infrastructure required for supporting
multiple ring formats.

The idea is as follows: we convert descriptors to an
independent format first, and process that converting to
iov later.

The point is that we have a tight loop that fetches
descriptors, which is good for cache utilization.
This will also allow all kind of batching tricks -
e.g. it seems possible to keep SMAP disabled while
we are fetching multiple descriptors.

This seems to perform exactly the same as the original
code already based on a microbenchmark.
Lightly tested.
More testing would be very much appreciated.

To use new code:
	echo 1 > /sys/module/vhost_test/parameters/newcode
or
	echo 1 > /sys/module/vhost_net/parameters/newcode

Changes from v2:
	- fixed indirect descriptor batching

Changes from v1:
	- typo fixes


Michael S. Tsirkin (4):
  vhost: option to fetch descriptors through an independent struct
  vhost/test: add an option to test new code
  vhost: batching fetches
  vhost/net: add an option to test new code

 drivers/vhost/net.c   |  32 +++-
 drivers/vhost/test.c  |  19 ++-
 drivers/vhost/vhost.c | 340 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  20 ++-
 4 files changed, 397 insertions(+), 14 deletions(-)

-- 
MST

