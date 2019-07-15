Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC7AC742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEE321734
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="gnWDsEn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfGOAac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:30:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53074 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfGOAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:30:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so13412392wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 17:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQN6nIE7YhXdUO5xObjkK2NfXESo8Rmaaa2vkcOFN4Q=;
        b=gnWDsEn2/Utp302o3nKRrdJVFB0hvujnrL9Icy5Pl3zlkqMSybizldTwcbc9WwZJox
         GN1RvXFR8zTPGu3YeoEVxSKcN4noWGOPjzFwlsjdl+hLb5mZcWd8yO2tl4wLno7XMDm7
         2aqVxE69iuIVut+9DM0eGI7m4nUsBYjK8QAvA314j/VPrXFS/ootaVzI8aQqMe57FiFG
         Q+hHaaGi3xUeNh3FOJahshYOQHqhAb0W6r3DtPwMdG/MIQq5WL8SncPBLwbd3GI1cFce
         ReoBAPANBgiwq/V2LVAIG1SJw9vKUuFwOAc77gALK7+TbJHYydviwDgfmxMwWLbDsXg1
         v32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQN6nIE7YhXdUO5xObjkK2NfXESo8Rmaaa2vkcOFN4Q=;
        b=Zdm3e/22xdwJtpevmJc+XEWPNTV8yqIxXD7XIcIO8MCqP93iJAlGLrXKsLq8weyn9d
         Cksmld+V00W9RsmZ/CkiiEOT04K18u+ot5EIhmDSOr1eQDV189vhrfjzgrsxbTxIgocf
         zlf+3IwrFR1SxcpGj/4jfn251UGbT3zW8o52op+GQiNGeIzEeJg00c+t0Y/2p9gVcWf6
         Xo1i4Rj7sHqSfa6x66KdfjpvC66favVnWuzfev9HNK5CSHGq7R9XP2RqaIo1eqYPAola
         XPs4l0CfRkY8ZkLIU5nIllndFJLE/v3C7lzfM/s3pLnzo75qsJS3hCwzucgOhIZutPeB
         f2Gw==
X-Gm-Message-State: APjAAAWmvMRtpigL3SLfE7Os/PAQ09RbtZStueiRGh9zoX44FnbjTql5
        qPp0ZoRRkYI4MV5QuPymAGjhCarlSU4=
X-Google-Smtp-Source: APXvYqy3CVVdmdRSTboWnh4OtQEuKfxnoLlF/tnVr42yAjft3cD12KULQq3VcxsfUHDep/4DFMCr5Q==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr19349720wmi.122.1563150630130;
        Sun, 14 Jul 2019 17:30:30 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id h133sm16246142wme.28.2019.07.14.17.30.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 17:30:29 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, davem@davemloft.net, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH v1] MAINTAINERS: add new entry for pidfd api
Date:   Mon, 15 Jul 2019 02:30:21 +0200
Message-Id: <20190715003021.25040-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
References: <8dbfa2d12bb0c76a19f46128af083921c8feb562.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add me as a maintainer for pidfd stuff so people know who to yell at and
to easily keep track of incoming changes.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
v1:
- Joe Perches <joe@perches.com>:
  - remove N: pidfd line
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1be025959be9..63522c0043d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12567,6 +12567,17 @@ F:	arch/arm/boot/dts/picoxcell*
 F:	arch/arm/mach-picoxcell/
 F:	drivers/crypto/picoxcell*
 
+PIDFD API
+M:	Christian Brauner <christian@brauner.io>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
+F:	samples/pidfd/
+F:	tools/testing/selftests/pidfd/
+K:	(?i)pidfd
+K:	(?i)clone3
+K:	\b(clone_args|kernel_clone_args)\b
+
 PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-gpio@vger.kernel.org
-- 
2.22.0

