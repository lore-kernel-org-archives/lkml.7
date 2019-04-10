Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DA52075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="EWM/Yqux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDJT6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:58:43 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:33565 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDJT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:58:43 -0400
Received: by mail-it1-f173.google.com with SMTP id v8so397402itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yZi/Af6OZDxL/mXF+uG13Q8VSXN8P9aVbmp8Y9QYVo=;
        b=EWM/YquxLqjLbkD8tRMdUkqgf3R4nDCUoHidW8DaZoR193tRKnpLhhXwdlQvAwsFys
         SyRxqvEfQ7ENqUpay7Ogb1MpLzD8anCMXm0YKhiQ//wYjkfLcAUjNXLxC64w8rKsOR68
         t/5/vK7DALwr5XVYX2oLUEAndI8+Vfk8Hhdcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yZi/Af6OZDxL/mXF+uG13Q8VSXN8P9aVbmp8Y9QYVo=;
        b=Q0Y/wnX9O9KASvliizd41oboTXW9IQOgdNVYeZw3kf9uDzKYpXH0JO/PYR5lN6dOyf
         m1mCaQnAggVCSLQaqWu52J9dKD2nO6bOtHVAPYBuBLwUFvdRV2im4HKqQSmoQX0i1ukt
         yxL4n58dMF9emy/RuxRpx3AnORy/hmhwup0vtGtbxc3rnMu542acHRGh4GW2UYI2uuFA
         zHGY5cwlMV3YGaamlZqnxuPpxwpQJh+oM7dUOZj4QufEnhYlTUwx1IDcIsDuUCHSf8ZU
         +fZKShnNtcLHvD2u4nK9zPtn3h2p/iTn/55Wr/MqJv9n0c1vLAmuU5DTKaeXkm3xXrNa
         O5fQ==
X-Gm-Message-State: APjAAAXLO5I/ytkxfZrW4vlXLs5u+vkUkGa2QppTA5FdQpuTM4VEbZ/g
        Wwn6Blg8rpn73UKVxMhGT6TFqw==
X-Google-Smtp-Source: APXvYqw9iNINYueAmekOlc7M5cVeqD9Zq8DKF4ZKU6DOpFRnsS4IuuBNJ/iXb7useztGcyUEAq+v2g==
X-Received: by 2002:a05:660c:685:: with SMTP id n5mr4182395itk.57.1554926322296;
        Wed, 10 Apr 2019 12:58:42 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id 79sm1568293itw.18.2019.04.10.12.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:58:41 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
Cc:     Vineeth Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Subject: Re: [RFC][PATCH 13/16] sched: Add core wide task selection and scheduling.
Date:   Wed, 10 Apr 2019 19:58:18 +0000
Message-Id: <20190410195818.4774-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410080630.GY11158@hirez.programming.kicks-ass.net>
References: <20190410080630.GY11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <vpillai@digitalocean.com>

> Well, I was promised someome else was going to carry all this, also

We are interested in this feature and have been actively testing, benchmarking
and working on fixes. If there is no v2 effort currently in progress, we are
willing to help consolidate all the changes discussed here and prepare a v2.
If there are any pending changes in pipeline, please post your ideas so that
we could include it in v2.

We hope to post the v2 with all the changes here in a week’s time rebased on
the latest tip.

