Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F872183E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412644;
	bh=h7pOISYaU4beSsQJn5Fx1A4XwVYbIZ0AkqkIUxEtpCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcoeUZSBGjpx35db7+e6Xzs/KtlqTNZmUCiSjN97bBLQtFo2QelHhtIQq4nLDxc9J
	 dqNTPUbzzdn1NHEISw1rGbItORuAt8/Vq4+IoMDQKqSYK6zYSY9SKZjtE869FgVkW/
	 ckwpf3O/1X3xICsCypHPyBn19uUukEtEPQeujOTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfCLRoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbfCLRPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:43 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71FDA217D4;
        Tue, 12 Mar 2019 17:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410942;
        bh=h7pOISYaU4beSsQJn5Fx1A4XwVYbIZ0AkqkIUxEtpCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnF5/xTmsK1vicYoGcYKRirPQ0Gn05jpQxAxhItcHDHW1zCIbGNNWm0lqZvCk+Yeb
         q/WpgyN5it3taXTlBaBQjuVUyX1sgzWg25z6DbBTA3J3Qo16cxqjBAQTixo3lelAJh
         o0YuJSpjFbVXDUMJNTXsr4rqpIH04vPxemAVoTCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.14 005/135] staging: comedi: ni_660x: fix missing break in switch statement
Date:   Tue, 12 Mar 2019 10:07:32 -0700
Message-Id: <20190312170341.641854164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 479826cc86118e0d87e5cefb3df5b748e0480924 upstream.

Add missing break statement in order to prevent the code from falling
through to the default case and return -EINVAL every time.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: aa94f2888825 ("staging: comedi: ni_660x: tidy up ni_660x_set_pfi_routing()")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/ni_660x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/comedi/drivers/ni_660x.c
+++ b/drivers/staging/comedi/drivers/ni_660x.c
@@ -611,6 +611,7 @@ static int ni_660x_set_pfi_routing(struc
 	case NI_660X_PFI_OUTPUT_DIO:
 		if (chan > 31)
 			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}


