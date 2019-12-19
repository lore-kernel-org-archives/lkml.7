Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6636DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330E0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782059;
	bh=Q//61RN9LItSVmdixa1IcuRMoJtnJtN5/9X5PEz/Sok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10vy2XcfJDok/FXPQ75rEodBe/8+nG01tfey66WFGX2nL0obcH0QxDygJsX9Tl54a
	 ktGI8JzTsolB4lqg/W2FLNvzy3HBawa9yO7vQ5fZaJKxFx/YKEgjJAeXdub2lJfvv/
	 gRmF21XkQigeAGvIGRdKd91m+ioLC9j4bEEAtAu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfLSTA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbfLSSvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:51:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D149E2064B;
        Thu, 19 Dec 2019 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781491;
        bh=Q//61RN9LItSVmdixa1IcuRMoJtnJtN5/9X5PEz/Sok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fzb40CeMefwesy9pM0cEAbM8ipKeXRawX9Boqh15lRkc+7wPe3MPvAJRAcgeLld3x
         4Xntt5TWnufg0vByjKbvFTt1g1ybPPIYs01JtQ2p5ALHzxg5l1SN+x67lbFjF2wLPB
         uBVLKbh/2ixlMEsQnQTF87cJerh4EApYAmTvcTRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.14 22/36] rpmsg: glink: Put an extra reference during cleanup
Date:   Thu, 19 Dec 2019 19:34:39 +0100
Message-Id: <20191219182912.440983906@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
References: <20191219182848.708141124@linuxfoundation.org>
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
@@ -1613,6 +1613,10 @@ void qcom_glink_native_remove(struct qco
 	idr_for_each_entry(&glink->lcids, channel, cid)
 		kref_put(&channel->refcount, qcom_glink_channel_release);
 
+	/* Release any defunct local channels, waiting for close-req */
+	idr_for_each_entry(&glink->rcids, channel, cid)
+		kref_put(&channel->refcount, qcom_glink_channel_release);
+
 	idr_destroy(&glink->lcids);
 	idr_destroy(&glink->rcids);
 	spin_unlock_irqrestore(&glink->idr_lock, flags);


