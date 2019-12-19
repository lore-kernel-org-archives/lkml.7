Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14343C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEE2222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRDtWvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLSRoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:44:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52488 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:44:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so6333214wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8kDU4q3nQ71eG5/cXl+NS6rCA9dQv2txs+IITzU0If4=;
        b=jmRDtWvvVgbFNZnw1WuYwoy67FErXxvRBi8akkq0XPgujgkV/TX+TakPshJ9wKXpmJ
         Kb0RXQuu2WNXIzFV3EsiM8u1UAvjt1XRdCje/5X8oicLc5xrldVIFqnggVAs30Cxeiw0
         OYRfMNFp8D7MXjNX3LlW/eknNI/sIA1ojduXfoyg+a+g/Ls1iVX2gMNJXE0D/02je9Oc
         hk5Rahd6P8Ldxjwl+wrH2kFeA1k7dtzlPZgdRkp5pMyZCG5PNx5NEOp5lC/OZs77+Gfa
         3NjSyZJNcWN51Ww1rvYelvlT3iF+Q+Bt0fHJyAKCzUDvcR4xU2FHHn5J7thFqLiCfK4Z
         Jn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8kDU4q3nQ71eG5/cXl+NS6rCA9dQv2txs+IITzU0If4=;
        b=ulQl52aegn2vIK2BNSQsar9xo5EsfP1kI7q1xwWaF/rxiwSeRBD9EStxKWdioonMmq
         aIzlISDkKVbQ6vhmSpn2SSmiKF658lplemhr5WQlrfICyhUKxbzqvq15qcY7NNRBbOo+
         WR4FCOee8WNTCHCEypqgp3fW0JQxIN0wSkPeXfJB6l4AiqW0qSzfSVJZAR1f/dtFs4IA
         P2/CbThUfcb+VzyeaX1WRmH0NXlLMzl2GhHVDVWKqbRDxhCxp1rPwqVu5js4hJSN8Jse
         WRlQjw3uST2wkhKvKP6YjTyVHQ5KFVSMFa7H3bScSnlsUrLL8W/+wu+JDO+o8TL9iTD3
         vkSQ==
X-Gm-Message-State: APjAAAVKMKkO2iAnuW6NQR4Kstc3EKgLKc9ZL7D1hJanq/KJXj2MKP18
        xqTXTJMCXRaf2IAAGhBZsOqre5Q=
X-Google-Smtp-Source: APXvYqyI1sn4kTcpDsKi+mglaw6ItEBkQQMT8y8UT+hWTsQ5I3bhH53SSZMOtGhBA8Q3clPnsqtyxQ==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr11890128wmk.8.1576777492213;
        Thu, 19 Dec 2019 09:44:52 -0800 (PST)
Received: from avx2 ([46.53.254.180])
        by smtp.gmail.com with ESMTPSA id z21sm6927780wml.5.2019.12.19.09.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:44:51 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:44:49 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: fixup type in workqueue_init_early()
Message-ID: <20191219174449.GA5232@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/workqueue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5899,7 +5899,7 @@ static void __init wq_numa_init(void)
 int __init workqueue_init_early(void)
 {
 	int std_nice[NR_STD_WORKER_POOLS] = { 0, HIGHPRI_NICE_LEVEL };
-	int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
+	enum hk_flags hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
 	int i, cpu;
 
 	WARN_ON(__alignof__(struct pool_workqueue) < __alignof__(long long));
