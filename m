Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411770;
	bh=jzpK9kJxk0aSH8lmwKTIvvZA2hn3CLP/vegAvnNXzWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MKpyHgWMhHxrjMTTQWnkQyxEMdMhTJIMzEvahMJYOO3/9WV335BsE3Kop5TW3zEf
	 na0Kh9Vl39+Dzraqc/qut4z/5MCqUTp0A2OQZe5yqoKLPuX0A9WHxXzeYumYtLnRV1
	 CNlDpwtxJ5A3pY8X3+2nV7zpDZ3VbvSjwrTcgLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfCLR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbfCLRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:24 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD29206DF;
        Tue, 12 Mar 2019 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411043;
        bh=jzpK9kJxk0aSH8lmwKTIvvZA2hn3CLP/vegAvnNXzWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BTYnuj3SCdHIQ9dBJpL+m6kWzUhk7V/anv0fRfCV/XJ0SDhAv/+EoTBtz9/h1bES
         zPLdRXYDdmQgcbkABlM5e1QjFyY10faVb1mpcb8mgAVawbPPEegsTbFXcWME6nxR9t
         6iQXtB0MjS0f3rNtrcaW2DrJLf0whHvu5czUIaQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.9 08/96] staging: wilc1000: fix to set correct value for vif_num
Date:   Tue, 12 Mar 2019 10:09:26 -0700
Message-Id: <20190312171035.193321357@linuxfoundation.org>
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

From: Ajay Singh <ajay.kathat@microchip.com>

commit dda037057a572f5c82ac2499eb4e6fb17600ba3e upstream.

Set correct value in '->vif_num' for the total number of interfaces and
set '->idx' value using 'i'.

Fixes: 735bb39ca3be ("staging: wilc1000: simplify vif[i]->ndev accesses")
Fixes: 0e490657c721 ("staging: wilc1000: Fix problem with wrong vif index")
Cc: <stable@vger.kernel.org>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/linux_wlan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1263,8 +1263,8 @@ int wilc_netdev_init(struct wilc **wilc,
 		vif->wilc = *wilc;
 		vif->ndev = ndev;
 		wl->vif[i] = vif;
-		wl->vif_num = i;
-		vif->idx = wl->vif_num;
+		wl->vif_num = i + 1;
+		vif->idx = i;
 
 		ndev->netdev_ops = &wilc_netdev_ops;
 


