Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9774ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228F9217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ck/WAJ+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKANLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:11:19 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46854 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbfKANLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:11:18 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 973DB2E0EA4;
        Fri,  1 Nov 2019 16:11:15 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id bPIq8rSMc8-BE0G4dru;
        Fri, 01 Nov 2019 16:11:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572613875; bh=Q0E2K70/ZzPbjsfKmlFmHf7N3dcY8dk+N7BPWk5DjpU=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=ck/WAJ+xm5SSFTrzVoXPjdi1WVSPfeEm2/r37W/EPao5TLAva3rmDsS3zKMvr5DYw
         ZRYH8y6AjAf9PiEAiJu19+u3sKmCZA5sUpNBsnOXDALdprdSCLhoUmKnN+kM1CBi1q
         pSEFNh3qczGcMdD+3cNWHWoL9TJE6gar54eO3gF4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id fAicdg0lZ4-BEUij5XX;
        Fri, 01 Nov 2019 16:11:14 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org,
        Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH] block,bfq: Skip tracing hooks if possible
Date:   Fri,  1 Nov 2019 13:11:10 +0000
Message-Id: <20191101131110.18356-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases blk_tracing is not active, but  bfq_log_bfqq macro
generate pid_str unconditionally, which result in significant overhead.

## Test
modprobe null_blk
echo bfq > /sys/block/nullb0/queue/scheduler
fio --name=t --ioengine=libaio --direct=1 --filename=/dev/nullb0 \
   --runtime=30 --time_based=1 --rw=write --iodepth=128 --bs=4k

# Results
|        | baseline | w/ patch | gain |
| iops   | 113.19K  | 126.42K  | +11% |

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 block/bfq-iosched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 5d1a519..b320fe9 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -1062,6 +1062,8 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
 	char pid_str[MAX_PID_STR_LENGTH];	\
+	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
+		break;							\
 	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
 	blk_add_cgroup_trace_msg((bfqd)->queue,				\
 			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		\
@@ -1078,6 +1080,8 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
 	char pid_str[MAX_PID_STR_LENGTH];	\
+	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
+		break;							\
 	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
 	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-- 
2.7.4

