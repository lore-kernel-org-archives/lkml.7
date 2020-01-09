Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E2C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DBB2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="rpbyJddq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgAIL6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:58:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgAIL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:58:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so2597191wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 03:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW/jU4nMv4mGFekrAe/bVdVaRHEifMOWCDSe/Rg3qfU=;
        b=rpbyJddq33B9qvSn4dhdc1kg2jDsQ5NECfImsJP0BmRVxX8YUmk+GZcwqJ/9GgwemW
         SkhY18OP1SxlTsHKFBzzBjzzArXq/PvYW5botlr9MrTX37wAcoZbEusNvNDDoddttatK
         20KjUtmfCziPSocV4nL54W0IvoVY7BP+gDu/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW/jU4nMv4mGFekrAe/bVdVaRHEifMOWCDSe/Rg3qfU=;
        b=dq45ktIxIRbUToTfi7KAxMaLdMynXvWe+7GafyrsbO0QBE1VemQUhMVj8XKij08PNa
         yWJSeFt3PxU2FdrPq+D0XawTZdMp//zhBVBjAa80NuMaXOkgbmY9YNQAY1c4YyWIDrtk
         jHlYCEoWQGBOzrlViYo0yWfsI/r4iLzzQ3Oi2gq590V7/RInm2ozODo1nYcG1lKwNrb3
         oI0IPEqxQcbR246J3SZ2RNEiwtUs16GvAY8U/X22s0Gm8CU1fAhpcu2Z5BhPSZ3sq4Vh
         a1zmDFAKQeOvSnWghZGBvHt6quv901EtdDA8e+k17/rWFxPAfruT2sxx9Z6vpaLY25b+
         Iu7Q==
X-Gm-Message-State: APjAAAVKR6BuEN0ij7al75ofb3M8PicAqrM/Wz1lQ+FGTDTSIOf3FKuQ
        gKp19U6q0hydcg5XamKJ5GQbqCrN298=
X-Google-Smtp-Source: APXvYqyBBcuvlKP3rGxkVcWLSllnjwn3aZuUrL+BdEqPQQcw/OUbBeFbOxs/AISfrFWwOfHd6Su6cg==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr4618431wmh.58.1578571123550;
        Thu, 09 Jan 2020 03:58:43 -0800 (PST)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:cd2c:908b:e15b:9937])
        by smtp.gmail.com with ESMTPSA id z124sm2728120wmc.20.2020.01.09.03.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:58:42 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Joe Stringer <joe@isovalent.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com, edumazet@google.com
Subject: [PATCH bpf 0/1] Fix memory leak in helpers dealing with sockets
Date:   Thu,  9 Jan 2020 11:57:47 +0000
Message-Id: <20200109115749.12283-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rolling out a new BPF based TC classifier I hit a memory leak, which
manifests in large numbers of request and time wait sockets not being released.

The root cause is that the current BPF helpers dealing with sockets are naive:
they assume that sk->sk_flags is always valid. struct request_sock and
struct inet_timewait_sock break this.

I've fixed this up by adding a helper that checks sk_state in addition to sk_flags.
The solution is a bit clumsy: it encapsulates details of struct sock in BPF.
It would probably be nicer to have a sock_gen_put + SOCK_RCU_FREE function exposed
in sock.h, but that might be too big a change for backports.

Thoughts?

Lorenz Bauer (1):
  net: bpf: don't leak time wait and request sockets

 net/core/filter.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

-- 
2.20.1

