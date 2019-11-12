Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61149C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAC821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gdgl6cTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLWKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:10:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726896AbfKLWKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573596638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OGswjGzUffihOSl/n5t/dLNRnhblfx+YfOx5kFh8IX4=;
        b=Gdgl6cTDiCtR86q6mCw5vxMFCY7zEnH9mCvVGwi6Sq9fKTWY3TSMPaN2KHH3T+VWU/Q49t
        IqviZcH6F9QcwayZx14XfhTc/RZjqDfxVhp8fQYzRpDrvsM4kZB3dp8sFOyFGe78rF9ZXc
        jri5I+fj/0JPuPmuV7rhtBFQopUebtg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-qPnCI2psNvWr-rAUDilEYg-1; Tue, 12 Nov 2019 17:10:35 -0500
Received: by mail-qk1-f197.google.com with SMTP id h80so135170qke.15
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 14:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bYI+fJWrfaTVip21z6+iZIacHnQTlTHn+UZkjofOrJ0=;
        b=DOxKkG1gMGsgbZyoQtCDLUZhrHkFsKTQ8cI4NNHJhTJZAXLGNRzgm3QOZ7b+ewjeAi
         bIEWpl02l7WyDNMGVJxwYKkD48grbhYPZ3pltCeWv+QmJrjsuPYtvctJmdjW8aN2XlH3
         W27xcvUlBUmzXuyBxFIQI1vnreZXtOfL0jO20rWWHD5gA+FnYt7/GNmadDygaj4lU89u
         boAwNAr4nnodKJt0QyAA7fjvymr0TSWHmWnatoCAtGqd1HXnOP+m0K/hjkDQsjnwswvW
         1X8pgZYdieX4lDa8cZ1owGkxg7JwvFV2TvUXygLIOqaJI/icmbW8JzER3rmcfZOcd1OZ
         9BIA==
X-Gm-Message-State: APjAAAWROWaK5CrnmzV9bE8Q/UfIe1uTWE35BKXBzqrfBwcZeCUp6jcf
        SoyznF5dHROi2woNrN0eo50HuPS0m0UqVjNPmOG1fChPBKTX0YHLVt2oKjNv9KetkgsPTvGFv76
        dMFIXqWsjxwCYQLdd/B486lKV
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr33202589qtm.310.1573596634718;
        Tue, 12 Nov 2019 14:10:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxtJyW+Mbx1NhfAQ3HEARf8vkQ6SiLwJiZfZFujYl6xkNZFUELs855wc2YOfNBe2HIaIxJO6A==
X-Received: by 2002:ac8:41cc:: with SMTP id o12mr33202571qtm.310.1573596634433;
        Tue, 12 Nov 2019 14:10:34 -0800 (PST)
Received: from labbott-redhat.redhat.com (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id s44sm140751qts.22.2019.11.12.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:10:33 -0800 (PST)
From:   Laura Abbott <labbott@redhat.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: gpio: Correctly add make dependencies for gpio_utils
Date:   Tue, 12 Nov 2019 17:10:26 -0500
Message-Id: <20191112221026.5859-1-labbott@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: qPnCI2psNvWr-rAUDilEYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


gpio tools fail to build correctly with make parallelization:

$ make -s -j24
ld: gpio-utils.o: file not recognized: file truncated
make[1]: *** [/home/labbott/linux_upstream/tools/build/Makefile.build:145: =
lsgpio-in.o] Error 1
make: *** [Makefile:43: lsgpio-in.o] Error 2
make: *** Waiting for unfinished jobs....

This is because gpio-utils.o is used across multiple targets.
Fix this by making gpio-utios.o a proper dependency.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
I made a similar fix to iio tools
lore.kernel.org/r/20191018172908.3761-1-labbott@redhat.com
---
 tools/gpio/Build    |  1 +
 tools/gpio/Makefile | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/gpio/Build b/tools/gpio/Build
index 620c1937d957..4141f35837db 100644
--- a/tools/gpio/Build
+++ b/tools/gpio/Build
@@ -1,3 +1,4 @@
+gpio-utils-y +=3D gpio-utils.o
 lsgpio-y +=3D lsgpio.o gpio-utils.o
 gpio-hammer-y +=3D gpio-hammer.o gpio-utils.o
 gpio-event-mon-y +=3D gpio-event-mon.o gpio-utils.o
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 1178d302757e..6080de58861f 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -35,11 +35,15 @@ $(OUTPUT)include/linux/gpio.h: ../../include/uapi/linux=
/gpio.h
=20
 prepare: $(OUTPUT)include/linux/gpio.h
=20
+GPIO_UTILS_IN :=3D $(output)gpio-utils-in.o
+$(GPIO_UTILS_IN): prepare FORCE
+=09$(Q)$(MAKE) $(build)=3Dgpio-utils
+
 #
 # lsgpio
 #
 LSGPIO_IN :=3D $(OUTPUT)lsgpio-in.o
-$(LSGPIO_IN): prepare FORCE
+$(LSGPIO_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
 =09$(Q)$(MAKE) $(build)=3Dlsgpio
 $(OUTPUT)lsgpio: $(LSGPIO_IN)
 =09$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
@@ -48,7 +52,7 @@ $(OUTPUT)lsgpio: $(LSGPIO_IN)
 # gpio-hammer
 #
 GPIO_HAMMER_IN :=3D $(OUTPUT)gpio-hammer-in.o
-$(GPIO_HAMMER_IN): prepare FORCE
+$(GPIO_HAMMER_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
 =09$(Q)$(MAKE) $(build)=3Dgpio-hammer
 $(OUTPUT)gpio-hammer: $(GPIO_HAMMER_IN)
 =09$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
@@ -57,7 +61,7 @@ $(OUTPUT)gpio-hammer: $(GPIO_HAMMER_IN)
 # gpio-event-mon
 #
 GPIO_EVENT_MON_IN :=3D $(OUTPUT)gpio-event-mon-in.o
-$(GPIO_EVENT_MON_IN): prepare FORCE
+$(GPIO_EVENT_MON_IN): prepare FORCE $(OUTPUT)gpio-utils-in.o
 =09$(Q)$(MAKE) $(build)=3Dgpio-event-mon
 $(OUTPUT)gpio-event-mon: $(GPIO_EVENT_MON_IN)
 =09$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
--=20
2.21.0

