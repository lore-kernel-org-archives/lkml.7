Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A6C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEF224672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780956;
	bh=cSlenA/DYxgvVgNsMAOxx3slHl0GY/6TqEJ5iBF+G/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwynl2AzvgafN+u4TTw3VeHQH1qNkWpw9v+rUaPoTLlgjVuHrP10iOdtfYbILsk56
	 T9KstF0BcWRWDP0GtM01hT3xch34Ujd9QEZYF4+DGWxTpLltWaegZ643MGmTnGpPqt
	 M7YoEMaYkghbIXXoXbeT+6yBy9o0q5cCkNZHvmgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLSSmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbfLSSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9592124672;
        Thu, 19 Dec 2019 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780946;
        bh=cSlenA/DYxgvVgNsMAOxx3slHl0GY/6TqEJ5iBF+G/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hrq18/jyB64kgGWtxdZtMzpF8rmCM7f6KBlafhaK+Ho5OZzFoq5g1DyLEzRJ6Mc/
         cWjlW08DIsmr60mWvVbYlnwIeHlNRNFfLmF1z8qhUq4lKCMbAZ300QQR1X++QdP4yu
         O3rOBDJLZByY4xvmNPCLTWCdo0n5lwXNsr5IfcNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ladislav Michl <ladis@linux-mips.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 002/199] usb: gadget: u_serial: add missing port entry locking
Date:   Thu, 19 Dec 2019 19:31:24 +0100
Message-Id: <20191219183214.782106713@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit daf82bd24e308c5a83758047aff1bd81edda4f11 upstream.

gserial_alloc_line() misses locking (for a release barrier) while
resetting port entry on TTY allocation failure. Fix this.

Cc: stable@vger.kernel.org
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/u_serial.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1391,8 +1391,10 @@ int gserial_alloc_line(unsigned char *li
 				__func__, port_num, PTR_ERR(tty_dev));
 
 		ret = PTR_ERR(tty_dev);
+		mutex_lock(&ports[port_num].lock);
 		port = ports[port_num].port;
 		ports[port_num].port = NULL;
+		mutex_unlock(&ports[port_num].lock);
 		gserial_free_port(port);
 		goto err;
 	}


