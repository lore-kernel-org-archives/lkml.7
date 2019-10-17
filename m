Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014EBECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C691A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFXoCi32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392669AbfJQKW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:22:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44170 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfJQKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:22:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so1075180pgd.11;
        Thu, 17 Oct 2019 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWBl598hPch0kRqDu8LvL1lTEO0c+qZkYK5TCBHEuVY=;
        b=hFXoCi32lErSoCCYnLu5CfJ5DUh7jtw3dJSjpZu4QIhXIornz5SS8Wv3NgRj8cjHga
         /xg14KfrMHnWMM6msGCRNHmNqBY6oGALbioDutwzlhr95ogGDhPrnvAOrNTxdT2prtUx
         lrxfD1PLKHEuR4/fADn1uDcD+Fqo9/2qi0t1J27F18zT38xqZENKxrMT0bpUDEBZYMcu
         1BbDBuIwb494vcxM+0pH/XijHfw0cw+K//MTcBhWzI/kx1GIDa4Pm4ZrKSLEL9Z/hWS8
         ln3OrTsDIJxr2ZwPEdNKK+gHVqSzWA14+n/KMn6V25HoSg193v5HNiwLWfW7GmAMovO2
         jB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWBl598hPch0kRqDu8LvL1lTEO0c+qZkYK5TCBHEuVY=;
        b=AMh9Lrx+LvI4n3zbnTIo9XbmkbQqwkDGqRhnUAiyamYqxL/zCN0ROe+OWiGuZcLPhp
         YidOz/PZ8kLYt973bOLq1uaJBOxzT5skDpsQlNgChQk7m6sAjuhsv9KyQhCV+q4S1jhJ
         ceflLuKNB5dn+K0V3qGpqw7IP1+IgkBrRXtk1lZaZvB3yeg7AdoTXjyLSyePLzBTV7r7
         82iDVwWhig2TwHToX5/ziESQ/NgNVwqAm94ZH+tPfYuEEbPA6IAZBGuA2oRDy2ZqErhx
         DMmF+RV/7MMe5E6+fT0Ln97rnu6W8OcjVthArZdbiPLcbbDhogzRKkqt1HMlqFMu2EBu
         Al7Q==
X-Gm-Message-State: APjAAAVNWFapRCdd4euKfJ+QYCOsao8B5Y9QeQpafljaxXHY29gqwc8k
        M84TV3qfnydBVfhjr6bQ3Go=
X-Google-Smtp-Source: APXvYqy/NFZF8MLOEiZlivZs3yu1xL1dOOvdGkL1iWCIYRG9CULS2iKg4D8aYunoEpaFFobksF32OQ==
X-Received: by 2002:a63:db15:: with SMTP id e21mr3281660pgg.21.1571307744360;
        Thu, 17 Oct 2019 03:22:24 -0700 (PDT)
Received: from Gentoo.localdomain ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id r24sm2150135pfh.69.2019.10.17.03.22.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 03:22:23 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, torvalds@linux-foundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] NM variable missed the value,so fixed
Date:   Thu, 17 Oct 2019 15:51:59 +0530
Message-Id: <20191017102159.20387-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will provide the missing value for NM variable.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/mksysmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index a35acc0d0b82..4b2f45c45f14 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -40,5 +40,5 @@
 # 'W' or 'w'. __crc_ are 'A' and placed in the middle
 # so we just ignore them to let readprofile continue to work.
 # (At least sparc64 has __crc_ in the middle).
-
+NM=$(which nm)
 $NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( .L\)' > $2
--
2.21.0

