Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62541CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C7B20659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571826486;
	bh=Vryolh+Fy68WfmYTX++DHboAIhxgrmDkoa42P6E9SUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gakNpxTzHq4CzEBNDreXfPGw82IghPkQrEj4i131wqp/8DLhEy2fn8iLhspLREOWw
	 2N75xwJQPMQrr0kxTzku6EKpmV7ZIVpcSeQ2rdTnL1ZKjJG96NDP95V8nGM3DWpz2q
	 mv2skbF2mkWbReCEoqvEPZh/tosqFMY8POHi8fWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404412AbfJWK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:27:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404089AbfJWK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:27:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so9513731wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsLzXYwYLSB8hHF4vHJgIrxG5rx+YZo4hwBqQCis9kU=;
        b=HMEcdTrR4CvUBuOE/pxGdcLXELcvaRrzceVSud5clQgbs5E9hVfOR8m8XtaHdO6iaM
         0KDid/rHDUfvx2pz5SVf+akkm18nDfrxb7w66mL6iVX3+G5/bGw9J40pd6aFRbHA2wCh
         g/3xTrthcykr4AbPtZfVRkVatqcMvINLfgxyW+afwmw98exMYHxHIreBJo8knkT46XKl
         MLYsxJFYDhXgGV54rYH660VzeaCiWyciSCq8oB+WYmRxi1hxwZ248jhmg0KjopxfgVhn
         xHOkvOV5H8yKz8ISkL2+srjgz8vk7kwhIjiuicuOdikQBtInwiS9TqlLYl3ej+cFSjbu
         MJBA==
X-Gm-Message-State: APjAAAU276a0flBFWwtCs835UNvXW1b95ldVwiVPqx2qz1CdPqhXoWYz
        jOHzpR6fdcX2TkjxxKeCMPI=
X-Google-Smtp-Source: APXvYqzP6Mht+wSNTC2Mtl2i9OMjpIr9618QNI6FunUy6TCvoivmzg9pmKUkUO33dVax3Omo1X3Haw==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr7091015wmd.32.1571826471365;
        Wed, 23 Oct 2019 03:27:51 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-173-3.eurotel.cz. [37.188.173.3])
        by smtp.gmail.com with ESMTPSA id u21sm18234122wmu.27.2019.10.23.03.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:27:50 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/2] mm, vmstat: hide /proc/pagetypeinfo from normal users
Date:   Wed, 23 Oct 2019 12:27:36 +0200
Message-Id: <20191023102737.32274-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023102737.32274-1-mhocko@kernel.org>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

/proc/pagetypeinfo is a debugging tool to examine internal page
allocator state wrt to fragmentation. It is not very useful for
any other use so normal users really do not need to read this file.

Waiman Long has noticed that reading this file can have negative side
effects because zone->lock is necessary for gathering data and that
a) interferes with the page allocator and its users and b) can lead to
hard lockups on large machines which have very long free_list.

Reduce both issues by simply not exporting the file to regular users.

Reported-by: Waiman Long <longman@redhat.com>
Cc: stable
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..4e885ecd44d1 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1972,7 +1972,7 @@ void __init init_mm_internals(void)
 #endif
 #ifdef CONFIG_PROC_FS
 	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
-	proc_create_seq("pagetypeinfo", 0444, NULL, &pagetypeinfo_op);
+	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
 	proc_create_seq("vmstat", 0444, NULL, &vmstat_op);
 	proc_create_seq("zoneinfo", 0444, NULL, &zoneinfo_op);
 #endif
-- 
2.20.1

