Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054172082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4eMVd1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfEOIk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:40:57 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:38785 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:40:56 -0400
Received: by mail-lf1-f41.google.com with SMTP id y19so1334391lfy.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PqVaSFiBytC8hxBsEh/HgINdW7HiuF2nkdZ+Xr3sRJM=;
        b=c4eMVd1cLxlB6SJBmNhemOrHGlx22bRWlhjGFOgNaLhbLW2OsPnJ6q7IN/0qHO2SJT
         44NH8SW7Cz7C3NbkZ6LUVyuc+HzNnulv1amtnBP+4BzX65YCeVqIiFPthbsIvGNRastI
         FbjiJSRIsNnOy55OzOM24lwDTwQ8e3guvD/twvzX8/U23YRpw/0O0FdUM5g8ol8rvtGT
         3HQfxeXNsLpmFjaOI0s2beybpvYsZWr56AL1iTqZnKWFCOtzAIRlXYsgw/i9aL/6NEPD
         g7GWfCO0vCdWKEMkUAxLxifdzh0t3jxTgaNvygX4vDQBbW/QJM0RreiOZzIYruK6B9fL
         hGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PqVaSFiBytC8hxBsEh/HgINdW7HiuF2nkdZ+Xr3sRJM=;
        b=PkKjxky2OoT0OMedOoCH/OCgwpM6b3zSjThO3d+2NeFmRNHcPXduacl4GSz12gNkWg
         eYHeY4TMOD9KhAHJ9VLx7FU7SYGxZhCyhWzWrYYglXurRHAAT0o7X4Ngf8OpsQGNH/Tt
         LjNO4i/8fbUHsrsDvLNou5OKkN1vO9eo1507v1DMsrROD5JEXiQKoY++Z93WzWe0GS5/
         /rUOZ1feMkZQcnoeDKGJUIhLGTBSec+/z4cL42WonXcGOdjcpp/Gm5nOeu4L4X4EHhA8
         ovjIGngBCYEPy71ZpYoXqtTu4wTiUPN7gbFldVXPAx1d/xkcR98Z0YIVHw9yuFwmxIc4
         N+KQ==
X-Gm-Message-State: APjAAAVM5XBtPPOzvLcL3isMP0oslSEiWv8lb8tWZ2OIuJQNeiBVut78
        w6Q9WlNSgKnYgtoN6P9z4S0hJzr49cGmpg7BuMLWpg==
X-Google-Smtp-Source: APXvYqz27fihyYyeqJzcm9uZcyrM35iaJPBOLqtP38PCvZvb3HdahvBJTwe31L0dHMb3DcwxQ1okZ20YuVymiVG6A6k=
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr16922584lfa.137.1557909654616;
 Wed, 15 May 2019 01:40:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 May 2019 14:10:43 +0530
Message-ID: <CA+G9fYu254sYc77jOVifOmxrd_jNmr4wNHTrqnW54a8F=EQZ6Q@mail.gmail.com>
Subject: LTP: mm: overcommit_memory01, 03...06 failed
To:     ltp@lists.linux.it, linux-mm@kvack.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>,
        lkft-triage@lists.linaro.org, dengke.du@windriver.com,
        petr.vorel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltp-mm-tests failed on Linux mainline kernel  5.1.0,
  * overcommit_memory01 overcommit_memory
  * overcommit_memory03 overcommit_memory -R 30
  * overcommit_memory04 overcommit_memory -R 80
  * overcommit_memory05 overcommit_memory -R 100
  * overcommit_memory06 overcommit_memory -R 200

mem.c:814: INFO: set overcommit_memory to 0
overcommit_memory.c:185: INFO: malloc 8094844 kB successfully
overcommit_memory.c:204: PASS: alloc passed as expected
overcommit_memory.c:189: INFO: malloc 32379376 kB failed
overcommit_memory.c:210: PASS: alloc failed as expected
overcommit_memory.c:185: INFO: malloc 16360216 kB successfully
overcommit_memory.c:212: FAIL: alloc passed, expected to fail

Failed test log,
https://lkft.validation.linaro.org/scheduler/job/726417#L22852

LTP version 20190115

Test case link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/tunable/overcommit_memory.c#L212

First bad commit:
git branch master
git commit e0654264c4806dc436b291294a0fbf9be7571ab6
git describe v5.1-10706-ge0654264c480
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Last good commit:
git branch master
git commit 7e9890a3500d95c01511a4c45b7e7192dfa47ae2
git describe v5.1-10326-g7e9890a3500d
git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Best regards
Naresh Kamboju
