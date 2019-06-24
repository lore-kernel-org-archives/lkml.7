Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822E7C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521A02077C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvJQB8hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfFXXyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:54:19 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:55191 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbfFXXyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:54:19 -0400
Received: by mail-vk1-f201.google.com with SMTP id w137so7035645vkd.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=XvJQB8hWrOW/SRpeI4tK10iYplodRxP7G102eNBFBqwIMqTgenq6LtYA3UW7T7ITUh
         thRvMJiDtniUB1muyhRW4m0OusgO2K0NXGpZmryrjGn7XtYQmOVnLnrgGwwgyOWfShV8
         xfHcMGtR1GM/LLQqBhE/yjinnKHbkILzy1lRqSNTcUV6NAMQolBDUCJWyNRUMfNrmTQQ
         FiQQQBS7vYwvSmP8HHvCTyDerVit/r1FsvvzcJF4TwX2RPJk35qgc4KBiUp+F8o0SFdp
         XH5fcmKm4j9ciAseV8FHibjrvG6SYiePUrx1fypcNHazdghb88UFwh9fJBOco3mjJypH
         VNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=mDZHx6pb5Y8B4OMuYXULPbj1MZ9wIpZ6wGSrA74xueebedzPUNeLCJo1n1VdXsWt2+
         2XFRa8BbtWhBKGh4L2mgR2CzBijxft9JyMQq6Qli0Stpgx/mJUgkMV0qMaW8M1NaUOso
         TQ9RW0AdFWGJf/P7HPs0AnKO0xMqLMpEyuTOqk4gLTQLSZke2eKu5RsSkYo9YIFU5dgP
         gaQB14a1+BrDhHumDisoI8evk3Uu2hLYlJWCsyEo6JAMX7sfrYqu7ySWKklLR3Oajz0N
         ljsu3mEi/5szbNAgQyOwqiewIFrgZkRN8Dw0tGRgpsI/Y4t92DOHoT43bFN9Y0vje+Zn
         Tx5A==
X-Gm-Message-State: APjAAAXHEhoRThNfuda5kQ0Flz9s0AlUhLM2xM9zGCewjxk/uCnYK2jR
        rmUjHLvxuiJ8ybcLHXLcwizTsjemBkzorZh8
X-Google-Smtp-Source: APXvYqyfoVxlgRd5tAjiNz4zlZpLlPBxbOYJd+sVBprlJOt9sCpkadgDf+EMfW+nT+HAQz7dmb4j1cWMKVLw0Nti
X-Received: by 2002:a67:ec8e:: with SMTP id h14mr49850337vsp.17.1561420458245;
 Mon, 24 Jun 2019 16:54:18 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:53:32 -0700
Message-Id: <20190624235334.163625-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/2] bpf: Allow bpf_skb_event_output for a few prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

*** BLURB HERE ***

allanzhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 33 ++++++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

