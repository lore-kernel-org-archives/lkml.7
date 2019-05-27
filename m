Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770EEC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D56C21871
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ9NJi36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfE0PS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:18:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33698 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0PS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:18:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so15029928ljw.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YAM42W4nl7Xrv+602WPlcincJeD4Ntz7L8w8jwaNl0c=;
        b=VQ9NJi36DfshM8MP2kweAEWk741ksZscNvFPiZjFXx0nT5AzXSauCHBeE0WJIHgqaY
         BNuAc5tc16R7hJ8HLN0whUtkUwKZT8HJGgCOVYWqETue3iojBVgK9UAwSHruHYFle6jB
         RSc/Tvq/UUeUGiVXcnCD+PzUIieXGblDvftvXPWX/EXXL60GcbWW2rNmn8f2oMRaiDOW
         Gp+MkJ9OGWciJdLAfmyrYnX4eyONJDiXr82BC6/mw7zqnYx4MLp6+PEG+2q/FQzOYIJN
         7Ho0DJ+8cCi1/d3JVay4+3lmb26TdDwWfwoU97yfGaLO5UbWOeCvZaKIizyBUQjqiIUh
         Wcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YAM42W4nl7Xrv+602WPlcincJeD4Ntz7L8w8jwaNl0c=;
        b=sujlVwFqbbjIYOLgray8fGxB1rlK2J0P3SdbBYZgxw6C9tlQcaMHlxnrhsDe4mQKmL
         KzhdfdXOxLONGKNbAIKbAjhyFJJHy99I8Eub2ZH1QU+8PPH7upO7nSS6zwpl5KQme/or
         UoQuOaObbfeANEbCVVggWHXn2Cnx3jH4nzY6ydvS00qdhuxeH2VnqHuMvXlKeXNsARfV
         ruhWSrhmWlkCZtaSZC6n1B7ibGmQ+VzjDtcNWrDgaf15lMFfLtPPpT7XLK2SLwPalADb
         f8NyhhnQEgn99h7J44HUOCQdh1NXInYTQF+P+ZAps3TPD9QGkF158he3fbg3REqzxzfg
         ogFg==
X-Gm-Message-State: APjAAAUsxqABhTPVOEeBFe2GonKRd7Xt9iOIjc8HbGrm/HK8eHzKPmQx
        ebIFh5wZwGBcUgunGI+em6w=
X-Google-Smtp-Source: APXvYqxD62DsXuniXEJslrnzdRm4D6x1+aa+aiF4J04y4ulWJ0Sk7kXPdjqDoq4c18XrEgykDRxvoQ==
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr22145532ljg.139.1558970334984;
        Mon, 27 May 2019 08:18:54 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id h25sm2308701ljb.80.2019.05.27.08.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:18:54 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Some cleanups for the KVA/vmalloc
Date:   Mon, 27 May 2019 17:18:39 +0200
Message-Id: <20190527151843.27416-1-urezki@gmail.com>
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

Patch [4] replaces BUG_ON() by WARN_ON() and moves it under "unlink" logic.
After [3] merging path "unlink" only linked nodes. Therefore we can say
that removing detached object is a bug in all cases.

v3->v4:
    - Replace BUG_ON by WARN_ON() in [4];
    - Update the commit message of the [4].

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
  mm/vmap: switch to WARN_ON() and move it under unlink_va()

 mm/vmalloc.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 18 deletions(-)

-- 
2.11.0

