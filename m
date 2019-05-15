Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EC9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF5216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919691;
	bh=7ukt3jvRBNYDflfRTIJXNHeIRiJ3xrKkSULaQME/Hjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qkvROzzOnQahvWu1rdeAfJ/n3y9VD3rQfD2aUKXEHvhoA15bPhCZ7oIt8J6uMfpL5
	 MB9L/Tv7SHXPep3cC+ZtbpgIBxpfyEn8UEQdwMn2xdUW59I6W1l2MBgfrcRdvnyDfY
	 a1VJYS96YIqqtOo+JOqKTW2l3reQMcg2WKOkFzjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbfEOL2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEOL2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:28:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F572084A;
        Wed, 15 May 2019 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919686;
        bh=7ukt3jvRBNYDflfRTIJXNHeIRiJ3xrKkSULaQME/Hjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3dXf26lNZjbirsgppepz/h+cNe3xPYrHnA3xSG2fBUkz1v88guo7tr+1S8dlIyeD
         l2PWNnYI/TO2d0en8lK+fgLfspU7kGANrIzldLD9FPnPJ2ho8GAzhc8x7AQCMK7tXs
         xegnftulp8QjrKLrvompzpoCBLuO+aVgfhsQK3lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Camuso <tcamuso@redhat.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 055/137] ipmi: ipmi_si_hardcode.c: init si_type array to fix a crash
Date:   Wed, 15 May 2019 12:55:36 +0200
Message-Id: <20190515090657.484044664@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a885bcfd152f97b25005298ab2d6b741aed9b49c ]

The intended behavior of function ipmi_hardcode_init_one() is to default
to kcs interface when no type argument is presented when initializing
ipmi with hard coded addresses.

However, the array of char pointers allocated on the stack by function
ipmi_hardcode_init() was not inited to zeroes, so it contained stack
debris.

Consequently, passing the cruft stored in this array to function
ipmi_hardcode_init_one() caused a crash when it was unable to detect
that the char * being passed was nonsense and tried to access the
address specified by the bogus pointer.

The fix is simply to initialize the si_type array to zeroes, so if
there were no type argument given to at the command line, function
ipmi_hardcode_init_one() could properly default to the kcs interface.

Signed-off-by: Tony Camuso <tcamuso@redhat.com>
Message-Id: <1554837603-40299-1-git-send-email-tcamuso@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_si_hardcode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index 1e5783961b0dc..ab7180c46d8dd 100644
--- a/drivers/char/ipmi/ipmi_si_hardcode.c
+++ b/drivers/char/ipmi/ipmi_si_hardcode.c
@@ -201,6 +201,8 @@ void __init ipmi_hardcode_init(void)
 	char *str;
 	char *si_type[SI_MAX_PARMS];
 
+	memset(si_type, 0, sizeof(si_type));
+
 	/* Parse out the si_type string into its components. */
 	str = si_type_str;
 	if (*str != '\0') {
-- 
2.20.1



