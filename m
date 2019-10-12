Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D4CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CAF20673
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfJLTSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:18:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729692AbfJLTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:18:51 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46D4AC05683F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 19:18:51 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id k67so12708092qkc.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XSSfcNJSuQK6tbBIRVqD8nyyhs8/n5qs+oek7V16gWg=;
        b=Ia9Yf/2bHIx2uUedYtuDQsmxB4ApzT/ua0V+as9YcHlR9xG8m+mBFLy+JVMk5csP3o
         53oGm+K6sUHyOiHieosf64f7UGfElcziTeXWTavGVl+lx8ns+EKBAnFgNL2pbcNmULZz
         SwiYBfyw7dp57FepOQ/N/3PStw5KPicxMfQSewUUrUseuvR/OcAeYojwcrx65kXp+1Yn
         AdVFPw5vvj8e5F84bOUuPXMlQTK+CiW68lYnEcOi/xqGDq1fETmsK20+Pg61Q0jany4z
         mLHmsjhAncNPCVhxULxEmR3kEf2+1BzWCgzKcdycnc7xai5Bdv9MpsJUBtRcLcMq0eaY
         OyvA==
X-Gm-Message-State: APjAAAX1YBNrsZ6MsjNl2DJtUTUab23TODIThQiVWWF41OMhkp6+XJM3
        DedxlA00WfcJ4vVFrUcpcZUJaQZMwpxuXlAkGK7cDgKIFh5cV77nOZRavjWyAXfuUeHEPYUyXQ6
        FzFmuyoyRJIBSHYLfdSG179Wf
X-Received: by 2002:a37:b8f:: with SMTP id 137mr21665702qkl.466.1570907930052;
        Sat, 12 Oct 2019 12:18:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYVcRWvZEcwbiX5JXr6fNk4W01ojqCtNq7uXnEznHUo/iukXYBpKClYnD6en9lTNPNSsx0Ow==
X-Received: by 2002:a37:b8f:: with SMTP id 137mr21665681qkl.466.1570907929802;
        Sat, 12 Oct 2019 12:18:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id x55sm7350774qta.74.2019.10.12.12.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 12:18:48 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:18:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH RFC v2 0/2] vhost: ring format independence
Message-ID: <20191012191820.8050-1-mst@redhat.com>
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
More testing would be very much appreciated.

Biggest TODO before this first step is ready to go in is to
batch indirect descriptors as well.

Integrating into vhost-net is basically
s/vhost_get_vq_desc/vhost_get_vq_desc_batch/ -
or add a module parameter like I did in the test module.


Changes from v1:
	- typo fixes

Michael S. Tsirkin (2):
  vhost: option to fetch descriptors through an independent struct
  vhost: batching fetches

 drivers/vhost/test.c  |  19 ++-
 drivers/vhost/vhost.c | 333 +++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  20 ++-
 3 files changed, 365 insertions(+), 7 deletions(-)

-- 
MST

