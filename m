Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950CC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A02073C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c33a1OSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfK3O4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:56:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36184 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3O4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:56:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so38443330wru.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwCozoTs8XG2ql1FZKnvEokfnqeNfbyM67ucxeEUbfo=;
        b=c33a1OSsBgCzx7NXCRReDmDQ2HWnQM1tDZadOh/TrDx47fxF5xc7+1WKtEvniCFm1H
         copRaEtRL+RhWoL3tPJvo3E7wkYvqe9R5RnI2y/5cfKEi4iK6fOxHsTSZq+kwfSPY+p2
         KHW/EwcaKDHkEa1hXO+9sNMvzVCIXio4TzVQzIiGIvmAP95H0SsnizRQFRGapb7okML6
         D+0ViMS8yokFh1Q5JOIAEdTiDD6lzXMJs+9pjqGpxCTDMtMTmmUTHjiLs57RDkDfp31J
         +ZB9qjAiSY8E/9WQuq576Xr8ZjTjYPlsZf7+4HYkOi0RbRfjDkIMOo3wKrznC4ljK8yp
         fH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PwCozoTs8XG2ql1FZKnvEokfnqeNfbyM67ucxeEUbfo=;
        b=tjrDSIFtMY/mJNA0/T5zxm9YyduJ76Yc7RyFeYcw6lqJkpmtsfKyYExHi8aZSYDzEc
         OPjX39j6IiBzAM6bqbaqqmtDewKKkNhMFmN6ysjGvUa4X3gWunKkxbTnVssCoL2NZfx0
         ouk68JKIlg4sMKByQSrW8ghXnRpwHUSh2zEIuxLDVL57EJZY5y4mLV5wa85GuFpDspwb
         wzvznpxzyxztEkx9QbdxXq5lO4BsvHjr+6YNwZaVSNqbJWPuMSa5uvkHbZ0Jo1jjzWLI
         hY7QIO1x5ckhtEvs/zJEUuFseCmsEoNaj+BfhaM24vCzeKK/N/Zlrc02OJwdK/7nNBYE
         IcKA==
X-Gm-Message-State: APjAAAVWqXTRnBjqPsmsGrj5/sEkG/fzRcO61S9qmQpVJOH4Bur1IrWA
        HxYPwHMFeD3/I5XOx3Z9rjE=
X-Google-Smtp-Source: APXvYqw5vPFt6szAkomA55xwpp96G7mGWyk6w+xUYxH7mO7VnvBKH6M4Ne9jlegRNkKp21i0+9KIFw==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr11646557wrr.265.1575125790967;
        Sat, 30 Nov 2019 06:56:30 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b17sm7163391wrx.15.2019.11.30.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:56:30 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] amlogic: meson-ee-pwrc: two small fixes
Date:   Sat, 30 Nov 2019 15:56:15 +0100
Message-Id: <20191130145617.1490233-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on power domain support for the 32-bit SoCs I had some
crashes when trying to actually use the power domains. Turns out I had
a bug in my patches which add support for the older SoCs to
meson-ee-pwrc. However, I didn't notice these because the driver probed
just fine.

This is my attempt to spot "problems" (bugs in my code) earlier.


Martin Blumenstingl (2):
  soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
  soc: amlogic: meson-ee-pwrc: propagate errors from pm_genpd_init()

 drivers/soc/amlogic/meson-ee-pwrc.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

-- 
2.24.0

