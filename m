Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF927C28CBF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C6521744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmnXcabM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfE0Jix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:38:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37155 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfE0Jix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:38:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id h19so5719950ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KJULdVfLsRoB+sGyptDGkaVMQxwt1Boacmd0PqpEDts=;
        b=MmnXcabMcBI+WEeJsRnfddqU+lstsU0ktKmJQSl7uzI8EtRq8qnyMA1cBgVBf32wcl
         Qf9naQEpc4VuIe9mIUYjZTAYExdOX+zopaT++YhS0Ah4GF/kzgFipzmfNcc72WyW0nU8
         9Ga3FDXngULiryXfN25QYjlUTI0Jg6KvDbl9WOhLzPtVw1d9KlKbjmBzwtppe6rpto3S
         CFWkdSmCO+oGvxbextYTgFnBuzzm+pV9u1qKr5cnN59/J3EO+LwtbbT84F903cE1Ise2
         4F66WtEzW9yL+mTT9IeSpAWeRAPUhoF88aRpMSrakmjlm6LHilud+/g/RB/GfPLBU+06
         Zyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KJULdVfLsRoB+sGyptDGkaVMQxwt1Boacmd0PqpEDts=;
        b=CuREjh1Ko1IRs5pcP5xKnEFqLCNx3W282Y7GgHFBymh2GX2DVJCO3JauxTq0GZ0mAK
         0DmfVrwJdtb56GdZtu1J3werehRNUgiBFXrPhRpb09r+kArlBy/MgxwlNwDHZisLTtnz
         HVPvENvg8f2e4mV5PMAxZayALvr7eeYxA42C5SPNRaXv5E99H777bbSHKAsF81nH4wB4
         WyuvZuMdSfj4B/vwM7z1oD/QJG4Wx2RXqwKsZS9kyzNMpYd5NeoOd9qe0XYF/i/vkfcB
         MiTjrDUIo6FHCkDMUo0uajbJna/q6xOgA6VTagFvsBC80eXhZfUWPp3PLnuI6f8WefES
         XpXg==
X-Gm-Message-State: APjAAAWhzp37l+9krkxyQlVFmUYWvyHxcYSO1W2R84cKUNcmguIaeSSx
        8B8k/JZ+PudcOAoFrrWz/vs=
X-Google-Smtp-Source: APXvYqzzWrckWdhlUjfKT+Mr6KWs7IdSOmIQyO0BsfKDrAL58MmE+qhRLg1+HDh+WeyceMc9FuBwfA==
X-Received: by 2002:a2e:8716:: with SMTP id m22mr8686777lji.128.1558949931317;
        Mon, 27 May 2019 02:38:51 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z26sm2176293lfg.31.2019.05.27.02.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 02:38:50 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 0/4] Some cleanups for the KVA/vmalloc
Date:   Mon, 27 May 2019 11:38:38 +0200
Message-Id: <20190527093842.10701-1-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch [1] removes an unused argument "node" from the __alloc_vmap_area()
function and that is it.

Patch [2] is not driven by any particular workload that fails or so,
it is just better approach to handle one specific split case.

Patch [3] some cleanups in merging path. Basically on a first step
the mergeable node is detached and there is no reason to "unlink" it.
The same concerns the second step unless it has been merged on first
one.

Patch [4] moves BUG_ON()/RB_EMPTY_NODE() checks under "unlink" logic.
After [3] merging path "unlink" only linked nodes. Therefore we can say
that removing detached object is a bug in all cases.

v2->v3:
    - remove the odd comment from the [3];

v1->v2:
    - update the commit message. [2] patch;
    - fix typos in comments. [2] patch;
    - do the "preload" for NUMA awareness. [2] patch;

Uladzislau Rezki (Sony) (4):
  mm/vmap: remove "node" argument
  mm/vmap: preload a CPU with one object for split purpose
  mm/vmap: get rid of one single unlink_va() when merge
  mm/vmap: move BUG_ON() check to the unlink_va()

 mm/vmalloc.c | 115 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 26 deletions(-)

-- 
2.11.0

