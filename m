Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58AC20684
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HUmNfilP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLBXbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:31:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35766 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:31:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so1444603wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 15:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wvx9nyxzMj2Q20ThBsLSisowyvUYXMlYKSukI+zanr8=;
        b=HUmNfilP1bDdVEPDWTiM4TiD+Hvd+V1cLHg2+0zcsq5I2sh/T88JjmtN1WpTMyTTjd
         AAxiM8SzKej+bvhBXJwrrKlx6XL/JDPPskP5loruPQHsnDI9VPti6f3LfI+//Yn+i4Kn
         mRChxHvP/MTFubs2llgvk1HyBNiJ34PzoRTSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wvx9nyxzMj2Q20ThBsLSisowyvUYXMlYKSukI+zanr8=;
        b=dyw6EPlfYf6b6YKn9LDGNe67gHSN7C5vV3dOFy1YU7Szo8r35sK3mTzUqyInR1HVwh
         4/fKR6ZwjAo9VSCyYEhxKLj3Iuq3mrkuek+S5KooGXYE1b9KJVuYRBYhjAP9CIHarLxN
         6dD70R4KORzlWHUPCZFEirNtskzl2JzPcsR4+R04CBVizWGakF06WvqMLrD6evss5v95
         xJ+Fyd1YVCl7LtfhSc/IhhrdBFoh2BtVrNWGHSPf5OpT1TEJxKK2ZMDEJJVpTORwjcF8
         c3VqyW0mf607dNurH0jCN8tBkcfFdSz+AZ+CKlg7NQgj1qjP61UJGBwvKkrjWuJQJ3N5
         mASA==
X-Gm-Message-State: APjAAAWifAhmFS2i16YH/BSHVLX8VG7FDFkz+QiBArIvsGIJAidV11qM
        a5DYrYNJvMeetNUQnyAierxGSw==
X-Google-Smtp-Source: APXvYqzYBJKAapr9QfnXl9kbxsEEShe5XaNo7VxzjPWxTXsbQtt8ZSLATPBsZO+NUaBQajgRBIM8yA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr1643668wrm.290.1575329502406;
        Mon, 02 Dec 2019 15:31:42 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c72sm1066197wmd.11.2019.12.02.15.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 15:31:41 -0800 (PST)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/2] Add iProc IDM device support
Date:   Mon,  2 Dec 2019 15:31:25 -0800
Message-Id: <20191202233127.31160-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom iProc IDM device allows control and monitoring of ASIC internal
bus transactions. Most importantly, it can be configured to detect bus
transaction timeout. In such case, critical information such as transaction
address that caused the error, bus master ID of the transaction that caused
the error, and etc., are made available from the IDM device.

This patch series adds the binding document and driver support for the
iProc IDM devices.

The patch series is based off v5.4 and was tested on Broadcom
Stingray combo SVK board. The patch series is available at:
Repo: https://github.com/Broadcom/arm64-linux.git
Branch: iproc-idm-v1

Ray Jui (2):
  dt-bindings: soc: Add binding doc for iProc IDM device
  soc: bcm: iproc: Add Broadcom iProc IDM driver

 .../bindings/soc/bcm/brcm,iproc-idm.txt       |  44 ++
 drivers/soc/bcm/Kconfig                       |  10 +
 drivers/soc/bcm/Makefile                      |   1 +
 drivers/soc/bcm/iproc/Kconfig                 |   6 +
 drivers/soc/bcm/iproc/Makefile                |   1 +
 drivers/soc/bcm/iproc/iproc-idm.c             | 390 ++++++++++++++++++
 6 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,iproc-idm.txt
 create mode 100644 drivers/soc/bcm/iproc/Kconfig
 create mode 100644 drivers/soc/bcm/iproc/Makefile
 create mode 100644 drivers/soc/bcm/iproc/iproc-idm.c

-- 
2.17.1

