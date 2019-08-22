Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD4EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5984A23400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495089;
	bh=dj7mEkG4videPuN9hCV/MWfKJniVmyHGSAILoiUiZLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uPbDf7/QWwLd27JnEnPKokAJh2LRIOuhPsfKom/Xdv3iMTwpCuXON+YF0hn6y54u4
	 Dg4RuWbyBu7w9XG6pwn5c/i9loMr50JXEU1A4+9tOOn7FpKabigh30vW52idgUgQ+M
	 WWYxLXvogBFMxzxxN6T6Yll/DzszkUfgej8DrcjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbfHVRb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404534AbfHVRZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:56 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79A52342B;
        Thu, 22 Aug 2019 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494755;
        bh=dj7mEkG4videPuN9hCV/MWfKJniVmyHGSAILoiUiZLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijfkt63oRWWACijW6697/D9l7LVsKcN0Ii0pOa2FdnPSdhd8cZxD1HAOJqF1LNsNQ
         D5Md/WIp4Q2V9vQat/EmZn7aovuXl/0T9Iqr8547kOQrHYJj8jecLp+lEahFBt+2Ho
         2w85P0OVMC65osWAQ0LMQXjfTaWGohln0zYYS8hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 56/85] staging: comedi: dt3000: Fix signed integer overflow divider * base
Date:   Thu, 22 Aug 2019 10:19:29 -0700
Message-Id: <20190822171733.646826894@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit b4d98bc3fc93ec3a58459948a2c0e0c9b501cd88 upstream.

In `dt3k_ns_to_timer()` the following lines near the end of the function
result in a signed integer overflow:

	prescale = 15;
	base = timer_base * (1 << prescale);
	divider = 65535;
	*nanosec = divider * base;

(`divider`, `base` and `prescale` are type `int`, `timer_base` and
`*nanosec` are type `unsigned int`.  The value of `timer_base` will be
either 50 or 100.)

The main reason for the overflow is that the calculation for `base` is
completely wrong.  It should be:

	base = timer_base * (prescale + 1);

which matches an earlier instance of this calculation in the same
function.

Reported-by: David Binderman <dcb314@hotmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20190812111517.26803-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/dt3000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/dt3000.c
+++ b/drivers/staging/comedi/drivers/dt3000.c
@@ -368,7 +368,7 @@ static int dt3k_ns_to_timer(unsigned int
 	}
 
 	prescale = 15;
-	base = timer_base * (1 << prescale);
+	base = timer_base * (prescale + 1);
 	divider = 65535;
 	*nanosec = divider * base;
 	return (prescale << 16) | (divider);


