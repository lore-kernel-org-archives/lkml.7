Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDC4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8F72067B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGq6Anxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfIQTpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:45:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfIQTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:45:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id s19so4805620lji.6;
        Tue, 17 Sep 2019 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glAfUtGhy1cDDW4ClQs75Rd7BWqQGXGFYsoau+F0hKg=;
        b=dGq6AnxvlR0IfzSEL4Av8sUx/aIEfI9ZGPm/D5Ch1fqHUxZ6evZLRF+RlrWA7Z3+HG
         kUN0w+be+ThLC+YXchNLFITpZwJkKpmHxdx0+jFTUX48C/SZDYF6eZOL52DizPI8XHnh
         SpSZ2fQ6+iLAmli0VC8oZmNpfi9CduR6I116Avzn4ScSJBpS2h1hSXWvIPweWVk72coq
         tj5Z6k8Dk5q0KY/LOZ+CboORC5DdnxGX5bEsQCCxu+Slo7oW/+iR8nVdZ7OvIoEMe5Of
         cvZLn04eD52hAomQ0K1nS6yp4OVx3xH1qdpD8lkhVsyLIpNV5GZqjV/NnfA/ixMi5mpO
         AvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=glAfUtGhy1cDDW4ClQs75Rd7BWqQGXGFYsoau+F0hKg=;
        b=AobkAente8Kyxf797A5yeqPatvMKomPfCxUkh4kYfAuRSpYCIpOQlMYKPVGeQEf0eH
         DxlNflrYEftzx30D9IerqVH1G+8tiqgAAf5hDFiAvS98/gAyCyKhLt33fICNBAuX7t3y
         o1loXuLJaoEaPrwRCYnZ0qS9mmankA/eQUdFl7pYfyAOQHsR5pIZeq6aPXZpESW8POSb
         ijZ4pULVj4O9OV/afjQno3YAkxSp6dmilwGCoMfrC3cFDjUkHPh2Ml9jwudOqI4dnGRF
         hmavmBfrLB+wvMKT63zYRrbNXePziDy53IDC6HN1Ilfl+l1jZiG+i0EQcp5Yufp/nOtz
         u/+A==
X-Gm-Message-State: APjAAAUJ25aPdkqNw5B5hZvdID+XLD0dnMLmTqD07mPv1Aq1YEBsYtrb
        /QIrFtw4/XcnrpsCBXhlgMk=
X-Google-Smtp-Source: APXvYqxVcOSeb4ui/whdivvWhL+7M+NWziGV2eJ528z2ZwwTcTTsTCMUSn91JEZYMvB1nRHGYM8gKw==
X-Received: by 2002:a2e:810e:: with SMTP id d14mr39911ljg.160.1568749515241;
        Tue, 17 Sep 2019 12:45:15 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id k15sm614547ljg.65.2019.09.17.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 12:45:14 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1iAJPW-0003qz-UI; Tue, 17 Sep 2019 22:45:14 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2 0/1] intel_cht_int33fe: Split code to USB TypeB and TypeC variants
Date:   Tue, 17 Sep 2019 22:45:06 +0300
Message-Id: <20190917194507.14771-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to support INT33FE ACPI pseudo-device on hardware with USB Type B
connector.

v2:
Instead of defining two separated modules with two separated config
options, compile {common,typeb,typec} sources into one .ko module.
Call needed variant-specific probe function based after of hardware type
detection in common code.

Yauhen Kharuzhy (1):
  platform/x86/intel_cht_int33fe: Split code to USB TypeB and TypeC
    variants

 drivers/platform/x86/Kconfig                  |  14 +-
 drivers/platform/x86/Makefile                 |   4 +
 .../platform/x86/intel_cht_int33fe_common.c   | 148 ++++++++++++++++++
 .../platform/x86/intel_cht_int33fe_common.h   |  44 ++++++
 .../platform/x86/intel_cht_int33fe_typeb.c    |  64 ++++++++
 ...ht_int33fe.c => intel_cht_int33fe_typec.c} |  79 +---------
 6 files changed, 278 insertions(+), 75 deletions(-)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.c
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_common.h
 create mode 100644 drivers/platform/x86/intel_cht_int33fe_typeb.c
 rename drivers/platform/x86/{intel_cht_int33fe.c => intel_cht_int33fe_typec.c} (83%)

-- 
2.20.1

