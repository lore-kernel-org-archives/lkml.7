Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C6CA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D538620862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3Pd9Wcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfJ2HrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:47:09 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:51224 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJ2HrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:47:09 -0400
Received: by mail-qk1-f202.google.com with SMTP id h4so12831925qkd.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=coTE+MJajFctVQLNyVBBx0dRF4V5QAJNpm9Z15UXxk4=;
        b=J3Pd9Wcsnx0fAFx+SuaJ/2ISyWHr/iOR+MyAqpulWQSKfN/L5GWFqWQ36Xk0my72EP
         aoHhIkRhqf1zoyv3Ivb3FJDRimdgkDZkn63ulG6N6Kx4yzc+QMNSxz5xS7KaUzOvSmya
         5RBkAhgPy0ZBcHerSvW6id1YOnmRaDWly0RVgYKfPK6bD/1+C+Z7f84BdGdLjZ4Tqyfi
         a09ZEnH3ORvmN/v/g0gXmsSvAcpeb++Toqc9tvQwN1hxSCibDEZn/Ew29O8LArDVHNF6
         Z3QwrVT08LPjudalRd1OTD2AkJzB4aT26ZfA9qJF8K8gnpDFeuFblPPhK9AlAS9PzSy7
         3rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=coTE+MJajFctVQLNyVBBx0dRF4V5QAJNpm9Z15UXxk4=;
        b=SKsgSH2pG/Tt3VMIiA584BeFTEMKkFTd+iNVFq6+my4xqqd+lBbrGbh0dkbjrwCdMq
         v7ctkRJ9zdvvc++zvV4WzxD5tJROFydMstDwlfTxORxgVzNea/3kqSF65rk2ZT7p1mWz
         6iqQby9UE8cRvTrLmP9oqcldWsTrqmOK6uFwg3jDerVtKmgnx9nHEvY6lXdGEeq/bULd
         p5St1o4q22EERF8sDei4ygQhk6+geH/ypAcqHzzWGLUjB3mQ6sGC+dO4hMxiosDmDnt2
         sqDyVG32dDJkPdlICnuHaAz3pWx/bJB9RQkHzcNF77imwXRr+pggsEF+XXNYAi/i0U7H
         IGFw==
X-Gm-Message-State: APjAAAUMMfi5uI4TtmpT192YmCaVGnsbVBt0N8KjtASXld55FEwJUewm
        RWCg6dvMhJl3Tm70tUiEBHhmNpkBNFBiJA==
X-Google-Smtp-Source: APXvYqxAx77Hh7nRevnvS8GpEcqHxWVZ3ZyQfkshEcYxuX+dw7rCCqEojhxQf1zbnDr1L8+5sm0iDYY7D+Pedw==
X-Received: by 2002:ac8:2ccc:: with SMTP id 12mr2844193qtx.49.1572335227156;
 Tue, 29 Oct 2019 00:47:07 -0700 (PDT)
Date:   Tue, 29 Oct 2019 15:46:59 +0800
Message-Id: <20191029074659.165884-1-robinhsu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 0/2] f2fs-tools: Introduce cache to speed up fsck
From:   Robin Hsu <robinhsu@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     huangrandall@google.com, robinhsu@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented cache and related command line options.

Robin Hsu (2):
  libf2fs_io: Add user-space cache
  fsck.f2fs: Enable user-space cache

 fsck/main.c       |  27 +++-
 include/f2fs_fs.h |  20 +++
 lib/libf2fs_io.c  | 317 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 362 insertions(+), 2 deletions(-)

-- 
2.24.0.rc0.303.g954a862665-goog

