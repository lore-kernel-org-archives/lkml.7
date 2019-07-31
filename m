Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F966C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6220C01
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7XN7S3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfGaSZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:25:35 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43362 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfGaSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:25:34 -0400
Received: by mail-pg1-f178.google.com with SMTP id r22so4860503pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CGOO3Qz8vz6py6i7KKOWSpuubNGLxWkIe5GopgOPJrk=;
        b=n7XN7S3C3zlpCNPVbparKSlbichuk0E/msHzh5M8NUL07f5YbqHff3uNg+enH1io7k
         1O89MzhAK6aeTCRHGJggMnklSj+5zAcwxfXmW7QwhjwJulYO/eWXXy8ZZIK+g0FFHpgN
         +U90F3xDD5RhXFdHIIDcBNqubWnCv68sEDNn1uMuZUhCg04LXXlAob5HP7rAKgH+Xu44
         hj4svatEGedzU2EwEA4O6O/dnCf3lnhlKNdAwjRlyWznJNZAlgOt1cesVd7QXZzrc0DE
         Klr3EMxJiTEPSwdgQBXtVMWjrH6arMNfD1B90CpHGwfIo0qnPOeaju8jteyx9C6DWOU3
         piZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CGOO3Qz8vz6py6i7KKOWSpuubNGLxWkIe5GopgOPJrk=;
        b=Cpus7+MDSJ2nKqzDqWDPFbKThkemScd9d1JPFnCwYZ6e634CEHGRrVDdqkRzz2CaFJ
         KySZtKAo3RqXkedwMTcKlVDbQoTWHah2pybjYHbY/Uhfclp6NyPpbXdwaINzIRDS7+XV
         D6UD3EqjIWti1Ixt7uwIRZ2znbnSNv96MMbuhiNCsk7WZ2kkpb+o63XINSGfoDYaam8z
         wuy0Mz1ggbfRyWFQbHOaURNuw4jKpt3REMCrIG6BCAcgzXLIS2Bi1SSeeUomPWmXxcKb
         +EUMLr+i6e0cqyrR4Pf7uq615RJNDgCjSB2ySs1F6Xe5cY6eRwhL5oCe6pvRxk8ePn/5
         b/+w==
X-Gm-Message-State: APjAAAVy9WfJEgnspVlT+nDVHzfoLZ3qYMZGa8qeKSMMwjsJipVSwAIq
        UN9k2gZxd47CQEMlbaEBdmg=
X-Google-Smtp-Source: APXvYqxUVw30HBVQzTRT8MRsyminQ7KjQNSeSj/zgCjKh4Yg2ucaoFQS6N4VwBDXP2aJLZkEhIaLyg==
X-Received: by 2002:a17:90a:d814:: with SMTP id a20mr4257773pjv.48.1564597533739;
        Wed, 31 Jul 2019 11:25:33 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id g62sm2664106pje.11.2019.07.31.11.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:25:33 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:55:28 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [Patch v2 10/10] staging: rtl8723bs: core: Remove Macro
 "IS_MAC_ADDRESS_BROADCAST"
Message-ID: <20190731182528.GA9874@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused macro IS_MAC_ADDRESS_BROADCAST. In future if one wants use
it ,use generic API "is_broadcast_ether_addr"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v2 - Add patch number

 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
index 8eb0ff5..eb08569 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
@@ -9,13 +9,6 @@
 #include <drv_types.h>
 #include <rtw_debug.h>
 
-#define IS_MAC_ADDRESS_BROADCAST(addr) \
-(\
-	((addr[0] == 0xff) && (addr[1] == 0xff) && \
-		(addr[2] == 0xff) && (addr[3] == 0xff) && \
-		(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
-)
-
 u8 rtw_validate_bssid(u8 *bssid)
 {
 	u8 ret = true;
-- 
2.7.4

