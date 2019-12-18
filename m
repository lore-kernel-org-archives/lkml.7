Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BED3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DCF2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbJDb6Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfLRRxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:53:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41857 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfLRRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:53:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2329255lfp.8;
        Wed, 18 Dec 2019 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvdNzD5IHBhEmZtEDEpQOxOvOd8cBVmNkzSmjr/+b7c=;
        b=CbJDb6Hn1Xp6w0jO0TzCZ7qQo4TJSbPb4WqlWBJ4UmRISdwW29CWw4D5ysJQOiU3B1
         hBArmBN3yO5tI/6jmKE4wrVJx/sKbV2fLyYqQHPjEEijKBC3Gi/nJAC3APUZGuokLVIx
         YIH6ubAyj0VAqgy/pX2TeEb4uF+rmO2btd5wsjP70fzG5WioLXj3a1zML/r82DIxrwx2
         xrjmBrLzSXyHVn3zAzjv2+bYijuykLabhDrrSQdaZFQQWjIUjyPw152w9Iq6LJ382XHV
         IT/e4vRuxhmn60asv4P1IbMOBC16UiuZ01xe5ux00YkC4kFw5bwGht9QjeiDc5uEANTL
         hr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvdNzD5IHBhEmZtEDEpQOxOvOd8cBVmNkzSmjr/+b7c=;
        b=KeTV9nmpP1NCFdaQ8GqfbwVyqjNgv3qYxftSVuJ6CDphvnuVKanSQgVw8aubtVeNGM
         oGHMBiEAhYFQ81thV5h8JHlwu6UeZj9voqvZFkxKZ7nhnWqxFjw0/x+N4XAiA1GMLUw4
         PeWgJlIZcKWC+47a563hZzPGcezDjdBghXbrPRSov5rTGYZ/7jN2Fa9bcasGj6pGbCSN
         d9NGBKZnk+PVkTXeZZxuE6pBac50IrI4TcBe9gU+OpG/M4YqoN2y0iogbVqKj/muvyvw
         JSST0yVlhCGObMZ4c3gUw+GhSHjFLpCsvdEKgPHJ0E9y3cvv+gDU3hmWlhd60OcVm4/S
         INOg==
X-Gm-Message-State: APjAAAWyKuL3Pd8ASoYtLcs12RYLBjlUPq8msyoPrXozVVZaACBbayJf
        2DMJdkCDfeDh/lgMDiX78fg=
X-Google-Smtp-Source: APXvYqynJ6OZr0C28qKxtkM6gS+TYuGP4lP73cGe9dthwwy9gNHH0PupidBT9cZKFndV3I4FL5QHDA==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr2582822lfm.189.1576691617069;
        Wed, 18 Dec 2019 09:53:37 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id n14sm1530480lfe.5.2019.12.18.09.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:53:36 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
Date:   Wed, 18 Dec 2019 20:53:10 +0300
Message-Id: <20191218175313.16235-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218175313.16235-1-digetx@gmail.com>
References: <20191218175313.16235-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index cfc9f40ab641..51376cbe5f3d 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -15,6 +15,10 @@ Required properties:
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
 	"xlnx,zynq-usb-2.20a"
+	"nvidia,tegra20-udc"
+	"nvidia,tegra30-udc"
+	"nvidia,tegra114-udc"
+	"nvidia,tegra124-udc"
 - reg: base address and length of the registers
 - interrupts: interrupt for the USB controller
 
-- 
2.24.0

