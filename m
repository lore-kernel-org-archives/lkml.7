Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F3C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C2621883
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="B+rVbvKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfIBWlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 18:41:01 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:62350 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfIBWlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 18:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567464060; x=1599000060;
  h=from:to:cc:subject:date:message-id;
  bh=GUlRnhw1ktvN0Krm8WYx+g4fwBhpTcrNDVgnXNgnDbM=;
  b=B+rVbvKduoJAhRqoGifZ2kNBi3cSb2lAosFKW/8p1001DeJxuJ8jXXXv
   Enc6HPVRqLI7b7u5gqfvr5SnVw20CPMSdVK53LOvZmqk+4rIr7EFKtG6z
   U7iuizvvoGBzAUi0M9wae3WUmugClzjNoztUUHkSrfpmLv3ZqyDXbeVFc
   urFVlizWX0cnKUbazbw1yu9fO8Ngbti7NRhwwTlWJ6CbR55Vn/6VMheTj
   oma5SPh/DGoxUB0XcQ5cZmrPU5ksDOONBAzl0BsLMmakrnNsJHlWn464K
   49ArX+Azv5El7VtMYjwSnewM0Xq04YS5Z2jfCMHqbTK9n2N3swyiRODKE
   Q==;
IronPort-SDR: 7zsmiVklgKYUqrTzMLNV3WorNr0UbxqhunFyPRuO8/qBeSONQ254imYQ7+5+FJWMpSI8xtK/z7
 3h/FuR4Prjyz9yyhKvov/wwuuoxAnfqddZ+JSviwykq2TdsdAow8Qp5OetBAJutdECPwMNcREB
 cAzO+TyjgHTg7zet0wHc6gNBreC5/5m2f5KtnDvLPBRHaqx0/BXqQPLrYLMWHnBQ2l9m70BHIK
 JC/XyZmFnNZeptv2k1g/m/Xjbr2ojleOJtMyPtU7luHIM9vKH/v57yiQ4KWui5iqraORWomxt+
 Z0A=
IronPort-PHdr: =?us-ascii?q?9a23=3AVfytWh9sSTiyTP9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B42u4cTK2v8tzYMVDF4r011RmVBN+dsq0dwLOO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhWiDanfL9/Lgi6oQrMusUKnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?pEX8ZRTDdBAoK6b4sAEuEPI/9WpJTzp1sPsxS+ARSjD/7rxjJGmnP62Ks32P?=
 =?us-ascii?q?kjHw7bxgwtB9IAvmrJotv7N6kcVvu4wLXUwTjZc/9bwyvx5JTOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEYtFgPEj1WQqZHiPziI0ekMs2ma7+p6WuKul2Irtw98ryOyxsgwkI?=
 =?us-ascii?q?nFnJwaxU3Z9Shgxos+ON62SFZjbNK6DJddszuWOoh2T884XW1kpTo2xqcbtZ?=
 =?us-ascii?q?O/eCUG0Ikryh/bZvCdbYSF7BLuWPyPLTp5nn5oer2yihCv+ka60OL8TNO70F?=
 =?us-ascii?q?NSoypAldnDq24C2gTI6siCVvt95kCh2SuT1wzL6uFLP0Q0la3DJp4k2LEwl5?=
 =?us-ascii?q?4TvV3bHi/4hUn6laGWelgg9+Ws8ejnbbLmppiTN49wlA7yKLghmsu6AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH94UH0RK9Gg/42n6XDrpzWONgXqrSkDwJR1osv8xO/AC2n0N?=
 =?us-ascii?q?Qck3kHNlVFeBefgonpOlDOIOr3Dfajj1iwnjpm3O3GMaH7ApnXMHfMjarhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB7EFIfLzXFLxtdPBAh86LQO02eDnB8t51o4FR2KPDb?=
 =?us-ascii?q?GWMLnIvV+L+O0vOe+Ma5ERuDrnLPgl/fHu3jcXg1gYKJioz5sKbzjsD+ZmKk?=
 =?us-ascii?q?TBOSHEn9wbV2oGo1xtH6TRlFSeXGsLND6JVKUm62R+V9qr?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EuBwDImW1dgMfSVdFlHQEBBQEHBQG?=
 =?us-ascii?q?BZ4NYTBCNHYZgAQEBBos4cYV6iigBCAEBAQwBAS0CAQGEP4JvIzgTAgMIAQE?=
 =?us-ascii?q?FAQEBAQEGBAEBAhABAQkNCQgnhUOCOimCYAsWFVKBFQEFATUiOYJHAYF2FJ1?=
 =?us-ascii?q?xgQM8jCMziGoBCAyBSQkBCIEihx+EWYEQgQeEYYdjgkQEgS4BAQGLEYIzhxZ?=
 =?us-ascii?q?slSEBBgKCDRSBc5JcJ4IzgX+JGzmKXwEtphICCgcGDyGBRoF6TSWBbAqBRIJ?=
 =?us-ascii?q?OFxWOLSAzgQiOfgE?=
