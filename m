Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C7C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D8220679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sv074q9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfHMKXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:23:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42317 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfHMKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id s19so13706180lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QNDFND62EBxa/CZRfT2L528o2r4UiKoyt1lXZ8Vl8r0=;
        b=Sv074q9r6jjjV52+0QfZzuE3FVJ3Gnln117xHMSh0yUvexXHce7Ca19L/ufyAwW2HO
         GIClTLInezjob7m5kYcfJp06RDsK5LbIt1PVa0yyOiPjYGT1MX0emf5Qw+8LsdQmqD4G
         i7TyVRxmOnXFrQ2F1yS5yYC1UD4dqbZoqyS8f1FFm8zfVPnI/i10qZFH7zRYx62ei9PA
         ouW68VPvY60rLwI0xusK8FygNzR41KW2tS6pxLqHVQUr1qWFq5yzk6VczQGboJWjG7lI
         7+bMfcre/Fj5GJ8/+vMBLq84HkDazNq5iFBJTRQXEf934J6KXvaTZe8jxZMyBQKNoSGU
         V00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNDFND62EBxa/CZRfT2L528o2r4UiKoyt1lXZ8Vl8r0=;
        b=IRGkmBviEj3Rxs5cGrSOaQWRoN+qXj+A5PiPoijGs5xWpdb2sQ6UL58RLxsW9ia3Ru
         cXWdYXkyog2nwqBoj/NfeyRfX7Nx5ARmVe4uZIQvRqGVKwp/qEmuSn0I9ad9luTjVBaN
         FOliSSjbyyQwqFUwcSaMLTogr6FkxJ1A3L3ettTypwnwfIUiO8WxIzT8EiZiSI4kzbmm
         5p4ef+7TEtBNF/q2M5BPLpf4QkToZeKZXS0+qtmhR4R7cQhwFe0M5h7n051zFMhsbihE
         vxjn2SQ1Bqjc6CK1A7fN9DDLoYrM4ZC/c0ljEfQYLEUKpp12s4Z6aHmNsBytFvsl/TKy
         /plg==
X-Gm-Message-State: APjAAAXs9IfZOL3V2Y5CYDD0tt8CmZeCvlCST8kT4Un6J0xubn/vc8mB
        Mmwq0DIgpXsiuHu0+d7XkUpC9g==
X-Google-Smtp-Source: APXvYqzIeZP4BTswUMbAIKKYK0uFCs4Sn6L/wWwzKIQ+KwsGx46yWPFum+AePDpFDtH7gV8rVc/mKw==
X-Received: by 2002:a19:c213:: with SMTP id l19mr21590844lfc.83.1565691826113;
        Tue, 13 Aug 2019 03:23:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e87sm24796942ljf.54.2019.08.13.03.23.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:23:45 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 0/3] xdpsock: allow mmap2 usage for 32bits
Date:   Tue, 13 Aug 2019 13:23:15 +0300
Message-Id: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains several improvements for af_xdp socket umem
mappings for 32bit systems. Also, there is one more patch outside of
othis series that can be applied to another tree and related to mmap2
af_xdp umem offsets:
"mm: mmap: increase sockets maximum memory size pgoff for 32bits"
https://lkml.org/lkml/2019/8/12/549

Based on bpf-next/master

Ivan Khoronzhuk (3):
  libbpf: add asm/unistd.h to xsk to get __NR_mmap2
  xdp: xdp_umem: replace kmap on vmap for umem map
  samples: bpf: syscal_nrs: use mmap2 if defined

 net/xdp/xdp_umem.c         | 16 ++++++++++++----
 samples/bpf/syscall_nrs.c  |  5 +++++
 samples/bpf/tracex5_kern.c | 11 +++++++++++
 tools/lib/bpf/xsk.c        |  1 +
 4 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.17.1

