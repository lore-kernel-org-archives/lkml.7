Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609DC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3FC02080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432381;
	bh=I4sA8xivLMNO6CwOvF8xUiTpBfs0ILrKpvdBotPbsgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F/Vek5V5strPdJCm+2IV99uzJ4KP7pCQWf1/HEeJKCQfFSFhGSdNaG9v5enoHKnbb
	 bsHOjdNUXuZABaz90sCXWZleY1FZmkBAl70o8MUcgYjoZlAST/wvLTCRvnymbD0Ysl
	 P1o/PReOJzGpOCIZM8S+/nQzxgpacI+59UoZObnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgAGU7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbgAGU67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:58:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C5A214D8;
        Tue,  7 Jan 2020 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430739;
        bh=I4sA8xivLMNO6CwOvF8xUiTpBfs0ILrKpvdBotPbsgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBzJxrWo6opNHjJafhiAeoXLzrXHjyNQl5NqaC55+1XMHamBnNlTaG7UCdHxCPcIh
         tYBuj4e4flBWoQrkxjwJAjUSJu1Fw+ZGv36Nf9ENUzXpmmB7ZMlU7WkbiEaakXhPHN
         w0PYbvkyPtaA/dvJEwpI9QFPufz3zoqQsOsaUxAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Wang <kevin1.wang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 075/191] drm/amdgpu/smu: add metrics table lock for vega20 (v2)
Date:   Tue,  7 Jan 2020 21:53:15 +0100
Message-Id: <20200107205336.995040961@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 1c455101c6d10c99b310d6bcf613244c97854012 upstream.

To protect access to the metrics table.

v2: unlock on error

Bug: https://gitlab.freedesktop.org/drm/amd/issues/900
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1691,17 +1691,20 @@ static int vega20_get_metrics_table(stru
 	struct smu_table_context *smu_table= &smu->smu_table;
 	int ret = 0;
 
+	mutex_lock(&smu->metrics_lock);
 	if (!smu_table->metrics_time || time_after(jiffies, smu_table->metrics_time + HZ / 1000)) {
 		ret = smu_update_table(smu, SMU_TABLE_SMU_METRICS, 0,
 				(void *)smu_table->metrics_table, false);
 		if (ret) {
 			pr_info("Failed to export SMU metrics table!\n");
+			mutex_unlock(&smu->metrics_lock);
 			return ret;
 		}
 		smu_table->metrics_time = jiffies;
 	}
 
 	memcpy(metrics_table, smu_table->metrics_table, sizeof(SmuMetrics_t));
+	mutex_unlock(&smu->metrics_lock);
 
 	return ret;
 }


