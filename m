Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1FFC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062A12054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="x3BFXGD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfEFO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:57:33 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40713 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfEFO5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:57:30 -0400
Received: by mail-pl1-f170.google.com with SMTP id b3so6499170plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KsZcNzF1hybdUscCtnXpBh/F254onDMylJHf8yLDCZI=;
        b=x3BFXGD8/emXf5QlCrkujCa+PcJkvQN9xszX7tdTYH90aT3XTCMaOe3K68c7JRmL4N
         PaynnQ0d5Kz8wipUcBEIe//4NdtuUtittkvJr70GCPT/WuyV9Vz8AQzWngVc1rn5CD90
         6A8L+TWxtZbQBdL72kK4/oLteDbFe3ZokokuKMv2CEt8vE2RO3TsNkEREaF6nci78oJJ
         z813KcEivWw1mvOwB3+/VpVuBuNbM9UAD8rTf0VabAJA/WouLrSW+lPFFpurm+JAikXS
         JlkpmQNX9dj3NaGzoaHKyLEWOUFzv1f28csn/BCkETIoKCEIESbq3cbFLbU4Yfwuw9km
         uW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KsZcNzF1hybdUscCtnXpBh/F254onDMylJHf8yLDCZI=;
        b=Tx+5I/yLXwH7Fqxo6mkM+XkSEnpLZ0jtT+kr+M5ygvBr3yK4zhXM3I/i9JC8neL/5T
         l59unIUtrccZzTgqk8Mo1WsddWgZhN6NER+WQb6UIqLQRdB2xq9F81667UM/iJTFGo2Q
         bLcP1AGAWu96geKD/tC5tUo2mmaj8BeEja69xnaoOvRIc6ZaTyjRibF0uuK2adMZlLFq
         9eQyUOIhmtE7uv7TTJgTERJ3EHzDXNqpEDvq9CYAns9W+Tu4dehK3cZzSH70ps3zZUHt
         2mGFe0VtDihRLN1IwuSC+vWvDkNgOKLJUSU7fuNK88OxINOtPcjgs7omH+A7KyTenP8F
         V2RQ==
X-Gm-Message-State: APjAAAVyDcGKWmPHNY5eDdhRa89DWbar3+nkfT3bjeMiuf/vYpzbUbWk
        Hs3rQOB8W9biyXbusslyZ4CjVw==
X-Google-Smtp-Source: APXvYqzsy76OdF+u7Stt+xa2A/2at4+7p58pfgr6xCJ0xlI8R//reK/oe8DtCKgvE1sPge7KpRGisQ==
X-Received: by 2002:a17:902:2825:: with SMTP id e34mr33208399plb.264.1557154649848;
        Mon, 06 May 2019 07:57:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:32a0])
        by smtp.gmail.com with ESMTPSA id b77sm23821195pfj.99.2019.05.06.07.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 07:57:28 -0700 (PDT)
Date:   Mon, 6 May 2019 10:57:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [[repost]RFC PATCH] mm/workingset : judge file page activity via
 timestamp
Message-ID: <20190506145727.GA11505@cmpxchg.org>
References: <1556437474-25319-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556437474-25319-1-git-send-email-huangzhaoyang@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 03:44:34PM +0800, Zhaoyang Huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> this patch introduce timestamp into workingset's entry and judge if the page is
> active or inactive via active_file/refault_ratio instead of refault distance.
> 
> The original thought is coming from the logs we got from trace_printk in this
> patch, we can find about 1/5 of the file pages' refault are under the
> scenario[1],which will be counted as inactive as they have a long refault distance
> in between access. However, we can also know from the time information that the
> page refault quickly as comparing to the average refault time which is calculated
> by the number of active file and refault ratio. We want to save these kinds of
> pages from evicted earlier as it used to be via setting it to ACTIVE instead.
> The refault ratio is the value which can reflect lru's average file access
> frequency in the past and provide the judge criteria for page's activation.
> 
> The patch is tested on an android system and reduce 30% of page faults, while
> 60% of the pages remain the original status as (refault_distance < active_file)
> indicates. Pages status got from ftrace during the test can refer to [2].
> 
> [1]
> system_server workingset_refault: WKST_ACT[0]:rft_dis 265976, act_file 34268 rft_ratio 3047 rft_time 0 avg_rft_time 11 refault 295592 eviction 29616 secs 97 pre_secs 97
> HwBinder:922  workingset_refault: WKST_ACT[0]:rft_dis 264478, act_file 35037 rft_ratio 3070 rft_time 2 avg_rft_time 11 refault 310078 eviction 45600 secs 101 pre_secs 99
> 
> [2]
> WKST_ACT[0]:   original--INACTIVE  commit--ACTIVE
> WKST_ACT[1]:   original--ACTIVE    commit--ACTIVE
> WKST_INACT[0]: original--INACTIVE  commit--INACTIVE
> WKST_INACT[1]: original--ACTIVE    commit--INACTIVE
> 
> Signed-off-by: Zhaoyang Huang <huangzhaoyang@gmail.com>

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>

You haven't addressed any of the questions raised during previous
submissions.
