Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4383C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A40218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcrdN+cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbfDXBiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:38:22 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39255 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfDXBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:38:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id x204so3011764ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 18:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p22V+aJrhB0BxAVxy1DNMt2mcsIprbVVrqZ7FZEVJfw=;
        b=UcrdN+cIfQ+KuZ6LMFPrOJ5opq8ueu/k5BHI/qUB8Ca9/91aclVv2fgiCkEdCbYwKa
         SBgmV+uhqRAUXDxsh+PNOoZuDejtL8sGc3kz1+zbF+IlRrcUrMy0PufuAOJ1Tro5Ssk/
         MSXZy/v3ltlF8PnvqKgtIMEq/hIb2ysxqYdySyN8fn5tSROeSl9lr1Il63nVYdhGnuo+
         O5hcHxFrh9nW6OyAklab515s1EBiv0dzfcWjT7sJ3VJmX+LDZZlnti/Dr+lCUMAl6PtM
         54y3cT1xvhf/ttL/xGwLXnsy1mZFTOX6loCn650pZddqyLA7Wg0s7y665z5NYyELXQmD
         oWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p22V+aJrhB0BxAVxy1DNMt2mcsIprbVVrqZ7FZEVJfw=;
        b=TV9cUS/+CYSijNAA9y6gBi9fVgkbVOdNTvJkwZbTiReyQwlUuWA7SmRqAHSXsxI86y
         eC10LXUrSUm5mF3/b0QCcwHZGy/TQSTjBE/jS22rcv3xkUKzjbCmzC9R4IfdSq0XaCCw
         5FfhlGGYTHp0RobbFjpJXggHzLCRIdSFaP4igWxTN9gS8uu65WW1h46FP01mKySNQ1c/
         j4z1TCWLdzkhNHzzhxc4ImgQcV9qQbdxxGWC2asM875IZ9lhE9CxMVVkjRn+tR9qxAZm
         lmXRLoiGYh6JsGKXDsaT2rNfkxIEVfDl4xyME0qvOPprZvqGkOgUlymNYwObzftVNqI2
         putw==
X-Gm-Message-State: APjAAAWp48tgfWk7AU95hWmV7fFARHDS9yXN8tPHkFVW2Yl3+cbE6gdX
        bQHx5VSwAD64AFLdMylfKE6R2utKc36tIA==
X-Google-Smtp-Source: APXvYqw+A86gSw0eXpH6TPWPX+nwB9UZumepWflTnGy9Caq7nvwTexwaFWB6psKr5iZPf99ERB43KA==
X-Received: by 2002:a81:7a01:: with SMTP id v1mr25301676ywc.25.1556069901239;
        Tue, 23 Apr 2019 18:38:21 -0700 (PDT)
Received: from localhost.localdomain (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id b131sm6629608ywb.103.2019.04.23.18.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 18:38:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] tools lib traceevent: Change tag string for error
Date:   Wed, 24 Apr 2019 09:38:02 +0800
Message-Id: <20190424013802.27569-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The traceevnt lib is used by perf tool, when execute 'perf test -v 6' it
outputs error log on ARM64 platform:

  running test 33 '*:*'trace-cmd: No such file or directory

  [...]

  trace-cmd: Invalid argument

The trace event parsing code originally came from trace-cmd so it keeps
the tag string "trace-cmd" for errors, this easily introduces the
impression that perf tool launches trace-cmd command for trace event
parsing, but in fact the related parsing is accomplished by traceevent
lib.

This patch changes the tag string to "libtraceevent" so can avoid
confusion and let users to be more easily to connect the error with
traceevent lib.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/traceevent/parse-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
index 77e4ec6402dd..e99867111387 100644
--- a/tools/lib/traceevent/parse-utils.c
+++ b/tools/lib/traceevent/parse-utils.c
@@ -14,7 +14,7 @@
 void __vwarning(const char *fmt, va_list ap)
 {
 	if (errno)
-		perror("trace-cmd");
+		perror("libtraceevent");
 	errno = 0;
 
 	fprintf(stderr, "  ");
-- 
2.17.1

