Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C2EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26684222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781937;
	bh=S/9+xWGmWDXPr3s3nImnrjBM7AWKWG9skAhDeJV1tWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dy3r3SeWm9zzDJGarR3LdGEPddx+k4AAn0TwjNWUt9q6R3xThN5QRuZygMoQbkJUO
	 45K5Z8yBCKFVfAegZMd7DPXxpM5JKWRRM51XaMuysXvmw4SUjC6WnAeEbTd2GhfrC+
	 R6M3V7xQMv+HPPRGiyNDVpfts6+rieUi7AKSMTew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfLSS6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbfLSSyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E1B2465E;
        Thu, 19 Dec 2019 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781651;
        bh=S/9+xWGmWDXPr3s3nImnrjBM7AWKWG9skAhDeJV1tWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRUq+m3tzdRV1Ozygmyxmsplap4YImdkWRspOtaxzP8bxqhl1RbfVQ5n2vK+DWJf4
         xl3FLjKKedorWSjXhOWYqjiAvTyv3wONQtsIGx26Rpg4eDnlLnfWhlf7TPYq9XxXTi
         Njawrm/nG6Z4vOOCOHNMs0UexEYCH6tGud9D+MlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.4 24/80] rpmsg: glink: Put an extra reference during cleanup
Date:   Thu, 19 Dec 2019 19:34:16 +0100
Message-Id: <20191219183102.112015951@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

commit b646293e272816dd0719529dcebbd659de0722f7 upstream.

In a remote processor crash scenario, there is no guarantee the remote
processor sent close requests before it went into a bad state. Remove
the reference that is normally handled by the close command in the
so channel resources can be released.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Chris Lew <clew@codeaurora.org>
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_glink_native.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1641,6 +1641,10 @@ void qcom_glink_native_remove(struct qco
 	idr_for_each_entry(&glink->lcids, channel, cid)
 		kref_put(&channel->refcount, qcom_glink_channel_release);
 
+	/* Release any defunct local channels, waiting for close-req */
+	idr_for_each_entry(&glink->rcids, channel, cid)
+		kref_put(&channel->refcount, qcom_glink_channel_release);
+
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
 	spin_unlock_irqrestore(&glink->idr_lock, flags);


