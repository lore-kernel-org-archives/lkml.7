Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AE9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437E720856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4etqiVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfJ3TFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:05:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44212 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3TFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:05:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id b10so2947168qto.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIfcfwZSfz3iFqYkkCsQDsEpxbNUtoI0tD1NbKhoPSw=;
        b=U4etqiVAXYGLuwSnkCnKmAeDO4XYNCdR0mgSrR8JvZeQNyIwor8I4gBMU2o1F2uVs8
         B2XmYPHf1WlDyU7sX5GBdYgynpwJr++CmY8p5jKmzWxmARa539d3tShPdv84iDmv+3BT
         x2cdXvA6Pr703pxNBkGkNNHG3bWzelCxU1ITY/wVJxzsJQqLKs+SeFQs99gx1HcMZ9E7
         Eqi0jmhJW2OP++aJy/q+58eqLaNXg9mgYMQgdzXAnehZUFW6tO0fE7kIpuFo/vFgkg/i
         pjoBElmuqvxxxCNVvJJ4cfYqOOccvKSoHuWX4Dk6IaNwf9mqL97os01S06dWIfFdetuW
         7PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIfcfwZSfz3iFqYkkCsQDsEpxbNUtoI0tD1NbKhoPSw=;
        b=QvvSlVjTuy1W87HoVmikgztMmYDWi4HpBYaZeeUcDjZMog0nzcmcEKSbXr9k7sBaX1
         HUBKXwfZhu1anVO8F4BkEa9dmxUSIySfdXvEVJtqmu6dxrNKMOb/BHMgLP8fsN/prc4I
         ICfgPyGbwFmzJ4rfVh0va5JjOH/M2J63ESM2ZmuKNn0/oJ7ixqJne5Ow6BJWyUUDFt1v
         VD56GnmTjMbA62x21vh/TYDOu8VOuG4uyFDD9OElFjpN4L/ee7GcOMrxMvbXjoDOWVPS
         CO+tozPPsiFNJQyqA6GoaJl6t1/EFtjc2+CXBK+bGiwV35ArtI4t09JeTNpIlixWyMg+
         Y3LA==
X-Gm-Message-State: APjAAAV7S8RstAXlJetCYKG8peT3U5DMHfQpqkvHFRAkIquyFmHyUG/C
        faJI9zCnFqV8NJuIq2Ye22A=
X-Google-Smtp-Source: APXvYqxkMw6RX4XNwRXX+HeXx4n622VVKCx9NLt8ZhgLlog4sMtxfMlRg7p2s4xvzh8Z15AlC6n7fw==
X-Received: by 2002:ac8:4a8f:: with SMTP id l15mr1734494qtq.220.1572462322849;
        Wed, 30 Oct 2019 12:05:22 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id o28sm690544qtk.4.2019.10.30.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:05:22 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, kim.jamie.bradley@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 0/3] staging: rts5208: Eliminate the use of Camel Case
Date:   Wed, 30 Oct 2019 16:05:11 -0300
Message-Id: <20191030190514.10011-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in tree rts5208

Changes in v3:
- Change the subject line of commits to make it more clear and informative

Changes in v2:
- Place the changes on variable's names in the use and definition in the
same commit

I compile the kernel after each commit of the series to make sure it
doesn't break the compilation.

Gabriela Bittencourt (3):
  staging: rts5208: Eliminate the use of Camel Case in files ms.{h,c}
  staging: rts5208: Eliminate the use of Camel Case in files xd.{h,c}
  staging: rts5208: Eliminate the use of Camel Case in file sd.h

 drivers/staging/rts5208/ms.c | 86 ++++++++++++++++++------------------
 drivers/staging/rts5208/ms.h | 70 ++++++++++++++---------------
 drivers/staging/rts5208/sd.h |  2 +-
 drivers/staging/rts5208/xd.c |  8 ++--
 drivers/staging/rts5208/xd.h |  6 +--
 5 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.20.1

