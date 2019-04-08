Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E446D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecLqHUnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDHTyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:54:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHTyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:54:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so8233382pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=1jo2iMrB0owQ9V5kkgcFERnG5vKtykcZHem1fyaBDFo=;
        b=ecLqHUnzNU7+FbXXx978+5RbQ1KF8vvKyf67EIY6PXNk03FzmiRTrZrDLsmXWptuPL
         /Rb82V3XEi9XGLiZ42bffTnISaWVr3H169b9bpmR2tFq/RhVtkWJOOu/QS9AMyAB8B5y
         2KVZpADsQ1m7nZIrGh806AiIUjWePNUVr4OfPFKZR/9o96Kz6i/CdEVSnOAW/ZwzeiS7
         XZOuLjnCVeaK2C8k3V2V2IkgbdipI+CABwpaebFQEKMN25A86sGs1a/YLs2eCP5+HKSK
         Dkuu9VTxFelntySxMNW/MbT9ehFwaNnQFF+Pu++P/EitwO1spGJDnJa3EgOOKOyQTvkC
         OBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=1jo2iMrB0owQ9V5kkgcFERnG5vKtykcZHem1fyaBDFo=;
        b=KIhQzLxGUzZ3wI5lIdVwuBuwfvcSIGy0C6KPrOFhu/TgQS0CyHWcIuAjN1x07mdAVp
         rsvfT/MwOrw2lS6qLyeBciCiGjSDv+hv/dy9JXoWfozM9JSAB2t1iocq/cPfN2MNGPqf
         /EGEAlig0yVeMEKECrDeh5p8g+9QVLN3qJkqE0cqJC3tYrVKvm50OpenizPPvr19Fn3F
         KDCN9z4Ay+iTVW9PzhrAkUuu9OLElf35Cng1ugsZBeDGbQQCIsBWYROli4c4jcqVi0wX
         P9NwMIdSwGcJczAG28BGCNYqTNAHB+6GAiKnquMZdbqltl78QKy5Xnte/GCKSSOmaejb
         mdCg==
X-Gm-Message-State: APjAAAUaKnye/ZliKUuPJxgtnlOrCySm6LK4UhBMW+CpQkV2GXdXD+Ir
        Uv0hZiVKAEeohPFSVNUUEba+z4y+Bc8=
X-Google-Smtp-Source: APXvYqwsb14x+NmywHmVHCl4/zVaonURAC95IyZ53d/9ljhSgpaIiseVXYB3ULyOpRPZCxThenZqGA==
X-Received: by 2002:a65:4185:: with SMTP id a5mr29606204pgq.82.1554753252418;
        Mon, 08 Apr 2019 12:54:12 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id 6sm12828984pfp.143.2019.04.08.12.54.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 12:54:11 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:53:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/4] mm: swapoff: fixes for 5.1-rc
Message-ID: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are four fixes to the new "rid quadratic" swapoff in 5.1-rc:

1/4 mm: swapoff: shmem_find_swap_entries() filter out other types
2/4 mm: swapoff: remove too limiting SWAP_UNUSE_MAX_TRIES
3/4 mm: swapoff: take notice of completion sooner
4/4 mm: swapoff: shmem_unuse() stop eviction without igrab()

 include/linux/shmem_fs.h |    1 
 mm/shmem.c               |   57 +++++++++++++++++--------------------
 mm/swapfile.c            |   32 +++++++++++---------
 3 files changed, 45 insertions(+), 45 deletions(-)

Hugh
