Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E1EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2C22087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049473;
	bh=WYl/3MxplEp/uZgXMp6F71oMK2d+IIkCXRAhvZkhEx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xOIXsMpBKI34Gts/SgEuxVgyAtroAgylBqVZKF5oZDe9sHAOzQsYOLojirVY1UQvv
	 V3gEVKffXW0rtbYKR+FPy6FSLM5iTQecYBqK8WuMcM05M4j7E4jepo/VEcI+ce3BBi
	 R+DiisU4q4ew9pU8/j9HtP5T1WLKJgKwm/EAah1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCHMvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfCHMvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:51:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B05A20684;
        Fri,  8 Mar 2019 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049468;
        bh=WYl/3MxplEp/uZgXMp6F71oMK2d+IIkCXRAhvZkhEx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXIEp906kfUtr3192GhHN4FKi/c41lESBApNRmGcbIMBtBU2OCNFYhQsinyzhwjOl
         B29N3V9CCMqKkbjzxAikPbFGt6XY3fR+lTbzZt5Md8owtdy9vINXn1W2GKI85Iewzg
         jYv+QryrjJUpIdMGWgNOMEKczOz/DduBuLalXElA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 5.0 12/46] staging: comedi: ni_660x: fix missing break in switch statement
Date:   Fri,  8 Mar 2019 13:49:45 +0100
Message-Id: <20190308124903.042940286@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -656,6 +656,7 @@ static int ni_660x_set_pfi_routing(struc
 	case NI_660X_PFI_OUTPUT_DIO:
 		if (chan > 31)
 			return -EINVAL;
+		break;
 	default:
 		return -EINVAL;
 	}


