Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C8AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95F22173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNLYvFTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfELHeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:34:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43817 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfELHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t22so5109525pgi.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tu8Fp/uz7bbeEJee+ohTniXikyB8jQpgmo0/F9wxQwc=;
        b=YNLYvFTYhaxsJmvLOTdE3rBOjlFAOxqVXOVNH5vzzODcv1aKfd4SkTQxaX/ooQge54
         x9GfsHqLMEQEXKQi3yIJnDCZGP3oBXw3kYUieHowaTudqliTKtFcAebmlsl7RllDJQVM
         2GX2KRWnjDFGAt0sHDvkwCbXSNgnucVQG9Oz5sfK8SIdSxpqVJ9SD0LnFLDPFYpELjrm
         72hQVLTGYZFgQyhAou1eyPKS2nbv7KEJKj3kY6Ga0keh8aryI9izaKCoQk2r9jmCJq8Y
         OadxxA+PYkiiDeJ0JmckfhUZJ+liXiVM9/sgPtcLfXIpnGjlXCaetgLxVKWpc1ze+QAs
         SV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tu8Fp/uz7bbeEJee+ohTniXikyB8jQpgmo0/F9wxQwc=;
        b=qa+ts+fSD3LuDlMR30KwBEkgys6IKnnv96Wt6vb0Xz3BgsrxnBwe4p7Cnxuhe5ArH4
         XfijjiI7RqrLdCWcqQPzmD7vJLuf1eqIjeddVc/WtNa7rCQoy5jO4yzVTs6PGVxSlprd
         uF4WFKET5Jj95BN/3gluSojqZkP+3RQnE6tWPfcmdeE0OmOR35y8kb+shz5isTKuD6UD
         ZCPOIrrOj/ZuRN0QmYMPy0R0mtB16JRIH+d7+bHbL1rnvHTNYSnB3AivglmTGXXdOalE
         vCisu4POA7cT09AX68WcgeZDwGG0FE0qCxG9zD4o8StrQ9zknVTtJcO+A1h8TUDHzE26
         g40Q==
X-Gm-Message-State: APjAAAWsmtgteB26CCNMcfI9GRHj7rQ32r/jElJ9iGsuvbcxOHZhW80Z
        Y+DmLLXnVrzg9bdWpGn4sBLdmAS7qs0=
X-Google-Smtp-Source: APXvYqxv7TotCZPxzbi9TfWTIu4D0s3TjKk9zD0KzFT5XZp5TC85KF/D7Rjc4nKxwkLReEaD8QRBhw==
X-Received: by 2002:a65:628b:: with SMTP id f11mr23776008pgv.95.1557646474151;
        Sun, 12 May 2019 00:34:34 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:33 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V3 0/5] nvme-trace: Add support for fabrics command
Date:   Sun, 12 May 2019 16:34:08 +0900
Message-Id: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a third patchset to support fabrics command tracing.  The first
patch updated host/trace module to a outside of it to provide common
interfaces for host and target both.  The second one adds support for
tracing fabrics command from host-side.  The third is a trivial clean-up
for providing a helper function to figure out given command structure is
for fabrics or not.

The fourth and fifth are the major change points of this patchset.  4th
patch adds request tracing from the target-side.  5th updated, of course,
completion of given request.

Please review.
Thanks,

Changes to V2:
  - Provide a common code for both host and target. (Chaitanya)
  - Add support for tracing requests in target-side (Chaitanya)
  - Make it simple in trace.h without branch out from nvme core module
    (Christoph)

Changes to V1:
  - fabrics commands should also be decoded, not just showing that it's
    a fabrics command. (Christoph)
  - do not make it within nvme admin commands (Chaitanya)

Minwoo Im (5):
  nvme: Make trace common for host and target both
  nvme-trace: Support tracing fabrics commands from host-side
  nvme: Introduce nvme_is_fabrics to check fabrics cmd
  nvme-trace: Add tracing for req_init in trarget
  nvme-trace: Add tracing for req_comp in target

 MAINTAINERS                       |   2 +
 drivers/nvme/Makefile             |   3 +
 drivers/nvme/host/Makefile        |   1 -
 drivers/nvme/host/core.c          |   7 +-
 drivers/nvme/host/fabrics.c       |   2 +-
 drivers/nvme/host/pci.c           |   2 +-
 drivers/nvme/target/core.c        |   8 +-
 drivers/nvme/target/fabrics-cmd.c |   2 +-
 drivers/nvme/target/fc.c          |   2 +-
 drivers/nvme/target/nvmet.h       |   9 ++
 drivers/nvme/{host => }/trace.c   |  75 ++++++++++++++++
 drivers/nvme/{host => }/trace.h   | 144 ++++++++++++++++++++++++------
 include/linux/nvme.h              |   7 +-
 13 files changed, 227 insertions(+), 37 deletions(-)
 rename drivers/nvme/{host => }/trace.c (65%)
 rename drivers/nvme/{host => }/trace.h (59%)

-- 
2.17.1

