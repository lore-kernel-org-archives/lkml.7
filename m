Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B89C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB00208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557676530;
	bh=81zzv5HPMcfSVOd19KiTtUudkXRGCMqR07WXK06or18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIO5trXMPTjDwpSrGcSIxa6XUDCwLxAbufQpX7UuWSSPW9vu3V2KZy+LMIX+GcYV+
	 lvEtrwDeeYYYacim9BWttRdXyjNKCLn7QAI4HhEpJ8FJIuVA5MVJu8f8w759gaEDI0
	 wzPBbBJ8v47m4ALV208S3Pk/u10NXyUlAH6D3SOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfELPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfELPz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:55:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4E44307D91E;
        Sun, 12 May 2019 15:55:26 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02FB4B6;
        Sun, 12 May 2019 15:55:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/9] perf: Add attr_groups_update into struct pmu
Date:   Sun, 12 May 2019 17:55:11 +0200
Message-Id: <20190512155518.21468-3-jolsa@kernel.org>
In-Reply-To: <20190512155518.21468-1-jolsa@kernel.org>
References: <20190512155518.21468-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 12 May 2019 15:55:26 +0000 (UTC)
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

