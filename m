Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA196C742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F90214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxL3DwpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfGNRbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:31:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43629 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfGNRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:31:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so6610288pgv.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XIexvq8195z5zdBnYHep1y5JG5Az7y2M3zNWSTA+XWk=;
        b=nxL3DwpINsiYf4kiJNJi3FOhugldoiw4H3VkM0UQBEUSmx6rZcI5sVgCUooFSq3V3g
         i+eTnT6NjJLb095llK7Z/ygc1nSahLW8TfMEzsjeFD7p+/dgzd867PEmNHhJoL+oQvyu
         PMkhZtwuB7j+y+BlQ1jsZbXVjMP05iIDqTrkgVkNw829hGBO5CmaM2tMRPchVTJ/Y+vf
         1QgS/CaLyPZEG0noM3LjWxvJd/pAXVdJNSnNiq4L7TKpIGOumcCgMF2KIXROKaMfoEvB
         SXSXsaxc9XT0iCr9svWd9frpY1vu/gz90UmvYtFGv2S3A3GPW7hyVzyTIHFPYQLt0gIJ
         WsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XIexvq8195z5zdBnYHep1y5JG5Az7y2M3zNWSTA+XWk=;
        b=hXLZN/OFfZrHW9A/+o8vsC8b8uXG04eO/9FyEyn5sZnibC/zSI4q8/sbN9zg0bfiUL
         EB+YVTKUHcdxfuAdYniK0xI+CngiHCSoNI7a0cc6SZosPUax5yIKvdrd26S+ymr1sy5T
         d1YgrhZkyHdLsuQjn+aED4q5kks/HoJwhbiDGf0+EeO3UoSChgGjegoVvvQbsnsdf4bJ
         12rQhB+lLW84DVNgC2C2OWebBnxxl20HBXsnZxON7cOCrsEFkjF7k2CDZ7BB3uH251Xw
         SQCFL3jsyTkAZgG78j+HA0CdV/sILgM/OF6ShYF3kTMVZY0aVwvAXPLNgqs/ECrowXx6
         Wi/w==
X-Gm-Message-State: APjAAAWOpqIU5JHM7K+CRJv5ADYZECjBY4YXBY+hSFH+5vU1M7xclQgC
        veAKd5pY5kbv1dRBvRMapZ4=
X-Google-Smtp-Source: APXvYqyzQ1nkBbFzEXz3kw3BOEybya2qUoXl08SFqarv5cYTZykIrodPwsj+jIvgm+QBa0VviN5geg==
X-Received: by 2002:a63:2a96:: with SMTP id q144mr11036842pgq.116.1563125500785;
        Sun, 14 Jul 2019 10:31:40 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id x67sm17593535pfb.21.2019.07.14.10.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 10:31:40 -0700 (PDT)
Date:   Sun, 14 Jul 2019 23:01:34 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove code valid only for 5GHz
Message-ID: <20190714173134.GA7111@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per TODO ,remove code valid only for 5 GHz(channel > 14).

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 544e799..18d61e5 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -239,9 +239,6 @@ static void loadparam(struct adapter *padapter, _nic_hdl pnetdev)
 	registry_par->channel = (u8)rtw_channel;
 	registry_par->wireless_mode = (u8)rtw_wireless_mode;
 
-	if (registry_par->channel > 14)
-		registry_par->channel = 1;
-
 	registry_par->vrtl_carrier_sense = (u8)rtw_vrtl_carrier_sense ;
 	registry_par->vcs_type = (u8)rtw_vcs_type;
 	registry_par->rts_thresh = (u16)rtw_rts_thresh;
-- 
2.7.4

