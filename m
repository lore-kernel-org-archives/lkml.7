Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C118ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564B82089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2DlWRdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfJKQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:38:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20714 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728463AbfJKQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570811909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3nslHDYKmfLHYdBDlpyt062nlj7ZyCRzMN4HOI+mqsM=;
        b=P2DlWRdboZVSWOqm5BDgvyQlXpTl6dr3RDARWwl/6LJQa5qRqMevyybcsjBeFzJ7sn9TS8
        VE/L/OCxT2ygL4V/rz410zAryuqhyPwMfeykJSIrK8jRXQT4Smh2K7eEYis6fPiRX0BWXJ
        ZUvOIGwONDKTQqw8Q4rI82T//VJj/nU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-JzU9i6wLNcSjixMk4k9wLA-1; Fri, 11 Oct 2019 12:38:28 -0400
Received: by mail-ed1-f70.google.com with SMTP id c23so6099219edb.14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QESqrn4NLBY+/uVxnw2MijgU+W7zIC6MI7jLwA7o+II=;
        b=hjk7kvbZYnn1dcc6PAl9+cT7hcTnqXZcvuIRPgtP00be8MLn9QqQv6FWeEl5pxcZsh
         xj82NazS8wyv9Zcsrl1WsHLoiJ4ToW4bPofvkWMU3ymGwkxF0oWOoZ/olNjjzkhKT5kj
         5rCt7HzgeuNMdN4irkVgXc7DMaVxkMHQe2D3jHhVbAHRWv+mRTEVvAFylKw9ExUH3cIl
         xcO+UN3DWUU1KPaKD6+NiUoLVA93NYo4OIO48ApGj6RPPu38sS/CX2lCW6lEUD0rzAnz
         3FoTT+KZfz85e5SkRwtE3q2QT1IZtTA5hJe1abVK6w5fA0fcYaGIhw8snfokBcGXtpr3
         M1kA==
X-Gm-Message-State: APjAAAXFMNdKSEMrdtbJmKXugVp+c5xqB543Y611cyQ8fJ12HbyjSWOY
        LkVVIsbmSpCdJg8PxosSHjGVBHLfQOF9F3o/oKvfl6qBGE5AegcvUlYXwW3S6C4GGxpaDz76G5r
        FltPJ0B8cX6bdgqqvOaLZawUr
X-Received: by 2002:aa7:c616:: with SMTP id h22mr14362304edq.296.1570811906390;
        Fri, 11 Oct 2019 09:38:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxSQkZlephre+VQXGuRd63krKX7AzetEj/Rb03PNhJ5jCyknYm/d9n1NLBt0KEv2clG2yF98w==
X-Received: by 2002:aa7:c616:: with SMTP id h22mr14362282edq.296.1570811906157;
        Fri, 11 Oct 2019 09:38:26 -0700 (PDT)
Received: from localhost ([2a02:2450:102e:d85:877d:43b4:dd8f:144d])
        by smtp.gmail.com with ESMTPSA id f21sm1542726edt.52.2019.10.11.09.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 09:38:24 -0700 (PDT)
From:   Christian Kellner <ckellner@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] pidfd: fix selftest compilation by removing linux/wait.h
Date:   Fri, 11 Oct 2019 18:38:11 +0200
Message-Id: <20191011163811.8607-1-ckellner@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: JzU9i6wLNcSjixMk4k9wLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Kellner <christian@kellner.me>

The pidfd_{open,poll}_test.c files both include `linux/wait.h` and
later `sys/wait.h`. The former has `#define P_ALL 0`, but in the
latter P_ALL is part of idtype_t enum, where it gets substituted
due to the aforementioned define to be `0`, which then results in
`typedef enum {0, ...`, which then results into a compiler error:
"error: expected identifier before numeric constant".
Since we need `sys/wait.h` for waitpid, drop `linux/wait.h`.

Signed-off-by: Christian Kellner <christian@kellner.me>
---
 tools/testing/selftests/pidfd/pidfd_open_test.c | 1 -
 tools/testing/selftests/pidfd/pidfd_poll_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testin=
g/selftests/pidfd/pidfd_open_test.c
index b9fe75fc3e51..8a59438ccc78 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -6,7 +6,6 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testin=
g/selftests/pidfd/pidfd_poll_test.c
index 4b115444dfe9..610811275357 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -3,7 +3,6 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 #include <poll.h>
 #include <signal.h>
 #include <stdbool.h>
--=20
2.21.0

