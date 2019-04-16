Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E238E20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHt5tLmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfDPP45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:56:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33764 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbfDPP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:56:35 -0400
Received: by mail-io1-f68.google.com with SMTP id b6so18082375iog.0;
        Tue, 16 Apr 2019 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQFqFQVUxetZDoixO+ZL6V2DgOrkdNMpFZaDD4ru6eA=;
        b=vHt5tLmNfp6P40u7mqTQi+y87gGTM4/WVija4SUtoQLzf6iA0swPM0VFDG/Eti3r/f
         R9QfTgtEHvagXZd3ckToKHp9eMGFZC5Bcxe0l71q4MlKZqBSF8JdA/maF9T3XTggFIyB
         78s1gX9PhDV92K9ftFr35jeEORk6bsdLNbFRQMkbpiSJZDwLfwvlILq24R3FZYHQAi8a
         T6nxDv4wyi84RIPtW47qPApy/sPh7qyypPpJVWnCsvel8s87gu/GgQ2cOxRLQbEpnTdH
         B+hTh1xxUc7XDg3IpZaO7hiQbzGoADmmov5nW2gq7XPiKfeyTcQ9NeHaBuSh24yCxlS8
         ma2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQFqFQVUxetZDoixO+ZL6V2DgOrkdNMpFZaDD4ru6eA=;
        b=BPSmb0hWuspszbxHnkdE3Hz+yU7Zl9C2j/8u2aztDoYwk+d4fES5phd+dfsp8bZOJe
         kAyfXoMVQJzZW8U0VgXawlGTGTsFPP7naI1jcvTY4joxYxjik1id+L7xf/e/UUKSGwz5
         LtX1dyb0ANVGui4RIgyG1JegmHalvHQ8WLOcAIddpL4N+dXuv4yaHDvyUGZKzTLRHxLP
         yDBeiBs/c/mLtIstvK2YhZkzlMX7ley5mD7gDDec7VzjgcY7g0q3e4DKSm7BA6II81A4
         uhJHRAGyLzKB8cGo1QHE3m/WcL7vLrPAdBIenvka8LKbmGub0ewpxNxfi2JT1x5RL5Qw
         L92A==
X-Gm-Message-State: APjAAAUuX+zc29bMsXZ3AJ75w6cxs6PqxsA6CaJNMnq8cUm/M07H+VIy
        478px/OEHzZzKNvFOCyP4ydLxp61
X-Google-Smtp-Source: APXvYqxcoPenFVbF2jO7bYPnhGYuAF9gxPujEKuDKz27EVcqJvPGUy2vwzRJx+L5Dm6VLUQ+J5cxMw==
X-Received: by 2002:a6b:e206:: with SMTP id z6mr1175364ioc.237.1555430194565;
        Tue, 16 Apr 2019 08:56:34 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 64sm9766630ite.42.2019.04.16.08.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:56:34 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v11 7/7] staging: fieldbus_dev: add TODO
Date:   Tue, 16 Apr 2019 11:56:18 -0400
Message-Id: <20190416155618.1369-8-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416155618.1369-1-TheSven73@gmail.com>
References: <20190416155618.1369-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a TODO file which describes what needs to be done in order to
get the fieldbus_dev subsystem out of staging.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/staging/fieldbus/TODO | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 drivers/staging/fieldbus/TODO

diff --git a/drivers/staging/fieldbus/TODO b/drivers/staging/fieldbus/TODO
new file mode 100644
index 000000000000..6d6626af4ec7
--- /dev/null
+++ b/drivers/staging/fieldbus/TODO
@@ -0,0 +1,5 @@
+TODO:
+-Get more people/drivers to use the Fieldbus userspace ABI. It requires
+ verification/sign-off by multiple users.
+
+Contact: Sven Van Asbroeck <TheSven73@gmail.com>
-- 
2.17.1

