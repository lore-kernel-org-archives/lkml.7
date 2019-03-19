Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D43C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EA22082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="YE7Ty6dG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfCSU1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:27:04 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:35436 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfCSU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:27:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E3C66CFD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 20:27:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o28XSSAFbCBL for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 15:27:01 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B3274CEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:27:01 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id m70so154149ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HrKIKLCjlp9oUkbLydcCAuBuizdH0N22kSprTM8P2/Q=;
        b=YE7Ty6dGWUwpLkCDykE++xkhVogniBkzQAbO9n0zCFVP5R2i3uqLMBcIifqsfDYt9k
         D2oPWFf7q5jMAfOlAUcGes6gtQx+TAFcgoQEA1phIX48M+hQubNdqbg4O2mlLX9pyjGy
         ZnLje963oI8w1QN9hD+QRtF2coKxhk/dRgErYZWcV4wImatUFmyqw3HieyMosiaI8ML6
         vQnBNlr7aULQRmGUAyGjLeCOamcV4E7JskLB8oyCiEusdMZGlecQI4Z0FBERFs8yulNV
         hEadItLKlMMt+wx04qq/Uxrrtbgu2mJZoMf4V5VHgA8gKkJzRb0QyKNBT0Kcr8CW/dyj
         rbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HrKIKLCjlp9oUkbLydcCAuBuizdH0N22kSprTM8P2/Q=;
        b=gIjuVtQMd8sXX7lW3uHt0A12+GB+Ezgy6qa4ihh88tVmwUte7a8Q07dzmR1vtlKTWX
         IwrM9OGYMMH2l5+q0LYiTmgiJ9bmKIQ7rqCdKxxZ5Wp9s+POyrXEIN152mRVcICUAVGd
         aUYI9XxSNNNlZiA/3uSyuAKdp3oz1uru9SyGdyAcxaTk1viPjlIZ/qs4Lis1gcDxHMlu
         YiBuM3D8wP6O8JPiZN3cW+sAXTDn49n3qWvs31X18ScyferG11Cx3Q9uTh11FNBeutb1
         WsUsUJ80s+ad6tP2SU/KkSStVZrh+CeMG8crkul++a/VGmPQvRTdkb/vgMQldxUabkjP
         dVEA==
X-Gm-Message-State: APjAAAUhxoSk5f10IrWA7/XxuKzzqi6MhRSc6yG6s2uqmRWuDLOO/CJr
        D/o0z+1IZ0Aj8b3wpLOMJMY4S2c+xeYl1BO1atGjYSM1Y2wR3r8ZdXOwev0s4uz2FCyvSPyIVc+
        R2W5tCVx5dmtt3OLjvDfHGK9AwMUU
X-Received: by 2002:a6b:f90d:: with SMTP id j13mr2820610iog.245.1553027221422;
        Tue, 19 Mar 2019 13:27:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylWSFDAwapnu293K57/98XD2ITDSxSbLSG6cbZeeDAOjyKZKjkW2EGVUsCLE5ahVbdK8Kthg==
X-Received: by 2002:a6b:f90d:: with SMTP id j13mr2820600iog.245.1553027221242;
        Tue, 19 Mar 2019 13:27:01 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id h131sm42669itb.6.2019.03.19.13.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:27:00 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: usb251xb: fix to avoid potential NULL pointer dereference
Date:   Tue, 19 Mar 2019 15:26:58 -0500
Message-Id: <20190319202658.17116-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device in usb251xb_probe can fail and returns a NULL pointer.
The patch avoids a potential NULL pointer dereference in this scenario.

--
v1: Fix to avoid return in case of error, per Richard's suggestion.
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/usb/misc/usb251xb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 4d72b7d1d383..bbfdb7447d6f 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -612,7 +612,7 @@ static int usb251xb_probe(struct usb251xb *hub)
 							   dev);
 	int err;
 
-	if (np) {
+	if (np && of_id) {
 		err = usb251xb_get_ofdata(hub,
 					  (struct usb251xb_data *)of_id->data);
 		if (err) {
-- 
2.17.1

