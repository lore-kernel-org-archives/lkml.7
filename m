Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594CC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75C208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz5v4uKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfF1R1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:27:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36776 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1R1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:27:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so2883988pgg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=F7Wjuu+YAC+TMsgPBs7sDbNdhkAudNoqym9xPIOSlIw=;
        b=Bz5v4uKwgvlAz5rXyYLV6lB7tF1/0vIK2w12fJTasrYDDuS4M0IdP2rf5RDJFHj/4j
         7n/o2QuI+0N/fDNjAx5i48FLuTyxaxCNFvxlshBmd/UJUkSZ9YItDTv6EMvZB5N4EOgd
         pGdyICU2n3MifgdbkQd6ZNku9JRBmPN2JcKGIIEK0gUpP/7MQit5GdJirc2PDpb76Pc9
         Eh8Aa+/1NOiUSjiK2KQBv2lUMQ9TzRg5EKbp4JYmDsuR+LLXSYiM2Zd2CxBPKk/ZyWb7
         4Jxy9moHGPLhzBXZg5Fi5aIn53oFRRFNQacd65S/JCQM9YOcZUH/HtHI4mWswID4VMnl
         ywVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=F7Wjuu+YAC+TMsgPBs7sDbNdhkAudNoqym9xPIOSlIw=;
        b=Ck4yfrafg8MW37asnvjTjrLxXThxANTNCmvJ8DESRZiFtgG3z8vWXOKCA2mq1vx9U4
         +Ct26szbxPYzS8BikP+fAscELAEHOrjH3XtooOWz2acHmUCTfNTqPi2J7qhg8qkrbZL6
         jG5YY6h/EnDWyghlYbCXjQuBcOTmNuLguG0zz3ISGJ4m0wuihVYE4FW3K9xV7oAB/PPd
         uVX/wKpFnorosPNECMf4ARqLl+XR9K+uC6U2O2C6cmSWXB+cL+zRxzNFNavJP6A8H0Sy
         WhIv8TyeetRY7JFCV6gu5K9jiOInJdMTICNFpDjbSgjsQ74ENdZ84ke0iPikFX2btK1O
         W0iA==
X-Gm-Message-State: APjAAAW32r8ll+gsb+pHXZkkDpX8avGJpI2ZmaluP2GDur9YIS0YPAww
        HUhJoYKx5KfCS0+rub9vuHA=
X-Google-Smtp-Source: APXvYqzAEP32NwaQdCQEcfyK+5IQX8lrXugQxv3e/LojcusSE5b0Ym/UhhiXvCakHYY6O9BIczTwQg==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr14392945pjk.89.1561742868182;
        Fri, 28 Jun 2019 10:27:48 -0700 (PDT)
Received: from localhost.localdomain ([183.83.73.90])
        by smtp.gmail.com with ESMTPSA id k19sm2070490pgl.42.2019.06.28.10.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 10:27:47 -0700 (PDT)
From:   Harsh Jain <harshjain32@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, harshjain32@gmail.com,
        harshjain.prof@gmail.com
Subject: [PATCH 0/2] staging:kpc2000:Fix integer as null pointer warning
Date:   Fri, 28 Jun 2019 22:57:22 +0530
Message-Id: <20190628172724.2689-1-harshjain32@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fixes sparse warning in kpc2000 driver.

Harsh Jain (2):
  staging:kpc2000:Fix symbol not declared warning
  staging:kpc2000:Fix integer as null pointer warning

 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.17.1

