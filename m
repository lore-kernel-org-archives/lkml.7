Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5900C46460
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FB4207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 02:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFGCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 22:34:09 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54768 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726305AbfFGCeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 22:34:09 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x572Y8QC016479
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:34:08 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x572Y3L0032413
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 22:34:08 -0400
Received: by mail-qk1-f200.google.com with SMTP id n126so380777qkc.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 19:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ZcoikDKkI7PPegWQ+6ZD26nDeLnWiH7ygdp1DcZcSDQ=;
        b=sY64CQtoNzFY1rU9THyriWvHBspNeM9Rn30EWvlPGQreAvKwzS0p6Nt+2AN5EB6sn2
         +dHXDFjqtukqYmcPKR1LDDjHS7b0G9Pxxna3v7vpGH8nz+pmz1dxi1Q+UjnRMlLIQKg+
         Ro4wJmQIEoIGQ+7c6sDWK9JbgfDjxHaciAa8DjcH1AUhk7q6ITPDJ0lON4sDo0lOwv7h
         O69HCMrLW9R4119KaEv4tsNLCsahytCRNl9D8c2FT4KqTpS63v4Wbga+zsque9Ae9Xxh
         k0CUb6PmVESxfww1rL7m4FPEHoRQmqUa29WLHLWLD8rNQpftU752+PPED9dCjvlNZgSD
         02rw==
X-Gm-Message-State: APjAAAUuk7ZQIwMQh6APQ0wZSQpy8CwpA+q1kjNAagGx9iRgGb3H14oS
        eqBrWzQEPH/UPKUC35qscecLsmhlFjuP6JMEg6SAdgULP0m0thm0C114+tVXY/f6Qf31g6MBNOY
        BmLzGfzTNFvpgi2JW3fbLgm73rgjKGGr8zTY=
X-Received: by 2002:a37:b607:: with SMTP id g7mr22692209qkf.257.1559874843108;
        Thu, 06 Jun 2019 19:34:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztjNXbN0PknY30mS4Cf3VjkBmChOemWcioN+jA0DTDb+VS/n4xW7sdOascOmxohJ3Ngiy3Bg==
X-Received: by 2002:a37:b607:: with SMTP id g7mr22692194qkf.257.1559874842912;
        Thu, 06 Jun 2019 19:34:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::936])
        by smtp.gmail.com with ESMTPSA id c7sm345534qth.53.2019.06.06.19.34.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 19:34:01 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/handle.c - fix up kerneldoc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 06 Jun 2019 22:34:00 -0400
Message-ID: <29300.1559874840@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1, gcc complains about kerneldoc issues:

  CC      fs/fhandle.o
fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'

Fix typo in the kerneldoc

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 0ee727485615..01263ffbc4c0 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -246,7 +246,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
  * sys_open_by_handle_at: Open the file handle
  * @mountdirfd: directory file descriptor
  * @handle: file handle to be opened
- * @flag: open flags.
+ * @flags: open flags.
  *
  * @mountdirfd indicate the directory file descriptor
  * of the mount point. file handle is decoded relative


