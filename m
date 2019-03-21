Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7862DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493A7218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="xPwFki6M";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nO5AQkCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfCUPlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:41:01 -0400
Received: from node.akkea.ca ([192.155.83.177]:39150 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCUPlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 3217F4E204E;
        Thu, 21 Mar 2019 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182860; bh=A0WYymUcpfrTzb2KhE89sS5xYgZxM6rtkkmUMs5t42o=;
        h=From:To:Cc:Subject:Date;
        b=xPwFki6MLaiqBcdWFIgov71UHz+N+wCCo48wTPMBecjuqvQXycPv7UjQCKbrfMtHI
         LnRPq6ip2BZOTn21GxehYu6BHWd+OgHg9Hwo6GXBzV+NT1Le0r0ZLuA9Pi3ydUS5TN
         Wynvjag0pVYNh+PZj9GoO8TkzFE8acgHZw3BbXow=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lR2V1V9S5B7j; Thu, 21 Mar 2019 15:40:59 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 2E7914E204B;
        Thu, 21 Mar 2019 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1553182859; bh=A0WYymUcpfrTzb2KhE89sS5xYgZxM6rtkkmUMs5t42o=;
        h=From:To:Cc:Subject:Date;
        b=nO5AQkCjpGZI4VYFdtzQshSeqyKeANh0Q77E7JVwbv3MdHPkUqGJ4JqLZDQ2Zb3Ww
         ppvf87y/2Bbb+6rQ0Rbu1En1ZlgSkp5wT+A4bn7BkIQUbcqMcQtcfppxBfbR63vkUd
         ufnU/+v0keW6+MObX1AxuAf967ffwoXm0rlpheGw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     jic23@kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add a VCNL4040 light and proximity driver
Date:   Thu, 21 Mar 2019 08:40:42 -0700
Message-Id: <20190321154047.23236-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Vishay VCNL4000/4010/4020/4200 driver to work with the VCNL4040
chip.

Changes since V2:
    Added Tested-by tag.
    Changed 0x00 to 0 for clarity.

Changes since V1:
    Separated byte vs word bug fix.
    Separated device tree hooks.
    Separated devicetree binding patches.

Angus Ainslie (Purism) (5):
  iio: light: vcnl4000 use word writes instead of byte writes
  iio: light: vcnl4000 add devicetree hooks
  dt-bindings: iio: light: add vcnl4000 devicetree bindings
  iio: light: vcnl4000 add support for the VCNL4040 proximity and light
    sensor
  dt-bindings: iio: light: add vcnl4040 devicetree bindings

 .../bindings/iio/light/vcnl4000.txt           | 24 ++++++
 drivers/iio/light/vcnl4000.c                  | 77 ++++++++++++++++---
 2 files changed, 91 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt

-- 
2.17.1

