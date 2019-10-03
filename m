Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2407C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E9221783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119202;
	bh=AMxdu2iAMkSh3XMhlH/qsHZK8WG69YqnxAMbGUcPvu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XFCebWL6afSA/3tE0Lx1+DsDezX3WjsVdd23aAMz6qPb7QMBW5X5cHLpZzpop1OYX
	 bimR/nVd8Ndo/9GXZ6aqaRIsFZQGOWQdN1lnb29lYGPDv0LLW607cYj5WA5N+u+MIA
	 fuD2WCBO/mSpRnwApBBKGVnwaD/zXJV2AxJHbghw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388270AbfJCQNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbfJCQNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C03A21D81;
        Thu,  3 Oct 2019 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119198;
        bh=AMxdu2iAMkSh3XMhlH/qsHZK8WG69YqnxAMbGUcPvu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YG0Ng4vdPu4UmffPQC97SF+YSfkhOh8qC081+lBRgr6FXnYJEvFWZMvsajDr6NAps
         jJE4CLSbgqZzZu6Hap/1WnTMIV+efM+PL+Lm+7WxEP2TLrpHrBCRPPWZzHHwCbrvLn
         qfvPQhxPJGOboJd+hXdhSGXrmdHCshzXIyif1jfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 161/185] alarmtimer: Use EOPNOTSUPP instead of ENOTSUPP
Date:   Thu,  3 Oct 2019 17:53:59 +0200
Message-Id: <20191003154515.507387737@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit f18ddc13af981ce3c7b7f26925f099e7c6929aba upstream.

ENOTSUPP is not supposed to be returned to userspace. This was found on an
OpenPower machine, where the RTC does not support set_alarm.

On that system, a clock_nanosleep(CLOCK_REALTIME_ALARM, ...) results in
"524 Unknown error 524"

Replace it with EOPNOTSUPP which results in the expected "95 Operation not
supported" error.

Fixes: 1c6b39ad3f01 (alarmtimers: Return -ENOTSUPP if no RTC device is present)
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190903171802.28314-1-cascardo@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/alarmtimer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -676,7 +676,7 @@ static int alarm_timer_create(struct k_i
 	enum  alarmtimer_type type;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (!capable(CAP_WAKE_ALARM))
 		return -EPERM;
@@ -794,7 +794,7 @@ static int alarm_timer_nsleep(const cloc
 	int ret = 0;
 
 	if (!alarmtimer_get_rtcdev())
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (flags & ~TIMER_ABSTIME)
 		return -EINVAL;


