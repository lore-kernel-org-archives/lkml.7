Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039ABC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C603420828
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny1tjL62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE3Xy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:54:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33314 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3Xy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:54:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so9320142qtf.0;
        Thu, 30 May 2019 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbY7QCszbNfK/dSu1/5otH3SCdjboPhqqSUH03GB/EM=;
        b=Ny1tjL62Yp/e+GaLKP/297tsrcWytC1zfKBHhaK8whtejfVXW+9A1kzpdKGUKbXuPu
         r1zlSaWDIqaTKLurdjO7Jh8cB5vISfHfW+EqCZ1FtDsYd2Q/CX/tTI6x5ITQmtONxR+E
         NUGUY8nXml4OMFbJtP1knoCgImmtmExDsSyNP6tMJXiw9TeMoQANay6FctL1OwSYP1dn
         YNL8ECJGlSDaNOA3OxQauNaWNTrCy+f0enTC7f0VEI0p6gWDY2C1+yRr8J5XnqSUSzv1
         c8joxknUf9XS59y6NYzlGZrevCvYMOEXuJD0PEnfkHyUdBNE7kebRg2hQLqe3WcS/3ct
         BUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pbY7QCszbNfK/dSu1/5otH3SCdjboPhqqSUH03GB/EM=;
        b=lmbtQDoOFOycHI+ctLw2dHUS02rFByusHFDEUrBdWYQJbOEaPj/Gg08CtVMCGXIwtK
         XVfk2HDo3inlY7GxVhJe8hi+45gsLohVLwnL3PHKKlZTaF3b6c3XxNYhgv3p/qaB/rQ/
         uHhAHtmzSec8tZ8GpNh3trVSYiGWE99viOxT2zhijXHT7U3TkBzc6rdpO6Kc38zkjRJ0
         6PKzuW9XssymcyurIxLJEcyd+x5wyLQyd+MjbR5M5SR4hELiiqMWDwCKuyC2KDcW0FE9
         VRH5OQLwd6QkVRQWIrVFff+RYdjNA7bhJrOfpGARia3vk5qlOB3XHw6sC5IQ1xY9v3fU
         vgbg==
X-Gm-Message-State: APjAAAX+aHaJK2kruh7n5A9a1xJSsen3i5qZ0viYR9JZD2BlYXHQKpWb
        pDQiGwi7Q7EZCRGoB2C0oRyZduHVBKI=
X-Google-Smtp-Source: APXvYqwC5aBJLO4OqocA65XZMTeIF8x0DraB85FMjCvPdDhwPzRxOvi5CPb3KhxvUWhB5cc83897SA==
X-Received: by 2002:a0c:9d0e:: with SMTP id m14mr5891204qvf.121.1559260497562;
        Thu, 30 May 2019 16:54:57 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id d23sm3671309qta.26.2019.05.30.16.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 16:54:56 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Kubecek <mkubecek@suse.cz>, linville@redhat.com,
        f.fainelli@gmail.com
Subject: [PATCH net-next] ethtool: do not use regs->len after ops->get_regs
Date:   Thu, 30 May 2019 19:54:50 -0400
Message-Id: <20190530235450.11824-1-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel allocates a buffer of size ops->get_regs_len(), and pass
it to the kernel driver via ops->get_regs() for filling.

There is no restriction about what the kernel drivers can or cannot
do with the regs->len member. Drivers usually ignore it or set
the same size again. However, ethtool_get_regs() must not use this
value when copying the buffer back to the user, because userspace may
have allocated a smaller buffer. For instance ethtool does that when
dumping the raw registers directly into a fixed-size file.

Software may still make use of the regs->len value updated by the
kernel driver, but ethtool_get_regs() must use the original regs->len
given by userspace, up to ops->get_regs_len(), when copying the buffer.

Also no need to check regbuf twice.

Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
---
 net/core/ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 4a593853cbf2..8f95c7b7cafe 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1338,38 +1338,40 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
 {
 	struct ethtool_regs regs;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	void *regbuf;
 	int reglen, ret;
 
 	if (!ops->get_regs || !ops->get_regs_len)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&regs, useraddr, sizeof(regs)))
 		return -EFAULT;
 
 	reglen = ops->get_regs_len(dev);
 	if (reglen <= 0)
 		return reglen;
 
 	if (regs.len > reglen)
 		regs.len = reglen;
+	else
+		reglen = regs.len;
 
 	regbuf = vzalloc(reglen);
 	if (!regbuf)
 		return -ENOMEM;
 
 	ops->get_regs(dev, &regs, regbuf);
 
 	ret = -EFAULT;
 	if (copy_to_user(useraddr, &regs, sizeof(regs)))
 		goto out;
 	useraddr += offsetof(struct ethtool_regs, data);
-	if (regbuf && copy_to_user(useraddr, regbuf, regs.len))
+	if (copy_to_user(useraddr, regbuf, reglen))
 		goto out;
 	ret = 0;
 
  out:
 	vfree(regbuf);
 	return ret;
 }
-- 
2.21.0

