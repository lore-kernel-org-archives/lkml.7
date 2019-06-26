Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EBE20883
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6HF3nqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfFZAi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:38:57 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38050 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfFZAi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:38:57 -0400
Received: by mail-pg1-f201.google.com with SMTP id 3so431320pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cALMpl1zhJhWyFsIJDuEGXPsZBtZwwHf9RNESh/DFIw=;
        b=q6HF3nqqskhjv+PSJGKOWHW3tR81pXc8EAsARsWrFtWfpmOTBajscuH3kgWx7gTq88
         UscPLsQhLExTfPPb8s8o9eux2AyHu5J31jpIYk81/O8PBTuJbE1/CuA1Quq37WkVBNVL
         Mu+rAsKAh64Fh4K1xmweEiFKJ7qkiDN4VPhJR9ERhv1h0yhwy38SHbCIQbowZ76CEnyI
         Y1+OIb7ZLCdVNWy50zvvroF+R+QJQszp9jsRnW6Nsr+meEuzcJaH9FMiZj0I6pZKbwtI
         4+1gekk3WxjZGND8TJx+/OMxg0HCBgreCjddGO+lzbO+NQRXoimoOWfXso0vFX4cUlnM
         wzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cALMpl1zhJhWyFsIJDuEGXPsZBtZwwHf9RNESh/DFIw=;
        b=ZuB03YNvnHmMO3EoRUQbIiMJgnAknjGuj1LZtBDqm3bP0ujGwI+Ym0qrzx1z0Y0Uk8
         IpEXMrHwkrqFdqYahwrTyt5dAaGBWwmjqAbSvaAk+0LzJrizvJbnS6VbCoWy9owg38Te
         t/Mo/67YnhWAnn9k3y8rEfeK1LgOM5fA6M8tlPkIvkVe0d5QWRbnOVrHeyYcW0rAltCB
         GIz9n9ieF2fu5MmASZJT0TAgHlUhA6+N2C0RhYVlaYnJohaAOWqJurA5Ud3wwk/rQy09
         UHW7XNoQGSXygd0lcD0YjhbqX84Kscr5NBtO+/yBDeENj+5+xDOTvZATME+wcFFU2FCA
         FBmA==
X-Gm-Message-State: APjAAAUY1mjo7bfi+z4hIPf8g5GvtNh8RdPIeRqaQrjI+U/8usIB2KM+
        rXE0eeZcWPnkvGWTtkO+BOQ7IWqKFazQtzA0
X-Google-Smtp-Source: APXvYqzsBFKGyDA2PqihhPpY6qxeUko0GVwQrfcpv5JxGJZAQguRpfdHPmcPJcuQET+xrL6DT6lvDvFz9BDkRC7U
X-Received: by 2002:a65:6102:: with SMTP id z2mr40322232pgu.194.1561509536303;
 Tue, 25 Jun 2019 17:38:56 -0700 (PDT)
Date:   Tue, 25 Jun 2019 17:38:50 -0700
Message-Id: <20190626003852.163986-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v6 0/2] bpf: Allow bpf_skb_event_output for more prog types
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

v6 changes:
fix Signed-off-by, fix fixup map creation.

allanzhang (2):
  bpf: Allow bpf_skb_event_output for a few prog types
  bpf: Add selftests for bpf_perf_event_output

 net/core/filter.c                             |  6 ++
 tools/testing/selftests/bpf/test_verifier.c   | 12 ++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 3 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

-- 
2.22.0.410.gd8fdbe21b5-goog

