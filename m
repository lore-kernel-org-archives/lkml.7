Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57CC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 03:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81902084C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 03:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKYJOWi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfKQDcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 22:32:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32774 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfKQDcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 22:32:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay6so7533802plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 19:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOVdn7VL7yyxBUHZntw/D8IwcAv73NBNkLlL+UAJFSs=;
        b=RKYJOWi8iEdEMFM9J/pjDm+5FeNgh2U31vD65Ic8a2K1qx92kW0miLGD1lkL57W9nE
         PzUaQUZNU1OH5AL2XOMEMA9t2AtOScIUN6MFha9yH+IfCyVzjluJJ6xy39s2EdpF23Ne
         jepM3Hou6Krym2qBscM6BYZOhAVheIGfP2ftU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wOVdn7VL7yyxBUHZntw/D8IwcAv73NBNkLlL+UAJFSs=;
        b=towryllvE6CcvlGyVmsfOcF5h5WFSRGy02GOlvfff2XeSJlh4KWJLEYg/Gs5r1kVeD
         d4uhVLaXBMaARSMIcM54NZaiO27o+4rYSbattWp48zcdaTNMYYT71nOfsibhN5p4XW/6
         spYT6gWxFQefSYjY4YWVnhta1LYaNx6QbiI08Rh67eJpUT0XqQrv++wS2bQ/kyC6v8Jd
         ParEQ7d3jnSj4rL5FLDhQnyHqkgJGrXRZFFiJqzlBhSsgTPtcZWjbgZYZ7tzvHxICWT+
         FSZ/ADqH368xlJE++WaOubMZziMgo2HMhg5b/eZwNyjj2b8RyFbbCVZdJjOhg9rywD5X
         wa4A==
X-Gm-Message-State: APjAAAWaJcYWQ3L2Ne2l6rciu8Z75T7d/Q4xXWxJ+GqO+NeFM8ANCrW8
        m/n+NyowNY0iyIpKKyAr6eWYjQ==
X-Google-Smtp-Source: APXvYqw8ibeSC9mMX54bu6dURPnqRLsC8s+GYw7BNmhc4RtLyWnWiS2SL+VhTBHiUkfuh8yW5oWrOg==
X-Received: by 2002:a17:90a:610:: with SMTP id j16mr30938906pjj.85.1573961519371;
        Sat, 16 Nov 2019 19:31:59 -0800 (PST)
Received: from ikjn-glaptop.roam.corp.google.com (2001-b400-e27e-4718-13bf-d274-f5e0-91a5.emome-ip6.hinet.net. [2001:b400:e27e:4718:13bf:d274:f5e0:91a5])
        by smtp.gmail.com with ESMTPSA id a145sm16539353pfa.7.2019.11.16.19.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 19:31:58 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 0/2] usb: override hub device bInterval with device node
Date:   Sun, 17 Nov 2019 11:31:49 +0800
Message-Id: <20191117033149.259303-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables hard wired hub device to use different bInterval
from its descriptor when the hub has a combined device node.

When we know the specific hard wired hub supports changing its polling
interval, we can adjust hub's interval to reduce the time of waking up
from autosuspend or connect detection of HIDs.

Ikjoon Jang (2):
  dt-bindings: usb: add "hub,interval" property
  usb: overridable hub bInterval by device node

 Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
 drivers/usb/core/config.c                            | 6 ++++++
 2 files changed, 10 insertions(+)

-- 
2.24.0.432.g9d3f5f5b63-goog

