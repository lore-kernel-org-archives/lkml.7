Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0AFC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBFA217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETEUNChR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfF1JQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33160 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfF1JQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so2673788pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pDlxezJgSj1bzWMAfYvDK//QbrYKsC8u1GusQxqtig=;
        b=ETEUNChR3rA1JeJuT6JgZqCDtHCxW5teYhKcDVryv9tbR3W8R2BozwRvZCnWyunm3r
         8kjtMnC3XnZXldd6gAm3FET+4Mh/urlJE5WzmKrr4Z9UdoqD7tKhqBmZU9Q7Qqu6lrgB
         5HeQYfrrtdLpRLFDVW9f6sMSOzHIAdHRWQdzIKZ7+lPa56UtTH2bP0D9iqkvPdB8OFns
         SqHGJFotoyK2LPS/3eGvj+xdu81mlBS0Km7f+hoNvHFHssgJeWE4sHwvDL1Usk+ds1mm
         2DujtnxJM0G7iB34U5npwvupatCi+TfoO/UcPRj/C2K69GenWAB0IIojQckTIvRo5hcS
         ztwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pDlxezJgSj1bzWMAfYvDK//QbrYKsC8u1GusQxqtig=;
        b=NhKKkkIyYGnPEQUPboPJXgjGZtAiZl6+jjzyg7KngEaqvVbqtfCPg3kVgjxf8feNjt
         QMHXrEWJ4CcL/csaN4X9kcDy16jxmAQOa9x/2qBBBY5poawbNBi/Aep2joIRnrJTubS6
         P3cHKbBdUWCufKXljKb7tBXDbN4LGvNvzLH/vBmABOHLCI95IYr2K1806dPe60y/imM1
         7wtEBncSyfzykDTlGD6TpzNYhjjHeurZwSU6gop4CGtv8LS0cYokwd0Pc2s49c3Dmlax
         Fc+ABfnLGgVzpS3ZazfM1iOFo6ly7MnJS3lgQz1flrlA3/rSjat7vA7UdhBrSfjnnCzC
         RCjw==
X-Gm-Message-State: APjAAAUgyTtLhld4FMjbPS4bYVpyLK4VsNa0eUdOQQgqnLjPgx1N3fGg
        JDhXrUcEp462XBXS1TgxJG0=
X-Google-Smtp-Source: APXvYqz+aqBXHvRGZeME4Q858BnoavKwz1S16hDEIMyRAYxEWhG5nzoNKvxHgNa8q4dhw9YwDQpMkA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr8641263pgr.52.1561713366187;
        Fri, 28 Jun 2019 02:16:06 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:05 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 05/30] locking/lockdep: Add lock chain list_head field in struct lock_list and lock_chain
Date:   Fri, 28 Jun 2019 17:15:03 +0800
Message-Id: <20190628091528.17059-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A direct lock dependency, such as L1 -> L2, may be in many lock chains.
These newly added fields in struct lock_list and lock_chain will be used
to associate lock chains to lock dependencies.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 151d557..3c6fb63 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -191,6 +191,7 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
  */
 struct lock_list {
 	struct list_head		entry;
+	struct list_head		chains;
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	struct lock_trace		trace;
@@ -210,6 +211,7 @@ struct lock_list {
  * @depth:       the number of held locks in this chain
  * @base:        the index in chain_hlocks for this chain
  * @entry:       the collided lock chains in lock_chain hash list
+ * @chain_entry: the link to the next lock_chain in the same dependency
  * @chain_key:   the hash key of this lock_chain
  */
 struct lock_chain {
@@ -219,6 +221,7 @@ struct lock_chain {
 					base	    : 24;
 	/* 4 byte hole */
 	struct hlist_node		entry;
+	struct list_head		chain_entry;
 	u64				chain_key;
 };
 
-- 
1.8.3.1

