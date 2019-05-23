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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D90C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732472175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgyMP5yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfEWUaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:30:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34637 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWUaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:30:05 -0400
Received: by mail-it1-f194.google.com with SMTP id g23so9178188iti.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bj8ppQxP85B58Zim1uSrGIafGs36jGGfVhzakkkoJL0=;
        b=MgyMP5yTi70qv6L9VuJ/IqB2z5GtK651k+ch3j89jfiehUtxLq+Hfh1ecDFhePBaCp
         pkntcUHEJPF44HxV1Hd4DMSjJALUHcqTrwO6DzmaBTNl6feAgXrwpEpXJCAi1xZJInBB
         uRH/ftjIXdrORSzY6I8wCi7rRr3m29b1VfEHKQvxhJ/420bSgk1kFI8I4acSmXpZcz3r
         o/EVa3Fis/FU+i69IJKUMn6rpX7oqrarNjj7IJoAufs4DJdmATKMDnI+to9cxYJocGko
         8aRMHC6B2aBWTnMbVCPDrCf6rivW2ow6TSa0QYBrXZEW4bheKdIWl+c59bYBaK32AmDE
         6GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bj8ppQxP85B58Zim1uSrGIafGs36jGGfVhzakkkoJL0=;
        b=bQ9NlPCuuGTWc2VueEpUMnmYveFi6IR1dqQEaxiVCH9BhF4QSfH+DNgB3Aaw3j+5N5
         WjAXQ7gW9rjsTZ5NZzoaoJi0Ts/84JA5Crsd+SEqKl5rJozTCnkd484GeSAt/p8QVp3L
         kMQhcyow7fo+odkhYUMT20/m2+rOYEkq7hlI/oiyf++qrSWqloGdAzofJh22O/S7sFNP
         TOMblfY0STuXxJkw4jCsUuJYAey6k4/fyE0oUHzUN1HfW0NY6uuXxYetCJrF9v0TYSrw
         B8P8zl0/tPI5lBDv7/SCoM9z140BhxfwjE2/moQWr4w56cU2eVjC5ywUpgf9Jl9+HWOF
         2QsA==
X-Gm-Message-State: APjAAAX307KOULCDjiALoXayIb8U0Ba5dYTEyLHOnqww1np0wY1t8b/N
        BLtZTvjXpRG7fe5QYgf3oKw=
X-Google-Smtp-Source: APXvYqwvbihKVmQ8+K0FulJCkH8g3QIqOgHcJOQGzLZBouc8mWMwT2mytbqz7T6r8z+/P1htwpl9qg==
X-Received: by 2002:a24:61d7:: with SMTP id s206mr14577422itc.133.1558643404344;
        Thu, 23 May 2019 13:30:04 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id w189sm217903itf.39.2019.05.23.13.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 13:30:03 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 1/2] MAINTAINERS: Add entry for fieldbus subsystem
Date:   Thu, 23 May 2019 16:29:59 -0400
Message-Id: <20190523203000.32306-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the fieldbus subsystem.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..50e164041e94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,6 +14905,12 @@ L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 F:	drivers/staging/erofs/
 
+STAGING - FIELDBUS SUBSYSTEM
+M:	Sven Van Asbroeck <TheSven73@gmail.com>
+S:	Maintained
+F:	drivers/staging/fieldbus/*
+F:	drivers/staging/fieldbus/Documentation/
+
 STAGING - INDUSTRIAL IO
 M:	Jonathan Cameron <jic23@kernel.org>
 L:	linux-iio@vger.kernel.org
-- 
2.17.1

