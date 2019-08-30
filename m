Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A23C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1521726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="N1tYV6Q+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfH3An2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:43:28 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:62149 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfH3An1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567125807; x=1598661807;
  h=from:to:cc:subject:date:message-id;
  bh=x/hPFWrb7N7daafIx/1mPp6kx5SsK9IpY+Su725vKIk=;
  b=N1tYV6Q+rRrUbPit34iobzudLltLnh3O5jYYYY+MWL8eyMGExWA2poko
   HJbyBNtTnX4eP2d7a/fAAWzKFjxYmRGmPnZoW7RITFHv9066Nvq8rwmws
   7rLtBU8Q7ojvmJmzROv0+Utf5MFLukcBlA861/r7ewyeoVZBbe02as2Ja
   Lxb7pU9uSpLcClyNadg6wVBWaXSz+wgGhhXGqKDHbjcBXgJkzD8IWNin6
   22A6ubazKmiMadJLv1yuoq1nqh6Og1jukp5in2Q/wP4fg7WNt2FHNAQNH
   WhRLw0+j+T/Hm08D7ecsn/okNurPK+PMjm4K11kImbmGGQd1zPnRK16GU
   g==;
IronPort-SDR: tt/zBWBmOETPkA5t0nki/U0jjsV9Zpb84fKaGOiaFCiSXjWFYEeTWPMuKf9sx8Hop78kNgd6Oh
 vxRuptNpLxo1bS0sH1CkOHkoNQwGM3cEEe9K20PeRq6HtxoJ0IhtITk0qpgm3Gdqa5WB4KrSPc
 RMTkImB/1wevfw8vwTUf3Ahnu2Tl3bMbAvAy/sSGwgEExIg524NWq3Z/qBGajaVmQOV1g/D1OT
 n3oGpwmYFF8WC3/W8Rb8Pzl8iN6Z+bmXr4Q58dGcdUIqkghnqSxo9AFK2FaTm/ocH+CDRAFVq3
 Qbk=
IronPort-PHdr: =?us-ascii?q?9a23=3AnFOK9ROPCYOO9407G1sl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfX/rarrMEGX3/hxlliBBdydt6sezbOI6Ou7BSQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Ngi6oATfu8UZj4ZvJbs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMtRUi1BApinb4sOCeoBMvtToZfkqVAToxu+BBejBOfyxTRVgnP707E23+?=
 =?us-ascii?q?EnHArb3gIvAsgOvWzUotvrKakcX+O7wq7TwDnfc/9bwyvx5ZLUfhw9p/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7KjFSQqI3lPzOI0eQGrm+W7uphVOKvkWEnqh19riShy8o3l4?=
 =?us-ascii?q?nGmpgVxkra+ipk3YY4PNu1Q1N4b968CJZcqT2WOo9sTs4hQ2xkojg2xqAJtJ?=
 =?us-ascii?q?KhYSQHzJAqywbCZ/GGd4WE+AzvWeiRLDtimn5oeaizihS9/EWm1+byTNO70E?=
 =?us-ascii?q?xQoSpAitTMs3cN2AHN5cWfUft9+1uh2S6I1wDO9uFIOUA0mrTfK54m2rMwk4?=
 =?us-ascii?q?AcsUXHHiPvgEX2iLKaelwq+uS17+nqZq/qppCbN49zhQH+NrohltajDuQ/Nw?=
 =?us-ascii?q?gCR2mb+eKi273/5UD1XqlGg/ksnqTasJ3WP9oXqrO2DgNPz4ou7xKyAy+j0N?=
 =?us-ascii?q?sCnHkHKFxFeAiAj4jsI1zPIPH5DfeljFStjDtn2/7LM6b8AprRNHjPiqnucq?=
 =?us-ascii?q?tg60JE0go80chf545ICrEGOP/zXk7xtNrFDh42KgC0wPjoCM971owAXWKCGb?=
 =?us-ascii?q?GZMKzMvl+S/O4vIPeDZJUTuDnjL/gp/fnujWU2mQxVU7Ou2M4maWK4A/Mud1?=
 =?us-ascii?q?SLYXPt2o9aOXoBpEwzQPG82w7KaiJae3vnB/F03To8Eo/zSNibSw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2H9AQCncGhdh8fWVdFmHgEGBwaBVgY?=
 =?us-ascii?q?LAYNXTBCNHYZeAQaLHxhxhXmDCYcfAQgBAQEMAQEtAgEBhD+CXCM3Bg4CAwg?=
 =?us-ascii?q?BAQUBAQEBAQYEAQECEAEBAQgNCQgphUGCOimCYAsWFVJWPwEFATUiOYJHAYF?=
 =?us-ascii?q?2FAWgA4EDPIwjM4hqAQgMgUkJAQiBIocehFmBEIEHg3VshA2DVoJEBIEuAQE?=
 =?us-ascii?q?BlFCWBgEGAgGCDBSBcpJVJ4QwiRmLEwEthAehcgIKBwYPIYFFgXtNJYFsCoF?=
 =?us-ascii?q?Eglweji0fM4EIi0yCVAE?=
