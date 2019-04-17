Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD95C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B32C20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bYJhk0dL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfDQPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:52:45 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40291 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:52:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id q17so9280848ybg.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sg3wq3MteswBnaiecj+bveQZpY+H78RJr86m90y8oys=;
        b=bYJhk0dLrPtTxpjPurxmDPGapsniq5TRVmv2A6DGFE6jpqbRdsEcFg5Q2KvfAsOpen
         l74SfecVlMebY6oiDK+k83CYJ0SX7NzkRP0RPbi90WD4OtJllWHGVti8CbaVwNV1aNBn
         +SI9MI7iW7Letd3aig1QTC3dd+DvGGX3CA+NmXot1uCu+fJh6kwzno1NJJCmzx7Vaapz
         dIvhnraeSD1i/m7WJrTqNo9m9OqdRcvn7DCk93gRVX7H8hcvszEj6cObcVyr5mQgKXYZ
         xZBx1k4I6JVpDuq+7S4X4x+rJ2KwGqQ03gsK+xjlz+omnm8Elti0/MCEGXinyTpELxwi
         17wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sg3wq3MteswBnaiecj+bveQZpY+H78RJr86m90y8oys=;
        b=G3wx/B1/XMypYiHXcUVbcPLGnp/Kxhmk4VxsFHPS+kmxfRQid/f+XMQv7ibfrxugR2
         vC+jTTd+bFCkSVAP/hKePhbAjFdON7I5duP8LmNubFvoZKixYUEMezWMF9LNYtV160HY
         I6K3sf5Yk38qu3SNBT2piOYWg62sLzR8HJ3Wp1ZN3+UOuspFNFKyylY+9yu9rbAA0QLT
         rfdD3ECpGiRl+ktyfXTcz6Lu+JWddlurn7ZBa3UrfpVkdRpyOuuf+Bi5ZE2HfsM5fsXI
         VgoAYd9zP+vtGDc8cY2/qua992IEsNkXnrJAm/461WQw9YHIvpXCtrss4l5G9g7btjTS
         +ajQ==
X-Gm-Message-State: APjAAAXe+sY/V6a8JRioMauRhWTKPPIk8SLhOkrnlOg0PtrAyAJWNKk8
        hdcRkDbssglfLQqKA3ag87eOVg==
X-Google-Smtp-Source: APXvYqzz8WMq8k7MzdIHvCMSCLAQVY4Q0vbKn+dG9MzFKu7XCQZZv5oDI0gB1QChOxDaH3RLOM0pJg==
X-Received: by 2002:a5b:987:: with SMTP id c7mr473393ybq.499.1555516363612;
        Wed, 17 Apr 2019 08:52:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:fc54])
        by smtp.gmail.com with ESMTPSA id h3sm22321975ywa.61.2019.04.17.08.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 08:52:42 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:52:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     shakeelb@google.com, mhocko@kernel.org, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: +
 mm-fix-inactive-list-balancing-between-numa-nodes-and-cgroups.patch added to
 -mm tree
Message-ID: <20190417155241.GB23013@cmpxchg.org>
References: <20190415212744.v9aTn%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415212744.v9aTn%akpm@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 02:27:44PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: mm: fix inactive list balancing between NUMA nodes and cgroups
> has been added to the -mm tree.  Its filename is
>      mm-fix-inactive-list-balancing-between-numa-nodes-and-cgroups.patch

---

From b5a82062b99fd3d2d4f4f7dc220d4acb1aa9b749 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 17 Apr 2019 11:08:07 -0400
Subject: [PATCH] mm: fix inactive list balancing between NUMA nodes and
 cgroups fix

lruvec_page_state_local() is only defined later in the series. This is
fallout from reshuffling the patch series to pull a standalone fix
before the bigger stats rework.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c9f8afe61ae3..461720e2ae90 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2979,7 +2979,7 @@ static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
 		struct lruvec *lruvec;
 
 		lruvec = mem_cgroup_lruvec(pgdat, memcg);
-		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
+		refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE);
 		lruvec->refaults = refaults;
 	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
 }
-- 
2.21.0

