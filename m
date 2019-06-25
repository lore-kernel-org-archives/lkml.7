Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF8AC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA020883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjaQkMYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFYWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:23:35 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46990 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYWXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:23:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id 18so277833qkl.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FdBlpsagwTRJbMA7Hzk2BzRggzKya+4KQ7pkEf2Z5gw=;
        b=ZjaQkMYUkVw2qRpcALtuunmsZ+Zwf46cVly3MO9ik/a08Obk5OT8J2DESoeGq0lMmO
         wbpr94q9HezhukSylrQ//o0WIt/qVQK7QQzrmj8myVJg0r1qmp/3KTnN+QPFKR04RYBv
         iKJTH/dd6m6YLLBgWT73W5pkpY/+m3r7JtgxrKT4dDtHqhSTx9G4PRvaNmaozy+Ej4bo
         hmaTq88FLWZRlpto+jOlTjU2Ld3zX+OFqG3fQtFmAZczAjlIR/4gM/ac8b0ANa0qy6CQ
         WHAX4UkqSyAfQiz/rVxgGo2ekmVXsr66zB5TUAk9nQkZOU5tOWQ23p4w3S3ECQZSO0UD
         rL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FdBlpsagwTRJbMA7Hzk2BzRggzKya+4KQ7pkEf2Z5gw=;
        b=tkVqcV5mcHbmHZyBqHgW2MgJb+FyRB0/KPHMriZRRqvnhx8jUzMv3GZjdaYIBCBe7G
         EkoSkh9q6yYRHtaE+EHXTrdom0sqCfALm6vju3uxvhxuPo49DQ4XoarWtivTkGfx0IVC
         41pvOBYmj8c3opBMGiAAGNvYmOlkMGWzcKE+MtQnX2leX4sD77YvVhJ7rVScOVjnOUqS
         A8YDMNIy+FGyax+G+/rYMmlmuJKkaJvNgGRBQewIp93/MNj/SwLrvXDT4MNEAVcA/1Ky
         +pnFJ3Es4pRVR8Os8l9qIAA4UR/tUxOKeoU9uQ6QxscR3+plxbyLBXsB8+p5ywOmLxMN
         YzuA==
X-Gm-Message-State: APjAAAW+k7Od/415Wk37Kf+53fA6ZgzPpSq2kpRaTvgmkFAL6gZqNoEc
        Tene6FpU4PVPo8/a+Kjl9UZVEKBB5LLD/VYe
X-Google-Smtp-Source: APXvYqx3scg0ElyPMQwkLEek4soTUEO+ZZuGgUXriNHcDBT2orpnKlALW2BAm20RFpwGt0QKe1eFKDmGWUix9mdZ
X-Received: by 2002:a37:9e4f:: with SMTP id h76mr863302qke.469.1561501413909;
 Tue, 25 Jun 2019 15:23:33 -0700 (PDT)
Date:   Tue, 25 Jun 2019 15:23:27 -0700
Message-Id: <20190625222329.209732-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v5 0/2] bpf: Allow bpf_skb_event_output for more prog types
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

More prog types are enabled to access bpf_skb_event_output in this
patch.

v2 changes:
Reformating log message.

v3 changes:
Reformating log message.

v4 changes:
Reformating log message.

v5 changes:
Fix typos, reformat comments in event_output.c, move revision history to
cover letter.

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

