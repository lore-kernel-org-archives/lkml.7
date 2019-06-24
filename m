Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3661C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAA620679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txqvv/Nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfFXX50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:57:26 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:56085 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfFXX5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:57:25 -0400
Received: by mail-pg1-f202.google.com with SMTP id b10so10311147pgb.22
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=txqvv/NrWF2r2ZYnikxukD/ZTGTxdxrEpeeOGHmXwj72GqxK2ht2VzPh7WQDvUOEvx
         fveeS03789E660Df7NgYySiBMq0CKfnt0FGrf+j0Ccn2Q8q1SUPKjPckd0zwOvi2S8Lm
         fTMZHhPZ2Rt4so+75FNenrstI74oZ231YwcoLAzFNzkScr9l99sN5uLzDadIRInd/sy2
         zSq3KdMgHT8SZI65hzgk0sGSFKdjTir5r+KZ4MDS5SoytMFRCAKJvHNZ7XT6h/cp2iDF
         HHPsjszn23XpCFmfrSA9dnk+MoClS1XLMfyLf3IfmKNR0qOJoAYvyKcGSTMGcqqvcYiJ
         pHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aQiVt1v1ZspQwRYs4b3nRqt7OstkFgTd68CV7/bkhBE=;
        b=dqtNgVdvhdRz2dkC2Lp2WjOx8hcgEXqPgH4+EBniPCIUquuQDWKhn8m1gHrP8DhPGC
         4eliQN/NxnsipFbPV6TXKE40ttE/PpLwJijcje5PxTzPI9evjyzve5t6ldlgg6BoLKHT
         3tPLFoWQhTRwu7o13Un+y1viNtNXA2dr8H0TEiQZjCVjszupmy9haS3lxGGhhowZmSQS
         RMq/uXM/DInZY8IIDePBwrvI/9RWGBO/y16dcOf+Ls1TlQ7y7DeRdihR5jkWp27+Gln8
         +6AOEe38T4kq8EsB1fWoEXkBEYJOVXowHmQZf2iNX58kxOe+yhAifQoNh3relEDJ36Si
         Vu7w==
X-Gm-Message-State: APjAAAWx6jcvkvOTdAI9FRYjdGDqWeqa6Y5H01uw6Ca9OMbeRTQ9ZAfC
        QnSI/yIEY8zHSDHqM/Bbdd4eYa9q3rw6FZv0
X-Google-Smtp-Source: APXvYqyVAz/J7JuE9xSQrMGwuqiw5jvMqJF2PJiivFk2FjhFS9d/dVj1l146q2/pkut1R0tC6xATSgINoHjQjykI
X-Received: by 2002:a65:560f:: with SMTP id l15mr12290186pgs.94.1561420645035;
 Mon, 24 Jun 2019 16:57:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:57:18 -0700
Message-Id: <20190624235720.167067-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/2] bpf: Allow bpf_skb_event_output for more prog types
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

