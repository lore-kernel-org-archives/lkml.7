Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80338218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="W61Z+6Gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfCRRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:42:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35002 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfCRRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:42:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so12121644wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=W61Z+6GwoguIn+kuWlioUvDowh6U4YGUvduTzVxMh3ZfloEfISU/2Kbcoz/2UbXvpK
         Ebl1DgR1UEDndkphzYm1kq5mYrZ/djP3ArzsrslGLgGndhcZuC+L7krNMWsg7wanrRMj
         Mfmrt5wqbDHUPWLkiAg35iJYZz2JWJePCwEzvpmxLkYbA7xkQE+6e/Z3W2HQhhzLrXa0
         flzrjiA8LNlJbEy4HcJL/cQMGuRlyVGi6xID8KMczKQVGRf/SlpeXGrjMPL74bkPNp8W
         VD/E4OY/l2LpsF2krS3Y1kJqYfB85kQrGKpjzcWtiW0QtJZXZ2kqwQAezprtU89ortHr
         nhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rD/Z65OnYoppq/ikSxqUpjeEOremUITKG7uIaduTeV4=;
        b=mmoyh7LkI7rLD7261z4jQZhkEj4+GpLDDEaxMNjscY+AocIbGYFv8PaVUexBsKOwXw
         hSF+fN7ltlxraMYREwm/XvQCOhzK9NtdjjvQ7wiQnQxMS6PysMS0IPPmdy9m8d3//OgG
         ubxCzLzK4TBiIyJxtmsW/Ddk02u7zwy+FZbQEw7Zj5/rqMTTchHgbDaXAFS5gGrrbt5l
         fLdwYpy0xLBR603mk6VmhKNXuKWzz2hX+UoTWB/C3Sg3bXWxasIUjKU6ZICwv4rXrGZQ
         1H8HQjMXWeAdp5jPBBNLVAoys4NHqBV1MLoSWTrIA7s70nBK6cJ99vLNp+r2ZPzLe/nf
         cjDQ==
X-Gm-Message-State: APjAAAVIs9B/5u3wfCSxMkWpLOPk3kSr3asHp7SCbxEpnAWMIIoJKcO3
        V3BX5Q4BYCK19VuYscdsxG6eeQ==
X-Google-Smtp-Source: APXvYqz5zwA7Sk2bRr82IuC+ZZzGWs1/CQKjZKXHsEaYpjQL3BxLW6z9LabbNoF8eyUuq5x7h9gEgw==
X-Received: by 2002:adf:fb82:: with SMTP id a2mr4167878wrr.214.1552930959978;
        Mon, 18 Mar 2019 10:42:39 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id g24sm14873909wmh.45.2019.03.18.10.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 10:42:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v6 05/11] mfd: core: document mfd_add_devices()
Date:   Mon, 18 Mar 2019 18:42:22 +0100
Message-Id: <20190318174228.18194-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318174228.18194-1-brgl@bgdev.pl>
References: <20190318174228.18194-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mfd/mfd-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..0898a8db1747 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register a set of child devices
+ *
+ * @parent: Parent device for all sub-nodes.
+ * @id: Platform device id. If >= 0, each sub-device will have its cell_id
+ *      added to this number and use it as the platform device id.
+ * @cells: Array of mfd cells describing sub-devices.
+ * @n_devs: Number of sub-devices to register.
+ * @mem_base: Parent register range resource for sub-devices.
+ * @irq_base: Base of the range of virtual interrupt numbers allocated for
+ *            this MFD device. Unused if @domain is specified.
+ * @domain: Interrupt domain used to create mappings for HW interrupt numbers
+ *          specificed in sub-devices' IRQ resources.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.20.1

