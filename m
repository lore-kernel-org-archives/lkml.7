Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA55AC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812F62173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802189;
	bh=Ai9mdzmAQV6krN547EwEtMM1Fzq6SgfTUAV5HDQIVTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WHuxwtV/xVcmmbRnB4t9r43k7NLXmXcL+nB2r+nKqB2iK8xQF9vaRdctrp3FVgHOC
	 JDlW+GqPUsZnwasK4iTbV3gWATr/C/FuIKMNmVcjk3RsqVV+qp/r+8QfI/+75975pV
	 ySDzrXnCAzQ7eZauEftGUir7XCV5/sy4YcQETHbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfHNRDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbfHNRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:03:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69C9208C2;
        Wed, 14 Aug 2019 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802184;
        bh=Ai9mdzmAQV6krN547EwEtMM1Fzq6SgfTUAV5HDQIVTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTRpDLmOt2Fek0N1XfKkYE9lpCimXXwaOV7bNW7EnoFPoIxJZQU951gHCf2VtcC4V
         /IKmB/84FhJdIh6+3vMxcNnD0QSDAAU+eeb5ADi18rgetmv/b3U/0ZlZ+nj/wX5B9T
         g8aNVG1tijmx/SU/uGovckOeYVAqjhpz98CP8i90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nate Graham <pointedstick@zoho.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.2 026/144] Input: synaptics - enable RMI mode for HP Spectre X360
Date:   Wed, 14 Aug 2019 18:59:42 +0200
Message-Id: <20190814165800.938400177@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 25f8c834e2a6871920cc1ca113f02fb301d007c3 upstream.

The 2016 kabylake HP Spectre X360 (model number 13-w013dx) works much better
with psmouse.synaptics_intertouch=1 kernel parameter, so let's enable RMI4
mode automatically.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204115
Reported-by: Nate Graham <pointedstick@zoho.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,6 +182,7 @@ static const char * const smbus_pnp_ids[
 	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
+	"SYN323d", /* HP Spectre X360 13-w013dx */
 	NULL
 };
 


