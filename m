Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D713C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C85F2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu6ENkUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfDBCwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:52:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41496 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfDBCwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:52:02 -0400
Received: by mail-io1-f65.google.com with SMTP id v10so9632575iom.8;
        Mon, 01 Apr 2019 19:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wIWPyD9h3bQgfe9zg0uJ+mpqYiO9JDv7lJfMFW8Van8=;
        b=pu6ENkUERaepnoXNksV4QvU537rbXFkWw/BpofYn8fZ6SwKMEji6wjD3zWFAFVHGou
         QbSZua7CYQIgrX1JHp6S+8bOVvaPeN7+RXkd10ETJilMlbV/5BEHqvqVx1B03h37b6TJ
         YPNyge2NBLsgejuBXU55T7s5Yl0pBm4hIQAqUGkWeFaboYbNyVl9Y7foQ8UPOHpmh4Oh
         ZYxSXMw+0arVaH8sD+hE3vx3jZRW1PkOGrHHkocq5uGYGIsyJejeAslGtoE6HWPKknfs
         BgkQ+KeU8TCsFupIZi4IXbsYLehxRQllCZl4jO3cR9CXz8Ut67CX0qptbOG7XpTfoLMY
         ZdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIWPyD9h3bQgfe9zg0uJ+mpqYiO9JDv7lJfMFW8Van8=;
        b=ZfVUDWVJWJuPHYRGrSKU/c4zJXlkoIkWbRZeutM760v/dqNsUcdsCjbaRJ+aVA7as6
         X3B3Y9bRGhbTFQBwVmhI6L5Dqtum+XdZBbdmST6Q+XE7vk0SCrSySOx0Y17fNApQDbVg
         Pa+ysznOkLksnu6AGMwp1vc9e2SsPaXGztc2S7nLwgcXi4JQ6eJq0ByUJaFZmLG2wlEA
         bOsEmvZrpJ+WJlNobS1TttggPLD5shIqBDuvs2PuijTlSC6ZJZmlN1TYiw+6I913p3Zj
         GgyzJa7PLzmqlZRcDl9nbwlw9Hw4d7RTbhQ8hxB9TpRrEHRx4y9+mbMWaBSJPo7EMz1w
         mIiw==
X-Gm-Message-State: APjAAAV3A5gH3CUwvr7dh8czCKK45O8TgcuGfmv3qy0nsA0OOwr7x0RW
        PJi2ZC28AGi38FAWuf3TNRk=
X-Google-Smtp-Source: APXvYqxmJg6kJXjkGuk1za2hiwLv+d+VQOTSmnV5ZcISOev/xXRMt+nGbcAMMi4F3dh42zjq6Z/Dvw==
X-Received: by 2002:a6b:e009:: with SMTP id z9mr30739152iog.127.1554173521377;
        Mon, 01 Apr 2019 19:52:01 -0700 (PDT)
Received: from ubu (2600-6c48-437f-c81d-984d-b4e8-0abe-7e26.dhcp6.chtrptr.net. [2600:6c48:437f:c81d:984d:b4e8:abe:7e26])
        by smtp.gmail.com with ESMTPSA id h133sm6506558itb.34.2019.04.01.19.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:52:00 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:51:58 -0400
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] livepatch: Replace klp_ktype_patch's default_attrs
 with groups
Message-ID: <1571eb59b1d523aac81d524ae20a56cf378ef9c4.1554151487.git.kimbrownkd@gmail.com>
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
default_groups field. Replace klp_ktype_patch's default_attrs field
with default_groups and use the ATTRIBUTE_GROUPS macro to create
klp_patch_groups.

This patch was tested by loading the livepatch-sample module and
verifying that the sysfs files for the attributes in the default groups
were created.

Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
---
 kernel/livepatch/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index eb0ee10a1981..34a8338657d2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -419,6 +419,7 @@ static struct attribute *klp_patch_attrs[] = {
 	&force_kobj_attr.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(klp_patch);
 
 static void klp_free_object_dynamic(struct klp_object *obj)
 {
@@ -546,7 +547,7 @@ static void klp_kobj_release_patch(struct kobject *kobj)
 static struct kobj_type klp_ktype_patch = {
 	.release = klp_kobj_release_patch,
 	.sysfs_ops = &kobj_sysfs_ops,
-	.default_attrs = klp_patch_attrs,
+	.default_groups = klp_patch_groups,
 };
 
 static void klp_kobj_release_object(struct kobject *kobj)
-- 
2.17.1

