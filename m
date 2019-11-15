Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE7C20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZdTwm1d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKOF3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:29:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44608 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKOF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:29:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so3837395plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 21:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lIff/HsuYUX4uhwWTx3aVYOPFjp52ImXeumnDjDhshw=;
        b=ZdTwm1d9Efmg5RBCb17XYd2ALis+3DV0tULR7SyLWLxP+EZEDSbYJw1GwgFrS5k7gr
         ZgOx0JDnwMInLiyLce5YAK+7xftVVhpwBFj1PPNIOV2rsfdXiE9FWu6snqZtBcn8xqjY
         kZyZbbHrGojcc/ySkh6p1kBCxP1A8tatQW4iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lIff/HsuYUX4uhwWTx3aVYOPFjp52ImXeumnDjDhshw=;
        b=AhWHzAYegHcSjSMnz9HAV1kZUYntY26xx0slKBMv0CKQBLfuXULlirB8EJ1ol5AMHz
         mPn2+CzAWu79vVN7b9bKwwpJ64fJANKZMGrtCJQwl9N5lBaR0xpvArmWubWZY3MIqxl9
         bznriEjtS2Qt7JRzqB/fR29wVsoZwDniHgD+y3WJNf6lHkR775uqRVSJHI7/A+EjPl3R
         sAg/fuw3aw+GjPh8JbcgyO6/Uj16/KkDA3YwuPkuwwcvbrMJYd/p0pUrxow4zsruGqos
         WBqlo/Cv3Ccy7zr5i3HeU1hDJi5FLDRfsj8xgeL1j0PkVtysznB3WE40akXfWCYgT+wq
         1Byg==
X-Gm-Message-State: APjAAAVup/Wxt+ac+d+Mv8ztCFMZqiscqxobmTuYjDH8TeiFb8owQFqq
        4+u8TvPmgIm58UGj7t7/AzNwBg==
X-Google-Smtp-Source: APXvYqy1G7d5ZLVqWMGLxX/au94Dv620lNHG5W446Zfu+MhtTYOS4k1eWDSBXwuFhLnBKVd1HLzF3w==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr17732430pjq.46.1573795781306;
        Thu, 14 Nov 2019 21:29:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l33sm8120333pgb.79.2019.11.14.21.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 21:29:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        Sami Tolvanen <samitolvanen@google.com>,
        netdev@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] bnx2x: Remove function casts
Date:   Thu, 14 Nov 2019 21:07:10 -0800
Message-Id: <20191115050715.6247-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the entire kernel usable under Clang's Control Flow
Integrity protections, function prototype casts need to be avoided
because this will trip CFI checks at runtime (i.e. a mismatch between
the caller's expected function prototype and the destination function's
prototype). Many of these cases can be found with -Wcast-function-type,
which found that bnx2x had a bunch of needless (or at least confusing)
function casts. This series removes them all.

-Kees

Kees Cook (5):
  bnx2x: Drop redundant callback function casts
  bnx2x: Remove read_status_t function casts
  bnx2x: Remove config_init_t function casts
  bnx2x: Remove format_fw_ver_t function casts
  bnx2x: Remove hw_reset_t function casts

 .../net/ethernet/broadcom/bnx2x/bnx2x_link.c  | 351 +++++++++---------
 .../net/ethernet/broadcom/bnx2x/bnx2x_link.h  |   6 +-
 2 files changed, 171 insertions(+), 186 deletions(-)

-- 
2.17.1