X-IPAS-Result: =?us-ascii?q?A2H9AQCncGhdh8fWVdFmHgEGBwaBVgYLAYNXTBCNHYZeA?=
 =?us-ascii?q?QaLHxhxhXmDCYcfAQgBAQEMAQEtAgEBhD+CXCM3Bg4CAwgBAQUBAQEBAQYEA?=
 =?us-ascii?q?QECEAEBAQgNCQgphUGCOimCYAsWFVJWPwEFATUiOYJHAYF2FAWgA4EDPIwjM?=
 =?us-ascii?q?4hqAQgMgUkJAQiBIocehFmBEIEHg3VshA2DVoJEBIEuAQEBlFCWBgEGAgGCD?=
 =?us-ascii?q?BSBcpJVJ4QwiRmLEwEthAehcgIKBwYPIYFFgXtNJYFsCoFEglweji0fM4EIi?=
 =?us-ascii?q?0yCVAE?=
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="73765524"
Received: from mail-pl1-f199.google.com ([209.85.214.199])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 17:43:26 -0700
Received: by mail-pl1-f199.google.com with SMTP id v4so2995877plp.23
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pUmojDYDL1a61kg6eynxQw3TTop/vKblfuVM8e3GTao=;
        b=aKZnKKTVnhzAs0511DuOPaTTIh6Vxq1S0PDshZbrhaSEbupmJcipWlAJ1DiXj8d2bR
         wwdiJpUV3ZE2vLMSVl9AevQraj3wBUqCqYsWIuZg4jhLku860nZV715U2b5fdqWFM1B2
         /tVdQoTNk6PLYNyM/K8U0g8V9pJK5A5eQCwL+/VAWRWZKMVdihd5155SehzCWjFgrixc
         6zFPa5qLP2bnqbTIP4RxWY2KkAelHqAO1N07WVyvf4cEbq7qu3pLjdZiwSAaYiokHG/B
         E8LHHKalFjFjykjCatNz9PBR6oLSpmOzH07zrHV3JzTa9C/VrT+w35Psd0C3Qhx3fFqb
         V+/Q==
X-Gm-Message-State: APjAAAVFl8HSJr6gyrbLXDwPl3I3rk25vyuK6FNfgM9w1utsr9LvTl9s
        qwiHvE/V/09hFWsinqaMfuE+LymdwGFbBmCwSY6kmImVLWnOdezN2kw6mmGS3c4sCpcJXW3m56v
        HLsbHzaAzRA/x8BsUujanxKIvqg==
X-Received: by 2002:a17:902:4581:: with SMTP id n1mr13190815pld.310.1567125806238;
        Thu, 29 Aug 2019 17:43:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwc6/cUWPfDkfqfrO57m1Cx+08ZFPT0rsri0ogDcuq7WHFidY41roOHBxcCTPRfJirehBoShA==
X-Received: by 2002:a17:902:4581:: with SMTP id n1mr13190790pld.310.1567125806046;
        Thu, 29 Aug 2019 17:43:26 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id g26sm4151989pfi.103.2019.08.29.17.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:43:25 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] drivers/media/pci: Variable vbi.type could be uninitialized if macro v4l2_subdev_call set __result an error code
Date:   Thu, 29 Aug 2019 17:43:59 -0700
Message-Id: <20190830004359.22622-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function compress_sliced_buf(), variable vbi.type is
uninitialized if macro v4l2_subdev_call set __result an
error code. However, vbi.type is used in the if statement
without any check, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/media/pci/ivtv/ivtv-vbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-vbi.c b/drivers/media/pci/ivtv/ivtv-vbi.c
index 3c156bc70fb4..e8140cab8c45 100644
--- a/drivers/media/pci/ivtv/ivtv-vbi.c
+++ b/drivers/media/pci/ivtv/ivtv-vbi.c
@@ -337,7 +337,7 @@ static u32 compress_raw_buf(struct ivtv *itv, u8 *buf, u32 size)
 static u32 compress_sliced_buf(struct ivtv *itv, u32 line, u8 *buf, u32 size, u8 sav)
 {
 	u32 line_size = itv->vbi.sliced_decoder_line_size;
-	struct v4l2_decode_vbi_line vbi;
+	struct v4l2_decode_vbi_line vbi = {};
 	int i;
 	unsigned lines = 0;
 
-- 
2.17.1

