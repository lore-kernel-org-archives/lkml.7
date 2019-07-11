Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DE8C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E1920872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6k9SG6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfGKVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:39:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41250 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGKVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:39:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so3542243pgj.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hN7B8WFgbqERacE3IYOfjDfi2Lnw5rUXxCTjyYNVNg0=;
        b=y6k9SG6CbD6cDUt9w3faCzDY41MjHi1ofuFcnSoPHwpygjpAIEzuM8BAYgIlQDSixx
         WiNjtp2ZVShJSSxViBDywPgygDU5vmkrKB5iJ2vAdiUx1KsXCchYLPCxySK9xBcvmORS
         HYSK7+BrQo1QyrEqeVnetfrV5JOPxjwiUqbq9T45uOqbzGnuTt8EXgmpul7XrkybKaAJ
         aNnslKHEAU7ixWp/2h8zSgOc8cD7vC7+1hXwhmmAmNZ3GEIRKDM7FbeTIVPNyXVQ2NSS
         YWI6973/UslklFCWPQVTZkUAqxtgzjdlswBjrQ9HpSMNjTuEQrKhIAjLBIp4T4dPas4c
         b38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hN7B8WFgbqERacE3IYOfjDfi2Lnw5rUXxCTjyYNVNg0=;
        b=brGsnR6Y0uxTWy8Q+QSmrm5zQNJ0VZ2QIZeH1hXPIoZBzKjBmxTzEa1ZGDPk7DXF9N
         9Q8lt2hLqTIQXH9NyPenkwi0ZvsY0AU8L3T7TUf8ojNLILx2AUjNtd1xFGDMX4XPOlmf
         Sc/dcCFI5nQsQ5Iv06spunl9i0Clj8cxdAr4v3bhZ1aNP3tCaHn2y26uwCKe1oOHaKs/
         Pic2B42fUXTmLg/w0U155s9CxA+TiO38UVHy/4LOpJ8JCDkr+1zQnnVulnr3EAKE16vX
         SZ1ua4yyJ1QNJLZt4wTtMKqtXSCH7chALx45CGTqTsVsHlsAw+lnvyZrHTYWd9a/vBGU
         7q2w==
X-Gm-Message-State: APjAAAXmdqcM9XcG9mxCuwavV/rhhyVYo28YxcnFFDJgwSf0ippMy2ha
        qY0xRmnfyfEZ4DZOdY8JzqtyzA==
X-Google-Smtp-Source: APXvYqwO/qoRqMR7KW5Hqj+kJmxD1WculQ0AOIFkYECuq3ZtLW3ZsWIkD8ihV642dt3FmZRSpC2L6w==
X-Received: by 2002:a63:4f45:: with SMTP id p5mr6766087pgl.326.1562881158410;
        Thu, 11 Jul 2019 14:39:18 -0700 (PDT)
Received: from localhost.localdomain ([27.7.91.104])
        by smtp.gmail.com with ESMTPSA id w3sm5709795pgl.31.2019.07.11.14.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 14:39:17 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v5 0/5] soc: qcom: Add SoC info driver
Date:   Fri, 12 Jul 2019 03:09:06 +0530
Message-Id: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds SoC info driver which can provide information
such as Chip ID, Chip family and serial number about Qualcomm SoCs
to user space via sysfs. Furthermore, it allows userspace to get
information about custom attributes and various image version
information via debugfs.

The patchset cleanly applies on top of v5.2-rc7.

Changes since v1:
        - Align ifdefs to left, remove unnecessary debugfs dir
          creation check and fix function signatures in patch 3
        - Fix comment for teh case when serial number is not
          available in patch 1

Changes since v2:
        - Reorder patches [patch five -> patch two]

Changes since v3:
        - Add reviewed-bys from Greg
        - Fix build warning when debugfs is disabled
        - Remove extra checks for dir creations in patch 5

Changes since v4:
	- Added Reviewed-bys in multiple patches
	- Bunch of nitpick fixes in patch 3
	- Major refactoring for using core debugfs functions and
	  eliminating duplicate code in patch 4 and 5 [detailed info
	  can be found under --- in each patch]

Vaishali Thakkar (5):
  base: soc: Add serial_number attribute to soc
  base: soc: Export soc_device_register/unregister APIs
  soc: qcom: Add socinfo driver
  soc: qcom: socinfo: Expose custom attributes
  soc: qcom: socinfo: Expose image information

 Documentation/ABI/testing/sysfs-devices-soc |   7 +
 drivers/base/soc.c                          |   9 +
 drivers/soc/qcom/Kconfig                    |   8 +
 drivers/soc/qcom/Makefile                   |   1 +
 drivers/soc/qcom/smem.c                     |   9 +
 drivers/soc/qcom/socinfo.c                  | 468 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 503 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

