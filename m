Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04622173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="H1Isg6Jp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCRX4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:56:14 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:33348 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:56:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 2933299F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PWnMgY8mv29q for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:56:12 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EAAAB9E5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:56:11 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id i24so14782152iol.21
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hQ1JwjK4jEzcEf+NolBYC9JKOqP7epZSeo7hVH2dAfo=;
        b=H1Isg6Jp4Y593/pruqeBUldpMJnnU7MN7A/k/2cx/WcVtHQhJSaJLhVwE1NgsyIytg
         J/PsAKYPuGcMZRvazZsRNPgpC3Drbxa/FxqvKwsXN+i93zw34+H7iW1t0DvCUFTDa8QJ
         m285GzttuuJIRAy5g4/5o79oufWETxy+1TpOfQjrkTavxA9ijvJdOV+DpJR3x/1Mzzpj
         08j2QWKFVj/Vi6FFST/1Op/0ynfeJntqifO6zR8FTao0ZVjfhX9DCtZIJDtRgrkq2zOO
         o/bfNH4QkvBgqjrVpPAm3LwXoqcb2Fn1vOGDK/BjpiboQ0L1AI2SHqMD7VTIwVNBC00T
         6Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hQ1JwjK4jEzcEf+NolBYC9JKOqP7epZSeo7hVH2dAfo=;
        b=Mcxj1jyf96evS59acKsn/VD6ToeQ1a14vfThertXDqUGUFP3fLaTb6MefdYR9NgaUt
         Uqvlr2pcSe6UsbFajym8GHhqbvzwq9O0/4+SVBUKg6EnlnI6q1IZLnjIJe0y5sx+les0
         FbMozpZqT/pZp5W1Cfuo+cSUHaOAufO3z0uMy0yXYrQ0Ld4/Doz1HV3mmZLIzJjesJPZ
         PsJ8FeHttlSHhKVb/E3pCbp9YXKnJfeXZcLoBukcZV1WOhgf5YYvCigm74P0t1889gkC
         2RUOB15c96YyPO5hbJxCJ1K+kM2H+AKZezDS0iNYTWsc653XIRCoJzcQRbh19ClGfxwO
         oyyA==
X-Gm-Message-State: APjAAAUoscwZIEJUfIOcWW0nZXR4BQSZWjir983Q8xwu6Zqo1zYrxkr+
        8d8NdsfGXac4p+AI5vEzhkKQM61VwIDExtldmoplDHFhvTLecJqkrZRsYVwtym/9q8iv4rUirmr
        2zRgvGkPV27TwM+DGeQ257nJAIi/C
X-Received: by 2002:a24:7412:: with SMTP id o18mr920707itc.117.1552953370641;
        Mon, 18 Mar 2019 16:56:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw59D4+SeOWhti018eblJyk8FbgMd8FHQCZ/Q/hKASjNu0gxW4DTHVm2K13ogrOszuG1PCfjA==
X-Received: by 2002:a24:7412:: with SMTP id o18mr920697itc.117.1552953370457;
        Mon, 18 Mar 2019 16:56:10 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id n20sm4945633iom.5.2019.03.18.16.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:56:09 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: usb251xb: fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:56:05 -0500
Message-Id: <20190318235605.11055-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device in usb251xb_probe can fail and returns a NULL pointer.
The patch avoids a potential NULL pointer dereference in this scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/misc/usb251xb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4d72b7d1d383..fe5266dc8864 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -612,6 +612,8 @@ static int usb251xb_probe(struct usb251xb *hub)
 							   dev);
 	int err;
 
+	if (!of_id)
+		return -ENODEV;
 	if (np) {
 		err = usb251xb_get_ofdata(hub,
 					  (struct usb251xb_data *)of_id->data);
-- 
2.17.1

