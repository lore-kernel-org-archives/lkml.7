Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C0CFA372C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FA22067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264160;
	bh=NULAnT487JWKocdUOvjYzvpKGwvjPMSpNvN1O/uwKF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VeNac44VoCPEYDt80x11XtYYGOSfVB1OY6J1aEKfo0GtWtVDTNSgplgQRNu/R4gK0
	 C3iI24WeN5aWytY7rU+gf8Q+66oCiT/IfiPadfsR1P4DI5HmVMszN/tFWwMFuaE5Fg
	 juIfcp7k53jbPiYuZDW+NmAhZvT0XrloalEecpWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437765AbfJPVzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437725AbfJPVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:55:14 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67886218DE;
        Wed, 16 Oct 2019 21:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262913;
        bh=NULAnT487JWKocdUOvjYzvpKGwvjPMSpNvN1O/uwKF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rr3ZGp//Gks0jjhCA4Alu4p9cbz4J6dW5qbDwHOQosNZ5GXOGaowDjeAhN+h4QijK
         BIZOa2lksJrtzalJ7io5vhxUBkLa8+10s7PjVz2zuY/ewhfUxiuD5dUwkukbH/bSgo
         pziF+8Lj1JEacUq+Z8dZpvkxfLb3aDShwEZgZRBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH 4.9 73/92] staging: vt6655: Fix memory leak in vt6655_probe
Date:   Wed, 16 Oct 2019 14:50:46 -0700
Message-Id: <20191016214845.006129966@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 80b15db5e1e9c3300de299b2d43d1aafb593e6ac upstream.

In vt6655_probe, if vnt_init() fails the cleanup code needs to be called
like other error handling cases. The call to device_free_info() is
added.

Fixes: 67013f2c0e58 ("staging: vt6655: mac80211 conversion add main mac80211 functions")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191004200319.22394-1-navid.emamdoost@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6655/device_main.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1673,8 +1673,10 @@ vt6655_probe(struct pci_dev *pcid, const
 
 	priv->hw->max_signal = 100;
 
-	if (vnt_init(priv))
+	if (vnt_init(priv)) {
+		device_free_info(priv);
 		return -ENODEV;
+	}
 
 	device_print_info(priv);
 	pci_set_drvdata(pcid, priv);


