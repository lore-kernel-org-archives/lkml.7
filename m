Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D61C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688233;
	bh=7TlSL5J/+MubC/RO+9vosMs3nAjHpwbQIB6CRkMBBtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mv2RmDILHt17q1DsdmTrNSFU6dRyGykujxTKiKr1290EQWx8ty8vmYnOJcDOpb06a
	 XcKIRK1zoBOmnjoS4Ze2NrYFo3HMduMhFnhN43NhZham8Cc7Qf2WBB4nGOub94yiGS
	 nWDknwb9o1CHoCQd+MWJYQkvmesaFWlfbio/jh8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCDIac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbfCDIa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1B621473;
        Mon,  4 Mar 2019 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688228;
        bh=7TlSL5J/+MubC/RO+9vosMs3nAjHpwbQIB6CRkMBBtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuZL1/sVaUxSr9uVomiUDli7a+mbqd6Rg/eLNkWwJtdglOuVutulvdXrT/I3vHUqO
         ARc3p/IJiub4PxlJrdY3rf3l2QaIUvv5inHh88HU0Qig7ecXFO3NMwV5hM717UU/mC
         CSTpGulQuHGDZiKJ+SXzWmCA2e/E12GMVVRa3Q58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Silvio Cesare <silvio.cesare@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>,
        Willy Tarreau <w@1wt.eu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/78] ASoC: dapm: change snprintf to scnprintf for possible overflow
Date:   Mon,  4 Mar 2019 09:22:05 +0100
Message-Id: <20190304081626.488896041@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e581e151e965bf1f2815dd94620b638fec4d0a7e ]

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 461d951917c05..6537069452226 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2028,19 +2028,19 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		out = is_connected_output_ep(w, NULL, NULL);
 	}
 
-	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
+	ret = scnprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
 		       w->name, w->power ? "On" : "Off",
 		       w->force ? " (forced)" : "", in, out);
 
 	if (w->reg >= 0)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				" - R%d(0x%x) mask 0x%x",
 				w->reg, w->reg, w->mask << w->shift);
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (w->sname)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, " stream %s %s\n",
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, " stream %s %s\n",
 				w->sname,
 				w->active ? "active" : "inactive");
 
@@ -2053,7 +2053,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 			if (!p->connect)
 				continue;
 
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					" %s  \"%s\" \"%s\"\n",
 					(rdir == SND_SOC_DAPM_DIR_IN) ? "in" : "out",
 					p->name ? p->name : "static",
-- 
2.19.1



