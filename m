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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9610E206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiRCoHTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfGaSOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:14:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGaSOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:14:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so26225172pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=54mrDTR1HhDgitZr7P55Wj93FkR2zRd8eVwIx2NJz0Q=;
        b=NiRCoHTzl5t5zFxYU7y15hmp7j2XcNyJ7BmEn8chRyLp169Is0v5YAfumlnO+ZtZTc
         dJWeKyfdeFmeVhnFBmge6qRMX0xV/gbm1s/4zTjJ9+5iwjwQ5dvLF7CK4njLuAAWh/f4
         UYHisriWlnZ8MxysjYRF7/5qwy7aUMXVhLf3lWiyYIFUiVCcl0MVnC02tsIePN3yTgOn
         1Q/Rj4wweJqs/mD0xow+KZpPkocKe9fFprIEXemQLkA4AZODY11M10ePvHp8N95ijJ0H
         cVYKemz1ze8jjLrP4C/x0xjf7t5ejoDhXyhSyAQngMPib0/MhA4eTLSobp4gqIycv4vt
         nLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=54mrDTR1HhDgitZr7P55Wj93FkR2zRd8eVwIx2NJz0Q=;
        b=cc5HrKSnn7F204PJMFdc+I6cKX/PDl1WHCLUKHNu9nBJ8wBYMxPsuvBkgE4PWj/ECY
         ZCaTDRdDGnzmlV4IVxRkl8dDHuai5RxvSjQTV1IDXB5nowzJ8heNJbt87KWE7/xCDUhR
         anI6FllvRSDCUSA5jc1oTP0RAtD3A5GDzg2kAyUgRnDjTOEbpiBALstAC2k8KiU38fOR
         iAxk/0VbmqTdPxCTImFKhbHoh2LPIC0MbeFoFbI+z8cY5x01c1cdbuRPGJWurc8eNFi/
         wCmego7iIcIFXn0I2/Yu7BMvxfkVB0PfLP2Qv0Xr7IQnN9V1pZk4dMf/NXrjLfd7kAbF
         t/UQ==
X-Gm-Message-State: APjAAAXhx/GJa0xHqmGYbjJBhGQfeb/1C7pkiCb3zBPGcLqzIfDY+eOJ
        pYNTR/Ua8uUydfgE9WkfChA=
X-Google-Smtp-Source: APXvYqz6roXYSEQ3td8yTlZJBCWaVyJz0Sk4ZbS/M5xBCUi88aQIAzdepTRvUJ/9jMjKTz2zKInd3A==
X-Received: by 2002:aa7:9217:: with SMTP id 23mr49520886pfo.239.1564596863552;
        Wed, 31 Jul 2019 11:14:23 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id d23sm2148422pjv.18.2019.07.31.11.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:14:23 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:44:18 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [Patch v2 03/10] staging: rtl8723bs: os_dep: Remove unused function
 argument sdio_device_id
Message-ID: <20190731181418.GA9222@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove passing pdid as function argument to rtw_sdio_if1_init as it is
not being used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v3 - Add patch number

 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 540a7ee..cefff1e 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -315,7 +315,7 @@ static void sd_intf_stop(struct adapter *padapter)
 }
 
 
-static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct sdio_device_id  *pdid)
+static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj)
 {
 	int status = _FAIL;
 	struct net_device *pnetdev;
@@ -473,7 +473,7 @@ static int rtw_drv_init(
 		goto exit;
 	}
 
-	if1 = rtw_sdio_if1_init(dvobj, id);
+	if1 = rtw_sdio_if1_init(dvobj);
 	if (if1 == NULL) {
 		DBG_871X("rtw_init_primarystruct adapter Failed!\n");
 		goto free_dvobj;
-- 
2.7.4

