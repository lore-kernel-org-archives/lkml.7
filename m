Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FB420857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlWabkS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCKPnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:43:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33941 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKPnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:43:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id u9so3983266pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=ld8EPvbzVMT+SldYJEwcIcbStFIJ9Fh5lF2txc8ZdMY=;
        b=WlWabkS9w+6ltQ4/pFiAOEjbXyXQVpSWZJFW3tlYc66dWRdgrsW4RSBcH04WPcB4Ig
         n/Pqbmx0WAgDwV/p4E1p83kkTzFDsHU9siwtLJdaLyqTC2o6Xdz3J/aVJ0HZ55g812XL
         wAuECGKr5Qm8aekyKHSRxWH76AoEoBW+S5tdfJ61dsklzvNObxa6ph7003y4Cb+b5tbi
         QR64xq9aH3fUNo+zLZYa1gjrm5xszJivZbB2dVxIqw1XJpLpy4qcQ1qLeFGOZtRvZrkK
         rkKdg3iihV7Qe33SVFdmbukg7pdOlSh0yxeayJqHWnnVRahD+LGOwuyN6j90Ya0N7ThE
         oRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=ld8EPvbzVMT+SldYJEwcIcbStFIJ9Fh5lF2txc8ZdMY=;
        b=s5/2W6WSRa5QtNaiWpG415p+8IQH2Ls4fdqK6bMBiDjAXBdWVYZ3UgX/7OPTK9LN5v
         I/gDKBpJSQVqAdvRFYejZvh6CjczeM+0B4aNNqyfaWlo4c3xdlCE8pWTq2CbpPI583GR
         OGV4GXcsiI5hKFhQAG1uZjJ3Z3Dig1UkgWFXUUD8SJ4uosKnDvQSD5Mu21k7YRJULEvv
         8RDC1IXM0AWvn6YSLkvjdmKPHsyL3jInXsO9kx5xHgYHFpi652tClYmJ1uIkDNpzvyEW
         Prnx4zvxJzrjm/Ajl2Sb8xlYvxDlN8mT3MEKXK8F0f+b/SQu7YK5A3/DxzHK1cqr+P4n
         0NHw==
X-Gm-Message-State: APjAAAX7ssff7W4/eZqzj1jipfD6AExCwO+WM7Fv9OEKkbQOrQzwLin8
        I3vnneg6mBU5GS/CsEhDA90=
X-Google-Smtp-Source: APXvYqwA58uvt+eCeFrt0yEQnwzmbUNSQbHBJbvbMvuz7aJ7RKIlDds2FFZtH72JjSZ9JOdl4jJhyQ==
X-Received: by 2002:a63:5812:: with SMTP id m18mr1682303pgb.325.1552318991932;
        Mon, 11 Mar 2019 08:43:11 -0700 (PDT)
Received: from sabyasachi ([2405:205:6194:e788:a4f9:f674:88cd:e152])
        by smtp.gmail.com with ESMTPSA id 20sm15885244pfs.182.2019.03.11.08.43.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 08:43:11 -0700 (PDT)
Message-ID: <5c86820f.1c69fb81.149f0.0834@mx.google.com>
X-Google-Original-Message-ID: <20190311154303.GA8425@sabyasachi.linux@gmail.com>
Date:   Mon, 11 Mar 2019 21:13:03 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, jrdr.linux@gmail.com
Subject: [PATCH] fs/coda/psdev.c: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/poll.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 fs/coda/psdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..f2bb798 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -39,7 +39,6 @@
 #include <linux/device.h>
 #include <linux/pid_namespace.h>
 #include <asm/io.h>
-#include <linux/poll.h>
 #include <linux/uaccess.h>
 
 #include <linux/coda.h>
-- 
2.7.4

