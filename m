Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3636C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0412081E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573798962;
	bh=R/yEUO+q2waTOvNlrvQlDw37xD7IuqRvVUN46oEIu2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hDUedITfXEhdYzlfWNp1J2CBfv8leUWzWBKznW2WjUY8x32qhrWsiMP+oXZI93w4j
	 2OVAKrvTNY1bZzRsfmAHLICJ7nTRegzXCmxaJVJjD+NERDjc75bluHYLXyricB4Rsm
	 8rK0NO3wLNLftzKj/lZESnvbrYxa6VZKAnfRnvw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfKOGWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfKOGW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:22:28 -0500
Received: from localhost (unknown [104.132.150.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0374420637;
        Fri, 15 Nov 2019 06:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573798947;
        bh=R/yEUO+q2waTOvNlrvQlDw37xD7IuqRvVUN46oEIu2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppC1+6xATCY/0B63pAUn/9vsF5maHjERQpZDulcgtPe/oGlniGXbFxaDGAY+uzy1R
         /qPBOW0VsIWUy7ZNoL5+7XMREtchEPpM1vy7QsGKWy7LRx/fOoefhCeZLf27PdUqWq
         RSffTrI7xbd2cJMp95d3FFCZH71QTIPL6k4V+CW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 03/31] MIPS: BCM63XX: fix switch core reset on BCM6368
Date:   Fri, 15 Nov 2019 14:20:32 +0800
Message-Id: <20191115062010.879739177@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115062009.813108457@linuxfoundation.org>
References: <20191115062009.813108457@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 8a38dacf87180738d42b058334c951eba15d2d47 upstream.

The Ethernet Switch core mask was set to 0, causing the switch core to
be not reset on BCM6368 on boot. Provide the proper mask so the switch
core gets reset to a known good state.

Fixes: 799faa626c71 ("MIPS: BCM63XX: add core reset helper")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm63xx/reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -119,7 +119,7 @@
 #define BCM6368_RESET_DSL	0
 #define BCM6368_RESET_SAR	SOFTRESET_6368_SAR_MASK
 #define BCM6368_RESET_EPHY	SOFTRESET_6368_EPHY_MASK
-#define BCM6368_RESET_ENETSW	0
+#define BCM6368_RESET_ENETSW	SOFTRESET_6368_ENETSW_MASK
 #define BCM6368_RESET_PCM	SOFTRESET_6368_PCM_MASK
 #define BCM6368_RESET_MPI	SOFTRESET_6368_MPI_MASK
 #define BCM6368_RESET_PCIE	0


