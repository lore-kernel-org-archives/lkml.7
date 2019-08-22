Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C92C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7321744
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eqp/T0lJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393820AbfHVWJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:09:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46570 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393808AbfHVWJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:09:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so4453457pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uYgPzTJBSidHw5rofgv1d7XIJLrP8BBx5dx0dnIxLaU=;
        b=Eqp/T0lJX6voDeerzbLZz2z62udbQ8JbYtCoxl8fpZ/fehQ1JxGVv2NF6u/4UU6IML
         jGNNZ8XgkZucbJhi8OK9rSR4FaCOTDhu66iVkp5EVfES9nFIA/ojfqTtmpkgH6+F33a4
         pEKfXcRnXzxYICeBAr5B7Bnz2LMQvQpmm5kpSRPZEQw05r8SZqaAbw0CpWWXvj+vBNkk
         P/iLorr+Oxh8THpeNuUwDahCrWTELDopP3a1jdJkYixY2QtkY0W8ttI4/RvmErfhtAaX
         B7aeQIa0StrASQKuVIBt+Z/035I1APcYvmcrZrUonofpIOeIpgNpRF5OzRESz/6QaRKk
         qyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uYgPzTJBSidHw5rofgv1d7XIJLrP8BBx5dx0dnIxLaU=;
        b=PYPEzKWQvUCTLDos1AfEPPZg3njgUpK7snr09YFeAbiCDVJLLvf2WoKChWhm7i0zJ4
         DPv8caY66VcKlFOotgj7xaFWqhv35/KOxqT7kz1Y6a4b6jsGJ7tRpEqsyGFvIZbJTKIo
         AeI87QqLVxpR6Ihpaf1JDiuj0mJECnxTubMiKjwOedXUWNLST4TgiFohuniM5/SU1A32
         wPJ6rpiI/rEArmGntHrQrl/EsvoHZfUCpO1e84CcWNIIKLa5RUigyAVJO0NVGQpuYURt
         6AU4a5gYySyMVw3PxV+v+TbggUf3G2PQFCaxcywOHhe+dyPNi8VLxNos940ZkTOY35r0
         mxPw==
X-Gm-Message-State: APjAAAUX4MvV+5W5g257oM6F8sP/4ZcPxcMQKVsf1butzfwv0SiB3tKs
        8pTbEW3RnKVSAbRSLiHkRbYfug==
X-Google-Smtp-Source: APXvYqznJGjtkxMx+LPgYTr2KV51e6oE+5OZSSDWV6Sob4CnwVBizgP0XyiDvzhwRVVxEkrDYljWFA==
X-Received: by 2002:aa7:934f:: with SMTP id 15mr1555731pfn.22.1566511757674;
        Thu, 22 Aug 2019 15:09:17 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s7sm377432pfb.138.2019.08.22.15.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:09:17 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     yabinc@google.com, suzuki.poulose@arm.com, leo.yan@linaro.org
Cc:     mike.leach@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] coresight: Add barrier packet when moving offset forward
Date:   Thu, 22 Aug 2019 16:09:13 -0600
Message-Id: <20190822220915.8876-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yabin,

When doing more tests on your patch that adjust the offset to fit the  
available space in the perf ring buffer[1], I noticed the decoder wasn't
able to decode the traces that had been collected.  The issue was observed
in CPU wide scenarios but I also suspect they would have showed up in
per-thread mode given the right conditions.

I traced the problem to the moving forward of the offset in the trace
buffer.  Doing so skips over the barrier packets originally inserted in
function tmc_sync_etr_buf(), which in turn prevents the decoder from
properly synchronising with the trace packets.

I fixed the condition by inserting barrier packets once the offset has been
moved forward, making sure that alignment rules are respected.

I'd be grateful if you could review and test my changes to make sure things
still work on your side.

Applies cleanly on the coresight next branch.

Best regards,
Mathieu 

[1]. https://lkml.org/lkml/2019/8/14/1336


Mathieu Poirier (2):
  coresight: tmc: Make memory width mask computation into a function
  coresight: tmc-etr: Add barrier packet when moving offset forward

 .../hwtracing/coresight/coresight-tmc-etf.c   | 23 +---------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 43 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.c   | 28 ++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
 4 files changed, 64 insertions(+), 31 deletions(-)

-- 
2.17.1

