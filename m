Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE1C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39C20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhTI0VON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbfFXV63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:58:29 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:43125 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfFXV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:29 -0400
Received: by mail-vk1-f201.google.com with SMTP id j140so4356966vke.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=RhTI0VON+5np3cwB/7HOu3t/iTPn2XCK9u35az8zZzqwq33aR1/TRgDApIz75TYjeD
         taeLRalcKhbhPepoAbvK52wnMDZ4a4X4rQyvghiYUBX6lvanbJlq1DeR0k4U1q7eFNYV
         BF+JEeZCIrldZEWNpdVz2IUoRYv+zgxEMD/AiCGhXJwswmAgGA3GeNHqIk31m5cbt2l1
         uwJ2HebPA8Tcrtk5Sq6k1GuOo6rkny49EjlVuC3wxvojrEBmBFbu3QlkfxniDohl6kCZ
         KUcCvCDfB5huDAVj39axpBOZIQ0XycHOBqagQKH8BqMaTmCzE2FHM+KvrEaKpSm4zON1
         p9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=qE1PkE0tVUdmx5k1iW22WVPzqzjEhrLBaFkNGuf+9UbcQyfGh918aKf+rrs36RJd1w
         oQ31ZK/taQ884YV/EdSjYiRuAc6ZJ0v8h9AzRg/i2rHitkqjNn1hpSxQzLyRlFWO63Up
         NMK/eiDRiSJeXNqDT/RYhT/QNxT5ZD0iHC4yZ1XSJIHZKJnGomBtwGCfS3fh1tTWdojE
         h5wuLOcgexyCcYMBlWIBRn+yCJSflUxn+3ZiGLVl0M1EoB2Ws72ddbvD+W4UhTEHeXAk
         1wVl5GDN7NQN9UYpjPyxh/VpMxiKs4jesM6dJdhyGjqapiGSRJBzrCPWH3PGehNFAHuO
         4rxw==
X-Gm-Message-State: APjAAAXbNjn2fxbjRu5bBtF2BMeDS9+KUqmPGpACWkQfKUxjE4HN34PI
        oZI18BqrbTlIsiafmxjOWAMLxHvhKQrQ/JB/
X-Google-Smtp-Source: APXvYqysClsnN/4Bk4V5HqW6LruC+5/Q9jhmidRxur/KiP8HrehrQutBwAy9P5+/J7jI4WPt5SLBO8hZ4T+vVzyY
X-Received: by 2002:a1f:4107:: with SMTP id o7mr4981084vka.34.1561413508074;
 Mon, 24 Jun 2019 14:58:28 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:22 -0700
Message-Id: <20190624215824.118783-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] bpf: Allow bpf_skb_event_output for a few prog types
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

Test bpf code is generated from code snippet:

struct TMP {
    uint64_t tmp;
} tt;
tt.tmp = 5;
bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
                      &tt, sizeof(tt));
return 1;

the bpf assembly from llvm is:
       0:       b7 02 00 00 05 00 00 00         r2 = 5
       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
       2:       bf a4 00 00 00 00 00 00         r4 = r10
       3:       07 04 00 00 f8 ff ff ff         r4 += -8
       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
       6:       b7 03 00 00 00 00 00 00         r3 = 0
       7:       b7 05 00 00 08 00 00 00         r5 = 8
       8:       85 00 00 00 19 00 00 00         call 25
       9:       b7 00 00 00 01 00 00 00         r0 = 1
      10:       95 00 00 00 00 00 00 00         exit

Patch 1 is enabling code.
Patch 2 is fullly covered selftest code.

Signed-off-by: allanzhang <allanzhang@google.com>
