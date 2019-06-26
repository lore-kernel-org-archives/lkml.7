Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454F8C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1509320815
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OULKLsIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFZX6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:58:07 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48690 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:58:07 -0400
Received: by mail-pg1-f201.google.com with SMTP id z10so201583pgf.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kFK6kUjpqNh/C0sbAwD586/2wF+g+pKdLWduP+48Qag=;
        b=OULKLsIl+2/igNiIyxSMQEZ09WlnN7Q5vcihYkyYKx5gqRl+4Fbh9jeuEqzKZBN+/r
         wlaJD5vkDwxc3zfuQt0mbw0H6y2M2Zuql6lPB6OW2f9Y3/sI+n7/KumjC/nymAHGz2qs
         twccjv2IPx5YPeC5dwXfnSl5SEqWbjesOYdm0T4gzPZ2l/QEOlJsyCVYp6EuZnWm29pe
         UoJUAJ/6/e2WR82o0NqGO08HkR5uxmV8Phz/tEKsE5TafnvB6pi9QMGj8choxTMwtsRz
         mDSuXDWWdIYDM+9AMHf4xixOtk5UojQRnVoyuBvCmUko3A54JVoBcMukHDpHSdR07LiG
         gFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kFK6kUjpqNh/C0sbAwD586/2wF+g+pKdLWduP+48Qag=;
        b=NKakLYK0h8BuYYBRPTcv1cUyTvbaIlIpWQgsLNnPU1MarBaUgiTD3Gh+cI++Urm+Hc
         1Hrhz1kFPmTuFxHHmZHShPwsaGCmklmrbD5VmTkTi9qMj+7Tc8QIvC6mCqz5qo2uocX4
         kk3AZgqTGdk9+W0pBtUkPoC8TiLzx5bYdhPkqgRAR3+iQYaqjxeJ+hYbJYO0IfF1O3yK
         k03rFqh/ET8/DAWCxJ5afIlOY98NuivOPcR9FjwuCMv3KLa79zlymODHwPdz3evzE5/B
         38DB4Ph99bEW2S+xgF5v50/+mRwi0p9eb1Ojzw/UKmOgfXBgkSvfN3ROGhL+6NwCGafF
         C+vQ==
X-Gm-Message-State: APjAAAUiIvT9p9DD2NGmcO1hBRXFYTFwLF/h+s60J2trxMGOIbi1dbk+
        QYOyLKmFQFVDJvm/jgK9i/VC3XV30UW0WuJv
X-Google-Smtp-Source: APXvYqyVcUdMzYMwzmbm6L0FaFU0CkZZDnGUw22g+ED0Vw7T6rHRtWPVv0iq15uAn/+jzW/PwGgqth77DdkSGtiN
X-Received: by 2002:a63:5048:: with SMTP id q8mr639484pgl.446.1561593486318;
 Wed, 26 Jun 2019 16:58:06 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:57:59 -0700
Message-Id: <20190626235801.210508-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v7 0/2] bpf: Allow bpf_skb_event_output for more prog types
From:   Allan Zhang <allanzhang@google.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Allan Zhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

More prog types are enabled to access bpf_skb_event_output in this
patch.

v7 changes:
Reformat from hints by scripts/checkpatch.pl, including Song's comment
on signed-off-by name to captical case in cover letter.
3 of hints are ignored:
1. new file mode.
2. SPDX-License-Identifier for event_output.c since all files under
   this dir have no such line.
3. "Macros ... enclosed in parentheses" for macro in event_output.c
   due to code's nature.

Change patch 02 subject "bpf:..." to "selftests/bpf:..."

v6 changes:
Fix Signed-off-by, fix fixup map creation.

v5 changes:
Fix typos, reformat comments in event_output.c, move revision history to
cover letter.

v4 changes:
Reformating log message.

v3 changes:
Reformating log message.

v2 changes:
Reformating log message.

Allan Zhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  selftests/bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 12 ++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

