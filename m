Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10756C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DF62070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuF5kf2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfDBCv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38362 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:51:27 -0400
Received: by mail-io1-f66.google.com with SMTP id v4so9649417ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 19:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cdw0h7f6dlrh5aXSLwgzdfQkXS3vqplD119RsMrSKT8=;
        b=fuF5kf2uzO6eKCQJoCOImzmtFIl4srGNj+3NVxZ4GlFI+8xf32kbBiXzKQg4lYHh8m
         0gHSewx2dwiiLdiEcfQOCi/Iq6omTexQyL/ZJSJNgCi/S07BWWSk907I/9vKv3NKUCGe
         xt0abv28cYnhe1MXmY0Nw1S3GaFowyabYbMeMZtzcqhYsXc20h/p7dmbGlnQV6/kofn4
         x6gMTQ9ER6+hOYcZ5s7cD9YBNd7LCnk75xY7JoMkkrOezsKXogOcbQn6oOTqylh+UVpu
         LlvcoQPeJnu/r20E5MSI+BZXIlLQHSi8/yrbAV077YTu+qoWiVtbCC4LrstI9F0QHVH5
         BSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cdw0h7f6dlrh5aXSLwgzdfQkXS3vqplD119RsMrSKT8=;
        b=XoVpDZUcpnnwwYhnB0eYNnlqwMpA/AJyKKTb5ozSU54nLLbZpKvCLBEsgGAMLHA5Rn
         afdGPcFSYsOH9mWgAKZxLGSrq4ktYhcYLwOzH7RKIckGqMzD8itZKMyFIcX6S69CAOLx
         9eSsG2HxNKFcvd2Xa8DtE4dtzrI8DLac/9r7j5Nqq1A+wv6b085miqLEgUwq04U9yS8d
         5AfAjLFcuRNoCv29CqgBFrj3zMQXwR/RWNdMHW30RMoFIh1G5ebQD72QvIl2+xmo1mFw
         sGaHua/Y8OvoAowJXBugKpQcJ1dD87naTBWwHgovx0INlnbtIxJAk2EcOZTtrp25aeCE
         KxZg==
X-Gm-Message-State: APjAAAVEsP+KquucCFkkEYF9j0fK3LJF/KlJE/KhwC4/AIkmngYE3DNb
        8Hz0KXdYYoIK/POPTxNJouk=
X-Google-Smtp-Source: APXvYqx1l4rB7O8duuoNbfA+uXPVlsXJUEXaVshzrHkemOxLXJv/auYVyk9ZS0PCXNEppkqZulLd9A==
X-Received: by 2002:a5d:8d88:: with SMTP id b8mr29322375ioj.58.1554173487061;
        Mon, 01 Apr 2019 19:51:27 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id f197sm7154847itf.5.2019.04.01.19.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:26 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:24 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] samples/kobject: Replace foo_ktype's default_attrs
 field with groups
Message-ID: <ff51525109ba2697b0e0f91b622c1473ee2d0141.1554151487.git.kimbrownkd@gmail.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <cover.1554151487.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kobj_type default_attrs field is being replaced by the
default_groups field. Replace foo_ktype's default_attrs field with
default_groups and use the ATTRIBUTE_GROUPS macro to create
foo_default_groups.

This patch was tested by loading the kset-example module and verifying
that the sysfs files for the attributes in the default group were
created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 samples/kobject/kset-example.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 401328fd687d..c8010f126808 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -178,6 +178,7 @@ static struct attribute *foo_default_attrs[] = {
 	&bar_attribute.attr,
 	NULL,	/* need to NULL terminate the list of attributes */
 };
+ATTRIBUTE_GROUPS(foo_default);
 
 /*
  * Our own ktype for our kobjects.  Here we specify our sysfs ops, the
@@ -187,7 +188,7 @@ static struct attribute *foo_default_attrs[] = {
 static struct kobj_type foo_ktype = {
 	.sysfs_ops = &foo_sysfs_ops,
 	.release = foo_release,
-	.default_attrs = foo_default_attrs,
+	.default_groups = foo_default_groups,
 };
 
 static struct kset *example_kset;
-- 
2.17.1

