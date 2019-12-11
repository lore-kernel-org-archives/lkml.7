Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF068C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA5C24654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077029;
	bh=m2FDG6Fw3Fq/ydclieVj27dDUEt6I8X68OhLjNVJiCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yhs+dt3f+d2QAxJNTPl2V9ivwP4p4F73VzoHC8yARdEnJUmCLm0vWrpJVIdx18OAD
	 KNpY8xmz+Gi7xQ/LNEYdha5H86Ro+y6VjsC+Moc4aosSU5w1p3x5K2+2FA6qpOx/LE
	 WOe+OH1h8NJEKKm/pU03qn4IxKf2MRhnFO/QvBhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfLKPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730729AbfLKPKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:10:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 160A520663;
        Wed, 11 Dec 2019 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077021;
        bh=m2FDG6Fw3Fq/ydclieVj27dDUEt6I8X68OhLjNVJiCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqvXFEzYJCDPqkbHcNaq14DOQ/z3BoKk/JnZFzexGyKVQPfOVytmNdIjq8jj0cODD
         Zc2yEX+wT84BgeBY1rx71WHFD7xcT6IjQtNC8kMoPg9NMdg+4h+ZzecjkjXytFv2sd
         9BTO0RxGh7wgrfCb4oVufG8RhksyrLhgDwxKqUSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.4 43/92] media: rc: mark input device as pointing stick
Date:   Wed, 11 Dec 2019 16:05:34 +0100
Message-Id: <20191211150241.052128348@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.977775294@linuxfoundation.org>
References: <20191211150221.977775294@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit ce819649b03d932dc19b0cb6be513779bf64fad3 upstream.

libinput refuses pointer movement from rc-core, since it believes it's not
a pointer-type device:

libinput error: event17 - Media Center Ed. eHome Infrared Remote Transceiver (1784:0008): libinput bug: REL_X/Y from a non-pointer device

Fixes: 158bc148a31e ("media: rc: mce_kbd: input events via rc-core's input device")
Fixes: 0ac5a603a732 ("media: rc: imon: report mouse events using rc-core's input device")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/rc/rc-main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1773,6 +1773,7 @@ static int rc_prepare_rx_device(struct r
 	set_bit(MSC_SCAN, dev->input_dev->mscbit);
 
 	/* Pointer/mouse events */
+	set_bit(INPUT_PROP_POINTING_STICK, dev->input_dev->propbit);
 	set_bit(EV_REL, dev->input_dev->evbit);
 	set_bit(REL_X, dev->input_dev->relbit);
 	set_bit(REL_Y, dev->input_dev->relbit);


