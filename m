Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5451C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B035920679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FUfvxf0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHLMlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:41:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42717 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHLMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:41:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so7717937wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrwfrIKrYFfamy4c5vzLtem+Xc73qRM6JZjJ2gik+Hc=;
        b=FUfvxf0DHtH9KpoJ0X9Ra32kGPWTpFo5rxU1zDYUZD9XzGJiNdMGbwGnUToDx9Bdp7
         LInJGSUSq46S655AB9fh12XDYUsPYcwH5EeRxx84QFfk8JE8KCiJVSireHFlgHai5ohA
         b3q/pqDVxyiQMOaoOXagXwqP/bMC1/CZ+CT3IxAVl/ZURzmgNwnRVeV/SqtnjzQRrx7Y
         Ih+b1xt/VvJWvjqrTfi9RzqT7vFsIWvMCT5xDjbkv4/DuH6+5J3kKqpsciKIVWg/OQS4
         WuxdKXninizlSxRRgzpzKBFLtvVNhfM50UfLmo6if0sjZW7vgKBNG7jOjXXzDBP1em3m
         kwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrwfrIKrYFfamy4c5vzLtem+Xc73qRM6JZjJ2gik+Hc=;
        b=eyD+VCH3TctgTFgwQlcAh68Zx/SBETggqTEncSB5ixkq66pQFcNNwXaMRrS4CWTWzt
         NE4qEDe5Jy87/PPlhrV0zaytMIWZEMAuCAUlgITizp7t0RwOlRgmxRfjYWfeVVOFzPCy
         Txi7ISoLpOg3aLzb18A8YgwiCCf5+aEUFrW8dUtQ63gnEOF3WmG333UPWyZAkO21M1Fp
         A5ltI9OraG6/9YC6evuWXi+A9SnFOxcsTl1ZRU5Pzl61VjW1wkQKSDkeEAG16I5+8Xo8
         g6GqjMoozltDWHpOYFLHIvV39iIVXZV1nZnlHV570yFl/oD3L6rEbgPwiSvK+zoCY1kl
         bZzg==
X-Gm-Message-State: APjAAAVvqchGXbMCYhK/+GC4iDPYusNUGuE0SS+/uXQtm3AjGadwO9fJ
        9RN92YrVLQ2QxoOzLdwD7kiX2g==
X-Google-Smtp-Source: APXvYqxvdiimPN6REXGqxrbIhOO5sIqtbXFrvpnzU/YAZRZkclAjxlZDYw6lM2NKBwaTeayPp6AhNA==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr11720190wrr.119.1565613704212;
        Mon, 12 Aug 2019 05:41:44 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id p13sm37961458wrw.90.2019.08.12.05.41.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:41:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] tools: iio: add .gitignore
Date:   Mon, 12 Aug 2019 14:41:41 +0200
Message-Id: <20190812124141.9108-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The generated files must not be tracked by git. Add a local .gitignore.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 tools/iio/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/iio/.gitignore

diff --git a/tools/iio/.gitignore b/tools/iio/.gitignore
new file mode 100644
index 000000000000..3758202618bd
--- /dev/null
+++ b/tools/iio/.gitignore
@@ -0,0 +1,4 @@
+iio_event_monitor
+iio_generic_buffer
+lsiio
+include/
-- 
2.21.0

