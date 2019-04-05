Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7D9C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B695217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChzUWipo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfDEKZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:25:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40317 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfDEKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:25:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3041689pfc.7;
        Fri, 05 Apr 2019 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3QzP4cYm2TOVKPV+VIy+S+5r4WzTpPrfu+RUgD9Xve0=;
        b=ChzUWipo16dVbOXEVUpC5Y26lnO5dfn9bswfegUDP4ld1sNY70ok/BOC7jfFK91nW6
         wj7Xnm192Ops0RXgibS1+qcMFb5GFMy2nhtnD9OFrRvAkhbuf+P4uRLLSdTqkAZZkGrM
         UsScdCeMi2q9esmC3uzAMWNTDxqYKwNel2sCCoj64uLnnOiWUI8Vzls+kRdmGOUmz4mj
         lhlh42QOpazHWOBDNeDELFzKLUP4+gdQdMyuveLX6D+Yga8PF+3ncZNw3OdFsyBvsFfY
         Z5ucejvSstTfkwDfKR5SyD6XS8TBSu3DWM4smFLZLzNaOHxHju/Q/sGpz3ZU7/AwzyqQ
         N58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3QzP4cYm2TOVKPV+VIy+S+5r4WzTpPrfu+RUgD9Xve0=;
        b=FT9MN0cNPOE5ANPR1K7kZJH92/23qB/qEQIxID7/hu2crIxiecWjVZtXMyaObrZvDO
         bohOqMbGxIrXabAwwrZPMj5Ba4SCf3Z22PadsLX7GJmyN1TA54+jIcRjZNpfY2hyd3vd
         E5f4HtSnDOoacOXeQgyBu9niRzW25d+Zt8qu3fCaP0tkBvSGZPvl2+5VATur0NXbkXqV
         PxLaidhkm5FJtt3M6wlmaxDiEXkoK6TJdnb/IMp9y6Uv3DYUHE8K4IQwjwU0eztrjwRC
         6w0sa4SzSmSrQK9qEpp2GMAfdvWQhaVHJ/0htUjSgCG5xAdwdRl2PoXDf5vWg+UHAplw
         oPfw==
X-Gm-Message-State: APjAAAW3Rvbx3gm4IJUydQD6/E4cZ5nbZxzRqw6TT8p2hVnci6k9aflb
        GrN6wjPSiUKeKFa4js3gJok=
X-Google-Smtp-Source: APXvYqzycCck+YMnCC6BfuSzJ/zZYo1/bQkYsNJEJU8sYPBNGOy8GZ7ZwS0s4gjodO/d1Qtk1AJgYA==
X-Received: by 2002:a63:e70c:: with SMTP id b12mr10755758pgi.399.1554459903673;
        Fri, 05 Apr 2019 03:25:03 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a80sm50323460pfj.61.2019.04.05.03.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 03:25:02 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tiny.windzz@gmail.com, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, rjw@rjwysocki.net,
        davem@davemloft.net, mchehab+samsung@kernel.org,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date:   Fri,  5 Apr 2019 06:24:53 -0400
Message-Id: <20190405102455.15311-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.

Yangtao Li (2):
  cpufreq: Add sunxi nvmem based CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-sunxi-cpu

 .../bindings/opp/sunxi-nvmem-cpufreq.txt      | 235 +++++++++++++++++
 MAINTAINERS                                   |   7 +
 drivers/cpufreq/Kconfig.arm                   |  10 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/sunxi-cpufreq-nvmem.c         | 236 ++++++++++++++++++
 6 files changed, 491 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/sunxi-nvmem-cpufreq.txt
 create mode 100644 drivers/cpufreq/sunxi-cpufreq-nvmem.c

-- 
2.17.0

