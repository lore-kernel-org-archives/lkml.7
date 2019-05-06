Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C3EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB2920C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153256;
	bh=FZWmhX0LOn08X+EAOqFfjr+hiP0Wt9oIwmgWAgU8zlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWBsOUgWTDZO4dzFnrcaAnhaTVyYu6AOMwD+uCldfKELNm7wcxRV+/YE0s91ovUtP
	 DtdGVTklJBiySDwpWV5IBbOwzqlZAsFXwSkTQ+qn46Zwmx6iqK+aW/1Za9NC7/SLsq
	 OGl2AsWXZsDLMtdwsYnaV3RQiiMPiHChpm1nOI2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfEFOeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbfEFOeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96D9204EC;
        Mon,  6 May 2019 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153251;
        bh=FZWmhX0LOn08X+EAOqFfjr+hiP0Wt9oIwmgWAgU8zlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZ5Oqdx+NgrPm5VNRgPBKaVGjPguNaawdIi/JVwGsMXpR+e8CvurPriDx5wS0YfX3
         wBZd2mVZYQ+Gnf5/SjlTHZzNJKX+DfEj2atmghKQYI9r8zA0DJV6F8IeSQ639+Be0s
         zyfkYOzG00+ioiEO56lJfoZUt3WKaWP/utOPYc18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 5.0 003/122] ARC: memset: fix build with L1_CACHE_SHIFT != 6
Date:   Mon,  6 May 2019 16:31:01 +0200
Message-Id: <20190506143055.015504901@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit 55c0c4c793b538fb438bcc72481b9dc2f79fe5a9 upstream.

In case of 'L1_CACHE_SHIFT != 6' we define dummy assembly macroses
PREALLOC_INSTR and PREFETCHW_INSTR without arguments. However
we pass arguments to them in code which cause build errors.
Fix that.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: <stable@vger.kernel.org>    [5.0]
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/lib/memset-archs.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arc/lib/memset-archs.S
+++ b/arch/arc/lib/memset-archs.S
@@ -30,10 +30,10 @@
 
 #else
 
-.macro PREALLOC_INSTR
+.macro PREALLOC_INSTR	reg, off
 .endm
 
-.macro PREFETCHW_INSTR
+.macro PREFETCHW_INSTR	reg, off
 .endm
 
 #endif


