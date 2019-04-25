Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD891C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BB20651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fIP32FBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfDYQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41431 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfDYQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so380959edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9aEqxxA2yxNvPNjH/wJr5hyMizRvWrXw2kpFujI3pI4=;
        b=fIP32FBxvTC/OIjPFPvlCUomADxpXQd+vcMzIjJ+UfBSmFiht81v2iBcoMoAYYFRMI
         SrLPad7VqDnZ+qQCrkX/yAbkIF8HYqIsiOf8CqJaoWYpfs6xGP9uJKLIIy4oHKKAX4rD
         tb2BqY8pT/SgNwmfBiW2qV9pen0apoG31ceKsxXXcvCCxtQcQPpolaJOaog96iAhjBw6
         ZJaq2xarCCb+k4IU2YsGjQEhCrvwOt4NSNbXnvSAoCPOQVmbjBwfo+E1vkBSQdNM9nP2
         nB1uMwubxQ5vijGuYBe13CwPdKQwzLXmwJmY2asn671EhHLcDg6xGDn04Wi63uOqybDD
         4+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9aEqxxA2yxNvPNjH/wJr5hyMizRvWrXw2kpFujI3pI4=;
        b=qdrRqbysY6VMEpwLecg8fLAn14gPZNVOBuBObq0PwABX7VH4v2psMpKJwcFGmQGR17
         CRv1JFJOvsSMy5aOJ3xr0qe8cfrlpMUfwilFz85nqaKhyjwZNNNSRxvU21CDuHnxOaTg
         ayuxKJYjIPm9aF5HN9jS5Q8UAfcztZDafAX3SdkEnqA5tcIEvAM6lp4qgfRY8kVM/UxX
         mrcYh+Rutes3O9IQqUmpV4PHq65cvxAcvgBJd7hoGqbXZ6vmpN/LlRjMLKDb0q0BeMud
         v/z2RdnT8upYSvPuGyj8hy/1+o4owASM9uQ+UaPXAxSkp1qO4pFYgKKKSO/iFznFTm4D
         qtKg==
X-Gm-Message-State: APjAAAWlgSWZqF4wv0ei2EfPnwmXO1L9emnms7i8EJIv7Bvfzf3VcJiM
        k8F5ulxv+ncjOoHuQKxCSb1nXAo91Ts=
X-Google-Smtp-Source: APXvYqzRtJf+qoh3NFgoHphTzsAJB6ixdFyjjXuN+RWt/+n9daYJ+R8xdoTDAIBqfNVWIPEBAkheXw==
X-Received: by 2002:a17:906:9a9:: with SMTP id q9mr12612166eje.171.1556208867967;
        Thu, 25 Apr 2019 09:14:27 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:27 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 06/27] posix-timers/timens: Take into account clock offsets
Date:   Thu, 25 Apr 2019 17:13:55 +0100
Message-Id: <20190425161416.26600-7-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   | 3 +++
 kernel/time/posix-timers.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 31f99361342e..23f5c39c8d23 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
@@ -621,6 +622,8 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 
 	if (!absolute)
 		expires = ktime_add_safe(expires, base->gettime());
+	else
+		expires = timens_ktime_to_host(base->base_clockid, expires);
 	if (sigev_none)
 		alarm->node.expires = expires;
 	else
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index a723e63d55fd..7922731f98cd 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -803,6 +803,8 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 
 	if (!absolute)
 		expires = ktime_add_safe(expires, timer->base->get_time());
+	else
+		expires = timens_ktime_to_host(timer->base->clockid, expires);
 	hrtimer_set_expires(timer, expires);
 
 	if (!sigev_none)
-- 
2.21.0

