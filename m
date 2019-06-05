Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FBBC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B052070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DncVZ5oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfFEBKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32942 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEBKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so16211559qtf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHgsRDD1+z+6q19pHneXAjqZEoVFV7+iEPXXwTFoSwE=;
        b=DncVZ5oMJZ/Uwq+Bq4S3U/4k+Arlj4Qd76UGokSeAPFh0b6mj0G2gyCW+xayJfzN4J
         hpWKMhzbQnaVyg9Fzd23k3oLrVFUt5M1g7PBde2ndSzJ14goiG6LUPmxN84cAb7jh7X0
         meyKmPLujNT6qZLSPs0nF1KBaki/7gPcm1xDB5r93g7gXDp6Q9n+wzeuzuoSpQvbQ/rk
         zIfjddlOul9VxSLPUICHgpOvmWg1NUal0OSyaSd/XeE0a/dAcRYd8ahD5w+rs10jlGbl
         H29Hdqw+VyRgwTr2ZVkr9/9omzuADeHXCMtrQySQN6y7l3ACqMtCK/2StntyyB3+AEE+
         fohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHgsRDD1+z+6q19pHneXAjqZEoVFV7+iEPXXwTFoSwE=;
        b=efrxWXnoBoDV5YI9dOj6g6qWVjTFo4vHv7JhRE/VocOPCnyzHUxFaCDJT4nwzpwL7Y
         ZBdiP5T9oj4wu5C/yAGY2JgudHEiJaJN00i9Vfm0o6zvKrO8N/mvo/19pVeYZjy89pEX
         z+DGZ/ZphFioHnZUKdUG6m/ed7jN2O5cC25Lbb5+nKOf0bI2pNrRPo4DeYJBaIl8rZug
         FOeV/NIiafMp7DbP1oTAnGF7EfwZqEn0AcHty1/OwpSTc7swfdVGTk+uRvZXSU77lW4L
         2CEDRsCdL5Fhexi857Na3zcxXMTZ39cwcaEbO3KUAmA0LnyIve4VgGeWKPR8j/h64pX5
         biRg==
X-Gm-Message-State: APjAAAWgJnQuMrxWlhW42y/tjvtaoHqlSJliqldZw4wai5642/o87BM6
        JGFe46KIQF+AjXRaEO4+5mU=
X-Google-Smtp-Source: APXvYqx/56AMU552StH8BKRt+dZNUrjJveYZG2J8uctiMGQhqjMdIN9H9Q8GOw8kv+HEBLYcOGTUuw==
X-Received: by 2002:a0c:d4b4:: with SMTP id u49mr1783502qvh.202.1559697004703;
        Tue, 04 Jun 2019 18:10:04 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:03 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: kpc2000: kpc_spi: Assorted minor fixups
Date:   Wed,  5 Jun 2019 01:09:07 +0000
Message-Id: <cover.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Primarily just a bunch of unused / unnecessarily used struct member
cleanup patches with the exception of one patch which removes an
unnecessary cast to a (void *) in a couple of functions.

Geordan Neukum (6):
  staging: kpc2000: kpc_spi: remove unnecessary struct member phys
  staging: kpc2000: kpc_spi: remove unnecessary struct member pin_dir
  staging: kpc2000: kpc_spi: remove unnecessary struct member word_len
  staging: kpc2000: kpc_spi: remove unnecessary struct member
    chip_select
  staging: kpc2000: kpc_spi: remove unnecessary ulong repr of i/o addr
  staging: kpc2000: kpc_spi: remove unnecessary cast in
    [read|write]_reg()

 drivers/staging/kpc2000/kpc2000_spi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

-- 
2.21.0

