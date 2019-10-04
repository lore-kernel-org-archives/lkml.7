Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306BFC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40D3222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GsEaQ4PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388724AbfJDNdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:33:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36044 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388673AbfJDNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:33:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so6545599ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35c6WKfWiVzHcoZfDnuVi6Z0edUxk0lXRUfNHbINisM=;
        b=GsEaQ4PAaCg++2pIX8jFuqPCmCG8bW4FnbepiCXMbGjjqMgVq+BZTo5sWrviIz1nm1
         HaZ0oOMcm5OU0oH0Si//o9G1g6UNYV/pOzZ85f+Rzk438Yvx3R2adqlKoUe0QxGD0W2m
         habr3gaCWgS2zCIavFKTIkmpOJqVSPVeh/h6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35c6WKfWiVzHcoZfDnuVi6Z0edUxk0lXRUfNHbINisM=;
        b=CrfP8KZMHaoPpkA0EwET1AGsuQZq8wktGzSO7TKfsbuVEZBFGVeF2nuDIazUO7Bd4n
         N742XXT3epB1SHcwGY1cV/pIyVcMo9iwjhpTAn7UjoWQRQqMYRFLrForqGYqjeNF4p+K
         hdULSxc0tkbIdH3JbIUXd3Z6yjfPPGSn71QruFUacHWm1Wj0fKhE1WVteTvQGbYXyJjX
         4KTA/xoVj2xWJuuw8UNdz2XbxY9DFOINcITnHO4Rd3wlHpjXQOootLckBWEcE/Rn7cB/
         vHcyQJfjYSblR+Gw6ay7knvZ86wQoXhnaiKpzyMysR45ACZDfinmQdnZbyCfUC9kqjkq
         Ioqw==
X-Gm-Message-State: APjAAAV8G1BvPNS8grk/PCTAhdkjqaeJ33NzDw0B90/fmKfNFNPHK8Xf
        l8hROVT9voWmE+ai4fWxWGy0mw==
X-Google-Smtp-Source: APXvYqzJapqdmPdUJMsrzSIurqdBWvVg4OUKJvpEiH2P9BXBMl+o8sCqNS90VSQHpgefK9j1QdikyA==
X-Received: by 2002:a2e:9094:: with SMTP id l20mr9895013ljg.35.1570195987641;
        Fri, 04 Oct 2019 06:33:07 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:33:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] pwm: update comment on struct pwm_ops::apply
Date:   Fri,  4 Oct 2019 15:32:07 +0200
Message-Id: <20191004133207.6663-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71523d1812ac (pwm: Ensure pwm_apply_state() doesn't modify the
state argument) updated the kernel-doc for pwm_apply_state(), but not
for the ->apply callback in the pwm_ops struct.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/pwm.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b2c9c460947d..0ef808d925bb 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -243,10 +243,7 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @request: optional hook for requesting a PWM
  * @free: optional hook for freeing a PWM
  * @capture: capture and report PWM signal
- * @apply: atomically apply a new PWM config. The state argument
- *	   should be adjusted with the real hardware config (if the
- *	   approximate the period or duty_cycle value, state should
- *	   reflect it)
+ * @apply: atomically apply a new PWM config
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
-- 
2.20.1

