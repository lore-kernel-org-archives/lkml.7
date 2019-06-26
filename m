Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC30C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB020663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IF7ThYpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFZK2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:03 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51476 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZK2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:03 -0400
Received: by mail-wm1-f41.google.com with SMTP id 207so1528113wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvnWQRlfd4B4N6c/4s3hGhvfQZZ8ZW/42ZjPOl8x3w4=;
        b=IF7ThYpdtxVvZKvmPh5olToLwnngj9WMZ6VTd4n8uwB3u949XuZ2iEW2bp/RtGtjzQ
         mhD0wC5mq4ZL2jjoCIp2DAprpR+3Ua07JIeMDhOrdiYU+bRweEgfTcup9yAf8//htUId
         /kfSs0/sbN9tzLPVJnNZn1wuzcP+ZlnZVg4ZobeyCgGi6lwW/m+H6CanCAwPDKBrNaDr
         CyEE224plZSYL7r1OO0QB49xU6oDmKfS05eP+mwLHIPt3JmmhQCBLFEFWg4sFqAf/L4L
         HaWkE2jyja2VNo2m8ZCgiQmfUOgR/eivDQG+X6Pmd1CExam2dp1LethpkE+HhEg7XJjc
         P2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GvnWQRlfd4B4N6c/4s3hGhvfQZZ8ZW/42ZjPOl8x3w4=;
        b=jxc4V9Gh21oF2UJ9UQZrdN11UxEAmAy5eYtBjdSKJVTAsPa9LtUYDHrqGpCmquYWvi
         WsxQMRfxBQa9N4ryWNUkAEoIWdwn5m5WYhwt4Oxax2UmRksUOJ7SK4AhkyMEGH/Io9Mg
         gXutWUgSO1rR8pm1llnKj8YVQNLpgYcKCmhijhJEdeAQ9yZvR/kzbkmE4Zs3eQMOqkMf
         ojU7jKQFUVxAL9+BYjwNtX3uPROeIyV44eBE2g09Yy731LONZSAtcuAIwzBsYvMk9JbF
         FWYFHPWpi7j/EwZyWFI6lb43Khx4sPygs176uqraTnlsYETezX8NU5DKyq+x8Z83OtPW
         CDVA==
X-Gm-Message-State: APjAAAUMrHA0nxyIRIgfvL/vAdIphgs4LLbvgaKAxDq8AsD2YwuEQyLL
        eLKJJQ5JFts/ujuuXxLNl6pstBe1q+8=
X-Google-Smtp-Source: APXvYqwxWS7GhAGtiOThf9UuWGFPBg6Fle1fRcAHFff48Yvx3jrR8e1jgTLncgXIetml1EOTBLbJdA==
X-Received: by 2002:a1c:f102:: with SMTP id p2mr2196560wmh.126.1561544880899;
        Wed, 26 Jun 2019 03:28:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] nvmem: patches for 5.3 set 2
Date:   Wed, 26 Jun 2019 11:27:27 +0100
Message-Id: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are imx-ocotp patches which I missed in last set.
Can you please pick them up if its not too late.

Thanks,
srini

Bryan O'Donoghue (5):
  nvmem: imx-ocotp: Elongate OCOTP_CTRL ADDR field to eight bits
  nvmem: imx-ocotp: Ensure WAIT bits are preserved when setting timing
  nvmem: imx-ocotp: Change TIMING calculation to u-boot algorithm
  nvmem: imx-ocotp: Add i.MX8MM support
  dt-bindings: imx-ocotp: Add i.MX8MM compatible

Leonard Crestez (1):
  nvmem: imx-ocotp: imx8mq is compatible with imx6 not imx7

 .../devicetree/bindings/nvmem/imx-ocotp.txt   |  1 +
 drivers/nvmem/imx-ocotp.c                     | 52 ++++++++++++++++---
 2 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.21.0

