Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE5C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222532084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWhWxleP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEDKYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:24:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43002 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEDKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:24:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so3931602pln.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wRkvuk/ppkVfgQA/u04JxN+vTaK6+EHxMzg7OnHwzD4=;
        b=TWhWxleP46BcSY1Uz2j+Xjvmeef0FV+PfLIXvjO8h14c9L74PwqYaW6Jc5xw7Wwm+7
         k9jPwsyb9PnXoycYekq77xwy8/S5vz2lSMmZ9fsweaBXYTJf7SDOr7kRsAP3ULdDw2Iy
         za5N12ES/9LZfVR74lHE5Kp2sfQ6LhAoWt6deUQ6heD2MXq/X1GDxww4jHcgmwxio7xB
         JUJlKd9wnKde61P9294kZxqQWf7skpo180qbkyc/tbFzVHKec9WG+8YzlngJ2YyKEIFj
         C+BuybUMl0OBV5l1ECAmTxYSDpuXHhsFw8iirHgx9Om9Zbz0V6qIRky+JTt6FfX7Ex/E
         jl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wRkvuk/ppkVfgQA/u04JxN+vTaK6+EHxMzg7OnHwzD4=;
        b=PLqvb2cDBPL4IFgUMndbHZhedOBYTWnJBCLJSx/oNBIWBFJEfKsj+eTq3VFAbF57me
         6vlVEHfG3c8qk4ijQDyTOJxf5Vbr5Xyjgyl7uDU9HdfeXdxN4KcPJ9/+hS7xINdTsY1t
         hpz+z8sZnrbFDlZRhp1WDDiCesDxh2oYCNW23pxoZBgdx+fQy4b7knW0P3xVnyS1On4B
         /hT9HTotCe6msN/3lXMqJVK4zbKmpvt9huq6Hzmbj/bloAXSabzm55kXDyLX7GtTazPV
         ueqMJDRFf2BeI3zrKVQ59mdlDzDyvRalGZRC38zaR7CLKZ29azXzng8h4QQZ0MI2OY4P
         RyRQ==
X-Gm-Message-State: APjAAAU+4smM8Bp4FaE0S7mninTs1vizpTDDTvtVZuQFIbNepYjDvQjr
        X8cypYP+PzbjkROhhZZOj2g=
X-Google-Smtp-Source: APXvYqzhCR5f2VjUvwDp1NC12WDK6Oxoh0vxQmYCf2LUf6eeQLNua9JxUOZf8xsL+aIinevs5TMWAw==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr17326462plt.59.1556965442466;
        Sat, 04 May 2019 03:24:02 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id d3sm5927732pfn.113.2019.05.04.03.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 03:24:01 -0700 (PDT)
Date:   Sat, 4 May 2019 15:53:54 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/huge_memory.c: Make __thp_get_unmapped_area static
Message-ID: <20190504102353.GA22525@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__thp_get_unmapped_area is only used in mm/huge_memory.c. Make it
static. Tested by building and booting the kernel.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 165ea46..75fe2b7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -509,7 +509,7 @@ void prep_transhuge_page(struct page *page)
 	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
 }
 
-unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
+static unsigned long __thp_get_unmapped_area(struct file *filp, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
 {
 	unsigned long addr;
-- 
2.7.4

