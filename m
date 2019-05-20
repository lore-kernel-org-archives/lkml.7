Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD87C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3220863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2FGtec4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbfETPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:19:00 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54170 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbfETPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:19:00 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so23506744ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bDPOW4T9PERtlCKjJ2lAbrC2Btl/gUnBtJeF4+SdEo=;
        b=M2FGtec4qwOQA9nWt3yNJamKQbZ6wWHEdQ7BldBsOi2SLF2pp3o3HgjfWthzjXcrkt
         1Hs+/DfFdQxqw0ItBC68YwvtUHfxSDPNMNLezriKfz417YqyxPA0xE315PCzAR3zfJwq
         sD4QG6ggCau9zHe06mjOfQ/XeYTExSpjEdqb9EfyT8q9xhCfiXdOI7D/5lD6jYqoWhyC
         KCI0lBwpSXxLHBGlYkTxZ182lmZPVwPKZjKhBCHRAF5RLHL/2mIcGf0eGvTbEPMZTbFy
         lRnLGTe/ufItgUvJSnsswcjufkJZChaO2cCIaWAhfiTpiBkCBx5/xWGe0JLXpAVpwW/L
         XZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8bDPOW4T9PERtlCKjJ2lAbrC2Btl/gUnBtJeF4+SdEo=;
        b=T2SoqZALk7iVNH/eh34uoLdCulkXv2YtUfTz2hiVlyjLC74WCIxQCo5L5p/VTNan0W
         Jv9Zh59cm2FJEHZ1xR/uRBoX7tdUwPGNslequQ+nEbZBUdREFr4LideZ37Fg3qbjfoBz
         36bGzAgVEGtLMV7IE6nj+q6oB/coAQJD6A6wEYbWG/3J7sBRs8043z80bW/nsf7rmRRw
         AP37WBAoKVF/5ig/om0DVWcgiqp9/3tjavRp3Ib+YScR+DZ8YLXp7FEyFcezEFz/7dR3
         oQKbC8jjifwC6U3i2cyqB4n8h80ArsMDHrwT7DvntMFrV/lrSOJz/8TIaEd6UJR6GpGe
         f5oA==
X-Gm-Message-State: APjAAAXEaogU8HMlcgkrk1saXOdgOMAlN6wM6jnMCAjc60RMdHPJ+x/Y
        qf73I92cwkkLlI8to4fXMxHuJA==
X-Google-Smtp-Source: APXvYqxPeWPsR3qi08xbeYLoNXEOxhRXLPb6AbDnMWGKPpAWkaPEec6V+TrN28W/Fq0LTraaojid4w==
X-Received: by 2002:a05:660c:107:: with SMTP id w7mr11276557itj.59.1558365539219;
        Mon, 20 May 2019 08:18:59 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id s8sm5513436iot.55.2019.05.20.08.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:18:58 -0700 (PDT)
From:   Dan Rue <dan.rue@linaro.org>
To:     dan.rue@linaro.org
Cc:     linux-kselftest@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: teach kselftest-merge to find nested config files
Date:   Mon, 20 May 2019 10:16:14 -0500
Message-Id: <20190520151614.19188-1-dan.rue@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of kselftest-merge only finds config files that
are one level deep using `$(srctree)/tools/testing/selftests/*/config`.

Often, config files are added in nested directories, and do not get
picked up by kselftest-merge.

Use `find` to catch all config files under
`$(srctree)/tools/testing/selftests` instead.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index a45f84a7e811..e99e7f9484af 100644
--- a/Makefile
+++ b/Makefile
@@ -1228,9 +1228,8 @@ kselftest-clean:
 PHONY += kselftest-merge
 kselftest-merge:
 	$(if $(wildcard $(objtree)/.config),, $(error No .config exists, config your kernel first!))
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m $(objtree)/.config \
-		$(srctree)/tools/testing/selftests/*/config
+	$(Q)find $(srctree)/tools/testing/selftests -name config | \
+		xargs $(srctree)/scripts/kconfig/merge_config.sh -m $(objtree)/.config
 	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 # ---------------------------------------------------------------------------
-- 
2.21.0

