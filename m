Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4BAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134AC2075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFxmKbnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfCBD1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:27:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44633 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBD1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:27:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so12303893pff.11;
        Fri, 01 Mar 2019 19:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmQ/nfEVWxvZmt65MH989j5HW22Ux+Ri7rIfiwpkWEo=;
        b=sFxmKbnFVy/0QqNNNfDX0GlfUlrWGlFU28kdU1K+xJeNiv1ltZJ0MeXKqYPO4iZQa4
         CIR7rn/vYnodO2kYg67p+ISh/Zg/2eth8GR3jvHdbaWtdS9bixdR8i+KRyBDAkVFLzan
         5YnKK3ZJyPu5V4wA+9j2wdZrtHBW22Id4vzF2FA+9cVBj0oxXDfQYbLSFZ85kRfiiKeG
         bt1AyeSY+/Zx4vFKDSWw3UmDW91o0jwfrJ99ZUqOLeYNdPYaufJTvpApDPrHinImuAyH
         +YNBL2PSxyeSjKaqNlH5e0aTp0z3VuRBWixWKMwDo7mj29M22gNPBmxy3D+7NpHKAPo4
         t7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmQ/nfEVWxvZmt65MH989j5HW22Ux+Ri7rIfiwpkWEo=;
        b=Ck3idkCh0b75irvhdJRqrNks+HMU3vy6ltHYFFmC6poOCGnL4xsXppDsqTjvbm91qR
         kMma1y/ch5qtPernXmOb6TliBn0mp9FFQxtrhagDgnOG+JNUzYmQ6rnh5s0zpQyko0Gc
         /4OCw96VVu2ThGh/E5Z/8ubs6DTFJMR/G/hMpl6J6icBM0Nge5/kSTWBKGL1YEOTS4FL
         N9wSXJwZB8y+bvVbruK6s+kl6LKD4Oml8GGMY37rjJZMJDL3QfnmrDVbNBMVMAXtbQkt
         gMQ5SIs84pamhI4SJrod6qHjkcdFKVgIiVSjxO+H3mgII/wN96Tv9C+OFitEfOvd3cki
         8WiQ==
X-Gm-Message-State: APjAAAW8dXvE3wYtfY/Ph7pS11UovoOWPuhi5FleRifFZj1oAFiOr0Zv
        sQFnvzaoNZL3xNpUUVY0vfs=
X-Google-Smtp-Source: APXvYqzMCGDSneiNFYjfJ/1ov//ITmiz09EMVCu79pghl7ITloB+qLtRnJZhE1x9LvqnaGIEf6kc5w==
X-Received: by 2002:a63:ed0b:: with SMTP id d11mr8123928pgi.435.1551497250415;
        Fri, 01 Mar 2019 19:27:30 -0800 (PST)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 63sm42312273pfy.110.2019.03.01.19.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:27:29 -0800 (PST)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [PATCH 0/1] RDMA/umem: minor bug fix and cleanup in error handling paths
Date:   Fri,  1 Mar 2019 19:27:25 -0800
Message-Id: <20190302032726.11769-1-jhubbard@nvidia.com>
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
attempted to dive more deeply into that code, I ran into things that I
*think* should be fixed up a bit.

I hope I didn't completely miss something. I am not set up to test this
(no Infiniband hardware) so I'm not even sure I should send this out, but
it seems like the best way to ask "is this code really working the way I
think it does"?

This applies to the latest linux.git tree.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org
Cc: linux-mm@kvack.org

John Hubbard (1):
  RDMA/umem: minor bug fix and cleanup in error handling paths

 drivers/infiniband/core/umem_odp.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

-- 
2.21.0

