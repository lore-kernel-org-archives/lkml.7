Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1663DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C222087C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF/NcU0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfDBCv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38755 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:51:56 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so2730608ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oUxF2b4WKgUzih0SC0IktVZrnDr9sVA4+xZBrQT4vKY=;
        b=uF/NcU0sN2WDp/WLa0AzBa1SFNgyH78fzCw/dbd6vYdN1H/7OT3ToIXJT134GZoYGX
         sfHp448ay6pAm9xt6PrnTXJEADOqVfMhmMbAABubbSBBMi5ogg2zQMMr21Ooyj/py9hh
         ZDmCaefeZElozqZAJVe5e+d4u0q3T/lfhSvJj9sdQyBI9j/vuz+ffZbNwKubekrhRx2E
         6jEZjvbHPm/xAjPeQA5UbF/1RPr9HxfBFOQmGtp3rUM/oWjLsLjgaYnX0NPr34V8yToV
         BRJqwEmDE3goObNL0WipUQro7G1gDTboUWiuPjNcMZEjQ85D4IOQzxoB0Cb7t0fhAquO
         TMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oUxF2b4WKgUzih0SC0IktVZrnDr9sVA4+xZBrQT4vKY=;
        b=CQba31ZmuptYTG52XKnhaNxBeu8DMeUGoV6hWhyUsxym8B9GXzNkbYB0Ud29Y8lO0i
         TC9bW2wtxNiitAvrJr46X7D2Bcdlbjxr+MNpUBn0Maspsn9rs/tloEf02BUc0xs36RPr
         jjqQzr6/eToOENpRVIyLIa2Jr9PPTv8YZhNynjXPHoRFdjo3to0vhVAVKczmoc4N8o7Q
         sxfbj/0PKA0aYKjiMRFu2m7+VxVaYHkIZsnqf8Gm7OPsBAGA9+iR9FM4KBjU7AqLTiyE
         UMdtPYPUqOk9Xee3LcSvzDhsUsDfW1+7qG6XMhTrpBusOBuw2pUXyJuD0T1n4LL3qvY2
         pLgA==
X-Gm-Message-State: APjAAAXgRW23tcXAU8wa9S5nKGSHzypQ1T9JvoLmUjGYQOSSoZC5EfPy
        Mtl3xv6D5eFLaiBzI6pRkOE=
X-Google-Smtp-Source: APXvYqxu0vDTKHmwqp8GjhhjAwTwhUucO3sLT8HySAf8iUJ+w316oL2KLQef6qpKuotypd51KaAxRQ==
X-Received: by 2002:a02:8c4d:: with SMTP id j13mr50886011jal.48.1554173515958;
        Mon, 01 Apr 2019 19:51:55 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id 19sm6326579itm.6.2019.04.01.19.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:55 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:53 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] cpufreq: schedutil: Replace default_attrs field with
 groups
Message-ID: <18a50bab72e6bd326250b2bd5b5a4b414351815d.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace sugov_tunables_ktype's default_attrs field
with default groups. Change "sugov_attributes" to "sugov_attrs" and use
the ATTRIBUTE_GROUPS macro to create sugov_groups.

This patch was tested by setting the scaling governor to schedutil and
verifying that the sysfs files for the attributes in the default groups
were created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5c41ea367422..148b60c8993d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -598,13 +598,14 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 
 static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
 
-static struct attribute *sugov_attributes[] = {
+static struct attribute *sugov_attrs[] = {
 	&rate_limit_us.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(sugov);
 
 static struct kobj_type sugov_tunables_ktype = {
-	.default_attrs = sugov_attributes,
+	.default_groups = sugov_groups,
 	.sysfs_ops = &governor_sysfs_ops,
 };
 
-- 
2.17.1

