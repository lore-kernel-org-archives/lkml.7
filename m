Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB8CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B608B21D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaB/UDJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfJYX3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:29:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43152 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJYX3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:29:41 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so5747580qtr.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QTe/mbHSIGF8oyKbKycoldd59M1YyY11WJBJiD/SUAo=;
        b=DaB/UDJYQMh1LUc+LAjr6OOYvjQ7nXfj+AhOR/wDO/Nm5udxMuFGjNHMnaCs+Qur4C
         5t1reY8OeD6PoiQqKJRyPurNC7CNLHl83DxsyZqDWD8bGdhTAv+MdnLBWzHHqcFw1VTc
         ApVjWij7lLaM9Ir2Jep9LKRRrutpMWQoNIFIG000V5jN1yXz85RFRIoc71p+9CI1DUmG
         X5worjrOfshIj+uD8m5zHBUCxgRTup2eqP6IR2bCtDkq1LnU8OXrvKCstITgQR5meD+v
         8mI3xTGH++qS8feOShOQQ4SJcuKb51hGiDQh2tQLxsI2syBoAyIPxrxpj0REasJ49W7c
         C+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QTe/mbHSIGF8oyKbKycoldd59M1YyY11WJBJiD/SUAo=;
        b=O8S54MgFwbZay6C9D+D90lDmCVtCvGPSvK407LIVAOsX+R5cm/6OxiAFAuXq/hRs30
         ClKGeuR+XrFmDOOxueQ/Vs2bsFhqb3mdLp3SYlbBwruvaMlV/sXSOaecPT9QY6knw1Zo
         VNQ6nRnlPWR5K3RX6AARnfxEPywyHeyNGQPncWywS2AsDB71kFLhJi9og5jn5wtHIW5S
         w4FsKxNxr2giegP8qUSImpXbb11tPDA3IMUilSbqUBZuYiVn8kZBOByY2EoKeu9JjFor
         1HeIQ4qb2ecGEVKYAmh1ST/6tGPeNzO7nFhTnj6k1huCsmpGikPFCqtIDFqDehKipKmt
         6wbg==
X-Gm-Message-State: APjAAAU29KN5qgrLYbDb9f5udWnvL1y5dwS1arKV8Im25tx8fiJ0THRB
        cWOAwvTxRtiBmy3sMBj+kwQ=
X-Google-Smtp-Source: APXvYqwSbgP7CVSsJKguPWXzctIkaWdwFBC78hDo373R593Z6gMUb5X/2W2rNjBNT5TngsGpKp19yA==
X-Received: by 2002:a0c:8b5b:: with SMTP id d27mr5989394qvc.29.1572046180069;
        Fri, 25 Oct 2019 16:29:40 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id o13sm3096434qto.96.2019.10.25.16.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 16:29:39 -0700 (PDT)
Date:   Fri, 25 Oct 2019 20:29:35 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] staging: gasket: Fix lines ending with a '('
Message-ID: <20191025232935.GA813@cristiane-Inspiron-5420>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines ending with a '('. Issue found by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index d1b3e9a..e3047d3 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -54,9 +54,9 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	ibuf.size = gasket_page_table_num_entries(
 		gasket_dev->page_table[ibuf.page_table_index]);
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
@@ -101,9 +101,9 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
 	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
 		return -EFAULT;
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
-- 
2.7.4

