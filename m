Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A529C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8D5206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="ViiQmKfh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGNXwBnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfG3NsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:48:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37331 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfG3NsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:48:25 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C16B2177A;
        Tue, 30 Jul 2019 09:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=32XiqIKnXoUaA
        By8jcbwir7KFpCAvJnhxbDxZJ1lPcA=; b=ViiQmKfhRYLiR3L1q3fwmnqK2qkbm
        sM7bKfzs4mYWu6JM/0ERAl9tLjfXIpQOwiALCzaHEu1QJWy7ZxohmRaQyFP58Ygq
        PziKP3DhiNaMyupgmuNAKbpgDKwYw9++J5rJTtTYDqQIQrFDy/MiaWXBkH5xuXb7
        M1NCVH1hFU0tiarySNQC58LyjrNm31N5ypnBJy7BWGNc5nCCNrHewuGz75n82hkN
        2mqWQ4ulrPpwuK3y32fC2XvPpHFAyXycZTk6Vobqy+/VE8YWxN8ZcUTQOJrL5cf6
        Dwl6cGOUw33aK9fuR3+84zNQJc2QLioFKeIcwodOHYswtDjqOEvYR0cfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=32XiqIKnXoUaABy8jcbwir7KFpCAvJnhxbDxZJ1lPcA=; b=nGNXwBnw
        s+VDHFL2hMCYX0Qeyko2FWwBIRboJrLWVhsB0UsuRu5D79pA6Wce1NkWkqC29fcQ
        3n0sei+9JDIWhO7G5FwJ1u9AXbIq2gkGcIptNhJTOiG9sh9kRlgCF420owaxCfMI
        ni03FEl53TcFYzHvxx+YogOwqfTPKuXmlTh1vbjFTxRNx4awzfKPSHb6Oyu4siMx
        pFTd+iC5Uxpl4HgIGOJrfy8nsJEupf+aqgYTE1ovCdCaTPTPoDp2LuDKzICj1WOm
        fBEBZyIECthVuBK8RWQArrlfw79whdFkDdgkC6JRX5w4yUYiBhoqxZwXtkUsMTdD
        6/XA1U4h81iAgA==
X-ME-Sender: <xms:qEpAXdvi05Io_APVa_6oMV0raCgdYCyMH7qGc5emQqKJdO_BbIJKuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucfkph
    epiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugies
    jhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:qEpAXVv66EwFVV29N4Z5vYGZ4iPnEbtZ1nNrAH_94tDuOMU9d1sF4w>
    <xmx:qEpAXc_vZASqWIwdc7xPMwblRyf0HeRg8S1LyoO7Jxt6mS1UeA7c2A>
    <xmx:qEpAXe9NM7_ymzrBZuNvDxPMz27V9lrmPImmTcHTxUsVRtOe3l5rSQ>
    <xmx:qEpAXXLPotCd2Mc0YPclUxknmovUHiQGwUUpuPHEZgJpMvTMprTPKQ>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE2528005B;
        Tue, 30 Jul 2019 09:48:22 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 3/6] dt-bindings: add good display epaper header
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <889ecf62-0bc6-2ad3-d673-22c8937646a1@jaseg.net>
Date:   Tue, 30 Jul 2019 22:48:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
---
 include/dt-bindings/display/gdepaper.h | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/display/gdepaper.h

diff --git a/include/dt-bindings/display/gdepaper.h b/include/dt-bindings/display/gdepaper.h
new file mode 100644
index 000000000000..929b0beda13c
--- /dev/null
+++ b/include/dt-bindings/display/gdepaper.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides constants for Good Display epaper displays
+ *
+ * Copyright 2019 Jan Sebastian Goette
+ */
+
+enum gdepaper_controller_res {
+	GDEP_CTRL_RES_320X300 = 0,
+	GDEP_CTRL_RES_300X200 = 1,
+	GDEP_CTRL_RES_296X160 = 2,
+	GDEP_CTRL_RES_296X128 = 3,
+};
+
+enum gdepaper_color_type {
+	GDEPAPER_COL_BW = 0,
+	GDEPAPER_COL_BW_RED,
+	GDEPAPER_COL_BW_YELLOW,
+	GDEPAPER_COL_END
+};
+
+enum gdepaper_vghl_lv {
+	GDEP_PWR_VGHL_16V = 0,
+	GDEP_PWR_VGHL_15V = 1,
+	GDEP_PWR_VGHL_14V = 2,
+	GDEP_PWR_VGHL_13V = 3,
+};
+
-- 
2.21.0

