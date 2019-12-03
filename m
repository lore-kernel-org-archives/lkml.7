Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2220C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B6206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HoZE0eWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLCKPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:15:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43759 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfLCKP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:15:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so1611227pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tRxVgE9HFG04agLIYkIxCuLcJXysbe1494NjR7f93c=;
        b=HoZE0eWAeqSX8yhZ60usZmY7HegNU7Eqm2zKr6UNbGa6jJJ8djzgc8nA81LFzKICE1
         o8P8YM2zbFkdgnQCgwsGaREaihuGxajcKV2hb6odfKtXRUqEeIVirQBGkmIIL0nIdxxl
         h6lxB/KZHg6EjlFBLYdMgA8Bx2roM6720uk6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9tRxVgE9HFG04agLIYkIxCuLcJXysbe1494NjR7f93c=;
        b=iPp5KZm2QmaiYud9rRLFvMTDEXU+Ab2UArmVHxM/yWDHZHkEEYRRi4vxEQ5cFTRUZg
         lW29v9/J1ZKd4XC3ZD+bNy7fZCH/URDx38U9FPOE6wmAmCy2WOhbF0kmnSzfCq6qzB60
         98MLwFshYO0BKzaZo/ulNQ8jsQqH8Mgxm683vjqpa2bpvwLUjsRHIjHw4nBzwgrHu6n2
         EQTcE9hAj10O+2q2TutYEUZYQ0yeiaAHYnbRLBYACF+Gl329Jt00gsOXj1AXu1/CKgKd
         jUVVA4EN9c0Tth4clPfH0Uv8WMTxmI/Y7b1WwEZ9/GPJ7OALgQG4t5QLRpVZ1zTWKk9R
         8iOw==
X-Gm-Message-State: APjAAAVuQS/YaIQ4v5F9lKqLYzJElI/PD4hU2WwVaVCvzkhN2bTTrfsC
        HEFFFP9hScn/D0hpqdcI71X7Ig==
X-Google-Smtp-Source: APXvYqwIvn1rfxHeprF7KgmnJ16qeOEmel+VhkoLgbCYekUX2UE7TrBlBzPYR3CfkEETTAbDZd46VQ==
X-Received: by 2002:a65:64d4:: with SMTP id t20mr4579380pgv.152.1575368127112;
        Tue, 03 Dec 2019 02:15:27 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id o7sm3248639pfg.138.2019.12.03.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 02:15:26 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        IkjoonJang <ikjn@chromium.org>, JohanHovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org
Subject: [PATCH v4 0/2] usb: override hub device bInterval with device
Date:   Tue,  3 Dec 2019 18:15:21 +0800
Message-Id: <20191203101521.198914-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables hard wired hub device to use different bInterval
from its descriptor when the hub has a combined device node.

When we know reducing autosuspend delay for built-in HIDs is better for
power saving, we can reduce it to the optimal value. But if a parent hub
has a long bInterval, mouse lags a lot from more frequent autosuspend.
So this enables overriding bInterval for a hard wired hub device only
when we know that reduces the power consumption.

Changes in v4
- use of_property_read_u32() instead of of_property_read_u8()

Ikjoon Jang (2):
  dt-bindings: usb: add "hub,interval" property
  usb: overridable hub bInterval by device node

 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 drivers/usb/core/config.c                            | 9 +++++++++
 2 files changed, 13 insertions(+)

-- 
2.24.0.393.g34dc348eaf-goog

