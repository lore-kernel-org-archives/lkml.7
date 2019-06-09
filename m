Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EEC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DEE20840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX3SzvJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfFIMt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:49:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfFIMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:49:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so971703pgh.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=a65Rbdca0083owoGg7iWD7lhivLDkOuC9WnrhQtGEJc=;
        b=BX3SzvJ5cdsDVXL+rItDBEyW0Tpmbzj7feTHVeVTuksaufPLGXIFsW63cOPBlaX50Y
         OIaa6ZNcLD2kSiR0AcePieAGfrVaPDzKNaLSGDsywkGPyBIlbZqBji7+zMxwTjRk8O0/
         8aw9qWidOVBeu01goDeDHUI9S2QUYtGZNZCJ3ZP16uCfPRajYFw6RbL0jf2vvtqlTnar
         V5HENWkvjK5yd8ivvOZU6tqTErndQNgmXUjVlzB3fWz21/CA1rU4nXNX5yek06QpUpNi
         v/rftibsXv5/CgH48/j3aBPIuZiWsYVR0/9o1iWDktTfbfvahuah1XGh40IQshui3fTA
         zFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a65Rbdca0083owoGg7iWD7lhivLDkOuC9WnrhQtGEJc=;
        b=ZJnjxjJ8qPPH+kDYUeEOHOF8W1F9YoKb3caUyIZ5OBn7m5IhU1nXwOqqKSTdCngO8v
         +Xx3KjNExEkH6rxbB3d+mqGjPayQYe6Br2meqK0Op1CdLWSlp/PzL7FxaFy3gXfSSyxn
         ZhgOxqeiW5nhGrLuDA/WhGMmOW6j1EvZj1dv4J/WuOAoRPHXiKMF/+o6KUnXzQ89oylE
         i+jlItKorPrRn3C93I54rKQQBmvpZA4CVBJkTbSZiGuBQzFiHJg971CZeEjzae6CTQEW
         8HVn9VovpYZjK72BidyS34ydikvJjwErPRhWp77J+azUIYNZdyxnsG8s8AzZT7EyT6Oh
         46iA==
X-Gm-Message-State: APjAAAUApCtnUs2vMSwcylpj0+QJipZ3nyVry8WH7/tmkMwjdWRoa2rE
        JmXi986MuARNNI9eE78Z+B8=
X-Google-Smtp-Source: APXvYqz/LJLVZAActCpPodVeN8hpGJWUhl0Nt6mFsviLHJ+iw2PE6HxfXZRvM6X0v8beFe+OPr8E0g==
X-Received: by 2002:a62:e417:: with SMTP id r23mr37153334pfh.160.1560084598389;
        Sun, 09 Jun 2019 05:49:58 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id m5sm10582296pgc.84.2019.06.09.05.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:49:57 -0700 (PDT)
Date:   Sun, 9 Jun 2019 18:19:53 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Straube <straube.linux@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8723bs: fix issue "Using comparison to true
 is error prone"
Message-ID: <20190609124953.GA4071@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below issue reported by checkpatch

CHECK: Using comparison to true is error prone
+                       if (res == true)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index c125ac2..4da5617 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -231,7 +231,7 @@ int _rtw_xmit_entry(_pkt *pkt, _nic_hdl pnetdev)
 		&& padapter->registrypriv.wifi_spec == 0) {
 		if (pxmitpriv->free_xmitframe_cnt > (NR_XMITFRAME/4)) {
 			res = rtw_mlcst2unicst(padapter, pkt);
-			if (res == true)
+			if (res)
 				goto exit;
 		} else {
 			/* DBG_871X("Stop M2U(%d, %d)! ", pxmitpriv->free_xmitframe_cnt, pxmitpriv->free_xmitbuf_cnt); */
-- 
2.7.4

