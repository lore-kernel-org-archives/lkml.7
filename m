Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07765C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BCD2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 01:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nab+MQum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgAGBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:03:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36893 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgAGBDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 20:03:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so8481155pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 17:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0W4z4C6dC01RLTeCcayXEvOAD5WKMfV6HC+a5WAWxQg=;
        b=Nab+MQumZjbQUj+anv/iG37LLvYcp3/1rDrEncHE8box4TpfBUgmhsmMuEyWYyRM7g
         2nIInJi4m4tpnYHmVFT2sXc810xWcAgZjxhAZ/+QIoWvbDX2e04+0Tl4aQ4vp8LY51pV
         ubA0n0x8n89rZGpU+dvilRo8QTunJ4x6GBPbhdHGiE2WR6M0rmO9hvZTHmhW3mjtwyFj
         fP9ImT7gsquimN0EfcS2e2Iu0myDSQXTNLqjBygSZWRvTVAVuQegC1hnTbYSkSzTkayO
         5e3bkyZWGNRhWTqcm/OxQc3QP3UCbRJfqMXxKQHmVevGi/HpcbQwcI3BJUjC9PCKDhCL
         T6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0W4z4C6dC01RLTeCcayXEvOAD5WKMfV6HC+a5WAWxQg=;
        b=OwYq4UIYqrwWjF6oXPgy2ZkB7PSgXtuhiEBtqwZlLHCHTLdzJeycQfGNOvtEJXNzTn
         9kK5ITxIK9lLdNSnbhOO3Tr2u9ixcboqeXvtdGXtgoxooXT8dOvnYllxpsJf0Tk5ApYt
         jbAjrXJe0jlw37q58N5i6+025QbY0ViMa3YdodFFIRVGkNQQmPkbcU4ASQrXcj7fiYkt
         Y9mS+HtZO+wRgmATV7qNiMlhJwhWb6k2ptVRjEEzJ7S640u5qeOC4AqRW3iyfHo36eA7
         CBU9JjfV1FnBnfIj1yTWcGZtGzv6ilpKLOrU7N7vo5tL0SgMTssH7uuLsapzouV+XiY9
         9gGw==
X-Gm-Message-State: APjAAAX3hTsvRi40f+usUYVtRClgYwcvNAyvytdWKl48MZjPS+Ea0Jgi
        t5at68jo0U+m30xqXPd01cbJc9c9pYI=
X-Google-Smtp-Source: APXvYqyv2jfqnyRBmzuLap2gU2hC5StQSLd4QLLs3VCxIscY4eumvb3CdwrH/fQwpJpUdQTzK/kqZw==
X-Received: by 2002:a17:902:9043:: with SMTP id w3mr107498255plz.8.1578358998329;
        Mon, 06 Jan 2020 17:03:18 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d21sm25361304pjs.25.2020.01.06.17.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:03:17 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE to be enabled if SERIAL_QCOM_GENI is a module
Date:   Tue,  7 Jan 2020 01:03:11 +0000
Message-Id: <20200107010311.58584-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107010311.58584-1-john.stultz@linaro.org>
References: <20200107010311.58584-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support having SERIAL_QCOM_GENI as a module while
also still preserving serial console support, tweak the
Kconfig requirements to not require =y

Cc: Todd Kjos <tkjos@google.com>
Cc: Alistair Delva <adelva@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 99f5da3bf913..4ca799198e88 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -975,7 +975,7 @@ config SERIAL_QCOM_GENI
 
 config SERIAL_QCOM_GENI_CONSOLE
 	bool "QCOM GENI Serial Console support"
-	depends on SERIAL_QCOM_GENI=y
+	depends on SERIAL_QCOM_GENI
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
-- 
2.17.1

