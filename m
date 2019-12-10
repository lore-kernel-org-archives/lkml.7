Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6ED207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmG29wWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfLJIgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:36:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41829 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfLJIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:36:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so8693552pfd.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pu4/2ANQPmHZrnKzXtjqAfHQuVoyYqqMUD1zdA8TWA8=;
        b=EmG29wWHS2gp76gw5j3GqEm4nyPPfdATY90pc5UqygzKBc5TDmqGPwDFS7SRnJlaKv
         7plSFyoJZ824pMoBZx6dPBwetD31p5nCUr99dOefcYmnK2WlSDRMWCsxBGIU/hbT1sFi
         J5sqKnPsNI9YxRaOlVp1uuFE5MzhrlflzX/rTinscA52tmvAGE9MsWDUpVe+WmcUVFJl
         KePxNMxLVpYxBNdIsG6b5Dg2Z/ZlxyxdfpToy3Q6Pxlz8OCRAWtD+qD3vQTXA4YXXgx6
         UqFPjmi0QcIjF5O6pmS/9lCY/VNKg1V2uMy9j9pynP7yKD1pfyoo+6JVC6P0IBOl7r4o
         U8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pu4/2ANQPmHZrnKzXtjqAfHQuVoyYqqMUD1zdA8TWA8=;
        b=I+xu+EpB1d4pctvESHyC0/bsfazwESCI1mkClQyqzMOQ3PzD969iboDoeMPn4b19rd
         PnXRm7cc0m1hvitmIyhb4/x4hwpz+f62+THBu0kdYeWoHgJPk3GIxRUWzovahC4j8C7Z
         ey92PSCYvJz7Cv09xo+DeywUstnLKkLkx1x2L2Y25WjgzSKwU5/yFiJLdEfacC76ov0+
         RY2p24L1PaQzTLhlYwnVkIgb6dOXVFMJjYqUcb9nXVY4MQBC/02fS/Jjao8j4OKnya1j
         3pQf+sRdGAinE0PNVhcDqppXbZOCJLsvQ0vGO94Aq+JSGVXXhGPI4Z6oqbddks3bbWVE
         pENA==
X-Gm-Message-State: APjAAAX/e4Z0nKeA20kuseHSfInI1hN954ddgo1s2pmyIM6GF86g8Aln
        zoBUSSnGt66TjFqMeDt+r1vt0EwT
X-Google-Smtp-Source: APXvYqxgmOJlJQT/f6GLe/LclnoUiDgzdOI5a+hO/n4LoErVTMkV97Glbmatf5OUJuzw8HjBO71M9w==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr25582339pfh.92.1575967007902;
        Tue, 10 Dec 2019 00:36:47 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y128sm2246632pfg.17.2019.12.10.00.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Dec 2019 00:36:47 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC 1/8] dt-bindings: display: add Unisoc's drm master bindings
Date:   Tue, 10 Dec 2019 16:36:28 +0800
Message-Id: <1575966995-13757-2-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

The Unisoc DRM master device is a virtual device needed to list all
DPU devices or other display interface nodes that comprise the
graphics subsystem

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 Documentation/devicetree/bindings/display/sprd/drm.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/drm.txt

diff --git a/Documentation/devicetree/bindings/display/sprd/drm.txt b/Documentation/devicetree/bindings/display/sprd/drm.txt
new file mode 100644
index 0000000..7327b9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/drm.txt
@@ -0,0 +1,18 @@
+Unisoc DRM master device
+================================
+
+The Unisoc DRM master device is a virtual device needed to list all
+DPU devices or other display interface nodes that comprise the
+graphics subsystem.
+
+Required properties:
+- compatible: Should be "sprd,display-subsystem"
+- ports: Should contain a list of phandles pointing to display interface port
+  of DPU devices.
+
+example:
+
+display-subsystem {
+	compatible = "sprd,display-subsystem";
+	ports = <&dpu_out>;
+};
-- 
2.7.4

