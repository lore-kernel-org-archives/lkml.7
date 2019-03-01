Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C0720663
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od2YN6UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfCAO3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:29:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42174 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfCAO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:29:00 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so20538808ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f9iT7k/0SY7wktRs7jQ6KW6acCQnct+rF3bMnszUFjU=;
        b=od2YN6UYNKJUpYL9AK7wxGbvHJvh4vFRVwQVZhVyGCehvPM7NElOWRR3l/kHo+Vofm
         sp2Dq114RZtuReeqRmsydJYG8sSqGjGD2cWMnFYzemQJqZjcH6oK3sqRLV/4o/iywthx
         XS3bP1cfVFpJZeySsL1iok2lwKGJzcuEIKDUsdhzTdU7E5b6fkIiqUXRMDHZq0Q9eLMe
         JeYjOwUzFrSroQTQImr/CvGqa46c5mmwbom0IdQmtlGQ0GNP9Nyv0UkeC3NF5Q2qVQ9h
         NpZXUBjwjRdUiXnn5kx8mypsub73Q9KXnPxLucQZm6PPmGPU6fWFcPR+KT3I1WhYU5pf
         WKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f9iT7k/0SY7wktRs7jQ6KW6acCQnct+rF3bMnszUFjU=;
        b=qe8caSfVbS1yG6lftUVupKPW3NfXFZVv32MFNNr3IkY/4s3RWmmFMRgJPZm2kFeD8g
         3MdYHFi9XPIoQr0CDTbCywSY8ccMzwKIPr3ntu2szPR9748SEj58j2wGFLcvJ9i290Id
         A1P8Q8/XWqHRfFvb0kz7awkQyYVQ0feloUM4Q2v2DWAaFbyzRn2aGKEUPyKiPT25Nw4p
         co/NHXjQ6sUASGJjduEtWrNOs8CYmPPcYd7qRh1/2D0p6ucFUUrvM6LcRtJI0poTjrCN
         1yr8A9XpvRU2886S0Ok3sI6zyHbtd7Vr8h/giaRZLSeyWakkePIzc9h9UlhKexg05R08
         ncwQ==
X-Gm-Message-State: APjAAAWLIxiK/2GLfitLdzGTwpcd40+3MANaUr7prAhgZvvruoyUNMCY
        GJQrHohaIu9OkbkweNSemes=
X-Google-Smtp-Source: APXvYqxH24p6XmqIj/tHGOdMJXjfxLJLyjBSusqpM0XHFJrjnzSWxFJNnOaS8Xlbc0lsWXr4tKSobg==
X-Received: by 2002:a2e:9056:: with SMTP id n22mr2829450ljg.132.1551450538283;
        Fri, 01 Mar 2019 06:28:58 -0800 (PST)
Received: from localhost.localdomain (bzq-109-64-85-100.red.bezeqint.net. [109.64.85.100])
        by smtp.googlemail.com with ESMTPSA id y20sm260232lfg.44.2019.03.01.06.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 06:28:57 -0800 (PST)
From:   Oryan Perlmutter <oryan.perl1997@gmail.com>
To:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        trivial@kernel.org
Cc:     Oryan Perlmutter <oryan.perl1997@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Coding style fixes on vme_user.c trivial
Date:   Fri,  1 Mar 2019 16:27:25 +0200
Message-Id: <20190301142726.23969-1-oryan.perl1997@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/staging/devices: Coding style fixes found at file vme_user.c.

Signed-off-by: Oryan Perlmutter <oryan.perl1997@gmail.com>
---
 drivers/staging/vme/devices/vme_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme/devices/vme_user.c b/drivers/staging/vme/devices/vme_user.c
index 6a33aaa1a49f..4c7db4f5f15e 100644
--- a/drivers/staging/vme/devices/vme_user.c
+++ b/drivers/staging/vme/devices/vme_user.c
@@ -506,7 +506,7 @@ static int vme_user_match(struct vme_dev *vdev)
 	int cur_slot = vme_slot_num(vdev);
 
 	for (i = 0; i < bus_num; i++)
-		if ((cur_bus == bus[i]) && (cur_slot == vdev->num))
+		if (cur_bus == bus[i] && cur_slot == vdev->num)
 			return 1;
 
 	return 0;
-- 
2.17.1

