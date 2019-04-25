Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155CC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0920E20644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlGRP6Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDYMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:55:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34860 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:55:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so907029pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ur4qJsmNX5K02yCniFaGsAk1nadFPW7D4uDoxxI0WdU=;
        b=WlGRP6FaRf9kiw3FJ05z5Z/fLhG+QwUPgE1hmsn7zKzLxE+ZTt0qFR58MMETYJ/ift
         szQm9Xtp/TpcNULUtvXuJpKklMRJBjGUFGG1VcT5Z91/nWuxg7FdWSCMjwLAyxNchxC3
         usipODPuCY7FFxPS4F9V2zyBg0mM18Mjjph0lOPyFAe8b7ixHm/cFHQxv7vmHIDIdJcm
         mj37WdTxB2ZPr3uxprrVCAI1LhPPzOPFBzRcUqMa55wVhY9YMp9fsTylAz/ek72U1wkE
         +4QoajlWrWGVm+S9FtmNr5dPoW959fqoJCUZ65KIB7ptFespfgtVG+rGSX6ivvaACzdZ
         i6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ur4qJsmNX5K02yCniFaGsAk1nadFPW7D4uDoxxI0WdU=;
        b=BbjuhJ7+FZHVgvRlDwgJ0LiXhiaXoTskki10/4hKjEc0ACJmicfwS8t/qeDb6z2A3f
         T1SDUY/ylDsjmQ3gUaxFFFT2Cgr5MhjZ3UryZcGQAyCnaYDLnnDPCPspywvMdMHLfXgD
         ScYmeSWRxI3se0yFt6NAPj7rC5p+69cyaRlgLbfOuH0KNjc8lFMEy86iBqSBBW2HaNuy
         ZXO8S8UFNG+TcFHkxqGqTVHs+YLv+QR8u9lES4DsPkgtf6GkAGtn4q3EpEGX2Sl5x04X
         aOBuGQBmXCmmTcEvPKPWZpRVmc8Rzmp1lwVbkWqqlWrCxqlLHaidS7tAhPyNvjQ95NQE
         gx0Q==
X-Gm-Message-State: APjAAAUGUHNOK89CuM1ShKzOjdEaVzSDz0utPqrqcmcDVRMJ/AeTCE+i
        5NYl8GObQEt3s0tAaYTkPAmB
X-Google-Smtp-Source: APXvYqyC/o57dYK3T8tz+H2uOM46gsv9bWJdPwmYGb16dMp3hmkr9IAvfAOYxE868UmpPI+C6h82gg==
X-Received: by 2002:a65:424d:: with SMTP id d13mr37021754pgq.318.1556196919481;
        Thu, 25 Apr 2019 05:55:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id c18sm50507983pfc.0.2019.04.25.05.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:55:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Add reset controller support for BM1880 SoC
Date:   Thu, 25 Apr 2019 18:25:05 +0530
Message-Id: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds reset controller support for Bitmain BM1880 SoC.
BM1880 SoC has two reset controllers each controlling reset lines of
different peripherals. And the reset-simple driver has been reused here.

This patchset has been tested on 96Boards Sophon Edge board.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: reset: Add devicetree binding for BM1880 reset controller
  arm64: dts: bitmain: Add reset controller support for BM1880 SoC
  reset: Add reset controller support for BM1880 SoC

 .../bindings/reset/bitmain,bm1880-reset.txt   |  18 +++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  17 +++
 drivers/reset/Kconfig                         |   3 +-
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-simple.c                  |  16 ++-
 .../dt-bindings/reset/bitmain,bm1880-reset.h  | 106 ++++++++++++++++++
 6 files changed, 155 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h

-- 
2.17.1

