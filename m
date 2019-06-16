Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F28DC31E51
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 02:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2104E2173C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 02:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ftvjkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfFPCyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 22:54:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35720 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfFPCyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 22:54:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so3744084pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 19:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AJZkUctyy1iP4lj+ZenQcgI+EZnxpcZPG/pF3IUKv5E=;
        b=l4ftvjkpJgj5rZAm91YeYiwItgta1YkWhD5Hhj3IUGTVf2hQU0rT+3AMcPNxEPPXzb
         /VA8+jWu+M3wP8+GjEFqA/8NixPqi4WeiNCkFM8FJy9uC9PesmHU63INRMN8GuqsY1UJ
         V6G7ubHaKZlnKWggYFU1m4zaVVo08ZbPKsOQVLn2eS90NV8kDzCdR+BSu4l8+pxk63Db
         q6eVvGabGFAcGMe4NycT8G/1zUuhW34jNhW0KIr3wVIXkM4JseY2ikEQDtgN4NQWveuc
         lHweGxFRp0WwrNyGYNRvdbiuLTwDOGfVHcNmYvQ4EDxOp+ByhHLhf+NZAaZsqzzAoW8P
         Ox3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AJZkUctyy1iP4lj+ZenQcgI+EZnxpcZPG/pF3IUKv5E=;
        b=g+26YVPfKQHjH473qd9dolYiYFnakBo3HLLy3D5UR1PjwOD7XCGOhOzTO3YksaxLsk
         qyA6DT4u3S74WGBqajsuThMArLYPsnR0qIvF6iJ8GPsWL+UnatY8ixzh/tB4y1+/Ifs9
         2+lYZew69iYjy6Eh9h3WJZEqIogKrghsMF5ULStVRsGsME1T+XXB+RvRvQUKUQbk/Hne
         L3d/m+9ZOLXoNzfiLGIh35wtbNrm3VTiyiPQk9nMwLIglrBBodgkgAu7nwwaYMBaOkn/
         CvkjUfjJmLgI/jsKTbOY0kM0H6AlgOQaaUM5qXj8NWgH8EtFIBJMVVm6UWGgmQG1Wpjj
         mE5w==
X-Gm-Message-State: APjAAAU34zHT2up5ytBbMPyUYvxAtvdhqzaYNNFyd5vSwDKJ70wgANwR
        tP0Ql4qvMGtpYp7Kkeg5AXE=
X-Google-Smtp-Source: APXvYqxGRYZhS2UOeRpczM60OIdcHbw5BBaUsoBjafkMjsWWzIMlqZaWgpun9OhIwsGxmqks0AFaMA==
X-Received: by 2002:a65:510c:: with SMTP id f12mr41514186pgq.92.1560653675662;
        Sat, 15 Jun 2019 19:54:35 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id p15sm6647513pgj.61.2019.06.15.19.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 19:54:35 -0700 (PDT)
Date:   Sun, 16 Jun 2019 08:24:31 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 2/2] staging: rtl8723bs: hal: fix Using comparison to
 false is error prone
Message-ID: <20190616025430.GA12034@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by checkpatch

CHECK: Using comparison to false is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
changes in v2: break the patch for specific change
----
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 07bee19..e23b39a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -175,7 +175,7 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 
 	res = rtw_c2h_packet_wk_cmd(padapter, tmp, length);
 
-	if (res == false)
+	if (!res)
 		kfree(tmp);
 
 	/* DBG_871X("-%s res(%d)\n", __func__, res); */
-- 
2.7.4

