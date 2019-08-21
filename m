Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30FDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6826206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XAN67aA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfHUVQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:16:19 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:41824 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbfHUVQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:16:19 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 17:16:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1566422178; x=1597958178;
  h=from:to:cc:subject:date:message-id;
  bh=cBdSPmFTN1DOzz1EeXVkXTHdBWMI8uVVtsHBkBxazoQ=;
  b=XAN67aA8hwBJ71ULZIHGlLOWYdw2A5myYHCrNercMBKNX06z+fynkxfT
   EcbmWMxSWXas0VNjg9hnLFYJRg8J1qo/Mfnz2dCo7s7FsjKDNvO2ase66
   TO0erfGIJ+x6qUHxaomlcmbOAHCFD/GHBKMtQ69hPUIy3EXbu1BSMyxyG
   f1sGNlwc2hhkzJB9TGjvci3PqMineO2cZQWQGgtYM/6G4KKUHWyyAoJh/
   NrxKsAImki6+HxNm1xAXEO7Wuil0tzqfihy8ox+oXUCBVsYs57Ryy3g7k
   2KfZZ+0VMch4gjSWXQNengFKSKELjXVloyPqAj386mWBL4i+lBDq8EqfZ
   w==;
IronPort-SDR: J9Uq8DN2wkXveoU4cJjJ9RGytFb9e8wKvvanGk8deGDuUyzCsk9bC325fZcNGeWOwtXkBnLFEA
 elHfwJJBKsMWG+HRm76Dp6BSHsZpTYpJ17WCAu5t1LIrcjkukushh9kg6U1z/MqsOGTCDxOIjE
 XxuxhjEyZ/na/mGHpB0A4M9mD+duOyItpJhkvBxzf2CQvyYo+NYUowAK8YmQgfy1NPH9kaYcxG
 gE1Vcn8hWZbw7IvBAfb8Xstmcz3SzWe98Z7eAG/ooKON17L73GycxUKY0O3ymrwT0/8xoSpjT8
 EyU=
IronPort-PHdr: =?us-ascii?q?9a23=3AywLkjRU5XHwQethDbf2tw13kyoPV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYYx2At8tkgFKBZ4jH8fUM07OQ7/m6HzVcut3Y7SFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBvdutMLjYZtJKs9xQ?=
 =?us-ascii?q?bFr3tMdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl9d9h7xHrh2/uxN/wpbUYICLO/p4YqPdZs4RSW?=
 =?us-ascii?q?5YUspMSyBNHoawYo0KD+oAJuZYtIj9p10BrRCjGweiHf7kyjFJhnDo2a01zv?=
 =?us-ascii?q?kqHQXI0QA8Gt4DtmnfotfoO6cISe27zLfGwyjNYf1V3jnw85TEfgw7rP2QR7?=
 =?us-ascii?q?98bdbdxE8yHA3FlFWQronlMiuX2eQMsmmb7/dgVeWygGMgqwBwozivyd0tio?=
 =?us-ascii?q?XVmo4YxEvJ9Thlz4YvP9G3VlN0YcO9HZZWqiqUNJN2T9s8T210vCs20L4LtJ?=
 =?us-ascii?q?6hcCQU1ZgqyATTZ+Kbf4SU+h7vSeecLDNiiH57dr+yhwy+/Vahx+HmVMS531?=
 =?us-ascii?q?BHpTdfnNbWrHACzRnT59CCSvt640iuxy6C1xvW6uFYOUA0krfbK4I5zr4wiJ?=
 =?us-ascii?q?UTtUPDEzfzmErsja+Wclwo+vCs6+j6e7nmqIGQO5Nohg3kPaQuncu/Aes8Mg?=
 =?us-ascii?q?cQRWSU5eO81Lj78U34RrVFkOE2n7HHvJzGIckXvK20Dg9P3oo99hqyAC2q3M?=
 =?us-ascii?q?oEkXUbNF5FfQiIj4ntO1HAOvD4CvK/jkyskTZqx/DJJLzhDonRInXNi7rhYK?=
 =?us-ascii?q?py61RGxAUt0N9f+opYCqsdL/LrRk/xqNvYAwc9Mwy1xebnFdp82podWW2RGK?=
 =?us-ascii?q?+ZNr3dsVuT6+IxLOmDepUVtCz+K/c7/f7ui2E2mVsHcamux5sXZyPwMO5hJh?=
 =?us-ascii?q?CoYGjsn9BJRXYYvgM/FLSxoECJS3hea2vkDPF03S0yFI/zVdSLfYuqmrHUmX?=
 =?us-ascii?q?jjEw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FXGgC4sV1dgMjWVdFkHgEGBwaBZ4M?=
 =?us-ascii?q?FUkwQh2mFMoZTAQEBBoNAKIc1GHGFeIMIgWOFOwEIAQEBDAEBGxICAQGBBIM?=
 =?us-ascii?q?7gl8jOBMCBQEBBQECAQEGBAEBAhABAQkNCQgnhTAMgjopgUxfNQsWFVKBFQE?=
 =?us-ascii?q?FATUiOYJHAYF2FAWeD4EDPIwjM4N3hH8BCAyBSQkBCIEihxWEWYEQgQeDbnO?=
 =?us-ascii?q?CSIUbgkQEgS4BAQGUNJVvAQYCAYILFIFvhHmNRSeDHoEOiRSLBQEtg36dTYN?=
 =?us-ascii?q?xAgoHBg8hgUaBek0lgWwKgUQJgnGGBIgpHzOBCIxCAQ?=
