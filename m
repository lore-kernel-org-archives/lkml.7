Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB70C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E777621874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmtBlYGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404227AbfHHS4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:56:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38802 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403901AbfHHS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:56:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id z14so7292985pga.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3NhUPjLzs7je5vt+pGcT0rtIfPFfRW8yibRORtLEaE=;
        b=GmtBlYGsA+TJJPso4MWBwLNOIv7kxqHtbGEGGqRQihC5phbhEz44c5/fID7XQ2b8kA
         nGpnCLJrfrm0E3Za38bN5qNXXGIuXHPNxmuaV3jyjinaiUgicMsm/uNRAWkzgJCNullf
         sOFzjthMgOQDwGddWShCVDi7FXkRjB+LUCRFuRrfYiHIDZPUZ+9MgOrZ89t3l7kz73T0
         qWU238IWAZBP8cLKxI90V4DEtXHTY6Ta29q2A6LLm2ViP/m8LAgUfgRj1rhXo9x3eb74
         We/kf25M5AuilUYVd98hz4O+oodSFAj60tiFJoLYbEJ+QJ1s2WFgJeZ4urtLDaiZH77O
         Vfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3NhUPjLzs7je5vt+pGcT0rtIfPFfRW8yibRORtLEaE=;
        b=qCxOsdPkB7vZxSVD+ca8BTBubuMArvvWkSWpmE3vyMusJsCmJSS6VAVD/UNvsvsfxQ
         Sm+N5UwDyuQnC/J6iP/+oT3LjSkxD7qmAckLaE2j8fhxICj3r3tUXSvezjMRdeo5nj1f
         rquXu65/qu7K/7Uk+ayYlBDFkfHUt4y6r0BJ4K9Kh7ir2SJcrdIhMf+1pdmTjntOdgIC
         evZbidHLhELA7HNMRauF4VnlLpvZHAzeIsZR/tbypZV2xSWF3KUwTu7Dd2agMKBkWK/H
         bjiGJePwetNl0MVZXwzWYZvVRHt8PM1nR3vXjpfqNwoj9Yc8ro8sx6x4QMC1JTvkKW5K
         sDpQ==
X-Gm-Message-State: APjAAAW7II3/Ed/h+krw1iEVZAiBYWp4nxcVy9rabB0ZzbjgKmFWHIkw
        hjT8EwOa1dUV9YNLuXyuoEQ=
X-Google-Smtp-Source: APXvYqxrB/9uqlfCMteW9WF5sFZ4DYPJdcyvFQ6jzXf2ExJrH6J6dgl0jvx/fh8l9yzKwCOkRRROGQ==
X-Received: by 2002:a63:b555:: with SMTP id u21mr14284684pgo.222.1565290562611;
        Thu, 08 Aug 2019 11:56:02 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id t8sm110170328pfq.31.2019.08.08.11.56.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 11:56:02 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, sivanich@sgi.com,
        jhubbard@nvidia.com
Cc:     ira.weiny@intel.com, jglisse@redhat.com,
        william.kucharski@oracle.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [Linux-kernel-mentees][PATCH v4 0/1] get_user_pages changes 
Date:   Fri,  9 Aug 2019 00:25:54 +0530
Message-Id: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this 4th version of the patch series, I have compressed the patches
of the v2 patch series into one patch. This was suggested by Christoph Hellwig.
The suggestion was to remove the pte_lookup functions and use the 
get_user_pages* functions directly instead of the pte_lookup functions.

There is nothing different in this series compared to the previous
series, It essentially compresses the 3 patches of the original series
into one patch.

This series survives a compile test.

Bharath Vedartham (1):
  sgi-gru: Remove *pte_lookup functions

 drivers/misc/sgi-gru/grufault.c | 112 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 88 deletions(-)

-- 
2.7.4

