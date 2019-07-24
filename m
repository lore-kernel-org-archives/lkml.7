Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE6920449
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpmUwRuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfGXCGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:06:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45934 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfGXCGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:06:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so20330081pgp.12;
        Tue, 23 Jul 2019 19:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUEsu1aJQ43M1dFiRUsIH0xR8QMlq0eMWSMkix2nG/s=;
        b=SpmUwRuIct58AB5vD4iMiE7f2Wp/E4iU/jQyuqwEp/xyS9ElMer8ikqdVjtrNj3EkT
         Z42ODOk1Yi6RlKG6jAwgXhbFKJawYA6q1E2S5mKgw37wmAJ0dbIOR/7Ng5qdm6DqkK3p
         HkACORz9DtEO0gLLCRp1IhH1j4jhb0lfpavqRe5LVPc7fMLq1BxTMGMwkHh/0JN4zpBE
         6RgXGsITgVOh8i1Vz3e5ucjLC9x6SeWBoWq9ZrUThpLGAtlh52CwWYJdgCXPUWW5BCPb
         0VhQPINV/CrfaiEP/V8C2z+Vuz7kYTzXGYtIYijCf0VnuoqEtZBJmf39NE3/tVAcZS36
         gTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUEsu1aJQ43M1dFiRUsIH0xR8QMlq0eMWSMkix2nG/s=;
        b=qXoh1otb4BlWYQ1SUNmO9p8zBC+0DGuGgenlgna8iyeXhuXiyMvpITdBY5yXPyGfV3
         f4nTREu2Miq6rIi03aFI/2aZSZeRlwvQ7E0cJHsykPjyScSUZT7s8nA0LJg60dfe6lLk
         GviYKlDZBk12ylzVZeAJPqh6qKBM07DEgOR52U9n4ma71TaaIT24Yt4NL9e6jMQ4DfcX
         HhC8CsCNLwsZWDdbAIZnlc9Lcc3AG7tlLISsJJvlerLeibUvV6BbasYMJUyjv83+8Wy/
         7VJcNX2VqzSf74QwOncmJv0hwMsVkdEu3S3+jinT6IQij1S9+Ownwl8IqfaTtwxGjzEk
         xv3A==
X-Gm-Message-State: APjAAAVn2SXA8zlxrQ5Me3oMlUrT+s2p58QGecwPsGkSIcDwmdmjcrNR
        8rL7uy5VzxZWptcF2jX5JiA=
X-Google-Smtp-Source: APXvYqyCAo/u0tdEDjAYadfSuXMI69XqXtjzYOL2ostY7UBdmnKxDtc1QPd76Njk33ivnhowdAXeYg==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr8975675pfd.207.1563933979631;
        Tue, 23 Jul 2019 19:06:19 -0700 (PDT)
Received: from debian.net.fpt ([2405:4800:58f7:33d1:2651:be77:cf4e:952])
        by smtp.gmail.com with ESMTPSA id 65sm48163919pgf.30.2019.07.23.19.06.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 19:06:18 -0700 (PDT)
From:   Phong Tran <tranmanphong@gmail.com>
To:     syzbot+fd2bd7df88c606eea4ef@syzkaller.appspotmail.com
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        louis@kragniz.eu, syzkaller-bugs@googlegroups.com,
        benquike@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] usb: wusbcore: fix unbalanced get/put cluster_id
Date:   Wed, 24 Jul 2019 09:06:01 +0700
Message-Id: <20190724020601.15257-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <000000000000d48965058e589a94@google.com>
References: <000000000000d48965058e589a94@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzboot reported that
https://syzkaller.appspot.com/bug?extid=fd2bd7df88c606eea4ef

There is not consitency parameter in cluste_id_get/put calling.
In case of getting the id with result is failure, the wusbhc->cluster_id
will not be updated and this can not be used for wusb_cluster_id_put().

Tested report
https://groups.google.com/d/msg/syzkaller-bugs/0znZopp3-9k/oxOrhLkLEgAJ

Reported-by: syzbot+fd2bd7df88c606eea4ef@syzkaller.appspotmail.com

Reproduce and gdb got the details:

139		addr = wusb_cluster_id_get();
(gdb) n
140		if (addr == 0)
(gdb) print addr
$1 = 254 '\376'
(gdb) n
142		result = __hwahc_set_cluster_id(hwahc, addr);
(gdb) print result
$2 = -71
(gdb) break wusb_cluster_id_put
Breakpoint 3 at 0xffffffff836e3f20: file drivers/usb/wusbcore/wusbhc.c, line 384.
(gdb) s
Thread 2 hit Breakpoint 3, wusb_cluster_id_put (id=0 '\000') at drivers/usb/wusbcore/wusbhc.c:384
384		id = 0xff - id;
(gdb) n
385		BUG_ON(id >= CLUSTER_IDS);
(gdb) print id
$3 = 255 '\377'

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/usb/host/hwa-hc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/hwa-hc.c b/drivers/usb/host/hwa-hc.c
index 09a8ebd95588..6968b9f2b76b 100644
--- a/drivers/usb/host/hwa-hc.c
+++ b/drivers/usb/host/hwa-hc.c
@@ -159,7 +159,7 @@ static int hwahc_op_start(struct usb_hcd *usb_hcd)
 	return result;
 
 error_set_cluster_id:
-	wusb_cluster_id_put(wusbhc->cluster_id);
+	wusb_cluster_id_put(addr);
 error_cluster_id_get:
 	goto out;
 
-- 
2.20.1

