Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96897C33CA2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623D420678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431226;
	bh=Q8FFZzskH42W+dZJS5N+XgnIUV7Y6jfVYJgYcjiKedE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AE5BtFPRANm8/uzMVaTDQL/7oJexlsQpv/wRwRNiSqE7+1VndWBi9hJL/tGtz/nHs
	 Z8aHtiMWlfk++RsI8qE+10bFVde/CN3veSVxMX3MQkycUisLYHOqBR+I7Ht/anU1P0
	 8LqaWNIhUo+nk7J3X7pahmllGPxs1A6J/16DKdIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgAGVHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbgAGVG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:06:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535B520678;
        Tue,  7 Jan 2020 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431216;
        bh=Q8FFZzskH42W+dZJS5N+XgnIUV7Y6jfVYJgYcjiKedE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2SZCanrzix3MHRxUjjvd2ezZ7K3UPzWZnMxDQE/cD80b0C4KfKtU8bqEG8scBBel
         dd4BFqwuY7yiGLxmawEDpMVuP2U44DTxnX546UXcAnG+9q2KKwFIyx0gzxJFYiQrxV
         Ob/C5Wa7QIXDAf6K+TRxt+mkzZS+exHS69thlJEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.19 080/115] PM / devfreq: Check NULL governor in available_governors_show
Date:   Tue,  7 Jan 2020 21:54:50 +0100
Message-Id: <20200107205304.594285302@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit d68adc8f85cd757bd33c8d7b2660ad6f16f7f3dc upstream.

The governor is initialized after sysfs attributes become visible so in
theory the governor field can be NULL here.

Fixes: bcf23c79c4e46 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1086,7 +1086,7 @@ static ssize_t available_governors_show(
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor->immutable) {
+	if (df->governor && df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				   "%s ", df->governor_name);
 	/*


