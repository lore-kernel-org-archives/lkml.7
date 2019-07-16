Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D89C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B20E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCSDzRUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfGPMF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:05:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41228 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbfGPMF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:05:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so8635815lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ftt1779R51gta0ONtQpJxcZlohE8KMN91kUXHGSN1G8=;
        b=OCSDzRUYihs3uGng7Kzdsuxey5RVjgG88OT9erKMhdNE3sOyD4A2P8nnnPSC7Dm1R+
         5fkyGF8HSWIoWXxvgj57ekP/cnqTXWUUFHwgPaAoeRvymD4g9FW+NHks2dO8V5pokzBs
         y4SuwipG3n7rtiZGNd66qz5NHAyFTNEVqyDUYDjphzMWCFmjoQc6GrVWV6Yy3OcCf69V
         ao+48jEl4Y+c87PS377+nI5FyuNwWnUSQRIxdWGTUT1dp81b0E5QAbXHcYIHlQ3h7ftU
         /+U2gNjwb0Y6iJGJrd7lYw6sHI26WBV0qThyk8GIHz87vo8EmXeEk7O/cKxT9+HkGmwW
         MmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ftt1779R51gta0ONtQpJxcZlohE8KMN91kUXHGSN1G8=;
        b=ey1JpnT45wQUK4TEND5VocL4yLahKyc30p3NRbxUG/v/Q6+JlN70WE0otyOdmbk+kN
         Oe+YeSUawdbZaKKVeVqgjdiJX/NjScCqmVFNALJLmleruPwUnGXu2et9q+FB1bJ/1j6i
         lbriAVkJWsap2/93Pa1g5exFQU4Sj74BZxp4ajocha4A2VPd6KnLs2iT9tTLkxlFXxpc
         GcUmSfB/MK1L95dDv8qtz33rbqj2CqJMvyZD0mjWSNJS1swxs0pRENsiYO9IhxuU+Ydk
         Yi71QvwfEJEPmSjtQXlQfFp+LIKhOooasXCOOD0iJqROz7fKugQAzmYLIiT1Py/bohMz
         amxA==
X-Gm-Message-State: APjAAAWiUshnPvWBgzKZ/aGX+G/V6ZqupApBn32MtBon8PPTkmcB8RPm
        NGmdl562Im3jG5w1moNjgAgcx0DH8wC0pg==
X-Google-Smtp-Source: APXvYqzmBP2Yrflx/y4/1oJ33vbI3SI1S9SGmHyT5/NPrhg5FX/1X78drUf1FNH6z/oAP67epWO3Fg==
X-Received: by 2002:ac2:5231:: with SMTP id i17mr14619779lfl.39.1563278725971;
        Tue, 16 Jul 2019 05:05:25 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t23sm3686410ljd.98.2019.07.16.05.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 05:05:25 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Pengfei Li <lpf.vector@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/1] do not keep unpurged areas in the busy tree
Date:   Tue, 16 Jul 2019 14:05:16 +0200
Message-Id: <20190716120517.10305-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this patch is to split "unpurged" objects and allocated
ones, that gives us some boost in performance, because of less number
of objects in the "busy" tree, i.e. insert/lookup/remove operations
become faster, what is obvious. The splitting is possible because
"purge list", "busy tree" and "free tree" are three separate entities.

Number of "unpurged" objects depends on num_online_cpus() and how many
pages each objects holds. For example on my 4xCPUs system the value
of lazy_max_pages() is 24576, i.e. in case of one object per one page
we get 24576 "unpurged" nodes in the rb-tree. 

v1 -> v2:
a) directly use merge_or_add_vmap_area() function in  __purge_vmap_area_lazy(),
   because VA is detached, i.e. there is no need to "unlink" it;

b) because of (a), we can avoid of modifying unlink_va() and keep
   WARN_ON(RB_EMPTY_NODE(&va->rb_node) in place as it used to be.

Appreciate for any comments and review.

Uladzislau Rezki (Sony) (1):
  mm/vmalloc: do not keep unpurged areas in the busy tree

 mm/vmalloc.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

-- 
2.11.0

