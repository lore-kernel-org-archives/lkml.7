Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCC2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0E621871
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn8sg71B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbfDQXj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:39:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55928 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:39:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so561072wmf.5;
        Wed, 17 Apr 2019 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U3OUFZkvLR+sfhgq/9Kpt0ROY6Ygc8Gu7DEm6hUTRqE=;
        b=Fn8sg71BLadIIr37bWFmQes6AuSD4Jcqop1c3MM+b7riJmh/PmwTVj9Eqo2NOJJSPK
         TQ6ks5NtYhMUBNz2ijJi/4X7Semxm80Cb7jF83pFqPLloswF/nyma1kS8a4t8BB4KI9W
         OSx6rjyMOsMbNYUrIA1b+c3dQ5qocUjsT2Kh8lm2WW49U97Cm2m6N1gph0YxKgvpbCtf
         kklLF9lcV+CvjrTzEBVUevpJ3m9AWDTUVfcQTdYgNUCSGNc/5f/1r8msEHiBKsAM4xoS
         vp+FRN9rZ428xH38Adm5Y9zij6e3zdeurtK7jqgscolv/40Mlb6r+dbbTxpNk/lIASY1
         Eaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U3OUFZkvLR+sfhgq/9Kpt0ROY6Ygc8Gu7DEm6hUTRqE=;
        b=XL8jTecplGOQqEtYX8ROW5X3w7U2AF9Q5Vx45jTJNCPQ8pZKzc4yCC72xGQQKMXG1H
         7BAagAp/tpffuUEqGvXklT1ZjMxSsVDmHMj2J5BfNe//FhkoAQ+OO6Jy94DF2Ce6QfsR
         PVngqCmxcq6FVxJId+iGzphxrpt3WnnhYmuWdWrUZi52bq8EmGSd2IvydfFv/veVnJtD
         IwLzHm2TkDh9K10+WXP6tscozwMCIqcnDi5OM2N3RbsJHUptWkMAgUabQd0hawlkCFeM
         2aaZ0a46LMYs1qTPvXxSOfE+OIfe33t2mQwNwfOzf/Nlhdh1djxlno+px4idWXNAPcFZ
         1zBQ==
X-Gm-Message-State: APjAAAXxpbXtMMsELiZzzBeLZBG7C/giFyqBnbyNrQ+9KHp+gfRU2srX
        da3EFgXwoNK1nbpothvTjlc=
X-Google-Smtp-Source: APXvYqwTW3AZDtk9isqrvoULgoO/MceqJdVgEDBklPc0RsX4JiGcNtjVNkuPCnZv6P5btMSyVHXMyQ==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr781803wmb.10.1555544364969;
        Wed, 17 Apr 2019 16:39:24 -0700 (PDT)
Received: from flb-GL552VW.home ([2a00:23c5:d2a0:d300:5d68:d3ac:d79d:ec90])
        by smtp.googlemail.com with ESMTPSA id k2sm241259wrx.21.2019.04.17.16.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:39:24 -0700 (PDT)
From:   Florent TOMASIN <tomasin.florent@gmail.com>
Cc:     tomasin.florent@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: Add CDTech S050WV43-CT5 panel bindings
Date:   Thu, 18 Apr 2019 00:38:44 +0100
Message-Id: <20190417233846.11880-1-tomasin.florent@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for S050WV43-CT5 panel

Signed-off-by: Florent TOMASIN <tomasin.florent@gmail.com>
---
 .../bindings/display/panel/cdtech,s050wv43-ct5.txt   | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s050wv43-ct5.txt

diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s050wv43-ct5.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s050wv43-ct5.txt
new file mode 100644
index 000000000000..0e3313b68d9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/cdtech,s050wv43-ct5.txt
@@ -0,0 +1,12 @@
+CDTech(H.K.) Electronics Limited 5" 800x480 color TFT-LCD panel
+
+Required properties:
+- compatible: should be "cdtech,s050wv43-ct5"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.17.1

