Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC3FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1320659
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLdo6Y5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394691AbfJPUNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:13:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39211 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfJPUNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:13:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so29518267wrj.6;
        Wed, 16 Oct 2019 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vpbsFRknebeQQJhtQXsaOo/WPV9F6xu2vA5grgfriE=;
        b=mLdo6Y5fRuE+hfNBJETHyPCQqcJOkZFUJA0VqIo/MMyLW3uWA9maRYwnm4YWSLNJbH
         gMnrOkN2+DtDmzzLWMS/0qPJeZZE8Y1XrSAQgefe+ABYTVLK64H5ml4i6kg+VK9aOocI
         u7oWHPQQQtGdBh3COfH5nt5CgJktOc06Gw3Qk3G5s0VGlxm0ZIoqO1e6pbfRWqfsmIyf
         5VVXgotYm7IikzJDCELJkrXJMm+0/gl4PZar1avNIgWt6KrarUjeFG8+txtS9uSykI2C
         pLgOplXrrvHcQ3V1mEO2XAzWtn2Du8Xb3a0SpGLNV+wN1ZH0iV9N0vo9z/o7B09zktph
         TpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vpbsFRknebeQQJhtQXsaOo/WPV9F6xu2vA5grgfriE=;
        b=SkZwJO7JJVAOKz1knv232t5RUO2cSKxYm1RteqnMGbuQqRQUcX2u/oxt73iCFviG+/
         lgQ5BroVAdyq5HERhvaCe738bL9XSX9Fw5jPZPpkF8MeeAqKdkmIMr4J6v/R2v3Zk7FS
         V0hGt2kibEwVwUd5pTBUal5ZRNQ48mkzE4s4yGN3pqB0rpVWXBYZSZ8jkhgOXmYavd+H
         hLZ8sAXh1w4wqbXujxnuAyozVK0RyCAGXT+Vvgrr88akUcXUNiJqZLagsvw5ksNBwGGt
         l5LrFIXm0u73nS/tj9zCoAZOYC1mJf2N0SIpO7YDQGv+zn8pWE3/X0MxisNsfIPUbpdL
         1NjA==
X-Gm-Message-State: APjAAAVyCGcGr+EhOBxVIzIKj4Xl5YzV26vF07IZ+YRrYh0dpBcq+6mv
        5fiOPL3XWxW5D93/KpwAuc730gCJD6Q=
X-Google-Smtp-Source: APXvYqyKVVYeQaw58do9LQEj55YH9eWaBNJqYSK7+26pSe5dBkpw4ywu4pnAcpmwUdZ5N5kR87TWxw==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr248252wrr.171.1571256830788;
        Wed, 16 Oct 2019 13:13:50 -0700 (PDT)
Received: from localhost.localdomain (151.red-88-2-41.staticip.rima-tde.net. [88.2.41.151])
        by smtp.gmail.com with ESMTPSA id 13sm1107wmj.29.2019.10.16.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:13:49 -0700 (PDT)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Cc:     Albert Vaca Cintora <albertvaka@gmail.com>
Subject: [PATCH] Updated iostats docs
Date:   Wed, 16 Oct 2019 22:13:37 +0200
Message-Id: <20191016201337.88554-1-albertvaka@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous docs mentioned 11 unsigned long fields, when the reality is that
we have 15 fields with a mix of unsigned long and unsigned int.

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
---
 Documentation/admin-guide/iostats.rst | 47 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 5d63b18bd6d1..321aae8d7e10 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -46,78 +46,79 @@ each snapshot of your disk statistics.
 In 2.4, the statistics fields are those after the device name. In
 the above example, the first field of statistics would be 446216.
 By contrast, in 2.6+ if you look at ``/sys/block/hda/stat``, you'll
-find just the eleven fields, beginning with 446216.  If you look at
-``/proc/diskstats``, the eleven fields will be preceded by the major and
+find just the 15 fields, beginning with 446216.  If you look at
+``/proc/diskstats``, the 15 fields will be preceded by the major and
 minor device numbers, and device name.  Each of these formats provides
