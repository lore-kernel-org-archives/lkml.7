Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0A321939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257049;
	bh=sRbmd3xFavSrlK6/o9IaQFEO7DFEDX8DHDxLhyNx3sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KuFpzSzE5ru/rdvNtV++/hscwl80Cd6lIXyDMNxOcx7QUc1JMYk8l1SAiX8/bRv4e
	 DSy5ZOT+cAag9tX3rCOR0h1Yl6XBEKSTAqPepjFOHooFYGWW6L/voXZHINS7CuPGkK
	 HTatzoy+eumn50qGFG07dYw6zJP4+5b+BaYjwlzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbfCVMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389942AbfCVMRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D9C218A1;
        Fri, 22 Mar 2019 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257043;
        bh=sRbmd3xFavSrlK6/o9IaQFEO7DFEDX8DHDxLhyNx3sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v9I8J4C/FoINySWOzmOqZ37br1blrIy7vohvcWnZdMGfv+ErJSDw5Dzo7MHGF33+T
         xFfB0XRrpNGMLzrp1KkXy/f62guYJT4w/caufLIyg4hGtqgE2DuONhOS9NUDuSReOg
         f8He2B3nGp27DdU81YETsRpVvPgIw1pH4AEuZ+GA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 114/238] device property: Fix the length used in PROPERTY_ENTRY_STRING()
Date:   Fri, 22 Mar 2019 12:15:33 +0100
Message-Id: <20190322111305.248843580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 2b6e492467c78183bb629bb0a100ea3509b615a5 upstream.

With string type property entries we need to use
sizeof(const char *) instead of the number of characters as
the length of the entry.

If the string was shorter then sizeof(const char *),
attempts to read it would have failed with -EOVERFLOW. The
problem has been hidden because all build-in string
properties have had a string longer then 8 characters until
now.

Fixes: a85f42047533 ("device property: helper macros for property entry creation")
Cc: 4.5+ <stable@vger.kernel.org> # 4.5+
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/property.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -258,7 +258,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
 (struct property_entry) {				\
 	.name = _name_,					\
-	.length = sizeof(_val_),			\
+	.length = sizeof(const char *),			\
 	.type = DEV_PROP_STRING,			\
 	{ .value = { .str = _val_ } },			\
 }


