Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F76C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9847020815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 05:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDSvJxoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfETFJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 01:09:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37343 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfETFJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:09:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so6126754pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 22:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DeIs543Fo1tpzwAkDVz3s9YNCY92X0aAoYWEA1Is5po=;
        b=iDSvJxoyo8/zSnrpacypxGAJ8DIx2dMzxkEobc2T8oAlUqfFxTELXIM5+iypd3nIub
         rKXSEQhXpleytcV5J6xqxhkbI1DMR0wkN9ik/JikUN+zKDA7MhRg/nZGt3WZpqhUxttr
         SCtiSSMgSs1TmZekU5oMVxh4mjBFFR+2OrK3IS/ngL5S/Ho/BH9ExsRJtF98yBQO9h65
         QpD0S5PDDyEsubyaaQrvqDmE+CCNd89wyoI/567UvQSJJ+t1YvexV8PI1jK0GmwMHCNE
         158P9C+wr08SmUXPvYW+LJWo+Cz7QpFfDmCqcA8XJBfKd6gy6K99TTQHfz3FFdH8bYQ+
         OQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DeIs543Fo1tpzwAkDVz3s9YNCY92X0aAoYWEA1Is5po=;
        b=DBax8n1qw6I97RURCkn+1MwwKwizx0mMw4Mc6nVsTM3W8+NTRVuKhbNzfO9W3QEIy3
         6dB2b5zVg8I8JyeL20mkpXNbM4opRcmOddCPTsgiSqp/Oh/HMp92dnuszfhrAcYZJf/z
         NuxzhENDbKYOI2KIE0M312XuDS83pN8jCLoM90SYZUcyC2DOMgpP2RTFbXpu2GJ3+hy8
         ex1i+9zsaBlj9CrmKiww1vueuLP+oOB7fSZq5iL8rObOL3oyojokxe/6ZZL3358iOs4n
         xNBCSlp5u6LHlXlgvUTqPIefhZDoX3qh50aRVtsVl6KyyF3/iSca87U8i9faYpcj04++
         szAA==
X-Gm-Message-State: APjAAAW2gojemPnQsVQW1nli63P0pXSb/6ItjuHTLvnMZ69Kitf0bUos
        ENBXonADAGt408y2qmW9uuY=
X-Google-Smtp-Source: APXvYqy37pMVBK6+3abGAwLpzkZZrYA7oJPZFNgJ9fo9QTyaFz16kB99SUsAbvKb+HGqpfiomDh66Q==
X-Received: by 2002:a17:902:6b8b:: with SMTP id p11mr72497464plk.225.1558328992779;
        Sun, 19 May 2019 22:09:52 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id s80sm44199649pfs.117.2019.05.19.22.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 22:09:52 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     houweitaoo@gmail.com, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, jroedel@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] intel-svm: fix typos in code comments
Date:   Mon, 20 May 2019 13:09:48 +0800
Message-Id: <20190520050948.26841-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix acccess to access

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 include/linux/intel-svm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index e3f76315ca4d..8dfead70699c 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -57,7 +57,7 @@ struct svm_dev_ops {
 
 /**
  * intel_svm_bind_mm() - Bind the current process to a PASID
- * @dev:	Device to be granted acccess
+ * @dev:	Device to be granted access
  * @pasid:	Address for allocated PASID
  * @flags:	Flags. Later for requesting supervisor mode, etc.
  * @ops:	Callbacks to device driver
-- 
2.18.0

