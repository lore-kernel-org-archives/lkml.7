Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A329C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B521214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411344;
	bh=1lg+rFx6CkPchOLeeK09WLTzJX9MI/9JizFRxUjE2nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h7T+yhBj+SVvFxO78KcFUiWIZT15b+FYualDvaADm/iC33RmEoC2Lj1Tnanv1WOpp
	 DJrPg0KX3WsUmg1tj2pxnjX3pm3Ug62e096djGevzKuT8FJcWwgT7EkISUvOJ5+K9v
	 /UKDP3KygTC8Szv2IIOFeUKHkkqJkVF/itmYoXqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfCLRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729561AbfCLRRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7109C217D8;
        Tue, 12 Mar 2019 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411042;
        bh=1lg+rFx6CkPchOLeeK09WLTzJX9MI/9JizFRxUjE2nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1RV4aYh+hH3X7d4vx5F8gaoJfTaVefSILiKD1onGv4cvHSgTtIrPc85wZ5va4mgZ
         5o749Ju1MEZvUN/+rHrJdXUYqN49Lcu/xYMx+s0sFLf86iACYCEldV9l7ZxfPKi4tr
         EeG+E1BrrPRIeMvDsPMGxlQbG1+5bfcVbeK6ApYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.9 06/96] isdn: isdn_tty: fix build warning of strncpy
Date:   Tue, 12 Mar 2019 10:09:24 -0700
Message-Id: <20190312171035.046614312@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Not upstream as isdn is long deleted.

Fix up a strncpy build warning for isdn_tty_suspend() using strscpy.

It's not like anyone uses this code anyway, and this gets rid of a build
warnings so that we can see real warnings as they pop up over time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/isdn/i4l/isdn_tty.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -786,7 +786,7 @@ isdn_tty_suspend(char *id, modem_info *i
 		cmd.parm.cmsg.para[3] = 4; /* 16 bit 0x0004 Suspend */
 		cmd.parm.cmsg.para[4] = 0;
 		cmd.parm.cmsg.para[5] = l;
-		strncpy(&cmd.parm.cmsg.para[6], id, l);
+		strscpy(&cmd.parm.cmsg.para[6], id, l);
 		cmd.command = CAPI_PUT_MESSAGE;
 		cmd.driver = info->isdn_driver;
 		cmd.arg = info->isdn_channel;