X-IPAS-Result: =?us-ascii?q?A2EuBwDImW1dgMfSVdFlHQEBBQEHBQGBZ4NYTBCNHYZgA?=
 =?us-ascii?q?QEBBos4cYV6iigBCAEBAQwBAS0CAQGEP4JvIzgTAgMIAQEFAQEBAQEGBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhUOCOimCYAsWFVKBFQEFATUiOYJHAYF2FJ1xgQM8jCMziGoBC?=
 =?us-ascii?q?AyBSQkBCIEihx+EWYEQgQeEYYdjgkQEgS4BAQGLEYIzhxZslSEBBgKCDRSBc?=
 =?us-ascii?q?5JcJ4IzgX+JGzmKXwEtphICCgcGDyGBRoF6TSWBbAqBRIJOFxWOLSAzgQiOf?=
 =?us-ascii?q?gE?=
X-IronPort-AV: E=Sophos;i="5.64,460,1559545200"; 
   d="scan'208";a="5792777"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 15:40:59 -0700
Received: by mail-pf1-f199.google.com with SMTP id x10so3519278pfr.20
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 15:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GIaGO/6lrVv1xQtAPZHHAkq5TRwqsPwlAn2CQacbn2c=;
        b=KX1o1PUxj0cdbyhFC3bPaJyTpAt7RQzuqlSwzxIysLZalTDSpDVFppaOkVZewBzLma
         JcHSAYYfltwdzcQBj3jn086Cik/qG2sUqy7HVayUw0yuQUTpEeC7xFg1RJGx/DLhf4j2
         PNd+Mhu5I7zvgH9IK5JYNhhgKfCMiyb5iRYTBe6oWHRgNkM3YeH9M3Ng3ZvBTg/mtisz
         XymFd5lYPXc1AUXrbUcQMMdt9B8cdZW3R5mMmJqiJfkt2CrMlUfuBUu9Q2JUV8IDrEYw
         wB3tW9f3YllJ7V2cO07YkB1rlkbxnzlNv7nJpfkvJF9zoAOzJAVawinyCe0PinOGeC7X
         3hbQ==
X-Gm-Message-State: APjAAAXbnIrYO8rFFowY+Jl4mWVrVpLmSIMZRppn0PThKR3QLf17pYLJ
        StEdKwp4rbfdm8qOv27uJmUPLgmzqyiNtZq8WeHo2LZnX6NcSrgT5oS1kIc3HBMuGbCW9gkS8De
        ZJVCtSS9OlHsLSfYanyf9FFJXrg==
X-Received: by 2002:aa7:9343:: with SMTP id 3mr5398484pfn.145.1567464058806;
        Mon, 02 Sep 2019 15:40:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzLmFyE3A1AN/klUmAF2HP9il9dlhuyzN7kpkXtfpaPgKx7VKgNHzwRrz5IZF9ZDGCklena9w==
X-Received: by 2002:aa7:9343:: with SMTP id 3mr5398471pfn.145.1567464058650;
        Mon, 02 Sep 2019 15:40:58 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id em21sm376305pjb.31.2019.09.02.15.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 15:40:57 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: axp288: Variable "val" could be uninitialized if regmap_read() fails
Date:   Mon,  2 Sep 2019 15:41:32 -0700
Message-Id: <20190902224132.20787-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function axp288_extcon_log_rsi(), variable "val" could be
uninitialized if regmap_read() fails. However, it's ued to
decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/extcon/extcon-axp288.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 7254852e6ec0..54116a926ab6 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -135,6 +135,11 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 	int ret;
 
 	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
+	if (ret) {
+		dev_err(info->dev, "failed to read AXP288_PS_BOOT_REASON_REG\n");
+		return;
+	}
+
 	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
 		if (val & BIT(i)) {
 			dev_dbg(info->dev, "%s\n", *rsi);
-- 
2.17.1

