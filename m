Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2134D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254260;
	bh=ciCGRQ8agMPxD0ZP2VpUQnJMH3KcB2/Rdac3/fd+n/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFqBMtj5cFACLu/oCvHlyLflOngyGJg4lv6q0mW/eo6HSZq8hqGyT6V5QkFpPWzjt
	 p8nUgnpf8ef7Q6HpHPtwYrTcYegS23kX+BUnfBojsM/8dPzuojtb0dh7vsLYIuclTf
	 8GBzrLWJsxxj1xHbKquK24L79WQDB+fPzSdO9QyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfCVLa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfCVLa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CA82183E;
        Fri, 22 Mar 2019 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254255;
        bh=ciCGRQ8agMPxD0ZP2VpUQnJMH3KcB2/Rdac3/fd+n/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spKy3rvALZFmKZfXLw4b2UDMCIdUAOc7jmXNPFrzvaU4oydSJl5USH1Up95CaAV0N
         S+ZLnJF+MeS+sFrUP3X+ZURCgu/TpDIqlAm4yvp11+Y8IshZTqqo5s+r4Jw+x49iOa
         xHuBEYhYe4XGT+F2O5UXkJf9HegUi4m4yCexnMMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 061/230] isdn: isdn_tty: fix build warning of strncpy
Date:   Fri, 22 Mar 2019 12:13:19 +0100
Message-Id: <20190322111240.970532600@linuxfoundation.org>
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


