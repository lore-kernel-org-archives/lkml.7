Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B2A20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557178020;
	bh=yLIfHljdY6SKn+3XgvJE5A8cMwI0EyTAQDq1f/Rw1xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:List-ID:
	 From;
	b=dAoRu8FBbUbWS9LPWVgLw7rw723HK1ck8w8Q4HdhnNGRgSNJOz6HZJ591LasHZRmE
	 JHUHBRUNYMoitJRQQ/wwZ3+b/mhRujupyN3utDGEh20VOAYh/YCZn+z1eHvThZvLYW
	 YEwTAYSSJbh+NiqYjYoCBo8nwrGTSpT3irbvs7DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfEFV06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:26:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51656 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfEFV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:26:53 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so10676471itk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=NASL/z1GXMPb/S94wC/bcg3jCMGLXonBlWTVA+tl8Ss=;
        b=iAZl6p5NKE7JVwuEDyKvQ/i+Sz4xzWZ/3bc+o1S/o/6hXbqiwFOJXLaC3/3W4pevUR
         PyvLE005JiuSt4DCHHRC/aXo5Uvirsal4Sb9VRfYRENlxjcdlnlyNMqNMSbMmjo1K1+n
         SL0w3ADiKNHd8LTwoCvFxMhz4QVkHQ8fXiBsrnlJDqUnpGgswq75B43l9CtSbpns3OZ6
         lxPCKevPQLsGHAxFS1rxmAXnJIAld03iu4/b9n5kNs+Wifq9+6K2STVh6sJqQ3xpy2d0
         4ASxEnv5V2kbNW6y/glJ72vgSxuvXTKAb61RvxAZVRbyfP6LGeKsPprBJ6uYeEY3Gkkq
         lexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=NASL/z1GXMPb/S94wC/bcg3jCMGLXonBlWTVA+tl8Ss=;
        b=cKxo7hv+nIp7Z0qCHsJhtGi/WJdNyMKau2SUu36gbENSsc8UtH8bFFoejR9EMcPgyE
         u6O6LQ3SiEq7Jd8bPdswyhISTdoWBRnm3WIlU84GIX85pqG83/CftFu28l86QZcQr852
         2FPYRM8H2qxlujIHUO0tYSCNpBvSfxWY+bA6QvsHBRj0V0XFXoNiSnXROtYaVdT7LItk
         zn4ke3DcmuJ6kdu2OVJe0YPtdDW1RE0TRGoxcMeTruT+tNzyj5QR5EOEP/2jcViSUsWW
         Peiiv6m7hH5qU99Hrno1NisKED9RkEGaIF05miTdK7/PxZZQ0OeofMF9hJJ0LJv9+yG5
         5rCQ==
X-Gm-Message-State: APjAAAUA89KtQLJvVqMjLqs/2Z0WASUi7Kjfs6fQY8FoAl/KGFmDFp6M
        QvOqJjeTV8s/hEUwYWcABIg=
X-Google-Smtp-Source: APXvYqyiVRQpBz6hbNRmYiAyyM+tEGKYhjoVETPPgWQGwNHahaMyDRpFZYBPJrBnEF98ltThJnsd8g==
X-Received: by 2002:a05:660c:acb:: with SMTP id k11mr20017103itl.1.1557178013127;
        Mon, 06 May 2019 14:26:53 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:52 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 22/22] perf/x86/intel/rapl: rename internal variables in response to multi-die/pkg support
Date:   Mon,  6 May 2019 17:26:17 -0400
Message-Id: <9f57786ba08d4d5e913cd21693aadb0ccdba72b2.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names
to use the more generic "pmuid" terminology, instead of "pkgid",
as the pmu can refer to either packages or die.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index e49f69c51b10..497eae4b4c9b 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -161,13 +161,13 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int pmuid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pkgid] : NULL;
+	return pmuid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pmuid] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
-- 
2.18.0-rc0

