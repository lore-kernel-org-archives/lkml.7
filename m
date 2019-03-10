Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A1AC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909D1207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJqCBFHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfCJUDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:03:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfCJUDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:03:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id p8so1209652wrq.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zbMhExhcQYCOyIfAYk0sSo4FJ/ZfISUCR/GKSvOcuA0=;
        b=DJqCBFHq1Z/2wpyTFMWdNEeVhm9QIBqFLuM98VctOaaNcOZ1C13s3/1J5IN+lWqs/x
         jV3tygdNoTupLVYBWZG1r7PFgvzag+Q4Zce8pg2q6QsjOKAkvi4RocDtirXoUYPCJecf
         M7SStV/ewhYudbmw5QxxcYrV0zVHPULcce52VSz8kDfR8XhduyiROmVA0mRK0gjukyLk
         3lJvA3aWEWQLrVHl3yQ2ASzwKeZJF4IgPXhLsVZhkQHsvbwhPWDnVDh5P9Vb9ecDdK/Q
         EQ89tFuARFukEDRnMy+B7/WnmIWY0OA55sTR6gHjNjqW7XhwXRHgWqg7ZHdGoYhfKG/H
         Lpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zbMhExhcQYCOyIfAYk0sSo4FJ/ZfISUCR/GKSvOcuA0=;
        b=mXqvXvhBCy7SYWPv2kL6DkCgwF+1TndnnUvDfBcWBlKiIBwvM2t3TFRX7ejANw0+wD
         VL7rv8BJpC8sGJxW0rhBZJpJH7dHtq7U8WYBQxEDWT6zSjhdZbc4qWdlZzof3J/12fUv
         ZKxhPMFBhE+be88hcSd9pZNlSI5PnHC89n60LQWmx43YuQGxdJkTxLtSGrOcY/d78/3X
         2V17YhWZZmNdi+zsqdcbS5AXTWyoO0xsjiMe5StkjOoqB2ovPyPsixH2H6zc8e7x9Lj5
         +ntl9aLWYvZk37vP0mAUpXvP8irYYjYx1B2YYHf4BfaS4ETo802DftOmdece2FNdSj0n
         9OpA==
X-Gm-Message-State: APjAAAWrkWJkkYpgzna2JiEn4EicG5oIKp9uugiU4CJa+0gA0/9R4i09
        +Z5LYS7Sohq9X0t0t8SaHDI=
X-Google-Smtp-Source: APXvYqwgEuPpARCbJr6BnqO5Ic8J3u9AM2SW5sXtYNirSn5GdLQ1Y1ACeTZzvesuDnxrTuus/2fKVg==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr17866239wrn.13.1552248190003;
        Sun, 10 Mar 2019 13:03:10 -0700 (PDT)
Received: from darwi-home-pc (ip-109-42-1-116.web.vodafone.de. [109.42.1.116])
        by smtp.gmail.com with ESMTPSA id f68sm41533105wmg.5.2019.03.10.13.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 13:03:08 -0700 (PDT)
Date:   Sun, 10 Mar 2019 21:03:02 +0100
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] printk: kmsg_dump: Mark registered flag as private
Message-ID: <20190310200302.GA11096@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'registered' flag is internally used by kmsg_dump_register()
and kmsg_dump_unregister() to track multiple registrations of the
same dumper.

It's protected by printk's internal dump_list_lock, and must thus
be accessed only from there. Mark it as private.

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
 include/linux/kmsg_dump.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
index 2e7a1e032c71..7c08cb58259a 100644
--- a/include/linux/kmsg_dump.h
+++ b/include/linux/kmsg_dump.h
@@ -36,7 +36,7 @@ enum kmsg_dump_reason {
  * @dump:	Call into dumping code which will retrieve the data with
  * 		through the record iterator
  * @max_reason:	filter for highest reason number that should be dumped
- * @registered:	Flag that specifies if this is already registered
+ * @registered:	Flag that specifies if this is already registered (private)
  */
 struct kmsg_dumper {
 	struct list_head list;
--
2.21.0
