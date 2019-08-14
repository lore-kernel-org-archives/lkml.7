Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B152C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A421721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802530;
	bh=S8IPL5fdFrB1YEC+xEAXvBeryNQRoErBMjsR/WoHJrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nD/uD84jUJwfkJXfaPgfOI/Fr+4mwdMjLdPIgL518nvSU/cL8o9nRwRWoNwR7ovD5
	 eEie372jUZqhAswgilfsJgJBr//TS92hUUKoKc4opxJwy/AcKCJYRzD16GljnBdBX3
	 hpqnPDqDtU+q06LAHWqAZSNm5ixFxmtszFjwqnDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfHNRIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730206AbfHNRIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B88CF2084D;
        Wed, 14 Aug 2019 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802526;
        bh=S8IPL5fdFrB1YEC+xEAXvBeryNQRoErBMjsR/WoHJrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzWGvUGgcH4bArDDEaj0k1XAZDVqdnxrc6Hoju83GH2NbmthsybPBKLRDdVJG6c8e
         bF2cFdNK9CZa8zub8WjraLQ+npeSSPR+LvuGEv3zXG5hJaKR39tGOPRVycfh/pNRqt
         asxkN1YTWvu0TyTriM+kfpVtG6KRPsaOseTPYS9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nate Graham <pointedstick@zoho.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 16/91] Input: synaptics - enable RMI mode for HP Spectre X360
Date:   Wed, 14 Aug 2019 19:00:39 +0200
Message-Id: <20190814165750.441808408@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
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
@@ -185,6 +185,7 @@ static const char * const smbus_pnp_ids[
 	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
+	"SYN323d", /* HP Spectre X360 13-w013dx */
 	NULL
 };
 


