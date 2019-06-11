Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C5921743
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4o0MlAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407017AbfFKSVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:21:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45625 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405802AbfFKSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:21:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id w34so7405610pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M6/ZPn8xIOzr0YIkcM1HqW+DDeE+OQYEaIUibkKZb5s=;
        b=e4o0MlAUmqo37Ha3paSip6SEW9qNLCaZI+xuZiXxDPjpul+YJjuMC5MIjCp17gwJRS
         4XChw0YtPxCwoGSnW7Xd0VP8QdqaBpIfUv8rjM08wmSRbmOGDeSQz6kU1TnWreNk3Vm6
         1dMgiuA8yYUcKSvq80IL1riHSqxH5CW6toOUjPaBM9gf9rO+WViDcsGQPzwUq99niD6Y
         M4PTDUxDJ3rcFRB+B/K0v+vHPF6A5HIL3DEWtTG0NKx44UbyVoieDDvIKlCfSGp8EUMf
         vtkevDWL+ytKh8B5xyBr5DlWHq5UaDKxBtSP0IrgLFFFSRheHUf18reUzkaB5/GBrPPN
         XU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M6/ZPn8xIOzr0YIkcM1HqW+DDeE+OQYEaIUibkKZb5s=;
        b=r7QKiqrc3dJT9ZH1Jiv2s13/hsxVa0a9rFQMtX5ZkrnAl6ZTYNZkjSnorjX0agJNQ8
         e5Y/S2Q+341NArrrTvaDP6P7QokhJcmpG2pJs4+EJWmHp0iB+tcjZCHvVM5D7W20orja
         JHOREHBJZGVNXiFN/6E1rneDCy5wzSD1J0CrBdj0kdnmGxJCfsonIv+nXAuTl1XotCZb
         QE+P3CEKSAOXEtuXyuDMM/0ENEAulkjDV+CHf7CC9XuN/PtQn7dsGrBzJrQwJftsNZws
         V1OLIclzilD6u5k1nADzcLOt8g0XiP9G2SUlFSitw3VJ+ylhnJGkckGzvfV4i43zKWLL
         HEcg==
X-Gm-Message-State: APjAAAXqbbjKhu4JExj66eF4+wbsCEvDhMUYpiqRjRQlF5+Vsm6NZz4s
        vE/X/04U6LASZ8icvAkCA2A=
X-Google-Smtp-Source: APXvYqxedw3RwRy16+RKHn1pE2FIn+u9mKluOP7NoMBZEtWh8I0BgH+IY7f8QGze0YQNXu08Fo1kOg==
X-Received: by 2002:a63:f70b:: with SMTP id x11mr21904632pgh.212.1560277308535;
        Tue, 11 Jun 2019 11:21:48 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id o11sm2780547pjp.31.2019.06.11.11.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 11:21:47 -0700 (PDT)
Date:   Tue, 11 Jun 2019 23:51:42 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: hal: sdio_ops: fix Comparison to NULL
Message-ID: <20190611182142.GA7164@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below warning reported by checkpatch

CHECK: Comparison to NULL could be written "c2h_evt"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index ac79de8..baeffbb 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -1058,7 +1058,7 @@ void sd_int_dpc(struct adapter *adapter)
 
 		DBG_8192C("%s: C2H Command\n", __func__);
 		c2h_evt = rtw_zmalloc(16);
-		if (c2h_evt != NULL) {
+		if (c2h_evt) {
 			if (rtw_hal_c2h_evt_read(adapter, (u8 *)c2h_evt) == _SUCCESS) {
 				if (c2h_id_filter_ccx_8723b((u8 *)c2h_evt)) {
 					/* Handle CCX report here */
-- 
2.7.4

