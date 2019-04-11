Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D82CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAC12133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuMazK2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKLxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:53:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35799 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:53:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so4488782lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mp2VBxj9q9/0wQU6kiJT1FxK/7BMos84WEgU9Np1Q2E=;
        b=KuMazK2+TXQSccaEbvobd33tXLMTeXas2Hzp8hRaHtWqGo6EPIEK9bhV8hcbohZFKW
         WaUg2CVehmWqVrOQPEV7R9rVKTW/JppzL0XwDiiMGFJKtzF1oZIJBNPtYobA1MyNcDak
         6RUwQfFkDTj7zJTI59dPWcSHTvKAl96ATruQC7u5kq1tOxz7wQ6xQ/Z6nABc01Lc85Ae
         2ZoicSGvj9k9ufBcmUjo39iXtIaouRECDrUfthyl3CGe8u8+aRald8rRWdueMm7RlI4I
         PPQqXacJHL3OnfRCMPug9VIhypOE6XHvYdWAgkFmm+XsEcgZUIt19zbsR0OQKMP3zRWz
         s+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mp2VBxj9q9/0wQU6kiJT1FxK/7BMos84WEgU9Np1Q2E=;
        b=lQGkKfiaFti51Uq6uUrTDmXxaZjIJbrzTCmPz6qosZAkmbTUN1RHtIveDdqf2QWYd6
         shkXbdnzfoxS8VYt5JRVStKgt/MPCD7Pgbw6QZh7QJznqmhiQPmfa5ZIaF4LTIIzdQzz
         IJ2UP4r3b3LcWlvwKBc/nCm+tmho5wLm/o1FN5JUDtkYOu3BDkrwSHZLsvnBcmUXvjrr
         Z3tEQsIp+js/5gOs959IRBYjbjOxEYz0zxg/08soN4zCgCVVFuipgKa2ga0joRBH1o2M
         FoZyZlzIsN0j6h9pEaiAW1TSWqHMitmM+ZgcEhxFArEL58Ej/1VVP3DBLzIbQ6U9SLK3
         AXuw==
X-Gm-Message-State: APjAAAUR6evo+PvjESihRXuOg6j3VvcHO11QHxhOW0jmbwbhuUnv19ZJ
        +LQmdccYMa5t6LkXkIIAxZs=
X-Google-Smtp-Source: APXvYqzkCGB/RdKEcFDFM9/3EFZr7ab8y764NQWexh8jZfxoR2fwOo0AqfP95Y7Q5ap7bmyCit2wsQ==
X-Received: by 2002:ac2:4192:: with SMTP id z18mr25384235lfh.96.1554983590357;
        Thu, 11 Apr 2019 04:53:10 -0700 (PDT)
Received: from rd-oc.homerouter.cpe (m90-139-33-123.cust.tele2.lv. [90.139.33.123])
        by smtp.gmail.com with ESMTPSA id k10sm7738273ljh.86.2019.04.11.04.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:53:09 -0700 (PDT)
From:   Reinis Danne <rei4dan@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Reinis Danne <rei4dan@gmail.com>
Subject: [PATCH] tty: vt: keyboard: Allow Unicode compose base char
Date:   Thu, 11 Apr 2019 14:50:54 +0300
Message-Id: <20190411115054.26173-1-rei4dan@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass Unicode character to k_unicode handler function to honor possible
accent_table definition.

With introduction of KDSKBDIACRUC ioctl, it has been possible to set
compose characters (diacr, base and result) to any Unicode character
(below 0xf000 code point) as defined in struct kbdiacruc.

But it does not work with characters beyond Latin-1 as base, because
they are printed early and not passed to any of the handler functions,
thus breaking compose and dead keys.

It affects keyboard layouts defining such characters on level 1 and
relying on dead keys to access level 3 (e.g., lv-modern with some
modifications for extra characters on level 3 for ē, ā and ī keys).

Signed-off-by: Reinis Danne <rei4dan@gmail.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 88312c6c92cc..8cf83e9f5a8c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1449,7 +1449,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
 			if (down && !raw_mode)
-				to_utf8(vc, keysym);
+				k_unicode(vc, keysym, !down);
 		return;
 	}
 
-- 
2.21.0

