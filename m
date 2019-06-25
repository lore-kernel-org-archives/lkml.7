Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A1EC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F2220644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhcjcAs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfFYR1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:27:25 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47824 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFYR1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:27:24 -0400
Received: by mail-pf1-f202.google.com with SMTP id f25so12266456pfk.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hTJIxoyoSbZZ+l0CCDRQzN4eQIToWW0/kgz0Q6JFjf4=;
        b=MhcjcAs3LEBD+vkQbdD9TWhi3dSZjKM7pPmbUKoDowcFMsmHVmyLRh1fNOIBfflDAX
         CIzNUb96xZm7BILKsyS4feJ9qPRHLbikO0Aazvo95ekSx51HHld4RtuyCrpAz9bNYP34
         lt/arVszR6L3Q8Zk+95EG2nmSRBxuNEgVIEjAxlFZxN7Oryd3qA0FMcZzqCqBIDcEudw
         KKk/0nw1x+fXv9Qx4pf39ELAnC8KYlh04TAPCMnHOH8Q278mHQ6fXkUT/IPicg+8rTWR
         in+g31w2EvhnAz/+/cOb5J6464aCVd75M3KBw80dmqjy8GQmmPGjmgHQA7xcycbcqPcA
         C21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hTJIxoyoSbZZ+l0CCDRQzN4eQIToWW0/kgz0Q6JFjf4=;
        b=JJkFjJy/Aud10XcXr2DLQV6qVn+COd2b+A3sa3T/ajmddGtVmLF6hgzy9FzA7hireg
         XgP88Z/BnRwFhGo0yBpNlXLPU0nK0xqoGYQ0tMruNUS7gOO3RwRbDXHMljFWZikQWWZF
         xSmZIfx3MMwj1AyBwBqm3xnhvHBtzTo2C8LX1ljs3MObbt94hJRu3rqi5KQLFPPzO22M
         c0REx+dpTUDmnYZbzd69Xy0rcCWFuYvEHkdAWeBCbCE1Rz5AhXGnM3QNIokUX26jhpiy
         EVBIBSejkpO2KmuTXKzi8gSRlScF96yxvgKJgCh714Fn1fECpga5mAGNn/WKP0kx0Jh4
         P22w==
X-Gm-Message-State: APjAAAVWJOws0GBIlBTVaFiSzFo+ZHG3e78h64ZbV8CHYZ5bHb9wkfpr
        gtrjvzOixkhSu6hm7p+cDMcwTNZLxay+VZTX
X-Google-Smtp-Source: APXvYqzS171nDYh6J6BwTctWj9MK+TT5o8Ua6zQVGFYAkmN/ikFB54mK/+hw9BGKX8GAIwsEV9thskkpDDY4C5XG
X-Received: by 2002:a63:1462:: with SMTP id 34mr40179941pgu.417.1561483643508;
 Tue, 25 Jun 2019 10:27:23 -0700 (PDT)
Date:   Tue, 25 Jun 2019 10:27:15 -0700
Message-Id: <20190625172717.158613-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v4 0/2] bpf: Allow bpf_skb_event_output for more prog types
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

