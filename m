Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F36C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2AF2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqyqbxRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbfJJNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:16:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40044 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfJJNP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:15:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so3651724pgl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5R0PLgqaQt/LlyIHo4fMN0uBOe621ivStxyy9BRN30w=;
        b=kqyqbxRRk40GY6BtvCZiSHUTKQ6DamrPeD9RxeaGQVsSyTGqqUJw/1uIK2k7B6rYnU
         LFHnCczr2Ne15BuewzuUndNP5PkpnzsyX1qJGHBst1DrhfrYa/I0Z22Ry5RYhn0JAoev
         YZ8KbYsSQUQYB42d2JsZ+bRhYUGpL3SCsnA07nZNiEZH6PFsyEaYCJjHKUl5nlRBHtG7
         DVk5EG43gjztJR677j6qVUY4LwvZUuutwAXXl1MYhJL1FBrMn8p4BJHc5ejtU7I823+H
         TKIA17DlA4nx/uYSNqA0dLkZoZWu2qPeXPDi6z/SeX7dAGp68OxgwoaTLEVxeClublyV
         ac9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5R0PLgqaQt/LlyIHo4fMN0uBOe621ivStxyy9BRN30w=;
        b=BB3av0n370etQ0kkT4fs8tXlSIT++3RP+UAg8Wpsd2mNXgahWLgBKUhtW0uUBRSu2f
         TSJSVvKzuHjcHmG6VIBCoICUcD5lGjJB6F8QsWiA6E2kgUNbyROJPpo8N6yy/noaDTE4
         +VtLyEvjUG2ixSk8BMP4UCe16cKurk4Iu1CXpvwv9F1/9GBLu8jSA3JYX8Ur2ZsJN9Us
         eNjTfYNCyISPwPYmxwu4SMSks7jkHcPqavMAsey3NQ9tgXlHGV18UqNhMvtANWxn2OJ5
         wEn/F2Jft5zZPkYz5f4UTqAZyPAAZq4aeGY2+WmJJemwMwIcd2hW38xoDZISEa1/wNXL
         M/6A==
X-Gm-Message-State: APjAAAUn7xx3MoAyUIx1QiChCbdPQMeCR0hvgb/6qBlweVL/1xTrHg3k
        1rHqthO15pyzzQWzzq9RorPbUsiTjr23jw==
X-Google-Smtp-Source: APXvYqwD7EpaZDerJpsr3Zx2t8DFaiXmyVJfu6eNr2V4XHoPuEij7Cvtmt1GqXfCFQ09S7/+sp6lxw==
X-Received: by 2002:a65:6205:: with SMTP id d5mr11340562pgv.424.1570713358872;
        Thu, 10 Oct 2019 06:15:58 -0700 (PDT)
Received: from wambui.brck.local ([197.254.95.158])
        by smtp.googlemail.com with ESMTPSA id 2sm8707720pfa.43.2019.10.10.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:15:58 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH v3 0/4] staging: rtl8723bs: Style clean-up in rtw_mlme.c
Date:   Thu, 10 Oct 2019 16:15:28 +0300
Message-Id: <cover.1570712632.git.wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses multiple style and formatting issues reported by
checkpatch.pl in drivers/staging/rtl8723bs/core/rtw_mlme.c

PATCH v2 of the series corrects the "patchest" mispelling in the
original cover letter and provides a clearer subject line.

PATCH v3 of the series incorporates newer changes in rtw_mlme.c
on staging-testing.

Wambui Karuga (4):
  staging: rtl8723bs: Remove comparisons to NULL in conditionals
  staging: rtl8723bs: Remove unnecessary braces for single statements
  staging: rtl8723bs: Remove comparisons to booleans in conditionals.
  staging: rtl8723bs: Remove unnecessary blank lines

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 161 +++++++---------------
 1 file changed, 50 insertions(+), 111 deletions(-)

-- 
2.23.0

