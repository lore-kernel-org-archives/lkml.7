Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9762FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A518B2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264361;
	bh=DmvXu861D0JAOm9UiLmDprTiTVdkfENg31SHjbS4Fzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1ZQNhvVwgkqQNzzSWR2KPjxdhnhLXDiQ1qYYC56XRzjTQOYUxg5cxj4fd2NhUh1T
	 R7W+Vk+PeuX4xlDC/d2athmeyyfvB11OS/egL8iL+56Tz/R3dewM/ThNpFHftuRPt9
	 ltL7x/XYZGTwXsszVoH/PS7cLxDHnmtFTOG6hjYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395187AbfJPWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437684AbfJPVyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:08 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EE821D7D;
        Wed, 16 Oct 2019 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262848;
        bh=DmvXu861D0JAOm9UiLmDprTiTVdkfENg31SHjbS4Fzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlquz3YV1QHRTyvOKFj9Sh1xcllHB7COlpz3fbfGTFdoDWMHh6Nz308uhvNihla4d
         3OKULuLoZVQgX/9sNpH0xRaTIDYPaHqix5vfLnjcKgso92Ki2udGD3gVPDJSxcgLeB
         w7wfS6snSNce2ua2OG+J7OyNWamNvzyVhQNAeNoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 06/92] ASoC: Define a set of DAPM pre/post-up events
Date:   Wed, 16 Oct 2019 14:49:39 -0700
Message-Id: <20191016214804.035774055@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

commit cfc8f568aada98f9608a0a62511ca18d647613e2 upstream.

Prepare to use SND_SOC_DAPM_PRE_POST_PMU definition to
reduce coming code size and make it more readable.

Cc: stable@vger.kernel.org
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/20190719100524.23300-2-oleksandr.suvorov@toradex.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/soc-dapm.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -339,6 +339,8 @@ struct device;
 #define SND_SOC_DAPM_WILL_PMD   0x80    /* called at start of sequence */
 #define SND_SOC_DAPM_PRE_POST_PMD \
 				(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
+#define SND_SOC_DAPM_PRE_POST_PMU \
+				(SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU)
 
 /* convenience event type detection */
 #define SND_SOC_DAPM_EVENT_ON(e)	\


