Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF884C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4B220885
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XtQspD0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKRTVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:21:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40570 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:21:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so2721844pgd.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5PWZi/zKiryoyNeQKLfBbB+ek5n6FC2NtouBDWVRQs=;
        b=XtQspD0uMRIVjaZ4j+RdCKdeQxaQCqQPp0dFHeqONKAZ35AY4eVCQPCYYleRmtsva6
         jiBaP6dXV6CIhPTqL5k3YcxCbhisRrR03J2vLkV72aCm+pVNX6rvuTWONb3vLXyxlYRs
         v5O5i+t3G1W2pCt3l+6JsFgLJWtzfK3LsM/dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5PWZi/zKiryoyNeQKLfBbB+ek5n6FC2NtouBDWVRQs=;
        b=L+gPepaPiLzf+Ni9oL0V+jrvgxn51fOhFFY3Pe+O9XLhcpmycv0u+2wgu6hM9RVi3z
         a0xOXyBtBMf8OsSmgkprVnTEg330qgnXDXJYCjt4ItCK2bpixQ7zBCh6ih9c0oVhVDvJ
         zuy/0o94CbP/O1qceGBM2kVmenvyrsm/Gqb2E39X9xD7DPaCYe/EZ+duKMVzYZZC7xYE
         +/gywvfaCwDguVUIfU+y3bbsL0KxyPdwFdl2JGC3FlZ+vle60KHqLtW8V6SJ5PpqphQv
         6nMlEOFybbwm/Zv2ZesixqaasSvgi2d+X76i5GOo7V0DpJUrtt0bt3Pzvsiauo6nBC8N
         Wi0A==
X-Gm-Message-State: APjAAAVoUbDKg08IX3ssS+mTZIriKcSRkqNr/Hu3xCqLumOLYxvvzbx2
        +gDrvdaD+cHmUjNxRU6x1+ctwg==
X-Google-Smtp-Source: APXvYqzs+mH7xTW54MFqTm5HE4eK5l6cG37wnugAw2nvX7u/bTQwIc633vnnHFTMf9ZOXDJoQw1YLg==
X-Received: by 2002:a63:af1a:: with SMTP id w26mr960203pge.251.1574104893199;
        Mon, 18 Nov 2019 11:21:33 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id p123sm22772633pfg.30.2019.11.18.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:21:31 -0800 (PST)
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
Subject: [PATCH v6 0/4] Bluetooth: hci_bcm: Additional changes for BCM4354 support
Date:   Mon, 18 Nov 2019 11:21:19 -0800
Message-Id: <20191118192123.82430-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
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


Changes in v6:
- Added btbcm_read_pcm_int_params and change pcm params to first read
  the pcm params before setting it

Changes in v5:
- Rename parameters to bt-* and read as integer instead of bytestring
- Update documentation with defaults and put values in header
- Changed patch order

Changes in v4:
- Fix incorrect function name in hci_bcm

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
  dt-bindings: net: broadcom-bluetooth: Add pcm config
  Bluetooth: hci_bcm: Support pcm params in dts

 .../bindings/net/broadcom-bluetooth.txt       | 16 ++++
 drivers/bluetooth/btbcm.c                     | 47 ++++++++++
 drivers/bluetooth/btbcm.h                     | 16 ++++
 drivers/bluetooth/hci_bcm.c                   | 88 ++++++++++++++++++-
 include/dt-bindings/bluetooth/brcm.h          | 32 +++++++
 5 files changed, 197 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/bluetooth/brcm.h

-- 
2.24.0.432.g9d3f5f5b63-goog

