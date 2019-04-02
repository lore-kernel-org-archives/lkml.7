Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D989FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0F2070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sl9qwHk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfDBCvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:51:39 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34557 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:51:38 -0400
Received: by mail-it1-f196.google.com with SMTP id z17so1569090itc.1;
        Mon, 01 Apr 2019 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDRmXG4optHf14MgiYhDhFbha36CsRJRAHAxA5JTtPY=;
        b=sl9qwHk9jK8xSLwOViaALM0wcHAlzfRqjr3YRxuWXARwD4GjF+sXvzo9CKSluCaVaR
         tg7SjsIa/vw2IAUC0gaYBd02mkwatRJIjX2QL0P7XrvZLPUGTfz5xgk/aIiKHnRf+IQg
         b+qTWr/yuYNHY6dQMR3ADwYi8ihgfsixd8v5m8E3gM2K3wQFi4PPCZY5RVT7d4/v+SUo
         nXlKG+XV0YXsivRcm+Cw8CVGnILD7yf0XJfhqbSCtRxr61aCtB00dBOYwmlhR/5QAEFd
         BNRJx/TzPFCJfInKd1xDGtIVhL8MzAcXxfj5Ku5xtbZxGxp648eVvAV7XoNzOO7p97Vw
         l4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDRmXG4optHf14MgiYhDhFbha36CsRJRAHAxA5JTtPY=;
        b=j3ayeH+EAiqLsi9iUZaSCnp2ReQQf1m0vHbp6/fVEXI9Mi5/13aF3u/OcPbXt1BxT5
         9wSOgWliLdAS3hi5SLNOM2GjVt5fB8hhh3YiixKHOEk1Mr817BfrJgcajGpfzPV5s+Zx
         lRhJpk8jIfXRijYqvAl4ZULsBJJC5RILje7Kc4637aXXhnDCmG8a17KfQ/cwo3L7FXlp
         E62H8y23+DkjmV/yffoAeSTmXdcRWJxhEEcnaA5xFdy4k+4DCdqbQ90ldf/EM4zQ3829
         In5CiLWj+iPEgyqELnmGHN/5uUIlnNtiPCngRRfbAIXrqLkjeEIy3gXe9SnH9tzofYEL
         mX2g==
X-Gm-Message-State: APjAAAWw58eQczzu9V5qbzExizMH4yNi+vWZ36I1KPFoCi3j07h6sGJZ
        dBW0h742muoDqkx7wf6XSinLp/G/
X-Google-Smtp-Source: APXvYqwdOYGiQ7e2ZSSjD3kf6rKyYHKQH4h9U7tRruCweO9MaGAnGbUSjIFFdUCZ99an/R58zwzkLA==
X-Received: by 2002:a02:1b54:: with SMTP id l81mr48720453jad.87.1554173497992;
        Mon, 01 Apr 2019 19:51:37 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id w69sm6584328itb.8.2019.04.01.19.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:51:37 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:35 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] net-sysfs: Replace ktype default_attrs field with
 groups
Message-ID: <25086311cc1c90f69ed00dcf2333b75f6d39cf38.1554151487.git.kimbrownkd@gmail.com>
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
default_groups field. Replace the default_attrs fields in rx_queue_ktype
and netdev_queue_ktype with default_groups. Use the ATTRIBUTE_GROUPS
macro to create rx_queue_default_groups and netdev_queue_default_groups.

This patch was tested by verifying that the sysfs files for the
attributes in the default groups were created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 net/core/net-sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f8f94303a1f5..bbf47dfb8a18 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -863,6 +863,7 @@ static struct attribute *rx_queue_default_attrs[] __ro_after_init = {
 #endif
 	NULL
 };
+ATTRIBUTE_GROUPS(rx_queue_default);
 
 static void rx_queue_release(struct kobject *kobj)
 {
@@ -911,7 +912,7 @@ static void rx_queue_get_ownership(struct kobject *kobj,
 static struct kobj_type rx_queue_ktype __ro_after_init = {
 	.sysfs_ops = &rx_queue_sysfs_ops,
 	.release = rx_queue_release,
-	.default_attrs = rx_queue_default_attrs,
+	.default_groups = rx_queue_default_groups,
 	.namespace = rx_queue_namespace,
 	.get_ownership = rx_queue_get_ownership,
 };
@@ -1416,6 +1417,7 @@ static struct attribute *netdev_queue_default_attrs[] __ro_after_init = {
 #endif
 	NULL
 };
+ATTRIBUTE_GROUPS(netdev_queue_default);
 
 static void netdev_queue_release(struct kobject *kobj)
 {
@@ -1448,7 +1450,7 @@ static void netdev_queue_get_ownership(struct kobject *kobj,
 static struct kobj_type netdev_queue_ktype __ro_after_init = {
 	.sysfs_ops = &netdev_queue_sysfs_ops,
 	.release = netdev_queue_release,
-	.default_attrs = netdev_queue_default_attrs,
+	.default_groups = netdev_queue_default_groups,
 	.namespace = netdev_queue_namespace,
 	.get_ownership = netdev_queue_get_ownership,
 };
-- 
2.17.1

