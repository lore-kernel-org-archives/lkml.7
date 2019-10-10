Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F50C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17EC20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiXrensv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfJJVDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:03:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35255 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfJJVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:03:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so8144186wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVd82TsNic1iRgEn8OK8OU1sOyACvsv7jo4EHLH2mCs=;
        b=WiXrensvozMU62UNWhoOYLW52zJXqI1OYiqh8V01JGAv1a6oknHHePtELmNgqP6iCu
         WKTN5d4J2DYyZWZ/eGigsTFHvVxnGjmRocZ0wtAo1kKKbneQ3LrI5G/DqcYGN77oWJiB
         K6ImuKOomH1y92sDPpIIip8bqZ6f4dEuw5Riy9LF53p8m8/3nbGy1oJCalGeD4NiTlJp
         4GXzD7rACMfl5cdD+YRWUb5HAylhF702Oq2TCgq8fl5PAkicV/58Ee3K9sf3qW6mS0EG
         v1X4820ear5WIeJR5zwHPJnAnQGnymX+QkVtkgwdIQo1HUVu/ICvIoaeLdV1dVQ1O6Sn
         vjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVd82TsNic1iRgEn8OK8OU1sOyACvsv7jo4EHLH2mCs=;
        b=aPulJVW/WyS08NUilwE+v5iOy27CqJqh6bxVX/3Pt/S0UJPyD1lnOzAtphe6rjZH3R
         EQIqlb7mv/5gpmUPAsYcaAr8Xxs2Zp15PnbbXSPYXdDgOeaVd6+ii9Mqc24ObISdgiHW
         85nQFK1f68j6yur01NvTM92iLoM+Du12k2BYQThNaRjZIE5CYoYMP3g3oXxxts8c+K4t
         leOHRJ5t1MZaN/y6gVCJr8iCZdtomKWJIdcfnB1+RUbs6ehlJTaDU5PiC8LxyYjfaORz
         kmRi0+aMz2I/iIKE1B2dRYYLt1VHSnDJReXWJZBLP3LzoL4FJbSKI4kNaHjPGWhfcic0
         AgWw==
X-Gm-Message-State: APjAAAVHhS5NV/HcoojqDpYtB9CgvXVLbnV3GmOKep6BxgXaXEvb5eJm
        je95CLZU7fR05EfUNRXcFA==
X-Google-Smtp-Source: APXvYqyELzmlq1D7QctfkYndY9W3xD4JlablG4X5QY1+jlswY+mMMMKJBeTV8rao/r6u/P3OOb2xlw==
X-Received: by 2002:a7b:c187:: with SMTP id y7mr402036wmi.154.1570741430234;
        Thu, 10 Oct 2019 14:03:50 -0700 (PDT)
Received: from ninjahub.org.net ([94.119.64.0])
        by smtp.googlemail.com with ESMTPSA id w125sm14908956wmg.32.2019.10.10.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:03:49 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH v1 0/5] checkpatch warnings cleanup
Date:   Thu, 10 Oct 2019 22:02:51 +0100
Message-Id: <20191010210256.22522-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up multiple warnings reported by checkpatch tool. These are a resend
in the order they were patched.

Jules Irenge (5):
  staging: qlge: correct a misspelled word
  staging: qlge: fix "alignment should match open parenthesis" checks
  staging: qlge: Fix multiple assignments warning by replacing integer
    variables to bool
  staging: qlge: add space to fix check warning
  staging: qlge: fix comparison to NULL warning

 drivers/staging/qlge/qlge_dbg.c | 209 ++++++++++++++++----------------
 1 file changed, 104 insertions(+), 105 deletions(-)

-- 
2.21.0

