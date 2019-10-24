Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8677D2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kz5po7s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409634AbfJXPPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:15:01 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46595 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409599AbfJXPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:15:01 -0400
Received: by mail-qt1-f173.google.com with SMTP id u22so38329569qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4Q6XHErtHhX+1mLaNoKaQj0VUhUfS1Bgbues0FuRIG4=;
        b=kz5po7s2ieKJl5ZCmOJw+6B8XVBPG87kZe4L62Qmh3UejutibGAXbPI4Hp4WYv4UC0
         gp1fXCxov4xDtKUqySwOynQjxJJ3vB2B6ABcR8Grzs18UzlgJMUyNgcVciyDH61P61qv
         hzwCeYTDpP589ZJRK++UiPeWEhzi9Ai1DxYEa4dMr9R4F2bnhGT+B0g4Rup9Wv3S/bBx
         sqGHcDczx46vWpoym700/p+r/NIzk2LjpjM9pt2HxiT8xnv6tqt+GQiGYHC/EMC24MsL
         5Yk9g+mVXWxN4M5xH8qwBKOuRRsJnuWx3tvpBRXe9NA+ZTsHVnQMEvQ26K0ZT+eVAJQK
         z9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Q6XHErtHhX+1mLaNoKaQj0VUhUfS1Bgbues0FuRIG4=;
        b=Xojfd6dFXQVw/S4nnbCKoY/V3wyogN7mFINyWkuxJ/7at1Nhci304TnahBkO3Ut7kv
         BITcsSa4lKb5YxQ1OsEJcVictpgBDt6c35xowuN5CKzPbFufkNJuP6kNG8HkQXm3ZZ0N
         Tfv8wpxBCjL/Jys906P9SgGSRhW+PzhsBqiJgA1Vkzt3szECUOoOjEpUofQkUl/L02Mz
         92tHPucqwdvxf4sytHLRqMcWLQrIUk7CzZPuzzUBzAaAl6v2sqjah+CiwIoUAWQLG1xt
         +L6mR7JFl6lju+oCpBmlUkUjbVCKm+3CNQf9uwYNCUh1EV5kV+w1Z3oHCykvQMU0/U2C
         g58g==
X-Gm-Message-State: APjAAAWx7Caj0BLjPPxgoe0Dn0sMHIirCIYPIPkbSY09ma0IKZMQreK4
        VXabFCf/w2tLZ5lLNBSzG5S6kw==
X-Google-Smtp-Source: APXvYqzV0S7dhVglLcNnMBPInsuMT4jIEBLgjOQjZvJGdNbcB2ev6s8rgp8oslwlCaUx3gfw1TschA==
X-Received: by 2002:ac8:290f:: with SMTP id y15mr4748046qty.181.1571930098546;
        Thu, 24 Oct 2019 08:14:58 -0700 (PDT)
Received: from localhost.localdomain (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id l5sm4346073qtj.52.2019.10.24.08.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:14:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Robert Walker <robert.walker@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] perf cs-etm: Fix synthesizing instruction samples
Date:   Thu, 24 Oct 2019 23:13:21 +0800
Message-Id: <20191024151325.28623-1-leo.yan@linaro.org>
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
  # perf script --itrace=i2li16
  # perf inject --itrace=i2il16 -i perf.data -o perf.data.new
  # perf inject --itrace=i100il16 -i perf.data -o perf.data.new


Leo Yan (4):
  perf cs-etm: Continuously record last branches
  perf cs-etm: Correct synthesizing instruction samples
  perf cs-etm: Optimize copying last branches
  perf cs-etm: Fix unsigned variable comparison to zero

 tools/perf/util/cs-etm.c | 137 ++++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 22 deletions(-)

-- 
2.17.1

