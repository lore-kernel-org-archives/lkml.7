Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F8C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071342173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 12:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoIhMH+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfELMY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 08:24:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38122 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 08:24:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so5301682pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 05:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=paH013GOd2gVWUwOGZuSguTs80alOhAT643zCT0EDfM=;
        b=uoIhMH+1+aCNFxqsoziGwT/juy8qi/hd+C1mYdyApJpsnp+/PXVXVOjJBCK9mh9EEl
         4H23uB+vzxw0zllM5Je0rZOcAA4Uuo5OrI1Jg2KL7kEJr2GzwOEeY7WC0zZScTOdMbtL
         OKOmjt4xGJLOQxPt37x/suDUmOQXRGws65PfopnmH9FT3ygPQEMXTJUel7iXcmPET3yo
         INxe1Q6HEEZO7qIyHbkzi7SynVgbg8OEk5uH7zKnMV8ND5rGqNm1Rl8rTPdpiwoJSIkr
         ZE61O2lMpFDHYgCaHnJq3fIQviy2NI3DRIURt1iJa9wfj8rWU4KF7ORlaAObFtSa5bKF
         KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=paH013GOd2gVWUwOGZuSguTs80alOhAT643zCT0EDfM=;
        b=Xwh4S0WOzaB9MtdOftYw6ydqKt2MFsOHX56fqZWO4cTC/kC21k8+8ps4qthTZ2VCTG
         6F5dLVCankNGgsWbyLU1Su9VoPSdUSy76W7JwRO9t1DaXOg+56UQ4yhXebLrg06ATLOV
         pliDbcomMkTR8wQl1NI/XJ3I8LhL0SOkSjhh5ref0LazVOD+6Io8o2/vuzigTLAJiGsX
         SX4cd82tEPCvY94gIz+kx88Y5r+FcyGj/eqHThqMIIB0Dkr/YJw0QpcVubUpSZChvH0Q
         1bb+az2YyUb3XTkLkS5YaQfG3C7z3e77crc/iHGAcSi74SNmM6G5wfhYUz0ATE7auRt4
         p7ig==
X-Gm-Message-State: APjAAAXI3jcY14/gpHvMRmmvUqlSYql6xbY6JLnIEajVx3omvQqXlK0U
        IW1f5vd/TmxypXl2r61tLxY=
X-Google-Smtp-Source: APXvYqxHUSVy5V9IPMXrfnx103n/CN+ISwfPJvPS1CuJ078l6q2X5AhsWDRQJn7Ac9+K69mL4m84ww==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr26758604pff.13.1557663895110;
        Sun, 12 May 2019 05:24:55 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id q20sm19280391pfi.166.2019.05.12.05.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 05:24:54 -0700 (PDT)
Date:   Sun, 12 May 2019 17:54:49 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        viswanath.barenkala@gmail.com
Subject: [PATCH] staging: rtl8723bs: core fix warning  Comparison to bool
Message-ID: <20190512122449.GA28268@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck

drivers/staging/rtl8723bs/core/rtw_mlme.c:1675:6-10: WARNING: Comparison
to bool

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5f78f1e..d26d8cf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1672,7 +1672,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 			roam_target = pmlmepriv->roam_network;
 		}
 
-		if (roam == true) {
+		if (roam) {
 			if (rtw_to_roam(adapter) > 0)
 				rtw_dec_to_roam(adapter); /* this stadel_event is caused by roaming, decrease to_roam */
 			else if (rtw_to_roam(adapter) == 0)
-- 
2.7.4

