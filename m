Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74335C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EE32083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfHNOXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:23:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40374 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfHNOXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:23:09 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <halves@canonical.com>)
        id 1hxuB9-0000Zd-In
        for linux-kernel@vger.kernel.org; Wed, 14 Aug 2019 14:23:07 +0000
Received: by mail-qt1-f199.google.com with SMTP id c14so10049329qtn.17
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyNOdgzrf0nEwWLN0ipEiO26i5YRDnxup2Cu8HuBZzY=;
        b=Wky/Vjt3afd31T38l9FRrZn4VRf5Kr+BLUQeRKEmSWiGGFovhqwBRQT2O7VPwqZmkJ
         O15JnHP7oU1aiBIR8Q6F0ZfHmmRS/36LKWNz47jLWorfocLGOO/kijaSTcpNb95YE+he
         Vm6+vtAkLHdsmSBrqgLU4Q0Wgsz09igA/wf4/e7s8zbkVULgD9SmXgxPzcald8y0QpC1
         yYl58WqF8bIvybrIvonjbSG5uxwy9pJW9LLDUa4Jck0juU6RFas7YD3dSuDzjlfae2wr
         7tLwKO205fl//3/G8KrG/FxUmkSEuvr6Bt0xk3arHt+gQWI7C0650G0ZlVPlk34svwcT
         ylWA==
X-Gm-Message-State: APjAAAVg9tBZTdvXrxvxSt5cCtYRjTyh8Aehde4/g5pkoqE9SCj21r9+
        PYJCfuNj9oEH5TwwtOxsSorkAYwgFfcaX6agD4O4jB2Ck1ZBnOLibxg3tijiViDD5SDJfeJLqzR
        V77hWo0dV7/0Cq/JHwh9ZNy3BpCFhsg9goBu6k1caow==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr18216790qke.110.1565792586775;
        Wed, 14 Aug 2019 07:23:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysQsjgJidhgsWx6K4OuqZYtSPysL0lhrpjw0CC5EWcGKlyOF9ztg1knSVFzSWIoV4eaLGtaQ==
X-Received: by 2002:a37:9b82:: with SMTP id d124mr18216773qke.110.1565792586594;
        Wed, 14 Aug 2019 07:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e3:83c1:584b:6fd:30f2:e7ed])
        by smtp.gmail.com with ESMTPSA id x26sm7928348qkn.116.2019.08.14.07.23.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:23:05 -0700 (PDT)
From:   Heitor Alves de Siqueira <halves@canonical.com>
To:     colyli@suse.de
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, shile.zhang@linux.alibaba.com,
        vojtech@suse.com
Subject: Re: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
Date:   Wed, 14 Aug 2019 11:23:01 -0300
Message-Id: <20190814142301.32556-1-halves@canonical.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <c13b1d2a-a8e6-f20c-604e-a375c018bf66@suse.de>
References: <c13b1d2a-a8e6-f20c-604e-a375c018bf66@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coly,

We've had users impacted by system stalls and were able to trace it back to the
bcache priority_stats query. After investigating a bit further, it seems that
the sorting step in the quantiles calculation can cause heavy CPU
contention. This has a severe performance impact on any task that is running in
the same CPU as the sysfs query, and caused issues even for non-bcache
workloads.

We did some test runs with fio to get a better picture of the impact on
read/write workloads while a priority_stats query is running, and came up with
some interesting results. The bucket locking doesn't seem to have that
much performance impact even in full-write workloads, but the 'sort' can affect
bcache device throughput and latency pretty heavily (and any other tasks that
are "unlucky" to be scheduled together with it). In some of our tests, there was
a performance reduction of almost 90% in random read IOPS to the bcache device
(refer to the comparison graph at [0]). There's a few more details on the
Launchpad bug [1] we've created to track this, together with the complete fio
results + comparison graphs.

The cond_resched() patch suggested by Shile Zhang actually improved performance
a lot, and eliminated the stalls we've observed during the priority_stats
query. Even though it may cause the sysfs query to take a bit longer, it seems
like a decent tradeoff for general performance when running that query on a
system under heavy load. It's also a cheap short-term solution until we can look
into a more complex re-write of the priority_stats calculation (perhaps one that
doesn't require the locking?). Could we revisit Shile's patch, and consider
merging it?

Thanks!
Heitor

[0] https://people.canonical.com/~halves/priority_stats/read/4k-iops-2Dsmooth.png
[1] https://bugs.launchpad.net/bugs/1840043
