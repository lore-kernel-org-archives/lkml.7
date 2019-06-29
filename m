Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407BC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F13214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYW33GDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfF2KV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:21:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45681 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:21:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so4195106pfq.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=6jXcyQz5oa080ljH3lxwjJW0irqf5iKTZLTX/DBR0+E=;
        b=gYW33GDAqkR+vAX51JYX0WJRg2g90O0GCNR796AKAyuwZwyqEknNkrHofqojPQgC3v
         9+HBX+fe0rsmEl9m2ZcoONZrtp9V9wIbIpKBXnVT8M/kB/etHergY6GCdZDYQnPnO/Kq
         xDOzr/GngzypwOCdonpklP5TwfsEYM5PC88aLcBlwa7IY8Xl7txf1UX155zSXMx17ClY
         TVA5+WSbxbhwn0FsZoS4PuV2SgnYVfMtIszC3xUFLgyytU4U6a56IRA/uzJUjpYilXpn
         hdZ5iwnXPUrQorOtcFXKcPNZleCoaEMXcgRxIGbDbDvjGbOWWv5tuA4ANllXE+7PwfD3
         hWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6jXcyQz5oa080ljH3lxwjJW0irqf5iKTZLTX/DBR0+E=;
        b=SOJjGLO0oYOEJOGStKHCfqbDLFdD8sLqr99x6Wo/Nkuqnjp00jnDTLC2HKC2a2LCTK
         VS021YnyMChde5DrexTYNO5He2wE8v19VhER7MW1Z1/WuW4OuBsNKMKSkK7SSsKQ2mX7
         BKolMHYa62/BPyIoDZEHKUs3vGtqVD5SqbL46UeB2Xas/rNg/uH2vZux1+mNtzhMhF1C
         0SGJacRT5VX31CqyD4T8g6Z5czix0B11OAPFpkTbrIcma6IWTR0F6ZmsGSfkkRiQhINk
         CztX5N4j6nOV6M/nw8iGoaXxn1xFczBpIGegXfYzr2N26XkwoGaBq/Dn0N2S9ElYv+EX
         8gCA==
X-Gm-Message-State: APjAAAXpUVi6ZIEjGB2VCERCB8WPLKWNeCvuU5e3SZyRvzRUEXYq1HY9
        aYridq8YhkWuD5/niK8Oc9Q=
X-Google-Smtp-Source: APXvYqynepLHYgkegudtj1Py1uSpr5ZQod36GZy1XyJZZ2I9kjwtvbDn937KkZq+Iv1unQYqnMnR5g==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr18988874pje.59.1561803716298;
        Sat, 29 Jun 2019 03:21:56 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id n98sm5103405pjc.26.2019.06.29.03.21.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:21:55 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:51:52 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629102152.GA15011@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 4d06ab7..39d7ba4 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -724,7 +724,7 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	pregistrypriv = &padapter->registrypriv;
 
 	if (
-		adapter_to_pwrctl(padapter)->bips_processing == true &&
+		adapter_to_pwrctl(padapter)->bips_processing &&
 		adapter_to_pwrctl(padapter)->pre_ips_type == 0
 	) {
 		unsigned long start_time;
-- 
2.7.4

