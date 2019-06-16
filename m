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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA1C31E51
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278D82085A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0E2MJVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfFPDOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 23:14:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35849 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfFPDOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 23:14:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so3834133pgi.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rM+/ypTKzHDjmz5d8wUoyWYZZW60mbQw25HJyMsGcus=;
        b=g0E2MJVyJwD8xzdXPW4vo5+svFBVDkX3MTAZMd/BVjkmU8RTOcXWTSqspOn9f2IdCa
         in3syGs281wTXIoJupcx6YFReM+1FWNyusQXDsL84KT/ueVNqDoCz0aMWXmcZE+KuJgM
         pzK6A8AfHIOPQ65RVGCE7B37O8lhw3ojjhkSdaWSjvQMb4yyXI6chs4jJnbu1lLHJbKb
         6vEpb8fIZPy+pxXkv4wQPC4YXP9nZo1I6PYvcnonL/+q4MGfVjO1yf1iPwYXCLU6XzbN
         ciSKb0OsvgnINeFLiWb2YfPWfUcTIgmFKJwNLVUZ0F0FNRJp2/F91tGCQDMmwZK6FRlz
         p85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rM+/ypTKzHDjmz5d8wUoyWYZZW60mbQw25HJyMsGcus=;
        b=YDfQUDFxZa018opJRCiyfZSbQfvRse7UznFHm6ETlAiaLKO5XuCKMu6q0utYALI9XO
         G4mb+A9m62p+khKCcm64GAySuzBRk3LznqcusOF8oWcVi0yn3yVx8jM2bHMnwbiemRtW
         mEiJIrAGOlCGS7aJ+/YZAh1B/5y3YIexyZR2Q+wqz0mn9R4Pyg1JER+QF5UhtWKUgX9I
         W+arow7MgWrKfmHJg1HWd3jEeoZxs0PbDbn79bxTDGEHDZmJPW9G4Bn12A+vIXIvQvB6
         5ExMn3/sbyUWie1CRcO5UBMX5gsE9YBM0MZ28sIBlR8B8ZpOHnVKxriVXFitJnKlaW23
         iQ+Q==
X-Gm-Message-State: APjAAAVrqTGNt9hHe2PQIEJjGa3Oi14jeQfc6BmVVl/LeB1SO1L9ktH9
        RVZuiJVLS9epp4sruj9oOFM=
X-Google-Smtp-Source: APXvYqx5Q5OzlQnfYKaEt8bu5j1BLwY8DuR4IQwNc2Yj7q95qerphSUWOKKRyNbbNGEH0WBOjgw2Hw==
X-Received: by 2002:a65:514a:: with SMTP id g10mr42838711pgq.328.1560654856182;
        Sat, 15 Jun 2019 20:14:16 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id l10sm746697pgm.26.2019.06.15.20.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 20:14:15 -0700 (PDT)
Date:   Sun, 16 Jun 2019 08:44:09 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Add null check after memory
 allocation
Message-ID: <20190616031409.GA13001@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NULL check post call to rtw_zmalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index ac79de8..9177c18 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -816,6 +816,9 @@ void clearinterrupt8723bsdio(struct adapter *adapter)
 	haldata = GET_HAL_DATA(adapter);
 	clear = rtw_zmalloc(4);
 
+	if (!clear)
+		return;
+
 	/*  Clear corresponding HISR Content if needed */
 	*(__le32 *)clear = cpu_to_le32(haldata->sdio_hisr & MASK_SDIO_HISR_CLEAR);
 	if (*(__le32 *)clear) {
-- 
2.7.4