-eleven fields of statistics, each meaning exactly the same things.
+15 fields of statistics, each meaning exactly the same things.
 All fields except field 9 are cumulative since boot.  Field 9 should
 go to zero as I/Os complete; all others only increase (unless they
-overflow and wrap).  Yes, these are (32-bit or 64-bit) unsigned long
-(native word size) numbers, and on a very busy or long-lived system they
-may wrap. Applications should be prepared to deal with that; unless
-your observations are measured in large numbers of minutes or hours,
-they should not wrap twice before you notice them.
+overflow and wrap). Wrapping might eventually occur on a very busy
+or long-lived system; so applications should be prepared to deal with
+it. Regarding wrapping, the types of the fields are either unsigned
+int (32 bit) or unsigned long (32-bit or 64-bit, depending on your
+machine) as noted per-field below. Unless your observations are very
+spread in time, these fields should not wrap twice before you notice it.
 
 Each set of stats only applies to the indicated device; if you want
 system-wide stats you'll have to find all the devices and sum them all up.
 
-Field  1 -- # of reads completed
+Field  1 -- # of reads completed (unsigned long)
     This is the total number of reads completed successfully.
 
-Field  2 -- # of reads merged, field 6 -- # of writes merged
+Field  2 -- # of reads merged, field 6 -- # of writes merged (unsigned long)
     Reads and writes which are adjacent to each other may be merged for
     efficiency.  Thus two 4K reads may become one 8K read before it is
     ultimately handed to the disk, and so it will be counted (and queued)
     as only one I/O.  This field lets you know how often this was done.
 
-Field  3 -- # of sectors read
+Field  3 -- # of sectors read (unsigned long)
     This is the total number of sectors read successfully.
 
-Field  4 -- # of milliseconds spent reading
+Field  4 -- # of milliseconds spent reading (unsigned int)
     This is the total number of milliseconds spent by all reads (as
     measured from __make_request() to end_that_request_last()).
 
-Field  5 -- # of writes completed
+Field  5 -- # of writes completed (unsigned long)
     This is the total number of writes completed successfully.
 
-Field  6 -- # of writes merged
+Field  6 -- # of writes merged  (unsigned long)
     See the description of field 2.
 
-Field  7 -- # of sectors written
+Field  7 -- # of sectors written (unsigned long)
     This is the total number of sectors written successfully.
 
-Field  8 -- # of milliseconds spent writing
+Field  8 -- # of milliseconds spent writing (unsigned int)
     This is the total number of milliseconds spent by all writes (as
     measured from __make_request() to end_that_request_last()).
 
-Field  9 -- # of I/Os currently in progress
+Field  9 -- # of I/Os currently in progress (unsigned int)
     The only field that should go to zero. Incremented as requests are
     given to appropriate struct request_queue and decremented as they finish.
 
-Field 10 -- # of milliseconds spent doing I/Os
+Field 10 -- # of milliseconds spent doing I/Os (unsigned int)
     This field increases so long as field 9 is nonzero.
 
     Since 5.0 this field counts jiffies when at least one request was
     started or completed. If request runs more than 2 jiffies then some
     I/O time will not be accounted unless there are other requests.
 
-Field 11 -- weighted # of milliseconds spent doing I/Os
+Field 11 -- weighted # of milliseconds spent doing I/Os (unsigned int)
     This field is incremented at each I/O start, I/O completion, I/O
     merge, or read of these stats by the number of I/Os in progress
     (field 9) times the number of milliseconds spent doing I/O since the
     last update of this field.  This can provide an easy measure of both
     I/O completion time and the backlog that may be accumulating.
 
-Field 12 -- # of discards completed
+Field 12 -- # of discards completed (unsigned long)
     This is the total number of discards completed successfully.
 
-Field 13 -- # of discards merged
+Field 13 -- # of discards merged (unsigned long)
     See the description of field 2
 
-Field 14 -- # of sectors discarded
+Field 14 -- # of sectors discarded (unsigned long)
     This is the total number of sectors discarded successfully.
 
-Field 15 -- # of milliseconds spent discarding
+Field 15 -- # of milliseconds spent discarding (unsigned int)
     This is the total number of milliseconds spent by all discards (as
     measured from __make_request() to end_that_request_last()).
 
-- 
2.23.0

