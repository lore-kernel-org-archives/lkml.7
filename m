Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EA3C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526FB208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ees/umAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDIOnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:14 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37547 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfDIOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:07 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so14494048ioh.4;
        Tue, 09 Apr 2019 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQFqFQVUxetZDoixO+ZL6V2DgOrkdNMpFZaDD4ru6eA=;
        b=ees/umAUASEMWdtucal8VcNe5tjSohjE4N5bGOnCHvgke7PuRoF+jleHXymfJXq4OJ
         RuxIs8xYo5fYKk5beqfz9m64gUSmCvF/ylYKhup5clM4ljNfLUiYH/LcgkQguIStrmEU
         Prpsm5EkzuJNgji/4RyDmgCcO3QDEAy2biUlzSYW2hGM2Zh3Sri7Jh2ZcxorS/M32XVt
         SgioAKvtS2oGrZIB/lIdFsy8jVjg+CaFwA092c+ulPZOhDHLovZlUAyugXzYhQCnoE70
         jObGY+dDoUIfREDCOMS2bBaXfgOEJ+5IOQO784ARGsjE6aCyBcVYIDVfXSuHZnIkSPTd
         Nhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQFqFQVUxetZDoixO+ZL6V2DgOrkdNMpFZaDD4ru6eA=;
        b=KoDQVKFo58zJynmkHA/DjPWLxbMyQaiBcAtHIy/u4Iu4LdKFDU85Zvo6ofjsLiyTY/
         8Tc9rk7kqNWBLDFjiAxe5OtY7J3YFEz2PhdwNa49zdmxsaOxGnxNKqkMM/cI9+6YMB3z
         czjTCAsUxRfRovPfIdQi85n7RoIRIz+TVAER0pwwQ+zuON3cvluuw3k30pDl7yRhoXg8
         DtLFFxTW7Fwns8NE1ycRijgg1UUR67TgjS6jXsTPP6LtLoMc922Yf75PDZBk7gTgCGzP
         9iKZNqu/7PpeAQU6ERe6tX31rLH5Xfl6Z5uvPAghx8zOeT5kBgxT9jOo6UN8HAZ758ws
         wBRw==
X-Gm-Message-State: APjAAAWCIE2vE9Ft906Z5yVGztLD0+2uAMUmUKVd5ltOzU/xvLKidvre
        IkVe6k9ggJQclhIYT4ujFDI=
X-Google-Smtp-Source: APXvYqyS7xIy/pkg3jKtpLnuYHGBtkxn7aavxbZMuxynBImler9jVpWYJNy2OeE60S8KwI81Q69fPA==
X-Received: by 2002:a6b:b757:: with SMTP id h84mr17326014iof.193.1554820986604;
        Tue, 09 Apr 2019 07:43:06 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j10sm6562000itj.32.2019.04.09.07.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:43:05 -0700 (PDT)
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
Subject: [PATCH v10 7/7] staging: fieldbus_dev: add TODO
Date:   Tue,  9 Apr 2019 10:42:50 -0400
Message-Id: <20190409144250.7237-8-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
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

