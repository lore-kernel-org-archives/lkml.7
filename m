Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20606C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93F92086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkeqqqqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFZCmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:42:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43283 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZCmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:42:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so515124plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TgGo/bYiWps+k76eI/kRcNwlMNadlMcwHKR/CkWVaSY=;
        b=KkeqqqqW0H0KOwBu/UKfqUQpMzCwsR5/X8t3ZCZSLkbxtXvUHCx+0vdN30Bb3ebWVa
         CNF69Nrz1103guRIHT7UKCJOsNwXfrDLm5m5amiWAnYWh90stJRD5PbRSbwUmc0tb+5G
         dj8OHZG3nIDdGEhqMF69a48GSuDKUR9CDBbaVDyw/aDdWQRH7lQwinbVRfuZjlrAVbuA
         Sk1YEvSWeIkm39saY9XN/7gh9J0Fr9wRXYH70moPToY+4ccLi9Btw8oJk6rCNb+MZiql
         ocJztIHDVdRXRwODqAYVIlSfcA85ZqNFztW7JIpwv9MvjnDXhw0RoWLrlZtYv+PZSn7h
         skEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TgGo/bYiWps+k76eI/kRcNwlMNadlMcwHKR/CkWVaSY=;
        b=U+colR1Bk0Eyf5JrXHvkKw4szDY/h9SYCCLGgw/sIzGWWww/MYP/ft1Y277W01MyRm
         J5KeA09hKxe4wWH/rgOwv7rXksVjK/GT342VvqFM02uL0MgWehRvBW393tXdgwmNQ8/x
         mA/4H1qL8Ovjb+a7lfcliEfKe+noSeMrKKKLkD6OP/6uCAJlN58JuSlPPFnaU38SA4kU
         PwMuVcDJ153M2r4Ce2TMF8ucemA9ZCOL6iBeJOiXKjF9CywgOiSyKoBwYyOHBOql4z30
         ut/dmzo/hi9Dr5yeGPWUdgrxuLWji06SPklp7XHJmy9/6/SGYjj5z7XSaIikuxi/eoRo
         41dA==
X-Gm-Message-State: APjAAAW4WIXJBIpmeRYwbhJDPZPKIp2Z2GWAWwc6kq4OxlJveQfEbF+Y
        NxT+i+HFTZn6mK0Bse42s6Q=
X-Google-Smtp-Source: APXvYqxs0jT22c/pi9/nuiq/FfIip7+FvBcoAH65a9//pdyQ/YYOfUFlslne5NqcT380Wfh1GmeQIQ==
X-Received: by 2002:a17:902:bd94:: with SMTP id q20mr2198045pls.307.1561516944732;
        Tue, 25 Jun 2019 19:42:24 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id u75sm134659pgb.92.2019.06.25.19.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:42:24 -0700 (PDT)
Date:   Wed, 26 Jun 2019 08:12:20 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8723bs: hal: hal_btcoex: Remove unneeded
 variable PHalData
Message-ID: <20190626024219.GA6052@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pHalData is not being used in halbtcoutsrc_LeaveLowPower. So remove the
same.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 99e0b91..0c2a754 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -195,7 +195,6 @@ static void halbtcoutsrc_NormalLps(PBTC_COEXIST pBtCoexist)
 static void halbtcoutsrc_LeaveLowPower(PBTC_COEXIST pBtCoexist)
 {
 	struct adapter *padapter;
-	struct hal_com_data *pHalData;
 	s32 ready;
 	unsigned long stime;
 	unsigned long utime;
@@ -203,7 +202,6 @@ static void halbtcoutsrc_LeaveLowPower(PBTC_COEXIST pBtCoexist)
 
 
 	padapter = pBtCoexist->Adapter;
-	pHalData = GET_HAL_DATA(padapter);
 	ready = _FAIL;
 #ifdef LPS_RPWM_WAIT_MS
 	timeout = LPS_RPWM_WAIT_MS;
-- 
2.7.4

