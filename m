Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC808C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81120840
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmHtHTSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKLAUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:20:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44773 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfKLAUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:20:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so10555022pgk.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5m2NG6A+YgxDfMfpQtOFvpd6UPNiApr1ET296m72/Jw=;
        b=LmHtHTSLUL2+tujgPcdLdh4oJucSyAFboxlu4pQO4dgCTYOivpUDb3eZljCFo9YCiz
         iTRgV4e8h/ACWzZ/aDa3yjZj7HO2PXQlYaUzp4oKePffml2I6UilI1IysWAwh8LQVBK+
         31as/o7Db8bOeXEV7OuMzb3FcZwiaH3AX5Fic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5m2NG6A+YgxDfMfpQtOFvpd6UPNiApr1ET296m72/Jw=;
        b=FUTu+wWGGuelSeNHiHxgi/RvPzRYRpDDYu2JwOwknvVOCZJgEjlg+cEFDrZQL3AXT5
         42bKpF/W1ie3jIlLePwgevP8lg7nxlkVJXgpSLRgNWgkCUqTrDlbSfXYJOIGWjqeko3x
         QRer7IC6r4eMjYI5t9PVNna+s05G38ODHX2qy388eqDjJvqKx14ESnhi4VDXA5qf7LkP
         JCmy+eKZJIKIZ/9krif4kpC/R7qdk2nEH4eFpn/BkNnnkum/JW89sL5F1gVclM/I0Acg
         uQKFwhdCGTwFSJxqGsSo4GKPHQViLbbzBsaPML1FLX+BiKTLuH2HAfJZxBk1W+Ys+idA
         y7nA==
X-Gm-Message-State: APjAAAW/8RwzftIStNnBuNb2tHiIMPEfz+5otZ/uUEmoxszGqsWNFHwM
        caRqUC5IrFcYrmAP+aMsOLmJMw==
X-Google-Smtp-Source: APXvYqxRBAafOGGdkjoeoMMLCuVKQsBTyvDmgFCv91eTMAU5wmb/LfQzoz+wYOxDAVLQfYbN4idhyQ==
X-Received: by 2002:a63:77c3:: with SMTP id s186mr9434885pgc.370.1573517999167;
        Mon, 11 Nov 2019 16:19:59 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h23sm8430898pgg.58.2019.11.11.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:19:58 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v3 0/4] Bluetooth: hci_bcm: Additional changes for BCM4354 support
Date:   Mon, 11 Nov 2019 16:19:45 -0800
Message-Id: <20191112001949.136377-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While adding support for the BCM4354, I discovered a few more things
that weren't working as they should have.

First, we disallow serdev from setting the baudrate on BCM4354. Serdev
sets the oper_speed first before calling hu->setup() in
hci_uart_setup(). On the BCM4354, this results in bcm_setup() failing
when the hci reset times out.

Next, we add support for setting the PCM parameters, which consists of
a pair of vendor specific opcodes to set the pcm parameters. The
documentation for these params are available in the brcm_patchram_plus
package (i.e. https://github.com/balena-os/brcm_patchram_plus). This is
necessary for PCM to work properly.

All changes were tested with rk3288-veyron-minnie.dts.


Changes in v3:
- Change disallow baudrate setting to return -EBUSY if called before
  ready. bcm_proto is no longer modified and is back to being const.
- Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
- Changed brcm,sco-routing to brcm,bt-sco-routing

Changes in v2:
- Use match data to disallow baudrate setting
- Parse pcm parameters by name instead of as a byte string
- Fix prefix for dt-bindings commit

Abhishek Pandit-Subedi (4):
  Bluetooth: hci_bcm: Disallow set_baudrate for BCM4354
  Bluetooth: btbcm: Support pcm configuration
  Bluetooth: hci_bcm: Support pcm params in dts
  dt-bindings: net: broadcom-bluetooth: Add pcm config

 .../bindings/net/broadcom-bluetooth.txt       | 11 +++
 drivers/bluetooth/btbcm.c                     | 18 +++++
 drivers/bluetooth/btbcm.h                     |  8 +++
 drivers/bluetooth/hci_bcm.c                   | 70 ++++++++++++++++++-
 4 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

