Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED564C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC03A2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjXOxOoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLZLvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 06:51:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46617 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLZLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 06:51:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id m26so22098759ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xHUUlXacIsdkD5xpHlgIYsmTNVE/8HZ6eRJcgqR5B9g=;
        b=GjXOxOoOhDP4X6ZPiK6LdWzZksk6hiAx4g1LzSpAgk/Qupl7QrqrzzVscsAhTcdF2f
         RO1dydg8sVY5NMak0Z12e6+ZT4geNxwRxHJN0Y3Z3rMyp1Ti2BUYaug2viNnRkLjf1as
         RA//WDzY4qpv8MW+3sQ/onqFn1L3yBpmz9UVWfCu03s6Yhshgk8E8Z497mRAf2v+j31h
         jELY5SnpmOEP8JzBBwW/X88FRHevEDedPNjAezdeeIEOntDF3fdbvhp73jcfL+pIGNdA
         nkjlbK/rqgyHx+PkUgWeOX0sJRWDIbPm7xsxq19z5DZ+lMmclqUJ1NuvyB5buCyzwDGC
         AoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xHUUlXacIsdkD5xpHlgIYsmTNVE/8HZ6eRJcgqR5B9g=;
        b=Kroy0LvUq1+9UqisOIN7hRrrSEaUFzEJgsiIkHDu5en2vq1yJcsUC1JzLTbc0AxN6R
         pj/YG/W4OCFhWaKkqaGFojIVQnaN4mtJV7KYiBi+CvRu8jW/mHPhK7UzEJwvmrDQKBuu
         OfML2KRn/75DLMmSqdmtQnyEF+YutYXvHdhAO+swbExaVxJsJUvVGV1lOW182AvVaXZo
         RIHrcJy0tbdb04KZ5QoguPeoZQWg+SeKZZeNV/QektfNiv7rDTm6WNRRJi0quKtqJheo
         NURvC2ezOxZ2PQCQRYefaHUoSKBU8NIuqwZ08P6GnWfQzqn/tq3ukc+6B3O5gTcxDRQ9
         8wSg==
X-Gm-Message-State: APjAAAWttayWkvprKde6Mou4x2dHw7spjCBJBBTPHI2XiWWeUkM10HBw
        M0vHvUrDhOG4qcx7Qu5vvZ4=
X-Google-Smtp-Source: APXvYqw/0SbORhl/FzuDQhVacfipG2Swb2CMGBo4iaB98a/5UinRs/3N0qHyAK+en7TqV0Ga/4UZ5A==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr8118180ljk.220.1577361062211;
        Thu, 26 Dec 2019 03:51:02 -0800 (PST)
Received: from kbp1-lhp-A00636.cisco.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id l12sm12249959lji.52.2019.12.26.03.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 03:51:01 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     openembedded-core@lists.openembedded.org, zhe.he@windriver.com,
        ross.burton@intel.com, andrea.adami@gmail.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: Make symbol link to vmlinux.64 in boot directory
Date:   Thu, 26 Dec 2019 13:50:56 +0200
Message-Id: <20191226115057.10413-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some mips 64 bit platforms use vmlinux.64 image name
Make a symbol link to vmlinux.64 in arch/mips/boot/

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 meta/classes/kernel.bbclass | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta/classes/kernel.bbclass b/meta/classes/kernel.bbclass
index ebcb79a528..750988f4e5 100644
--- a/meta/classes/kernel.bbclass
+++ b/meta/classes/kernel.bbclass
@@ -613,6 +613,9 @@ do_kernel_link_images() {
 	if [ -f ../../../vmlinuz.bin ]; then
 		ln -sf ../../../vmlinuz.bin
 	fi
+	if [ -f ../../../vmlinux.64 ]; then
+		ln -sf ../../../vmlinux.64
+	fi
 }
 addtask kernel_link_images after do_compile before do_strip
 
-- 
2.17.1