X-IPAS-Result: =?us-ascii?q?A2FXGgC4sV1dgMjWVdFkHgEGBwaBZ4MFUkwQh2mFMoZTA?=
 =?us-ascii?q?QEBBoNAKIc1GHGFeIMIgWOFOwEIAQEBDAEBGxICAQGBBIM7gl8jOBMCBQEBB?=
 =?us-ascii?q?QECAQEGBAEBAhABAQkNCQgnhTAMgjopgUxfNQsWFVKBFQEFATUiOYJHAYF2F?=
 =?us-ascii?q?AWeD4EDPIwjM4N3hH8BCAyBSQkBCIEihxWEWYEQgQeDbnOCSIUbgkQEgS4BA?=
 =?us-ascii?q?QGUNJVvAQYCAYILFIFvhHmNRSeDHoEOiRSLBQEtg36dTYNxAgoHBg8hgUaBe?=
 =?us-ascii?q?k0lgWwKgUQJgnGGBIgpHzOBCIxCAQ?=
X-IronPort-AV: E=Sophos;i="5.64,414,1559545200"; 
   d="scan'208";a="71679617"
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 14:09:12 -0700
Received: by mail-pl1-f200.google.com with SMTP id j12so2215309pll.14
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 14:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KPS5jpp4Ywj8sRwhNiLpJFreklEq0lOjofl+ZAU4qJQ=;
        b=fP2P9c6QtOb4rICOZCLfCmswWdP6JE71EpL9m9gquay7BiIBmZpLt0QBD96kaEAklf
         O7tDh1NYgJEX0s0/pXpWCMoSzLANxRWdT7lnv1LoGzlwOg6KEWnliAuVeUBtOYQvZeEC
         tocjcJIsfQsFNB9vwUBxVXAnJdd3gr9cIJB80uIY3KlzbOF5426i6uf8ACz+gdSlbOJF
         pLTNQ4BZ07Vtb/whCa82AnLVruT3KcB3HzdcEWLkb/FkjQbpiLEV+TTLzu69GLuCeNuu
         jkUU9JuT8s545mRoAZwTgtIqyXlqbWz68lDuFLTrYiPS9pVfAhYTwevaUOfGTs+5tM4z
         KiIA==
X-Gm-Message-State: APjAAAXcu6GwVMkZfhDe7PN+ja/2+kCO6A9eFerg43cyX85HuDirloLT
        0PUzHL5gYZFG61PPe8FdPOeGSix2UGSZpdv/7JJqRqqCrgitT2bYBHuOZ/i1gqV1IFIoQ200TkB
        nlft0EmfdtDhZ2AzW1QwpNub5gg==
X-Received: by 2002:a63:b555:: with SMTP id u21mr31205060pgo.222.1566421748841;
        Wed, 21 Aug 2019 14:09:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypPungdy54NKD8FgZtyzscW8+eeQZFviA3kiXY7Ju80sT8SoAvChCE+gSfywI+XS44rMNfaQ==
X-Received: by 2002:a63:b555:: with SMTP id u21mr31205024pgo.222.1566421748376;
        Wed, 21 Aug 2019 14:09:08 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id m37sm4782555pjb.0.2019.08.21.14.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:09:07 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] pvrusb2: qctrl.flag will be uninitlaized if cx2341x_ctrl_query() returns error code
Date:   Wed, 21 Aug 2019 14:09:31 -0700
Message-Id: <20190821210931.9621-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function ctrl_cx2341x_getv4lflags(), qctrl.flag
will be uninitlaized if cx2341x_ctrl_query() returns -EINVAL.
However, it will be used in the later if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index ad5b25b89699..1fa05971316a 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -793,6 +793,7 @@ static unsigned int ctrl_cx2341x_getv4lflags(struct pvr2_ctrl *cptr)
 	struct v4l2_queryctrl qctrl;
 	struct pvr2_ctl_info *info;
 	qctrl.id = cptr->info->v4l_id;
+	memset(&qctr, 0, sizeof(qctrl))
 	cx2341x_ctrl_query(&cptr->hdw->enc_ctl_state,&qctrl);
 	/* Strip out the const so we can adjust a function pointer.  It's
 	   OK to do this here because we know this is a dynamically created
-- 
2.17.1

