Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBAC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8472A2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9gDyHJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgAIKcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:32:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAIKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:32:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so6795767wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKOjXoXUmMkVLHPqpRRdxvzHegVqL9k6dIgoFzOzfdA=;
        b=G9gDyHJflfuiDJk23URo02ck7jlHsQ9ueEmJxO6KzNTwxjznlQk1OShugDNSSpOufM
         7IsSuPZqf6u8KEq1WfsvkS6q/zJpnrTP1kKggBjAYZ/BjtYKEmtYZvJ2gq7ADI1PrU7s
         V+FkHLsqI0D3xNEc+qQ0SHEfPKGSAbqnILEyMGYH+1gn6RJlp9WL/4iU6F7V4/APxUrP
         jP48GQQUmuFXlb/zG7e/1znyVaqVjar73l2Jl45c3uFuvYUKq1LC5e9oyCJudkAmW3lf
         QlCOZKALQIxEXWkt5pL1V9jFbMei25/5C0EvcUILvN0O45NzuhjECcV6bBBjM2N5YDxG
         ejlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gKOjXoXUmMkVLHPqpRRdxvzHegVqL9k6dIgoFzOzfdA=;
        b=eOFXljPpwc4QpVehQFrb1H+p7LSh0xWHZM+fOIL9guFftepY1NEEbwS6LjPDCMRMDS
         KyhhXGRX5r9iN3VbIO4uTrAOgd2xVecgBW8bin9cXW9wQrZkkmhmKo7LRRO3Fh0CI3Cf
         FsEtJ+bJwoy740ka9zgYoP1Kt/YuWqkRNLnTHt1TNnWdGVWo2/OUCzf3dLlyeB1sqz1N
         4cSDH4dgkNqfTf0l2ISdR8KsBlkuJAG5k9wMlqFGuHtdoN1pVqyVy4TDGXj1TKa+Z74d
         N68M+xhVDHqw1wiZ4VcpdrofV01H7tXdwu9zhUSSJ765koxNYQlMTiMQWoOQh7XtBN+X
         ZQ5w==
X-Gm-Message-State: APjAAAXkx08M0pCbWyJwZSQ1JpYRrNp5g1VnIwSGGNo8kcQdiqtH1C2Y
        R9pr7iaFDW7H89Qk4LDWr4jtvg==
X-Google-Smtp-Source: APXvYqxLOl8XWBWGvHRCBJ13HtAncHNohxPiZ2zPtSJsHz9hTbzjLukruLfFJBbz4BLj4CPF80Wa5A==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr10665392wrv.79.1578565923314;
        Thu, 09 Jan 2020 02:32:03 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z83sm2473830wmg.2.2020.01.09.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:32:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: patches for 5.6
Date:   Thu,  9 Jan 2020 10:31:44 +0000
Message-Id: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some trival SLIMBus fixes + a new bindings for 5.6.

Can you please queue them up for 5.6.

thanks,
Srini


Chuhong Yuan (1):
  slimbus: qcom: add missed clk_disable_unprepare in remove

Nishad Kamdar (1):
  slimbus: Use the correct style for SPDX License Identifier

Peter Ujfalusi (1):
  slimbus: qcom-ngd-ctrl: Use dma_request_chan() instead
    dma_request_slave_channel()

Srinivas Kandagatla (1):
  dt-bindings: SLIMBus: add slim devices optional properties

 .../devicetree/bindings/slimbus/bus.txt       | 10 ++++++++++
 drivers/slimbus/qcom-ctrl.c                   |  2 ++
 drivers/slimbus/qcom-ngd-ctrl.c               | 20 +++++++++++--------
 drivers/slimbus/slimbus.h                     |  2 +-
 4 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.21.0

