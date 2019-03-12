Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFA4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A262175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411254;
	bh=79wUbzp7nPmJ94wVXs4effWx7GlSWWHoHaWsj9HeAWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ha+ehOFTbI5YyMzXckzb9X4TULlKNMEnIJBi53gnJ8pb1UvdYvuHob1/ZD3hbrs1x
	 2uDpo9pnyya4w1kq3aeTrmvxTMdXYWnTGC0ixuF1WyqjpM8+CdoprtwisFFJBEf84X
	 VlpktFmXamlPSBsDY577Aovgq+JPI2cebeMLQxn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfCLRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbfCLRSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:18 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F0621871;
        Tue, 12 Mar 2019 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411097;
        bh=79wUbzp7nPmJ94wVXs4effWx7GlSWWHoHaWsj9HeAWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ecC2o/JZBNF2R7cBwWQQLiPh7h297Z6y2cTVPJJZdFWCZqZfDquTFuuYv2zwoZj+I
         IL3ecizonLudDDz+9zmvAZbLNsuEiTBqhtGSVYcAFC6OaGyanFdOFgMCn1lsNz4WAH
         QqOZHi3phKbHU/Nyi+wLO5+Y0iMXQ7EyRH+/5Cq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 87/96] scsi: aacraid: Fix missing break in switch statement
Date:   Tue, 12 Mar 2019 10:10:45 -0700
Message-Id: <20190312171041.040747384@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 5e420fe635813e5746b296cfc8fff4853ae205a2 upstream.

Add missing break statement and fix identation issue.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: 9cb62fa24e0d ("aacraid: Log firmware AIF messages")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/commsup.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -1179,8 +1179,9 @@ static void aac_handle_aif(struct aac_de
 				  ADD : DELETE;
 				break;
 			}
-			case AifBuManagerEvent:
-				aac_handle_aif_bu(dev, aifcmd);
+			break;
+		case AifBuManagerEvent:
+			aac_handle_aif_bu(dev, aifcmd);
 			break;
 		}
 


