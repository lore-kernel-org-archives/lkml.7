Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC78C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B815120857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hOKH9wVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfDHV31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:29:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38178 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDHV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:29:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so8028596pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbB6gMbRWZnd3XGR++ZafZznSxQYOIqaHAc9TBmuW38=;
        b=hOKH9wVPW2ru+rMr8WZWSAkF5qWzyQgoxLfn37q1FmSeZZCibD4miqJyNwZWkRma0C
         S9Xnk3hC7IxfbKcyTJzjfp3aQAi0TG/3ULOggHzmW4YfG/0ZQuHNfeBs2aQJ7zhX7YPD
         naIJpr1XfiW+haJ5Pa3tSvR69YSsJmyZVM9YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbB6gMbRWZnd3XGR++ZafZznSxQYOIqaHAc9TBmuW38=;
        b=VyQJh0MUJcVB6/STcgfM2ohpvMzBpQNr7DVjjsYATLJ5nc2fQ17yWUzmSDMM/mhjDg
         AvWluKoUSiuVsUP08lrYDZ6svFrQzMSQHVs7szNCFsmwOLaUtJnPvePyYgHS9iaXug/G
         S2Y3ywJ8vKFMLMrb3KG+/VF/Kx1Kj+5rJy+DOwhKhgBvDrSD5PgbKbM7bmD7axy4D929
         K1X0GEgln1XBAjbJf8l9fuDXSr4DradpdhE1Qd42TvU6RKuHb3vL0cZHCxIUytM7zsPE
         f/KwlMff4wm+qTgDg8VVNXI1fpYvv56bhV57dFor0kjDOAPQwloaVltugbe2bu7eZ3+N
         I4Dg==
X-Gm-Message-State: APjAAAUAch6+SYM9BWstmE9yFLS84jFT/Vho3Jn3tRbentiBsO0doZlm
        NrE98fWYausL0LxQFgjXtfeXHTqfsYE=
X-Google-Smtp-Source: APXvYqxCmxc7H/Y722GyFHvR0Y9Elc+ji0teoq3wduyN/AGQG9MEgBL7m5NJx1/Dh2hvpWv+xYb3rA==
X-Received: by 2002:a63:b811:: with SMTP id p17mr30735868pge.219.1554758964939;
        Mon, 08 Apr 2019 14:29:24 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t12sm68073407pfl.59.2019.04.08.14.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 14:29:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mhiramat@kernel.org, qais.yousef@arm.com, rdunlap@infradead.org,
        rostedt@goodmis.org, Shuah Khan <shuah@kernel.org>, yhs@fb.com
Subject: [PATCH v6 2/2] init/config: Do not select BUILD_BIN2C for IKCONFIG
Date:   Mon,  8 Apr 2019 17:28:55 -0400
Message-Id: <20190408212855.233198-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190408212855.233198-1-joel@joelfernandes.org>
References: <20190408212855.233198-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 13610aa908dc ("kernel/configs: use .incbin directive to
embed config_data.gz"), IKCONFIG no longer uses BUILD_BIN2C so prevent
it from being selected in Kconfig.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index ea75bfbf7dfa..ffcb2f90543f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -562,7 +562,6 @@ config BUILD_BIN2C
 
 config IKCONFIG
 	tristate "Kernel .config support"
-	select BUILD_BIN2C
 	---help---
 	  This option enables the complete Linux kernel ".config" file
 	  contents to be saved in the kernel. It provides documentation
-- 
2.21.0.392.gf8f6787159e-goog

