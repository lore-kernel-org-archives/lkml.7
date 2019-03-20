Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE102146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YWEQk0i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCTQb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:31:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44573 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfCTQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:31:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id w5so3208040qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbEx3hMagtlG7gtXzbw55L8OpDPeq7CK2cOpXhk6DvE=;
        b=YWEQk0i3DNve9X7odkA0YaqSFB+S7FYiv8C2wDlK/DFq6VaqBKPXsMVfzU++p0s+TD
         2QipDN2VY1q2PndUDXCpYdcP39GOrAaX5JTzhOnZAGh1GL7HPSv19zZjt0i3ePp92tE5
         KFJNorfx2+MYSutVG731h2Zw6MKmQKtmum02Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbEx3hMagtlG7gtXzbw55L8OpDPeq7CK2cOpXhk6DvE=;
        b=T3OOonzWTfd5w1Y53438tX+VZW4x0oPPeMdd38D+b1f+QUKk8XstPLx+3eph4MFEQi
         yqXez/FYGO+YRcur6tK16PgafJ7EtSUgeJCMahTfukNn/al/+MWzBekkp3OPzDSBmlD8
         xjnomJWkiH5pXJ0xycPVsN8nuO9o4LjVWmyi2dzOaZEi/jHXQqhyh74qj4ARXur5hliB
         GTjSPi5y9ajcpnETZh4Ve4f77jOkWivIj8XHnZ+w97+9cgyPDmDhc93SCbJWpc3luf9h
         Zg2vNpBnbCGQCfzmH3R76s1YaneGw4T/xc1zuu9odvJ00DqhBt1P9XuIIpipYX684UPl
         Sbpg==
X-Gm-Message-State: APjAAAXuCi9A+ukmgZbINUxq8qGFTySoD/O8Bfxmf1fbSex+WrVN+SsO
        RwzSXCi5ltlmuCHdv+/aa9ww/JQEi04=
X-Google-Smtp-Source: APXvYqwUF3xe/DWcZKtonrv9q/U0k5qLbP3U0nAhFQKHu/SfL9W8qYNP1+vPEf/zpj0obFGYk+wJ4g==
X-Received: by 2002:a0c:8b63:: with SMTP id d35mr7274369qvc.148.1553099510901;
        Wed, 20 Mar 2019 09:31:50 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id h10sm2289721qta.3.2019.03.20.09.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 09:31:50 -0700 (PDT)
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
Subject: [PATCH v5 3/3] init/config: Do not select BUILD_BIN2C for IKCONFIG
Date:   Wed, 20 Mar 2019 12:31:16 -0400
Message-Id: <20190320163116.39275-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190320163116.39275-1-joel@joelfernandes.org>
References: <20190320163116.39275-1-joel@joelfernandes.org>
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
2.21.0.225.g810b269d1ac-goog

