Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546CDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1769C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brMAKXXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfCZNrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:47:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54947 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:47:22 -0400
Received: by mail-it1-f194.google.com with SMTP id w18so19574271itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WmWB2c/e32KhdSTgqdSH2PxSp4DLQ8s4NIAkFxD/RDA=;
        b=brMAKXXAzclwsShMlFg5dX2NrdO6dAsgzGuKIUOKG6R5BPaEwkpZAnhj2DUhYDrazS
         qVBoPtzCli21gEp6TMeX4NttiyVI3ViFn+nziOH8PT38KIImiPIGZtIo9/y0KJnccEMF
         tAWavGeKi7wDh/T4H1zfDfr/8VHgkLEfzYKp4KOFWAkNeTWfbYUNCu8K+jFdPk85Roa7
         xm3tuL7Figtv3cBq9KLyxW3IFyE8OX36k7AEAclBKx+f8v2JzbBQCfIe7tnZMzfA9qaz
         TASREfgVcezkwMwvapDGrYQkq8XQGmynTWguW4QIriYuRM9ev9q5gW5Q/PbJn3MNzmE/
         a9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WmWB2c/e32KhdSTgqdSH2PxSp4DLQ8s4NIAkFxD/RDA=;
        b=nL3QXIfFEAa978l1KSg5ygrwvsxA6aewLklFAAVoEH7elnJkVTO6C3ezu2vS8QcQq0
         ipCtBX9owf/eCvwcnysk9eVWi9EHIacmINDbX9vh49r0dlf4vtSxCG8x6ZgCvlQdPYgh
         3vnfGdGG2llszhsA4sznD1bIJYq9/jZprVvCXQ1MjBW4BQh49FfOqk1UhL0UIDhkbecB
         2eA4GGcSmqVJuX0/00j/osg3Djtti+iKP72J/H621xOXWhGynV0ZI/rDqykZmj4qITzn
         iMeGUYtJagwx6uQFkP5dFCtX42KHYumVfREsKZwknLcw5zUumOIxaqRqEt0lRxurolLR
         8z6w==
X-Gm-Message-State: APjAAAU+qcSRCgUc4zHHcD9qN7YUa0NF+cgtqENsmYAB91VnWTdysxvO
        AoV9V5WF3ySR/Ko0kK+LzwU=
X-Google-Smtp-Source: APXvYqy5Z5PhNPaLDaly+12aLeYDEkNK6nIbZJeluxupFPVObhLL3PupeN7nlROngTK9z/dexXENBA==
X-Received: by 2002:a02:bb04:: with SMTP id y4mr22131148jan.67.1553608041745;
        Tue, 26 Mar 2019 06:47:21 -0700 (PDT)
Received: from titus.pi.local ([66.97.27.10])
        by smtp.gmail.com with ESMTPSA id b199sm3513790itb.29.2019.03.26.06.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 06:47:20 -0700 (PDT)
Date:   Tue, 26 Mar 2019 09:47:23 -0400
From:   Will Cunningham <wjcunningham7@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH] Staging: emxx_udc: emxx_udc: Fixed a coding style error
Message-ID: <20190326134723.GA32229@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary parentheses.

Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index a913d40f0801..80a906742cdc 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -136,7 +136,7 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 	struct usb_ctrlrequest	*p_ctrl;
 	struct nbu2ss_udc *udc;
 
-	if ((!_ep) || (!_req))
+	if (!_ep || !_req)
 		return;
 
 	udc = (struct nbu2ss_udc *)_req->context;
-- 
2.19.2

