Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB21C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD17A2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L/OQosoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUFKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:10:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41117 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfKUFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:10:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id 207so965197pge.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msCu0QpwL+TYH2H0S7A59z3R+0BjpgNq8syAjSNxH5A=;
        b=L/OQosoCwe6MxD5gy1A0NnLJOkaGqqtWsSD3IhTXsXHBvOFV0eT/u4HEoDnvJmMAJn
         YGM2wbDk98aSrs1dW2Px/8o6lCMHN97PlNFo1yKoFWgF5BRG/CWgVPgafPfqqXKOfw61
         qWYZW4aQ5Zkj6KYGcwlV/6dc9qH0PaNin8UaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msCu0QpwL+TYH2H0S7A59z3R+0BjpgNq8syAjSNxH5A=;
        b=K+9uFd7X9UgZebtTgvPiyuIy3CoWXYRG4/CbkxggdE8MGuTf3n8BTNLIQSAaLa7Sta
         xIV1lKTUH9lcRS3CZ+JRG1jPJCJV0rsWpyrO94h+GCTIO52h6Fqj4G0H7TrO0kgOAQ+c
         SzQHKfL6+GkVWRaqraL8AFTWX26x+kLDE2+b7OLrcXerKbfa0uM/AeY6R6mFFKzLf2Dx
         ySP7cJGgP1ZVSXxB5DH3MKmeglPPbU/6wEELODPQCgbKco9FcbYr/v3gm1TDQaJh7pj5
         u6yehTeik665rIFg0aoIV1Ge3jOvHCkABh12Lj2OVXoO92dywC8nkTj+xZJRKbzq9wz3
         33/g==
X-Gm-Message-State: APjAAAWxyrhM8c8xCoa+TkwReW22tL0AmOgMWK82gHU6UZX9cXARFSx5
        3utdkIUHE0sIj8jA2rvFxGs05w==
X-Google-Smtp-Source: APXvYqzxE1UUlMo4o5lL/9FGxnbsO+/yKZx/OP3POMctvwZK6KLKxRCCVHn6zJamnA++y2PEy02TYg==
X-Received: by 2002:a62:6385:: with SMTP id x127mr8745328pfb.244.1574313043585;
        Wed, 20 Nov 2019 21:10:43 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id x2sm1329257pfj.90.2019.11.20.21.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 21:10:42 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        IkjoonJang <ikjn@chromium.org>, JohanHovold <johan@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: [PATCH v2 0/2] usb: override hub device bInterval with device
Date:   Thu, 21 Nov 2019 13:06:34 +0800
Message-Id: <20191121050634.108727-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
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

Ikjoon Jang (2):
  dt-bindings: usb: add "hub,interval" property
  usb: overridable hub bInterval by device node

 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 drivers/usb/core/config.c                            | 6 ++++++
 2 files changed, 10 insertions(+)

-- 
2.24.0.432.g9d3f5f5b63-goog

