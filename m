Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BCCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8027206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkPO2QT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbfDRTjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:39:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44800 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:39:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so2855984ljg.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2AdhvgM7Cxux2pBCdTUM20R8bROhTNP+rJNXCIVVoc=;
        b=QkPO2QT9yV6+PYYK1+V0TkkxwDuYMSc78hp8tRl4Qou9en4Z++KTveqgv9beyIsSxT
         DDUx502Ig4WIJ7odnDPlDkoLwnCtF/D+6W2ssbwoCgjyHcrLuTPXZxaJB/NgxSOii68Q
         faxnbh9VZ1+6zOt3xKwfh8USimkX1oR3tf2pzLe6sRRXZapFXog8l+uBncMuiDzbJuSP
         0jMsZ/yuND0ssCZRGgIAWmclnz12WiDG2VRiSA8ysDkNQ/LQYxNRIScUQTZB5VHsDsPf
         D4x/6OotalhDuoo14ZYSPzAdOF6UfiaT+9/C4MRmzYoL0iGY6sWF6257CNPXGiQXcu/x
         qE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2AdhvgM7Cxux2pBCdTUM20R8bROhTNP+rJNXCIVVoc=;
        b=Qxqv3wKnaik+r5zBbLFR42l3HS+4l6UrnYLmNQ67ABXYtI25ddSlqBWmuHDY+JDhhF
         7DYoRSINuPYeqIcV5SCyXJ+atSiJ527OChISzHp7XN6Czp6E0f8+eD9H0x7nlTMB35+D
         BoyMOmSZa5lUeT2RPqKIcbnNizHbAYkYyXBROX+iXZOYPiK2QBQhxkNqPGA4ITmfGENx
         lGIeHmM6Jt0YqN2kSIAgK808GHg+6u2OT5g/HfAR06BkYBa9CghFOOKuWWJu2Xpf8NjM
         efVO4AM44rusbJhFHlKbkUpFnLR2fJMLaxr+YnngwixbIXzXKSDDpCR9FWtrnrPFMJ9M
         9j+g==
X-Gm-Message-State: APjAAAWEolxJVGV+ME46+jnJd4qqBWanw9jP0W6bHi0fKk8EZznuLNuN
        ZCxkiU1/RlYv3Xrj7XJfrSU=
X-Google-Smtp-Source: APXvYqzncSGqXZp5lZyJcsGLt28Vjrr7iR4OBc2rYAZnGHU+IO4rMUXrUfPby7tHldovJf4L//mflw==
X-Received: by 2002:a2e:4a09:: with SMTP id x9mr8523433lja.19.1555616374123;
        Thu, 18 Apr 2019 12:39:34 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w2sm672898lfa.63.2019.04.18.12.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:39:33 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/1] lib/test_vmalloc: do not create cpumask_t variable on stack
Date:   Thu, 18 Apr 2019 21:39:25 +0200
Message-Id: <20190418193925.9361-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On my "Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz" system(12 CPUs)
i get the warning from the compiler about frame size:

<snip>
warning: the frame size of 1096 bytes is larger than 1024 bytes
[-Wframe-larger-than=]
<snip>

the size of cpumask_t depends on number of CPUs, therefore just
make use of cpumask_of() in set_cpus_allowed_ptr() as a second
argument.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 83cdcaa82bf6..f832b095afba 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -383,14 +383,14 @@ static void shuffle_array(int *arr, int n)
 static int test_func(void *private)
 {
 	struct test_driver *t = private;
-	cpumask_t newmask = CPU_MASK_NONE;
 	int random_array[ARRAY_SIZE(test_case_array)];
 	int index, i, j, ret;
 	ktime_t kt;
 	u64 delta;
 
-	cpumask_set_cpu(t->cpu, &newmask);
-	set_cpus_allowed_ptr(current, &newmask);
+	ret = set_cpus_allowed_ptr(current, cpumask_of(t->cpu));
+	if (ret < 0)
+		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
 
 	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
 		random_array[i] = i;
-- 
2.11.0

