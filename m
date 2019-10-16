Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FE5ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C85A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZcrc7dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391815AbfJPJGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:06:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36252 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfJPJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:06:32 -0400
Received: by mail-lf1-f67.google.com with SMTP id u16so4224191lfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3rHYjSn/fPz1RWaGjBzSPmxHyXb9HMcMJGjWVoGxGPI=;
        b=dZcrc7drlitYAWv20+Jq+uoC3xeizi2y47hD+dcBI2t4uPjxpcp2vBpQlHoDF2Mtk0
         ApHd8bnow5M64tUmafJ4NE16aNjESmPHQ7PRdmzIMK/l3uKLHUsmmCay9YyLMU+8ChGb
         X/aIMvNuszj82rbR1lnz7ozOPesUo7C2MHpJg045uuFs8SCPlLzfyHoov7Qmu3M2rbNq
         1/AqGNaDpIx898NzGen4hZhvULlOG+xzHUXPFNMPAqlvcfkrxgm/4mY87Cq105PUINXw
         JqH0sIBaNqxewfqATCc+7CjF58hfRGq/bsfSrjBGxmOQwmOWZNvgSDIJIqHZfQ6+7Xud
         kXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3rHYjSn/fPz1RWaGjBzSPmxHyXb9HMcMJGjWVoGxGPI=;
        b=IYdXHn9aq/ImWnYlPnD3ewUo/E84PDgHKpxzlhg9/SE1vKLYvqHzZ+WpXZ3QW+zbfh
         tFY4zlhrWRuCP6Zm+iWoyOQByJZPcfubDWyWvZziuga6COa4KtCxJRz5mTDHBe0FGRn2
         sWaU0n4Jf8URJS1MJ8AWhgBXcfU7kRvyv69H3wXdgGM2GKXC08sup1nyMWQSnmB2L8bv
         LpuYZgeQCMyrzuxpNMJTS7fMz0KVuqZPJMdFnSL6OTF2DpmD1jQHwM9vbCufWU9vfTx+
         hTYf+tdOPicrSNicWAunbwR8mtOZGt19mRJPA5xbQhp7AeVN0Cm6kWQWI1IHSyameSpO
         8+Sg==
X-Gm-Message-State: APjAAAVutr0ZC3lz3toQ5qApQMPRL3Suq2DoE1hBNpJS+kldw/73+ets
        xvVLyJYJY5KRivcMhAdCMXqFRfCaXEJycQ==
X-Google-Smtp-Source: APXvYqz3/NNjkhaIQyTJX9b35fU8jvLbes0EA17X2xo/PmZ8MWdseCUjfXMlz7gWyLq9Kpg4hqy9SQ==
X-Received: by 2002:a19:c518:: with SMTP id w24mr5616642lfe.14.1571216789905;
        Wed, 16 Oct 2019 02:06:29 -0700 (PDT)
Received: from localhost ([78.133.233.210])
        by smtp.gmail.com with ESMTPSA id v203sm215365lfa.25.2019.10.16.02.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 02:06:29 -0700 (PDT)
Date:   Wed, 16 Oct 2019 11:06:12 +0200
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     mark.rutland@arm.com, will.deacon@arm.com, pawel.moll@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] bus: arm-ccn: Enable stats for CCN-512
 interconnect
Message-ID: <20191016110612.17381ad6@gmail.com>
In-Reply-To: <1570454475-2848-1-git-send-email-marek.bykowski@gmail.com>
References: <1570454475-2848-1-git-send-email-marek.bykowski@gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the ARM CCN-502 interconnect

Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
Signed-off-by: Boleslaw Malecki <boleslaw.malecki@tieto.com>
---
Changelog v1->v2:
- Change the subject to reflect where the driver got moved to (drivers/perf) from
  (drivers/bus).
- Add credit to my work mate that helped me validate the counts from
  the interconnect.
---
 drivers/perf/arm-ccn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 7dd850e02f19..b6e00f35a448 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1545,6 +1545,7 @@ static int arm_ccn_remove(struct platform_device *pdev)
 static const struct of_device_id arm_ccn_match[] = {
        { .compatible = "arm,ccn-502", },
        { .compatible = "arm,ccn-504", },
+       { .compatible = "arm,ccn-512", },
        {},
 };
 MODULE_DEVICE_TABLE(of, arm_ccn_match);
