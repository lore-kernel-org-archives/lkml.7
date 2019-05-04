Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BDDC04AA9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F246206A3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556974336;
	bh=81zzv5HPMcfSVOd19KiTtUudkXRGCMqR07WXK06or18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YaRj0YV1F9AJfjuSlqhiHDSY4aeJyP9a1KU7XXjXUCcAdSnFu+mfRVVPdBqF4DHEF
	 zfJCnk30qtmvRX7i+X1HDavUfHEVrIJR5cCYWRLJqe5vML0kXsp3xJ9nV5rg5/Dgef
	 p3xJvlU4hx8+9o/rJyjczhCUbU+PgRb2EoKq5HtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfEDMwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 08:52:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfEDMwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 08:52:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5ABFC05681F;
        Sat,  4 May 2019 12:52:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08A435C298;
        Sat,  4 May 2019 12:52:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/8] perf: Add attr_groups_update into struct pmu
Date:   Sat,  4 May 2019 14:52:01 +0200
Message-Id: <20190504125207.24662-3-jolsa@kernel.org>
In-Reply-To: <20190504125207.24662-1-jolsa@kernel.org>
References: <20190504125207.24662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 04 May 2019 12:52:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding attr_update attribute group into pmu, to allow
having multiple attribute groups for same group name.

This will allow us to update "events" or "format"
directories with attributes that depend on various
HW conditions.

For example having group_format_extra group that updates
"format" directory only if pmu version is 2 and higher:

  static umode_t
  exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
  {
         return x86_pmu.version >= 2 ? attr->mode : 0;
  }

  static struct attribute_group group_format_extra = {
         .name       = "format",
         .is_visible = exra_is_visible,
  };

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f3864e1c5569..cb5f07d50edb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -255,6 +255,7 @@ struct pmu {
 	struct module			*module;
 	struct device			*dev;
 	const struct attribute_group	**attr_groups;
+	const struct attribute_group	**attr_update;
 	const char			*name;
 	int				type;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..21ef9b843af0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9874,6 +9874,12 @@ static int pmu_dev_alloc(struct pmu *pmu)
 	if (ret)
 		goto del_dev;
 
+	if (pmu->attr_update)
+		ret = sysfs_update_groups(&pmu->dev->kobj, pmu->attr_update);
+
+	if (ret)
+		goto del_dev;
+
 out:
 	return ret;
 
-- 
2.20.1

