Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33669C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C2C2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htiG74DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDCUIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:08:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54530 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDCUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:08:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so231104wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4+9EzKS2xxXNQGSpxxfbuRUr2AmzKqruYi2N7NneNlg=;
        b=htiG74DBFTQY6xPiUpUXKImSQaj+J+3IxROkQXvJ8WQRFwcE5GaAlruSXdzIWQI0Yg
         03awMUffq5Q2Zv7ty3QEfdVyywPtH+JbswLfTRmkQP4oZxpeE9O+Itdd8F7By036DT0W
         hmcTKPuO6Vns06csGjvJS2h+v6MCyqSgFcQ5rc2R9dJ94xc+ikyJe5KOVCJBEuvn5c/U
         npQsPRlUme4w1CVSkUOks4sAy+Zt3RbdaTDS5Cl6SS9XFk9nbRc7Ymg+pwRQe5zT+YaB
         yqLAssFQ8DuKLw30j2qIrvubc9icth79Oh//rdw9+OPLj3qJe5VStywmh/i3WXEurrWA
         hJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4+9EzKS2xxXNQGSpxxfbuRUr2AmzKqruYi2N7NneNlg=;
        b=MyG9io8UL1z2ZMOZ+MHlp4N/Icn0/Q84+BHozVR4vK3GPgKJuydyN7E1clLF8FMC+t
         irthgFjxnNidiWOn8Tkhuy/ytmTqiU+ucIPLCgAmmTuZ6zCx8s7sJTTJNL83wPInMUpL
         pbeThfGwUwOmtsyqsTXH/uDXwzKlfZLBkRRVNWIHdfVSYA6nhxA50vArxyYYa8nJpyiH
         6lioJxpYxmGuLodIxe3lKDP3aSIi63jrESba4TjMN9R5UqFIsRWeOLwGemyzkhOH1ZEy
         RS6/bGUtUc3QrzK/hvU3XejtMhy/rTcVoGEvPuAx+0UYhCOAn4ylz5VJU6Qe8KbdJHys
         AnKg==
X-Gm-Message-State: APjAAAWyN6Ty6c9lKT/WzKuZNnTQkQm89T+E+7qwcDaBXAE+nf69r+b7
        lhDFzJ+k4hUm6KVIMNmilA==
X-Google-Smtp-Source: APXvYqxt6h23Q+HgG8D4Cv7wjhbZtoPTg1+Mex45zc+1TnfuhlqMQYBv76XMN9mBwtw6Z2GkcEc2bA==
X-Received: by 2002:a1c:14:: with SMTP id 20mr1194206wma.66.1554322092874;
        Wed, 03 Apr 2019 13:08:12 -0700 (PDT)
Received: from avx2 ([46.53.245.231])
        by smtp.gmail.com with ESMTPSA id 7sm60007196wrc.81.2019.04.03.13.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:08:11 -0700 (PDT)
Date:   Wed, 3 Apr 2019 23:08:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: expand sched_getaffinity(2) to return number of
 CPUs
Message-ID: <20190403200809.GA13876@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no easy way to get the number of CPUs on the system.
Applications are divided into 2 groups:
One group allocates buffer and call sched_getaffinity(2) once. It works
but either underallocate or overallocates and in the future such application
will become buggy as Linux will start working on even more SMP-ier systems.

Glibc in particular shipped with 1024 CPUs support maximum at some point
which is quite surprising as glibc maitainers should know better.

Another group dynamically grow buffer until cpumask fits. This is
inefficient as multiple system calls are done.

Nobody seems to parse "/sys/devices/system/cpu/possible".
Even if someone does, parsing sysfs is much slower than necessary.

Patch overloads sched_getaffinity(len=0) to simply return "nr_cpu_ids".
This will make gettting CPU mask require at most 2 system calls
and will eliminate unnecessary code.

len=0 is chosen so that
* passing zeroes is the simplest thing

	syscall(__NR_sched_getaffinity, 0, 0, NULL)

  will simply do the right thing,

* old kernels returned -EINVAL unconditionally.

Note: glibc segfaults upon exiting from system call because it tries to
clear the rest of the buffer if return value is positive, so
applications will have to use syscall(3).
Good news is that it proves noone uses sched_getaffinity(pid, 0, NULL).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/sched/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4942,6 +4942,9 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	int ret;
 	cpumask_var_t mask;
 
+	if (len == 0)
+		return nr_cpu_ids;
+
 	if ((len * BITS_PER_BYTE) < nr_cpu_ids)
 		return -EINVAL;
 	if (len & (sizeof(unsigned long)-1))
