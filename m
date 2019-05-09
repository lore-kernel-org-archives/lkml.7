Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4173204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428077;
	bh=qxNcQDxSh66X3XT1A9HlEwqB20CxHkhLaAHXQ69M1j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ek/zOOZMeigLfBnAuQyecNjBpxrERV51+1Gl/j4MW8mqZikM7SwJIWMx0msh4jJ8a
	 pc2CxWsTYbwVg+rALZN5EKb5ErInPuUoO1S3aP+Z2xyyP9QaZ8jEPMv+/5xHlFsLwv
	 IgqjKhgWniGdaYtS5C9ykexNSge+MjEiYi1VKyvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfEISyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbfEISyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:54:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 017222184B;
        Thu,  9 May 2019 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428072;
        bh=qxNcQDxSh66X3XT1A9HlEwqB20CxHkhLaAHXQ69M1j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xwo3rxbf/HuPqX2iKJA0/3vIKuEjSSfcpjkprUWndDQsNwtBqTtC4KMQUGS+wYFr+
         hxiSEte721/0pXRsPRbNTqlRO8B/bj/2Bitpq5n8s3+id3ACJJff+6QMkvKHjF6APP
         flVP8juSAvwEfcQqscoS954kc5yoCaGmIOUa8mqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.1 16/30] ACPI / LPSS: Use acpi_lpss_* instead of acpi_subsys_* functions for hibernate
Date:   Thu,  9 May 2019 20:42:48 +0200
Message-Id: <20190509181254.247477276@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit c8afd03486c26accdda4846e5561aa3f8e862a9d upstream.

Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
on BYT/CHT as resume_from_noirq is set.

This means that on resume from hibernate dw_i2c_plat_resume() doesn't get
called by the restore_early callback, acpi_lpss_resume_early(). Instead it
should be called by the restore_noirq callback matching how things are done
when resume_from_noirq is set and we are doing a regular resume.

Change the restore_noirq callback to acpi_lpss_resume_noirq so that
dw_i2c_plat_resume() gets properly called when resume_from_noirq is set
and we are resuming from hibernate.

Likewise also change the poweroff_noirq callback so that
dw_i2c_plat_suspend gets called properly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_lpss.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1142,8 +1142,8 @@ static struct dev_pm_domain acpi_lpss_pm
 		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_lpss_suspend_late,
-		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
+		.poweroff_noirq = acpi_lpss_suspend_noirq,
+		.restore_noirq = acpi_lpss_resume_noirq,
 		.restore_early = acpi_lpss_resume_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,


