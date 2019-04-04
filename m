Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795DBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4506B20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8I/KkTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfDDIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35248 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:24 -0400
Received: by mail-yw1-f66.google.com with SMTP id d132so656320ywa.2;
        Thu, 04 Apr 2019 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=cDaTSDZgwH1tEyxeK1FWu9PQ+2EvkmR6IA94ykP8ez8=;
        b=U8I/KkTB7UVhjNfpPCw3GwiL3pdRGT1ZlKaenHOQgoBse9ydTXqf4BFYxJ84DcDype
         qjU1HGL5cllchRxEBNNnraPuOut+jiGfxBd2Oc6bYnkVLDcOb6t5ABicvoNeUGxgLRvg
         9ecZckne18kSHudZvx8pegi7SkdU5GN3hwPjmZndIYVlWdxwFu6ZzsdKwoZx+A/MpZdn
         6jHDVa1SQDZSkAwACFoeuEh0D5di1KeIB7s2y5oqHtjVpt4OoFEenM45tL6NmF7DT+bJ
         W8ezQ8wy18EwLWA6Jvi5PqARmtpViTNj4yjcTPzGcdkd72JOlKfoj63Ik9EWxkQ5hQKD
         FP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=cDaTSDZgwH1tEyxeK1FWu9PQ+2EvkmR6IA94ykP8ez8=;
        b=c/2XkgJwRmNb/zKjsmkVUepE38+AffaaIjCalDL1bQ2LgFMuStUhO9lvYtBHQnJaZW
         G4d62GYC0M1COX0j3GCA31Sdog/I2ZYw4cWOjqN/VCJZSni8thdpmlykU2CdB66yKnqf
         ASK88GF+dYCv7kahxpMBVKefe15k4Chk2W8tzfbFxhldVNZZjnIP28TIj5l1huiMhD5f
         FrfTa/6C9jUjbRlRL8cs8NHv8zIgxtqmFx57lIJ1doO0R4zh/g8vLsCTJt6opW5e0XTk
         s999vl0KMrNfpow7mqGbDJ+AET7BkOmhKj2lPLzO8t4vC5GJzKaADq7x4fQWhIWdNtef
         2oaA==
X-Gm-Message-State: APjAAAV2UO9FD/OlpD6y5/qVZxklVQchwy94PUCmTrapYa67uJhBI5E5
        NQgy+CcN6/Du3I1e+ImFr50=
X-Google-Smtp-Source: APXvYqzo/uVNwd535ausfjPQgjH0/K8IpYbSdqfGpZQIQu6N37B2dvWXGeLN9pQTOI9FgU0mvD4m+w==
X-Received: by 2002:a0d:eb13:: with SMTP id u19mr3459315ywe.110.1554365783343;
        Thu, 04 Apr 2019 01:16:23 -0700 (PDT)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 131sm7049810ywp.20.2019.04.04.01.16.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:16:23 -0700 (PDT)
Date:   Thu, 4 Apr 2019 04:16:21 -0400
From:   Bo YU <tsu.yubo@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, netdev@vger.kernel.org, yhs@fb.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] bpf:sample: fix field 'lock' has incomplete type in hbm.h
Message-ID: <20190404081620.zx5rt2j2rjvdcglt@yubo-2>
Mail-Followup-To: ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, netdev@vger.kernel.org, yhs@fb.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling sample/bpf:

samples/bpf/hbm.h:12:23: error: field ‘lock’ has incomplete type
  struct bpf_spin_lock lock;

Fixes: 187d0738ff35(bpf: Sample HBM BPF program to limit egress bw)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 samples/bpf/hbm.h          | 2 +-
 samples/bpf/hbm_out_kern.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/hbm.h b/samples/bpf/hbm.h
index 518e8147d084..7ce18cb9e365 100644
--- a/samples/bpf/hbm.h
+++ b/samples/bpf/hbm.h
@@ -9,7 +9,7 @@
  * Include file for Host Bandwidth Management (HBM) programs
  */
 struct hbm_vqueue {
-	struct bpf_spin_lock lock;
+	struct bpf_spin_lock *lock;
 	/* 4 byte hole */
 	unsigned long long lasttime;	/* In ns */
 	int credit;			/* In bytes */
diff --git a/samples/bpf/hbm_out_kern.c b/samples/bpf/hbm_out_kern.c
index f806863d0b79..04c4f3d6ab9a 100644
--- a/samples/bpf/hbm_out_kern.c
+++ b/samples/bpf/hbm_out_kern.c
@@ -90,7 +90,7 @@ int _hbm_out_cg(struct __sk_buff *skb)
 	curtime = bpf_ktime_get_ns();

 	// Begin critical section
-	bpf_spin_lock(&qdp->lock);
+	bpf_spin_lock(qdp->lock);
 	credit = qdp->credit;
 	delta = curtime - qdp->lasttime;
 	/* delta < 0 implies that another process with a curtime greater
@@ -105,7 +105,7 @@ int _hbm_out_cg(struct __sk_buff *skb)
 	}
 	credit -= len;
 	qdp->credit = credit;
-	bpf_spin_unlock(&qdp->lock);
+	bpf_spin_unlock(qdp->lock);
 	// End critical section

 	// Check if we should update rate
--
2.11.0

