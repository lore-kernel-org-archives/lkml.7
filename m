Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC3E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7sJH1ky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfHZTqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 15:46:08 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35092 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHZTqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 15:46:07 -0400
Received: by mail-pl1-f171.google.com with SMTP id gn20so10527766plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qMpP0MgShBQ+Pe6ISqup2rRvNK7sBJVKGzHYTIV6ZnQ=;
        b=l7sJH1kyE+MeklaUOVqk93JQJS9lLUqeyPcIRpMyDtZH/3DmYcsR0RnqkmB7II5YO8
         wH03/UzYjG6K4m6cqKgTSSiytDQYWC8mccd5QCYgy8iUu6+NousnkGzzTY0Of6b0VSAD
         QYxaCA6obMGor10rrTVZkM3j2LR5GCMQk12d7318PdYf1o8f0s7TuNsi9VT4xeQFqEz7
         GaocepPIhJlSy3Axc1UEoz6Lc4CH0JZMyrIbXJTT0p28lwWmTLZCpwjsZemCITHlpjmc
         Y4pRXdqpWcNuRzF6Vjm8Iy62PazNgwdRwUVpTcy41YBJpBQMdyr9dQBHP5Uhh9M9zZsr
         iAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qMpP0MgShBQ+Pe6ISqup2rRvNK7sBJVKGzHYTIV6ZnQ=;
        b=ca6HOolb1U3kDqyf+8tSM7XFNTZynfvGQ0X9pbF+XXmBK+ErxWWg/JD8ED+JfCbuTr
         8BZMo02D5h/is2ID0rpomYjnL++rNP4MhWEeNhBVHBLTHBAa+Kpoe4y9Czypb08PF9t3
         e3GDQcFNI8CkpHUxXSa4dMj/iOYNP7H7ww+iVsdlkPE+/PCXYQ7GR2Ruio1aA+rzNj8b
         85n8vPQzEuS5a9IX/c4jvHzi8cb3W1Z7gQRId2fMiJQw5bkWl52AHk6wKF9dQs2Af8eV
         gGsRlsuEe+yjLmytoOc3Ryqa7EmVkz0kwNZZQffSEWj6ms7DsUBCPnsJNP1BO/LrWPnL
         ia7Q==
X-Gm-Message-State: APjAAAUvqZfHrsm0n0aFdPconrVFD3x0NamH/Aoyi/KhIjg7LRNQQScn
        +Hf/rrrR0SgkMANQQCST1/tQsc6oHpE=
X-Google-Smtp-Source: APXvYqwJgW9p5d6lqmBLWSOn0KbFlJ2MZBxLif5mU5pNMrb/4c+qlzMdTjm39DN9LeG62T1DKxyQ0g==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr20949583plb.195.1566848767073;
        Mon, 26 Aug 2019 12:46:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c35sm13214789pgl.72.2019.08.26.12.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 12:46:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     suzuki.poulose@arm.com, leo.yan@linaro.org, mike.leach@arm.com
Cc:     yabinc@google.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] coresight: Add barrier packet when moving offset forward 
Date:   Mon, 26 Aug 2019 13:46:02 -0600
Message-Id: <20190826194605.3791-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set builds on top of an original patch by Yabin Cui[1] that deals with
cases where the ETR buffer it bigger than the space available in the perf
ring buffer.  The work herein complements Yabin's by inserting barrier
packets after the head of the memory buffer has been moved forward in order
for the trace decoder to still synchronise with the trace stream.  

Applies cleanly to the coresight next branch.

Thanks,
Mathieu

[1]. https://lkml.org/lkml/2019/8/14/1336

New to V2:
- Added Yabin's Tested-by.
- Addressed Leo's comment about extending the solution to the sysfs
  interface.
- Split the work in 3 patches rather than 2.

Mathieu Poirier (3):
  coresight: tmc: Make memory width mask computation into a function
  coresight: tmc-etr: Decouple buffer sync and barrier packet insertion
  coresight: tmc-etr: Add barrier packets when moving offset forward

 .../hwtracing/coresight/coresight-tmc-etf.c   | 23 +--------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 47 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.c   | 28 +++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h   |  1 +
 4 files changed, 67 insertions(+), 32 deletions(-)

-- 
2.17.1

