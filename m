Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDAFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D932465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781955;
	bh=J5/14ErjQFX/vUZvANlmfZEZ14nE/YRklZ5JEAAXeqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sGkmSKkFOv3k5HdlJbS2SWU/PgTFILef+8nHSzPOdj+P4lwtxUEetUveBTq4rBadq
	 X6XRgIqRxkxUczE3OcBUagwjzK3NTkOpXD4+39lmdJ8b+RozjhoTpEXsbX0jQJ57lr
	 PWWnux463HcY5tR7VyxavmdfPdnlFvTIn48nmGOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfLSS7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbfLSSxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:53:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443EA20674;
        Thu, 19 Dec 2019 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781624;
        bh=J5/14ErjQFX/vUZvANlmfZEZ14nE/YRklZ5JEAAXeqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4fTqlmljGM47x95GjNMy659zFC5Ocrd91E/3nsQPq/vSE8C+8cFjdRMvPzm3AXwG
         yqRUSW6U0RSIOgZZ7rCWmLT03rFvORVj2GMlFilaf1dAI5zQsJmtTAZYp0GxmbfiiO
         ErRUqjGM6CqMflVYzNtu92kkXZ8LxZQahV+m2p28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 14/80] PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
Date:   Thu, 19 Dec 2019 19:34:06 +0100
Message-Id: <20191219183050.779066263@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit c6a3aea93571a5393602256d8f74772bd64c8225 upstream.

QOS requests for DEFAULT_VALUE are supposed to be ignored but this is
not the case for FREQ_QOS_MAX. Adding one request for MAX_DEFAULT_VALUE
and one for a real value will cause freq_qos_read_value to unexpectedly
return MAX_DEFAULT_VALUE (-1).

This happens because freq_qos max value is aggregated with PM_QOS_MIN
but FREQ_QOS_MAX_DEFAULT_VALUE is (-1) so it's smaller than other
values.

Fix this by redefining FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX.

Looking at current users for freq_qos it seems that none of them create
requests for FREQ_QOS_MAX_DEFAULT_VALUE.

Fixes: 77751a466ebd ("PM: QoS: Introduce frequency QoS")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reported-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/pm_qos.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -256,7 +256,7 @@ static inline s32 dev_pm_qos_raw_resume_
 #endif
 
 #define FREQ_QOS_MIN_DEFAULT_VALUE	0
-#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
+#define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
 
 enum freq_qos_req_type {
 	FREQ_QOS_MIN = 1,


