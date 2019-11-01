Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92909CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BB208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/NqR3xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfKACIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:08:07 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39731 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKACIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:08:07 -0400
Received: by mail-yw1-f65.google.com with SMTP id k127so2971372ywc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=A/ta4o63hQ96fBCgzb5RGLjMhlxTMZ+PcK5dvaw+Anc=;
        b=C/NqR3xxIKG4023ZzRSgbk9XuoVpmk3xyEfEYwHqucSMXZYPUKg00oCcEmNmSjoPdq
         m6MafLbKbrsEgumWyIYlHPe99C9Hz4w//Rj9WvnYYpaDmEjfeCw2EeTkZPYvKZq5HyoF
         gHGgl6NLx+bfgPniQGFNrqJtrKZIqzNq4TQfRrf6OvSFO6d8io5xr/dUcjz38TfDWYqE
         deP9D6rYbVTI7ueuTY2YUeoHJe1++HLc/NMt9EF/YyBG5leyN4w6gL4PMVErIXo/OxJZ
         7gRDQNMnBDE2UsqBvZ1y5yY6WeP4514WIK9HOADV1vw9P9IE3XY7fqZYE9TlDcSmLe8d
         YN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A/ta4o63hQ96fBCgzb5RGLjMhlxTMZ+PcK5dvaw+Anc=;
        b=YigHe1+w86ZFUQzZMPmLm6GkJJYEr8Ama2NudYdAhciXMnnBNpEOx04H2ar8gAw3v9
         xSIEOW4IcbS0JWMw+fhHkNkLwobR12NY63wSxuAinWlcpn4FjdEMdzDfioyN7RVcmxpU
         ALE+V17fGzyibMFeBG0Cj3YlyK0xJbhL1Dr8IZUhcjryEJZ9ATRi9xzYhK/ei5n6Z8QC
         OCe3w0/ZDhfjQhEg/iv8MXv8eYY3CN+s0kfuzemnrAdQLCUr1k3ZYjEoLEZcJk+j6Ewa
         1UwbRsgZvAMYKz20066QT2+uSyQ/2M7Iaco4ZBozWAMVs11892/1bEt4VnVMYVGHv2Xf
         s8BQ==
X-Gm-Message-State: APjAAAX5YKgl1RUuHfdE9Tt5nxyUAJH65A7U4eglKgq5VKIePqzEl5PG
        JszDKLgLZayFJ2BhWXpmGwxZTg==
X-Google-Smtp-Source: APXvYqyxpCWVDWsP19hRctcE2z7o5p5vtcKC3m638NJPhzYms8Uqdwj7fvtQQudg7Ye0vVxrqI3+2A==
X-Received: by 2002:a81:5b46:: with SMTP id p67mr6513588ywb.228.1572574084527;
        Thu, 31 Oct 2019 19:08:04 -0700 (PDT)
Received: from localhost.localdomain (li1038-30.members.linode.com. [45.33.96.30])
        by smtp.gmail.com with ESMTPSA id m5sm3762076ywj.27.2019.10.31.19.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:08:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf cs-etm: Fix synthesizing instruction samples
Date:   Fri,  1 Nov 2019 10:07:46 +0800
Message-Id: <20191101020750.29063-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to address the issue for synthesizing instruction
samples, especially when the instruction sample period is small enough,
the current logic cannot synthesize multiple instruction samples within
one instruction range packet.

To fix this issue, patch 0001 avoids to reset the last branches for
every instruction sample; if reset the last branches when every time
generate instruction sample, then the later samples in the same range
packet cannot use the last branches anymore.

Patch 0002 is the main patch to fix the logic for synthesizing
instruction samples; it allows to handle different instruction periods.

Patch 0003 is an optimization for copying last branches; it only copies
last branches once if the instruction samples share the same last
branches.

Patch 0004 is a minor fix for unsigned variable comparison to zero.

To verify my changing for synthesizing instruction samples, I added
some logs in the code, and reviewed the output log manually for
instuctions samples.  The below commands are tested on DB410c board:

  # perf script --itrace=i2
  # perf script --itrace=i2il16
  # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
  # perf inject --itrace=i100il16 -i perf.data -o perf.data.new


Changes from v1:
* Rebased patch set on perf/core branch with latest commit 9fec3cd5fa4a
  ("perf map: Check if the map still has some refcounts on exit").


Leo Yan (4):
  perf cs-etm: Continuously record last branches
  perf cs-etm: Correct synthesizing instruction samples
  perf cs-etm: Optimize copying last branches
  perf cs-etm: Fix unsigned variable comparison to zero

 tools/perf/util/cs-etm.c | 137 ++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 22 deletions(-)

-- 
2.17.1

