Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F08C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQWEo9K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCDTqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:46:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46515 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:46:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so3793124pgf.13;
        Mon, 04 Mar 2019 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xmz5CLW0FSy25OQrcpPjEI+jhUMsvf19y6/jwFDBJlQ=;
        b=sQWEo9K1CGxltrMpEXO2LIK894eOWnmM8qXH1cQ+A8sgxCaq8NFdhDnAbfI+RFxqit
         ROUCK8A6X/kbviOJ6RZLIQEKMqb5Lr5qOi7NnkoRBAj+dcJcv1MI+Eqw0e1K7TAxXu79
         GBsuV/VhOEaScy5T55Ed8fR6FHDxwE6sUQxdlseSe9RJFX263YFbwRw6DLTXtcdlroYU
         F1o5tHsA2TAZt59Y3qqPq2PpGgtI0TW0ZMUd+xx/TuBQ0+IRskNaorJ6s2CffjVxgeC6
         7Fdf6skIKB52MA/FRYZhA8aXy6jIQ646pH8q9J7yfVEEMTn6O49yHz+WkGp4bnzJt9xQ
         c64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xmz5CLW0FSy25OQrcpPjEI+jhUMsvf19y6/jwFDBJlQ=;
        b=CYjU22po+F9Nm+il8OPr9xnKijVqJVLczYLURiUiWAavZuJ0XrHY06/1vJ4hW//Izx
         FRqQOQ3BUTYrkAvkzjmGROiUXX4/1/xwGJnnCge4guxmNn7kbE1+AM53aqAu0o7GKOIV
         jEwxQVLsym1AD2Q8tfw/0YU6iJ2g64gFf1X3TFx+IUEIZkDa8wPAaB/7jFccVX/HAvmJ
         ZKFo971IqoUb820kAVq1ve9b2pQmLt2HP2UJoKAdX5FKbIgBE+dnTTn5AsTqxyZT9gY8
         XvXlLu79I+KPsKeZ9aB773KSBtGgYYPA1IibkyDzCifCxuz34IHvJwPJyY1tt9cvSHlW
         yH7A==
X-Gm-Message-State: APjAAAWAUL8wna2P2toMI0PSILIyuDWIv1cohIDmw5Psy/jB6HFAoXBm
        gcEkhEzBC7AZRCnhgHi46Vk=
X-Google-Smtp-Source: APXvYqxXGf+BxuaG8hXTW5NUGoEESrfS6v3Gbr/JMYj+Zojw5syYOQxjoXKNa9Y30ghsqwDey2xXyw==
X-Received: by 2002:a63:440d:: with SMTP id r13mr19917825pga.5.1551728810418;
        Mon, 04 Mar 2019 11:46:50 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v15sm13499604pfa.75.2019.03.04.11.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 11:46:49 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH v3 0/1] RDMA/umem: minor bug fix in error handling path
Date:   Mon,  4 Mar 2019 11:46:44 -0800
Message-Id: <20190304194645.10422-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

Hi,

Ira Weiny alerted me to a couple of places where I'd missed a change from
put_page() to put_user_page(), in my pending patchsets. But when I
attempted to dive more deeply into that code, I ran into a bug in the
cleanup code. Leon Romanovsky has confirmed that and requested this
simplified patch to fix it, so here it is.

Changes since v2:

1) Removed the part of the patch that tried to delete "dead code",
because that code was dealing with huge pages.

2) Reverted the pr_*() line shortening, so as to keep this to only
the minimal bug fix required.

3) Rebased to today's linux.git.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-mm@kvack.org

John Hubbard (1):
  RDMA/umem: minor bug fix in error handling path

 drivers/infiniband/core/umem_odp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.21.0

