Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67349C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1Kj7Y5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfEWSWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:22:06 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:45203 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbfEWSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:22:05 -0400
Received: by mail-lj1-f178.google.com with SMTP id r76so912491lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BpudeZUFrlSCrP2B/P8tYhvppT/zfprdXnWGePwKYEY=;
        b=C1Kj7Y5GxYetF4BJIrBU3mwtg+1jBuR+s4zE+5z8qJiCT051vUBnhotoYeT0lGeAcT
         8LYq3F8uCk/jcJOeXib9IPyvXg5tc5UFAAUQOMn5w99pNQEv8LGobIdeAcVpsVa8pNgg
         yd3gQg2gVJhejNSJywyYV8zN5fNUTBQdP1sOmxbAK/jI8xvU6RPge0d3foYEKc7zPoej
         wI0mYtO2kf6DTRKPKbSSh7R/8Y7FsBbExCoKynTia0WGJR+4JMioi7pquR0PHQWEDdQO
         MFgdv7KWcTUQLu31FzrE4Y1uOe9g8PxhU847czYZJXvuNpR4zBzE0aTKmpC/F5cmvZ7Y
         H3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BpudeZUFrlSCrP2B/P8tYhvppT/zfprdXnWGePwKYEY=;
        b=Aup9dC1u0D5y9gvdBy+Abree12/VNHdwSKA8+5u/ryqS14RtCzzSwO3jwVVRmrS2GP
         XA9IjpyPWJ0W9rAgGfqUk407APKmT2+kgcPdowvQvwHUQA9Bba9S9coJYrqZA9owlugu
         0Ug4M34k8c2l6PdiNEol0t5uYHV/EHmfR4slspuGjpd6QSnakPkaKRzLAaFYBNWB10Tv
         KIpiDfjoWjj0CshG5ZjMdr2MKqziJGEoKEnhJx8mBUApvCoOYby0wSnJrbme6R4BZP/h
         9ID7KmSS/LxHq7koOkmNrhwvypUIslT6GH0MglRgdFmfo/towVBsQEcAYkT4GHkSzor4
         wCvw==
X-Gm-Message-State: APjAAAUmlHAdGJb5wcE0SZG2jPu0IXMd5VA8dIdSo7x4zv4FEBNFnEO5
        TUo3PJybOSSjF+S6ZSAEgnyFyg==
X-Google-Smtp-Source: APXvYqxAQ35H8/+Zfus63wHMy+Bnd9HPsOnmwYG4iAGndPLMW6rfYPQxR/lFRUGy5T2Hwi1tG2t4zw==
X-Received: by 2002:a05:651c:150:: with SMTP id c16mr49794302ljd.65.1558635723403;
        Thu, 23 May 2019 11:22:03 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id n26sm59904lfi.90.2019.05.23.11.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:22:02 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, hawk@kernel.org, davem@davemloft.net
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, xdp-newbies@vger.kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/3] net: ethernet: ti: cpsw: Add XDP support
Date:   Thu, 23 May 2019 21:20:32 +0300
Message-Id: <20190523182035.9283-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add XDP support for TI cpsw driver and base it on
page_pool allocator. It was verified on af_xdp socket drop,
af_xdp l2f, ebpf XDP_DROP, XDP_REDIRECT, XDP_PASS, XDP_TX.

It was verified with following configs enabled:
CONFIG_JIT=y
CONFIG_BPFILTER=y
CONFIG_BPF_SYSCALL=y
CONFIG_XDP_SOCKETS=y
CONFIG_BPF_EVENTS=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y

Link on previous RFC:
https://lkml.org/lkml/2019/4/17/861

Also regular tests with iperf2 were done in order to verify impact on
regular netstack performance, compared with base commit:
https://pastebin.com/JSMT0iZ4

Based on net-next/master

Ivan Khoronzhuk (3):
  net: ethernet: ti: davinci_cpdma: add dma mapped submit
  net: ethernet: ti: davinci_cpdma: return handler status
  net: ethernet: ti: cpsw: add XDP support

 drivers/net/ethernet/ti/Kconfig         |   1 +
 drivers/net/ethernet/ti/cpsw.c          | 570 +++++++++++++++++++++---
 drivers/net/ethernet/ti/cpsw_ethtool.c  |  55 ++-
 drivers/net/ethernet/ti/cpsw_priv.h     |   9 +-
 drivers/net/ethernet/ti/davinci_cpdma.c | 122 +++--
 drivers/net/ethernet/ti/davinci_cpdma.h |   6 +-
 drivers/net/ethernet/ti/davinci_emac.c  |  18 +-
 7 files changed, 675 insertions(+), 106 deletions(-)

-- 
2.17.1

