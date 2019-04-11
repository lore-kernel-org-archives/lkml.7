Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7DBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A80217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYtmQxHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDKDyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:54:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54700 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKDyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:54:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so4778353wml.4;
        Wed, 10 Apr 2019 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Z91ixljCpwssb/9kTZtnCZqne0XLiVRXDj2DxnE/CA=;
        b=RYtmQxHzkdNJTKDZ6BIM5SBlKzSiC8auWfjYHGLeql6SAvE+dA0yU14zI6eFvu0lET
         Sh1sC7wSjyh+leGGQLGtkjFrZAGYZS5hJ9mHpJkvea5ri1KKp5pEZgP/3vzCG/zQOjNF
         hcMVjfaB+NGbCJyLlYO+1WyElshyurzPJUoSZM6/D1Xlpc6EmkMYT9cDB0wA0Fl3L0K2
         rYP/YwziW24uyWmtV/Uhk8DOUgV9p/yQF5cSRcAwdYNGt1fgPUHL7ulJtiQBwKVuTEHN
         +lHFtoJRZIMVKhSvt8K4Cja7HS6cYqFpI8bRkVCEwxaxTlRePZEnXBtWk+I4yYsNLyYo
         AndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Z91ixljCpwssb/9kTZtnCZqne0XLiVRXDj2DxnE/CA=;
        b=Wgh4U5jD0ziQWDMXadOzKnmq8PEZuqVWdq52bZPUWiZVQHHHw8BUkIZEe8GT0pBbYr
         L5FFJu5lCYRlhypvR9SPWgf0lmFDztzsftqs9glZuLwigSLlcAHEBJlGiUNos03ehlY3
         IIEv7nZ2q/sf8wwnAYa7KTnUDQtjBqxZsSK0Dd70F4M3R+YmOssUSiiB2BTyNHHxdyT+
         APmOW6ZLd2jUG5kJ5mIZsY2Wv5vOU5W9B4WPZMyHZT4nEM6QESQ0n0Twp7O0Uxp5LpYQ
         n2QQgyR54MZh3d08ivzKup9pIFUAY1+ORsewPDrYf4p4biWuq+oCiNHeMajjNmKsNhJC
         ZWSg==
X-Gm-Message-State: APjAAAWGtg+EvVqoTcMoKAdfC4U4D2Q0/sAcGxqUhhQMn9lRHOD56ONT
        y6rygTkZIGmzBbr3ezyyomg=
X-Google-Smtp-Source: APXvYqyCPdGIEbZ2W5kUs+6ZO0p9l4h2SBwf2wdxN0RJhwr8XNiwuxPfPOXBzlRpzZMhqC34hGm7Xg==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr4911807wmg.114.1554954855949;
        Wed, 10 Apr 2019 20:54:15 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da5:5700:805e:d3ab:f95:5de])
        by smtp.gmail.com with ESMTPSA id f1sm3125591wml.28.2019.04.10.20.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 20:54:14 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Krystian Radlak <kradlak@exida.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] fs: drop unused fput_atomic definition
Date:   Thu, 11 Apr 2019 05:53:52 +0200
Message-Id: <20190411035352.19407-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d7065da03822 ("get rid of the magic around f_count in aio") added
fput_atomic to include/linux/fs.h, motivated by its use in __aio_put_req()
in fs/aio.c.

Later, commit 3ffa3c0e3f6e ("aio: now fput() is OK from interrupt context;
get rid of manual delayed __fput()") removed the only use of fput_atomic
in __aio_put_req(), but did not remove the since then unused fput_atomic
definition in include/linux/fs.h.

We curate this now and finally remove the unused definition.

This issue was identified during a code review due to a coccinelle warning
from the atomic_as_refcounter.cocci rule pointing to the use of atomic_t
in fput_atomic.

Suggested-by: Krystian Radlak <kradlak@exida.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1:
  - sent on 2018-01-12, got no response
    https://lore.kernel.org/lkml/20190112055430.5860-1-lukas.bulwahn@gmail.com/

v1 resend:
  - rebased to v5.1-rc4

  - added Jens to recipient list as he touched the place lately closeby
    in commit 091141a42e15 ("fs: add fget_many() and fput_many()")

  - compile-tested with defconfig on v5.1-rc4 and next-20190410


 include/linux/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e7679089..79b2f43b945d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -969,7 +969,6 @@ static inline struct file *get_file(struct file *f)
 #define get_file_rcu_many(x, cnt)	\
 	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
 #define get_file_rcu(x) get_file_rcu_many((x), 1)
-#define fput_atomic(x)	atomic_long_add_unless(&(x)->f_count, -1, 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
-- 
2.17.1

