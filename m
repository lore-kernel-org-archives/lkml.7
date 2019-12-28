Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CC0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B185320828
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 01:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="z7N+czYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfL1Bsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 20:48:54 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46994 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL1Bsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:48:54 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so23598082ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 17:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DDPiRYZKbt5YXi2Y+CUXPuPnWcpqDrbVx/b405CuP1A=;
        b=z7N+czYvcFoUZNOTteUd/f/rHfciJ4hgUaWHyQLVN5HHfSLwU/odrwm8TCvckRM1ly
         ECiTcJMDn+llLl4v7RwW7/seiD9hC+3Z/OcMSSJLjNm3T81PtQp7QHh3x6VedLLacFIz
         ZelH1jhe171qCQkU34vsmEkQtwU982tQ6EZvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DDPiRYZKbt5YXi2Y+CUXPuPnWcpqDrbVx/b405CuP1A=;
        b=J1TimgXX81pzhy9XLkmhCxdvo+MUkfjpv1IWl9lhU/7ychf4Xq1bxOVkLTZ5Kl8lqz
         iMBEb6tIxhtOH7gyt2UGC0ULX2fO7kMgxjKwe/ILHl27d4+naWys3odgZaCwYSUueGEO
         pRm8S0g1xRa5/fvsh0buWt7Cn69Py24i9ovoz+OEt8uddeSq7cko9/tcl+nC2FaLHf8s
         0fWziE2QR3zK8W5GdsuIEnJE3Jkw1dDoOHpud1NRe5EmoRSICOb+H06GJgVFHUik3vYU
         fufjMFRugODVdP6qjOxooFTJcO2ts9RaVWEzoBHDMkqFEYKgmcYzbT0b9ooFlhLTxFVI
         aTqA==
X-Gm-Message-State: APjAAAV8b4bkdPTnpwe8wMMt1xyt8zZBHdRuzVYY4nzMYINA/CEuqPHJ
        vnvGRy6AkwJ3cbsIm8i5aC66eOGmJI0=
X-Google-Smtp-Source: APXvYqyoZZo9NvOdbd3yORVqoHuqAGtvfcLRDigiJZrZTHX2eNvyhqnZsRdvRYWzRUMcl3T4o0CDSw==
X-Received: by 2002:a92:b6db:: with SMTP id m88mr34585103ill.220.1577497733231;
        Fri, 27 Dec 2019 17:48:53 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id n20sm9732216ioj.83.2019.12.27.17.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 17:48:53 -0800 (PST)
Date:   Sat, 28 Dec 2019 01:48:51 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org, cyphar@cyphar.com
Subject: [PATCH v2 2/2] seccomp: Check that seccomp_notif is zeroed out by
 the user
Message-ID: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a small change in enforcement of the uapi for
SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
is passed (seccomp_notif) must be zeroed out. Previously any of its
members could be set to nonsense values, and we would ignore it.

This ensures all fields are set to their zero value.

This relies on the seccomp_notif datastructure to not have
any unnamed padding, as it is valid to initialize the datastructure
as:

  struct seccomp_notif notif = {};

This only initializes named members to their 0-value [1].

[1]: https://lore.kernel.org/lkml/20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com/

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 12d2227e5786..4fd73cbdd01e 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1026,6 +1026,12 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
+	ret = check_zeroed_user(buf, sizeof(unotif));
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EINVAL;
+
 	memset(&unotif, 0, sizeof(unotif));
 
 	ret = down_interruptible(&filter->notif->request);
-- 
2.20.1

