Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D7FC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B081C21019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVJUzQ++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGLI0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:26:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:26:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so8035748wmj.5;
        Fri, 12 Jul 2019 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwx+cMEft2PFGPMJbRtKXHY4DXSVCtrKSWASe73jxoo=;
        b=nVJUzQ++TuIzNhHp2sLYUw+zqkM3/biyEDtZX9BKVXF0l4Ffui6czFlx1A9+iplc6v
         bJqPgT+HN8a8iQd45BcMBOc/w4x6fI3jFtJU08ju5klNtT5/fx6RzYVJcKObOQROt2CY
         4rXV8WotMfMRl/lpDVaE25rUZpMAd7e84foZioSpJa31el9luJi8wa2eIFq3/sythWVo
         GJS49jhEQ0HNUgEFijbsJlHIi5HEzj0ujXlP6NZqo3YFaAA7n0n0fcYRjePAo7keVdcz
         ER9gOS00DhYXHSPxx2xK1GLlULt8lj2FZiW8pjaimykyLb5KY5UM/jtEet0V8wsO1+TH
         7/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwx+cMEft2PFGPMJbRtKXHY4DXSVCtrKSWASe73jxoo=;
        b=aOv8IH2DpVe+FVJ9ekHSUPBxq/4o7rSrWyBYlEWjqbVaYh9C+hDf9MdaOsJZZ8OlHh
         mTfzg96OFCN1pcsdlOhifSFcuJr7F2vwwDx7u+TG205kLWOQOosyp6hRNFwBBwlE1seo
         l1pXdeqDSlUkctLcsEGV8mBlD0WVORenZbuQKxr7b+QX8wQrBzzUiE/DDQcqGdrKPWUp
         LNqiD0OgGZcnbhXisKJZJPuUiN+xMVmQd1rlJWi+YYZUxJnS1GO95SXCXSbisUAHuEud
         a3CJyR4/TxM1dnIH/wZywpGntVJ9qFYR2S1nXOurRdz/cj5HSY6HP0OMVldKk99M8Qx2
         n9lA==
X-Gm-Message-State: APjAAAW/M/WDvbowxSf3w21ENmv6MpKvfn3GmipxcpZ5F9wlBsaxjGO/
        OgeMYN8dbWIrIWS+JxwYfrIRGxc7
X-Google-Smtp-Source: APXvYqxNNdMGqOcPkE4ucROjcMN7gUWGanh74tXauE+2XgwZlZ1GZECA30YxeDpH3LaO+lBgrvVrJA==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr8078395wmk.36.1562919991584;
        Fri, 12 Jul 2019 01:26:31 -0700 (PDT)
Received: from alan-laptop.carrier.duckdns.org (host-89-243-246-11.as13285.net. [89.243.246.11])
        by smtp.gmail.com with ESMTPSA id o11sm7305548wmh.37.2019.07.12.01.26.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:26:30 -0700 (PDT)
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
To:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH] Documentation: proc.txt: emphasize that iowait cannot be relied on
Date:   Fri, 12 Jul 2019 09:22:09 +0100
Message-Id: <20190712082209.16073-1-alan.christopher.jenkins@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU "iowait" time in /proc/stat does not work on my laptop.

I saw the documentation mention several problems with "iowait".  However
each problem appeared to be qualified.  It gave me the impression I could
probably account for each problem.  My impression was wrong.

There are a couple of writeups explaining the specific problem I had.[1][2]

[1] "[RFC PATCH 0/8] rework iowait accounting", 2014-06-26:
    https://lore.kernel.org/lkml/53ABE28F.6010402@jp.fujitsu.com/

[2] A recent writeup by myself:
    https://unix.stackexchange.com/questions/517757/my-basic-assumption-about-system-iowait-does-not-hold/527836#527836

This might just be me.  Partly, my small knowledge about the scheduler
allowed for false assumptions.  But I think we can emphasize more strongly
how broken iowait is on SMP.  Overall, I aim to make it sound much scarier
to analyze iowait.  I add some precise details, and also some
anxiety-inducing vagueness :-).

[Detailed reasons for the specific points I included:]

1. Let us say that "iowait _can_ be massively under-accounted".  It is
likely to remain true in future.  At least since v4.16, the
under-accounting problem seems very exposed on non-virtual, multi-CPU
systems.  In theory the wheel might turn again; this exposure might be
reduced in future.  But even on v4.15, I can reproduce the problem using
CPU affinity.

2. Point to NO_HZ_IDLE, as a good hint towards i) the nature of the problem
and ii) and how widespread it is.  To give a more comprehensive picture,
also point to NO_HZ_FULL and VIRT_CPU_ACCOUNTING_NATIVE.

Setting down my exact scenario would require a lot of specifics.  That
would be going beyond the point.  We could link to one of the writeups as
well, but I don't think we need to.

3. My own "use case" did not expose the problem when I ran it on a virtual
machine.  Even using my CPU affinity method.[2]  I haven't tracked down
why.  This is a significant qualification to point 1.  Explicitly
acknowledge this.  It's a pain, but it makes the main point easier to
verify, and hence more credible.

(I suspect this is common at least to small test VMs.  It appears true
for both a Fedora 30 VM (5.1.x) and a Debian 9 VM (4.9.x).  I also tried
some different storage options, virtio-blk v.s. virtio-scsi v.s. isilogic.)

[:end of details]

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 Documentation/filesystems/proc.txt | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..f1da71cd276e 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -1348,16 +1348,23 @@ second).  The meanings of the columns are as follows, from left to right:
 - nice: niced processes executing in user mode
 - system: processes executing in kernel mode
 - idle: twiddling thumbs
-- iowait: In a word, iowait stands for waiting for I/O to complete. But there
-  are several problems:
-  1. Cpu will not wait for I/O to complete, iowait is the time that a task is
-     waiting for I/O to complete. When cpu goes into idle state for
-     outstanding task io, another task will be scheduled on this CPU.
-  2. In a multi-core CPU, the task waiting for I/O to complete is not running
-     on any CPU, so the iowait of each CPU is difficult to calculate.
-  3. The value of iowait field in /proc/stat will decrease in certain
+- iowait: In a word, iowait stands for waiting for I/O to complete.  This
+  number is not reliable.  The problems include:
+  1. A CPU does not wait for I/O to complete; iowait is the time that a task
+     is waiting for I/O to complete.  When a CPU goes into idle state for
+     outstanding task I/O, another task will be scheduled on this CPU.
+  2. iowait was extended to support systems with multiple CPUs. But the
+     extended version is misleading.  Consider a two-CPU system, where you see
+     50% iowait.  This could represent two tasks that could use 100% of both
+     CPUs, if they were not waiting for I/O.
+  3. iowait can be massively under-accounted on modern kernels.  The iowait
+     code does not account for the behaviour of NO_HZ_IDLE, NO_HZ_FULL, or
+     VIRT_CPU_ACCOUNTING_NATIVE on multi-CPU systems.  The amount of
+     under-accounting varies depending on the exact system configuration and
+     kernel version.  The effects might be less obvious when running in a
+     virtual machine.
+  4. The value of iowait field in /proc/stat will decrease in certain
      conditions.
-  So, the iowait is not reliable by reading from /proc/stat.
 - irq: servicing interrupts
 - softirq: servicing softirqs
 - steal: involuntary wait
-- 
2.21.0

