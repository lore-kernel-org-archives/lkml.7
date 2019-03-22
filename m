Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4095C21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254605;
	bh=zIf3H3NQHQ/V8DZP6agMe5ctNOflHsJP6oqSOaY1qnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWp6aiNRvjHMwLXSK1O52RTl4D2bZAPyCjXTl/nEoQJK63poNPee2VW+CxSosFUto
	 7j3TiJTWD8fGBFv8X5vt1tLJ15aFaeBW8e+JjrsKQn9h9fC6/hb3OAkd2s7lfbF1N8
	 dAvW6unCHboYCVgiuplUmmZ2jmP3oJsf1iMW6Nj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbfCVLgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbfCVLgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E75B2082C;
        Fri, 22 Mar 2019 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254597;
        bh=zIf3H3NQHQ/V8DZP6agMe5ctNOflHsJP6oqSOaY1qnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q67MS+sTqD2uCmS7PhZN+q34xKh5Ug6Va3wFT8FbcHQ/jJtTUrBF8BZZVWSpqb34p
         G8z7mtcHyVcL0ZsvCXKbwsDm2l5218Gr1F2Z4BqLj8fy5dNu5Uu4WEN7T9aYKrysIW
         7wsST9Tvv2/iQ3HJYdclJipq3l6txENb9LzOXKwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4.4 185/230] clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown
Date:   Fri, 22 Mar 2019 12:15:23 +0100
Message-Id: <20190322111249.763966401@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stuart Menefy <stuart.menefy@mathembedded.com>

commit d2f276c8d3c224d5b493c42b6cf006ae4e64fb1c upstream.

When shutting down the timer, ensure that after we have stopped the
timer any pending interrupts are cleared. This fixes a problem when
suspending, as interrupts are disabled before the timer is stopped,
so the timer interrupt may still be asserted, preventing the system
entering a low power state when the wfi is executed.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/exynos_mct.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -402,6 +402,7 @@ static int set_state_shutdown(struct clo
 
 	mevt = container_of(evt, struct mct_clock_event_device, evt);
 	exynos4_mct_tick_stop(mevt);
+	exynos4_mct_tick_clear(mevt);
 	return 0;
 }
 


