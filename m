Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D55C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C582173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfHHRoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:44:13 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:46964 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727096AbfHHRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:44:12 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78HiB93028971
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 13:44:11 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78Hi6S6006749
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 13:44:11 -0400
Received: by mail-qt1-f200.google.com with SMTP id p34so86253590qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ocu8C9DzUnItcD8VwauK/PbrxyEWz2B8Awr1UvoHzFw=;
        b=Gl0CDDqSyAvH9qyeJS3BE8vy7y+PgIibGuaHVGSU/qqbZO+X1ciimBG7wDWfHuRpVy
         mufMFfZvL3b2pam7tK4uKsc+sInvhsVEU8Evs8xd2OaR73D1KHcp8uI4yEBfmzf0CRDR
         YiM7DeJdOrWO1l03U5vuFKh2BLKwYSTv3hin3HK8IZyKepuQehOm2vnhMpZCbZ+Ar+VH
         guhBOSNL1GpK1bK0G7SK/tgEnRMMp454cn9ixhqmmmNrm2vFcXZjc/J3oDDKrBJQYQI6
         TUG2N1X/RfQpLXMKF0QrMWMqRroBSH0rbOB+vQLyxhlc7raQVf1eRgwPeSabgVjfZnCv
         acqQ==
X-Gm-Message-State: APjAAAW+wXGdwij4v9kvnY9jAogJyURdwPh5VQvh5JuMlhpZuj3KXPz6
        2MYKBOC6tE2MzilyN0awXTCD2UB5vFe3ysDY2bZiPfUlgtPmIsels69YHbGVbCSNEmA2RarpbMQ
        EatqCwwPw+bJJ0JIUwsT0oEtbEPuykloV3WI=
X-Received: by 2002:aed:2d67:: with SMTP id h94mr14182023qtd.154.1565286245456;
        Thu, 08 Aug 2019 10:44:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWLsjvSpuRTv+an2uu6MpgTPWu4bf1JJwxkDVZffrsO5pybPCTHePzZtCk0LLfZ4P5PeL9tw==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr14181997qtd.154.1565286245177;
        Thu, 08 Aug 2019 10:44:05 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id a67sm43020911qkg.131.2019.08.08.10.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:44:03 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/events - make more stuff static
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 08 Aug 2019 13:44:02 -0400
Message-ID: <128059.1565286242@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with C=2, sparse makes note of a number of things:

  CHECK   arch/x86/events/intel/rapl.c
arch/x86/events/intel/rapl.c:637:30: warning: symbol 'rapl_attr_update' was not declared. Should it be static?
  CHECK   arch/x86/events/intel/cstate.c
arch/x86/events/intel/cstate.c:449:30: warning: symbol 'core_attr_update' was not declared. Should it be static?
arch/x86/events/intel/cstate.c:457:30: warning: symbol 'pkg_attr_update' was not declared. Should it be static?
  CHECK   arch/x86/events/msr.c
arch/x86/events/msr.c:170:30: warning: symbol 'attr_update' was not declared. Should it be static?

And they can indeed be static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 688592b34564..db498b5d4aae 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -446,7 +446,7 @@ static int cstate_cpu_init(unsigned int cpu)
 	return 0;
 }
 
-const struct attribute_group *core_attr_update[] = {
+static const struct attribute_group *core_attr_update[] = {
 	&group_cstate_core_c1,
 	&group_cstate_core_c3,
 	&group_cstate_core_c6,
@@ -454,7 +454,7 @@ const struct attribute_group *core_attr_update[] = {
 	NULL,
 };
 
-const struct attribute_group *pkg_attr_update[] = {
+static const struct attribute_group *pkg_attr_update[] = {
 	&group_cstate_pkg_c2,
 	&group_cstate_pkg_c3,
 	&group_cstate_pkg_c6,
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 64ab51ffdf06..f34b9491ea6e 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -634,7 +634,7 @@ static void cleanup_rapl_pmus(void)
 	kfree(rapl_pmus);
 }
 
-const struct attribute_group *rapl_attr_update[] = {
+static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_cores_group,
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 9431447541e9..5812e8747d1f 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -167,7 +167,7 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-const struct attribute_group *attr_update[] = {
+static const struct attribute_group *attr_update[] = {
 	&group_aperf,
 	&group_mperf,
 	&group_pperf,

