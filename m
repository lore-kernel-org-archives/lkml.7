Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A3BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188C20863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687762;
	bh=14EF2DnntPMVJn3+B6AcdeA1/N9yDQw7UlSxwvUeqOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLnG8TNsz3LERY12d8DFzXc4JLFnvW+cRBNBjEaHOYzVidjxYKkgptc5GjzHWGIW/
	 xFRH+8bSBsk21b+8PMw3pJmLVaEs5jumawa6161U3SY4U92gVO2IDez4YuN6pCENR7
	 sprL25Nfr3SriXQ/mpf9snyhdHhDg5N5MCv4ko1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfCDIWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCDIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:22:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344DF21019;
        Mon,  4 Mar 2019 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687757;
        bh=14EF2DnntPMVJn3+B6AcdeA1/N9yDQw7UlSxwvUeqOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cd9hcjU2PBYglaLigvGzsOt1H2lp8nEfMikEZKeUW/kixJVTvKNkSG96WjBzPfprO
         Lic7vODdJ7p7biUk3RSVAkqjpkdRHuXLsercl99KuoAh9rb1YXjjK6vTunizRwetM+
         iCNjyvLwKCvZ1x/wvUXCkQHMBZLEKtb31hyozRq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 11/32] usb: gadget: Potential NULL dereference on allocation error
Date:   Mon,  4 Mar 2019 09:21:59 +0100
Message-Id: <20190304081603.104988529@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

[ Upstream commit df28169e1538e4a8bcd8b779b043e5aa6524545c ]

The source_sink_alloc_func() function is supposed to return error
pointers on error.  The function is called from usb_get_function() which
doesn't check for NULL returns so it would result in an Oops.

Of course, in the current kernel, small allocations always succeed so
this doesn't affect runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_sourcesink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_sourcesink.c b/drivers/usb/gadget/function/f_sourcesink.c
index 8784fa12ea2c6..6e9d958004a0d 100644
--- a/drivers/usb/gadget/function/f_sourcesink.c
+++ b/drivers/usb/gadget/function/f_sourcesink.c
@@ -842,7 +842,7 @@ static struct usb_function *source_sink_alloc_func(
 
 	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
 	if (!ss)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ss_opts =  container_of(fi, struct f_ss_opts, func_inst);
 
-- 
2.19.1



