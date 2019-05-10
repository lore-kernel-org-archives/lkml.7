Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35599C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036BC20989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UVBj/OwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfEJVDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:03:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41026 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfEJVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:03:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so3561046pgp.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9Gow6vM42aJp56wjf9r7GBUU79udYOMt8dacDWI13Q=;
        b=UVBj/OwFLiTzum6IDgk7LUVfg4GiBlqfYvJJl4E6HY2WxlnZ0tj+8Mbyp8HNH5SRIF
         xlPqFSE4NCYZBHfO7irbMEN+Vg+YxVQx3scJ2UAuP3Tk7DRfDauHCWrKS0qfq1K4r+C8
         3DBrBuEM2rpf+Pk1qNBmlldbVkgMKr/w1GTH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9Gow6vM42aJp56wjf9r7GBUU79udYOMt8dacDWI13Q=;
        b=aLKFn5LdQ1jRfONS+XKWID4piQZbP7tyryRqKF9aYciOAr2NGkQ7hD0IE/ddrvf5o9
         dIT8vZaUmcrgliwEnLREQWHja9T43Caud12wfTCHMUpRWGrzEteWoGHnd8IbWqs0g5VQ
         /733QLYdlZ9ZE83BmDmr0+tysO2MGGAywPV0RF4pIWTxHxiXvENXNKnB7RLveJiYWdNG
         De8b4yCYWwHuWfY67x0i3Z/0AFT2V65P2Ui2m5mU5e1s1hPp6A5MBS4mNQs3MiFeDOh5
         +2BR7bBIlDa+k4TdQghlWuntCizzK/KaCn4tUZ11Atli9FSnVpck8cnmy1zb2OC7UjQr
         OKwA==
X-Gm-Message-State: APjAAAUPEAV2sQTnAVM4PnNcG8QztCHSG0+iA4hd8Ys4wU6PBMj0Dup4
        q0sG9YsOxgOQEc+fblAAai98vM71fMA=
X-Google-Smtp-Source: APXvYqxx7K5CBGqKQ/c/VTttlOFyb3tvfg/8U27VnQPYkICRqEywBVXgF7yTbE4iu6TL2YhtYXVtAQ==
X-Received: by 2002:a63:2118:: with SMTP id h24mr16498738pgh.320.1557522187805;
        Fri, 10 May 2019 14:03:07 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y8sm6523333pgk.20.2019.05.10.14.03.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:03:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, atishp04@gmail.com,
        bpf@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, dancol@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dan Williams <dan.j.williams@intel.com>,
        dietmar.eggemann@arm.com, duyuchao <yuchao.du@unisoc.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Manjo Raja Rao <linux@manojrajarao.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Gregorczyk?= <michalgr@fb.com>,
        Michal Gregorczyk <michalgr@live.com>,
        Mohammad Husain <russoue@gmail.com>,
        Olof Johansson <olof@lixom.net>, qais.yousef@arm.com,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Tamir Carmeli <carmeli.tamir@gmail.com>, yhs@fb.com
Subject: [PATCH 3/3] kheaders: Make it depend on sysfs
Date:   Fri, 10 May 2019 17:02:43 -0400
Message-Id: <20190510210243.152808-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190510210243.152808-1-joel@joelfernandes.org>
References: <20190510210243.152808-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kheaders archive is exposed through SYSFS in /sys/kernel/. Make it
depend on SYSFS as it makes no sense to enable this feature without it.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index ce08adf0f637..f27138a8cf28 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -581,6 +581,7 @@ config IKCONFIG_PROC
 
 config IKHEADERS
 	tristate "Enable kernel headers through /sys/kernel/kheaders.tar.xz"
+	depends on SYSFS
 	help
 	  This option enables access to the in-kernel headers that are generated during
 	  the build process. These can be used to build eBPF tracing programs,
-- 
2.21.0.1020.gf2820cf01a-goog

