Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B0DC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0232146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="EYGzdgf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfFGOLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:11:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37778 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfFGOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:11:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id w13so3249582eds.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GW1chtOYexn3iEYy8Pq9DlSLLB5ej7vVGOlF8xEFfgU=;
        b=EYGzdgf8GAFWo+SUyvKer6mt4TBmt6hBTlBmp7LWW7m2jE7nTiqLOxmCZV8tazHxrf
         M1SSmcRjBT8RT7KRPwphdtUa0AII+xGWk8LYzp2KzYic2GPc7D++koW3LSe9BqZ+AVrc
         PX8vgtxaB/YP8EWs1dzemyRdcps5F8/ftMbis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GW1chtOYexn3iEYy8Pq9DlSLLB5ej7vVGOlF8xEFfgU=;
        b=SaoZA3fTAB9lUYe787q8BOATkZV/B8yNtv6FRB1VADaEj7I4EvUF/Q77XtNKpMi8X5
         1mQ3kmgo4qewI+t42SNGUzynjtTCnGFOLLLDn/zw5gt6C7M9ELHmYyXo34sY7y5h85fj
         +Q/HIUMO/Wahfq8F37CSH6d101Y7GCsOjxnvOGU27vrCvEkJJZXm3M7o20irzaSOrato
         LQsMrXmWcBEeaYhrDXXi9wyI2CNNAUcuWgt31/UiTjO1UfWpZfuTqw0/sRtj315eyJMZ
         vMFEmk+A8dcLPFNEDbY9DaETbJ3uKw8EmHskTOP1x8MJnnjhNWIxAyrguTsy1W4zCtFV
         USMQ==
X-Gm-Message-State: APjAAAVJ6lykZ2UayyIs0/M2ptktlnuffKYlin848JcGSCA7eEthkUFR
        5+PF2GkhMJHKU3M/HwCtznr8Xg==
X-Google-Smtp-Source: APXvYqyFO8OVO9Ek1HXeW7uJldc9Q3IHl5BmgqroEGn0wz7sBZvCdcPBXBgzAj+vO/RGzRoDloQRMg==
X-Received: by 2002:aa7:cdc4:: with SMTP id h4mr47346453edw.221.1559916671307;
        Fri, 07 Jun 2019 07:11:11 -0700 (PDT)
Received: from locke-xps13.fritz.box (dslb-002-205-069-198.002.205.pools.vodafone-ip.de. [2.205.69.198])
        by smtp.gmail.com with ESMTPSA id a40sm546116edd.1.2019.06.07.07.11.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:11:10 -0700 (PDT)
From:   =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
To:     john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net
Cc:     alban@kinvolk.io, krzesimir@kinvolk.io, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>
Subject: [PATCH bpf-next v5 0/4] sock ops: add netns ino and dev in bpf context
Date:   Fri,  7 Jun 2019 16:11:02 +0200
Message-Id: <20190607141106.32148-1-iago@kinvolk.io>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows sockops programs to access the network namespace
inode and device via (struct bpf_sock_ops)->netns_ino and ->netns_dev.
This can be useful to apply different policies on different network
namespaces.

In the unlikely case where network namespaces are not compiled in
(CONFIG_NET_NS=n), the verifier will generate code to return netns_dev
as usual and will return 0 for netns_ino.

The generated BPF bytecode for netns_ino is loading the correct
inode number at the time of execution.

However, the generated BPF bytecode for netns_dev is loading an
immediate value determined at BPF-load-time by looking at the
initial network namespace. In practice, this works because all netns
currently use the same virtual device. If this was to change, this
code would need to be updated too.

It also adds sockmap and verifier selftests to cover the new fields.

Partial reads work thanks to commit e2f7fc0ac69 ("bpf: fix undefined
behavior in narrow load handling").

v1 patchset can be found at:
https://lkml.org/lkml/2019/4/12/238

Changes since v1:
- add netns_dev (review from Alexei)
- tools/include/uapi/linux/bpf.h: update with netns_dev
- tools/testing/selftests/bpf/test_sockmap_kern.h: print debugs with
- This is a new selftest (review from Song)

v2 patchest can be found at:
https://lkml.org/lkml/2019/4/18/685

Changes since v2:
- replace __u64 by u64 in kernel code (review from Y Song)
- remove unneeded #else branch: program would be rejected in
  is_valid_access (review from Y Song)
- allow partial reads (<u64) (review from Y Song)
- standalone patch for the sync (requested by Y Song)
- update commitmsg to refer to netns_ino
- test partial reads on netns_dev (review from Y Song)
- split in two tests

v3 patchset can be found at:
https://lkml.org/lkml/2019/4/26/740

Changes since v3:
- return netns_dev unconditionally and set netns_ino to 0 if
  CONFIG_NET_NS is not enabled (review from Jakub Kicinski)
- use bpf_ctx_record_field_size and bpf_ctx_narrow_access_ok instead of
  manually deal with partial reads (review from Y Song)
- update commit message to reflect new code and remove note about
  partial reads since it was discussed in the review
- use bpf_ctx_range() and offsetofend()

v4 patchset can be found at:
https://lkml.org/lkml/2019/5/24/714

Changes since v4:
- add netns_dev comment on uapi headers (review from Y Song)
- remove redundant bounds check (review from Y Song)

Alban Crequy (4):
  bpf: sock ops: add netns ino and dev in bpf context
  bpf: sync bpf.h to tools/ for bpf_sock_ops->netns*
  selftests: bpf: read netns_ino from struct bpf_sock_ops
  selftests: bpf: verifier: read netns_dev and netns_ino from struct
    bpf_sock_ops

 include/uapi/linux/bpf.h                      |  6 ++
 net/core/filter.c                             | 67 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  6 ++
 tools/testing/selftests/bpf/test_sockmap.c    | 38 ++++++++++-
 .../testing/selftests/bpf/test_sockmap_kern.h | 22 ++++++
 .../testing/selftests/bpf/verifier/var_off.c  | 53 +++++++++++++++
 6 files changed, 189 insertions(+), 3 deletions(-)

-- 
2.21.0

