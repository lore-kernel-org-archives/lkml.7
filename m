Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE2EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDBB20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049973;
	bh=opmfsv0wChM/9oH9qa8TgdAbD2XpGsUxztxQzN082dA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nciR6STFCnunl2bPq+bHUqoLW6FI9ZC6flMLAAaFXcAwKYBW9nCxPsUqS7PQI1MHV
	 JCLEKicIIj2Yf3xAWBdwEpPq2eYQgKOFYm4MjMzPAgFhxQknO7KjXDlbURD54liV4y
	 9+8x5dbby+NP7XXxcCYYOojq6Jn+MgPOP4hFyJXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfCHM7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfCHM73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA8B620449;
        Fri,  8 Mar 2019 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049968;
        bh=opmfsv0wChM/9oH9qa8TgdAbD2XpGsUxztxQzN082dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2takCTRAYJEZs81ZNkjODPybLVxsn7y+OCAKzgtgaU7T8mmYZWfw720nrjmaNUgZV
         rV4c1psqGpq2SMW6iMf0J/4AxAy4PUTGcwnzIUUH/4Ikx8yI1fAkrRkAr6yl92pasH
         7+WUNKvqbEpo+ijDhyGW+ZAra5MiYNPi34ZYtNBY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 08/68] staging: comedi: ni_660x: fix missing break in switch statement
Date:   Fri,  8 Mar 2019 13:49:38 +0100
Message-Id: <20190308124911.191235684@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -602,6 +602,7 @@ static int ni_660x_set_pfi_routing(struc
 	case NI_660X_PFI_OUTPUT_DIO:
 		if (chan > 31)
 			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}


