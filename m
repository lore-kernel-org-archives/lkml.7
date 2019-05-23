Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D80EC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4642420856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igINZ4GD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfEWTxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:53:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43467 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387422AbfEWTxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:53:18 -0400
Received: by mail-io1-f65.google.com with SMTP id v7so5863796iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DUU/JbmMxaxg7HEI5Jb2l3ME8qgdUZEOoglUf3jK+GY=;
        b=igINZ4GD+EOp0DvTKqUNFQnlzJ1wiFH4hEOhTjj0cIvpAK3IncMBUgipg+Uy6akPXM
         oM1m5FQHGxuDD0SnhgkdAEcdanMHc3aDKrCDQIUR0BQJAlZGy47IYOYNn0WeVrBNoGXT
         G4A9527XT1IEyaaEUwzfJTN3i5o5Fd4hHTdHaAAbf6XWlp2gtioS3KYT9Vj8DniHnSZE
         5rH89R5ML0i9TBsCS3NQdtzGagFLiUDYnND742EMZEGgg1QaxwmyIKM40sGPimDdIOYT
         hboFUwj/at1sWwmTWW8b845KOHsU4s2p4+JeLiaGNKGQSWnHEapnMam2xhYd92iphFiC
         fazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DUU/JbmMxaxg7HEI5Jb2l3ME8qgdUZEOoglUf3jK+GY=;
        b=mNWQd/OJFErt+gcEJ8HmcvlmJev6N22xQJxRZYKgUpHXMON8VTh9Z4JhWAfTdp+ltG
         LOhxhsB5R4+eJUq0OKdX5POwzipXiqlcruqXGvSTk5fUq7q/CkpRpruRPf7udDKgBVjO
         27KQijZ3nN4H7+SGBJoycy8Rhl90B7P1XnHPwIMRphEhKkt8PvTNQMrQIr+fm8dIZqqL
         KskXUrMmEAh645lw8eWM1yPtUwXEWhn3q4heEDxitBO0N4MDL1pe66ZpJ/+jwksJvTue
         Dyn989pmnHnFFgim6nyXKd+i1O7sQsP5eY84+glHLoPspeLS14o9aOXdORUXvAapcJQ2
         QQQA==
X-Gm-Message-State: APjAAAWMFzyeg4GfGR4Sy10dyYQPK7M14QWW+PFCbEqfwlKWOeID07Sx
        vhfEcPm7PyfuJgHvk4YMkczFaeKC
X-Google-Smtp-Source: APXvYqzZdSej/UV5gAPYiZNghEuZ3itNPIn1ECvcokeYAni5y3sjlxKqulk9wFkuXjR1CQ+YInXCpQ==
X-Received: by 2002:a5d:9c0e:: with SMTP id 14mr24944306ioe.135.1558641197860;
        Thu, 23 May 2019 12:53:17 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id w194sm206638itb.33.2019.05.23.12.53.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 12:53:17 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MAINTAINERS: Add entry for fieldbus subsystem
Date:   Thu, 23 May 2019 15:53:12 -0400
Message-Id: <20190523195313.31008-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the fieldbus subsystem.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..1cac53bced08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,6 +14905,11 @@ L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 F:	drivers/staging/erofs/
 
+STAGING - FIELDBUS SUBSYSTEM
+M:	Sven Van Asbroeck <TheSven73@gmail.com>
+S:	Maintained
+F:	drivers/staging/fieldbus/*
+
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

