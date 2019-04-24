Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673222089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="XbQKZGHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfDXLTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:19:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54446 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:19:33 -0400
Received: by mail-it1-f194.google.com with SMTP id a190so5596972ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=89e+dSKzA5afsooadXFqIW/dhRPfNS/VO9cxUzIYJzA=;
        b=XbQKZGHeg3iLzUZ0V+4n6tNPHiHq1l7B8g05mD4Jgmgky8oRQ/hrTEvVZMrnxcS876
         I6+4dsE34yBbDaZkExOPOX5ZTUGp2gxfGI12SYG9trTBzulifeNge8zoLtDE+ok60pFB
         G5/VYKZ0ETiuf76ntTsPaMdPYSAFvNFvz4nzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=89e+dSKzA5afsooadXFqIW/dhRPfNS/VO9cxUzIYJzA=;
        b=oDmQ2pfjcsJwLSjL9uR3RnPuGRagEGS09/k/BWJ5QzJbhVR75KPmSEiTvK5pYcmRu6
         ytEKceVNqlVxUnusZIwHy81mMgtTFCTsZoWG/5TxNYjT7kmVZLn8KWNhmElB0YrLQOdV
         PRMFTR/GkMpXmt1W5sjLc13lb4vmlQ2EqzC4aBJyT6BfPMFBBUEAKtT39J36dnve3pkI
         INYduxIuEbRUnPC8yK8oFaLSwxdd0r/m/4QTU1QDrZfJVduye19UA6hqyAskya1Y0h/j
         VPcJXeSj4SYVxq07WSWqtodbQkbro7mQW04zK4kfojBsippHpgSE7yQEtVWNPWgeSjFt
         JBuA==
X-Gm-Message-State: APjAAAXIHdTJWyz2fRFa2d/ALmNgr4ZbyASS9rHGIZnWl9Is/7rnlWiT
        LKp1q9GReEal5etbECsWZQezSw==
X-Google-Smtp-Source: APXvYqyeHKUZYfXK7lKk+BMUdr9nnjSAKhLSAmdvV4MYlklw8LFKnv5S0oXqJwnuVYz4vJDH5z8VpA==
X-Received: by 2002:a24:7688:: with SMTP id z130mr5962841itb.57.1556104772835;
        Wed, 24 Apr 2019 04:19:32 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id r21sm8889191itb.35.2019.04.24.04.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 04:19:32 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Date:   Wed, 24 Apr 2019 11:19:13 +0000
Message-Id: <20190424111913.1386-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAERHkrtcW8L0duMTzkt-eDnesiG6sEO=zfswZcoM+n3TMxrG_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this one missed? Or fixed with a better impl?
>
> The boot up CPUs don't match the possible cpu map, so the not onlined
> CPU rq->core are not initialized, which causes NULL pointer dereference
> panic in online_fair_sched_group():
>
Thanks for pointing this out. I think the ideal fix would be to
correctly initialize/cleanup the coresched attributes in the cpu
hotplug code path so that lock could be taken successfully if the
sibling is offlined/onlined after coresched was enabled. We are
working on another bug related to hotplugpath and shall introduce
the fix in v3.

Thanks
