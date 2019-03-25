Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0620854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="W9oeS6ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfCYUXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:23:20 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33020 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:23:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E009C6A0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 20:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j9xy9PZBxTXY for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 15:23:17 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B36BE24F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:23:17 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id s24so8595936ioe.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fIZgJ+MnwfOqENFOpznHdTOiduIcAhPw+LW8+ijs6Is=;
        b=W9oeS6ei7ol3DoXBDaroSvOJ/IIqE/NDJ0UC6F6xfTNq4I9V9QpnQQeqeOOjBUZEf4
         8JoxGcv+uoEkMSYCICM+tMjiqu0+yUnS/9pQOycnzdruMmUrVjy6ND1oa7LPzinF5kxU
         nsjjdFR5HV17FWDvtng6pCjrXKpcfslCQ1qez+SUXFRS3L5RoPYlLeDpMiKICuooYP5A
         smR/dzudQHBpem/gS+CDac+iDYB/nQ7jk23XuN0geCWLfoj4A0lhnw9vgJRrl8l6zGPd
         0axZP0S2vkxAPVriiv59F2oSZujEZZR5EWx39mPqMxCt1945md+Z5i4AX3aFD0cqGF9c
         glDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fIZgJ+MnwfOqENFOpznHdTOiduIcAhPw+LW8+ijs6Is=;
        b=GTG8IvZi+dSDWuUOugtBCBqOhSixgYzXo0n7QPn+7dprQG/CA2QYHCwkKzqMvz6m7b
         cdb4VhlMsgraTykw40pTHARAVzdDMPjRLxQfxq4sE9tTrFeFZLMn9n35MUBYXsTzqL28
         8YpXOXQmfk6WQHuDG4tS5Io1N+26g8LRPoRiro6ueGEfEQYqXZAmTuaqR+K6SK4iQtWX
         arZEc1zxK1IRVSOj1eKgBGlorO3kvUQ5sfrIGO/aRaXec9qGTQRtoITXetg4n0e/uzig
         5ifh1DV01UEUyH6PSHJisl8XP9czbTeQycGBDmRcnWHchFnS+6jZolIOEr3CC0CbV8HZ
         SIMw==
X-Gm-Message-State: APjAAAVGuYFmuwZ6QwngdH0jfDHtYiUsubkrB8dDwsIIVtRbssZjXAL7
        NBzfQn4mHtUZ5ffNb+JWprF2o1PK/xVGCsG5U1LwVESasLfLkS1BrsleBt6V9eaRivyFo/vOBZE
        7yJk/mz67SMt257PmzrnADGGrHEwR
X-Received: by 2002:a02:6610:: with SMTP id k16mr19330499jac.40.1553545397312;
        Mon, 25 Mar 2019 13:23:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOhUpKQjDKeBD3lNrR1QpAG1mnQqOR3KFSxucwxhNaUSPwPp9s4laxooIePsEXhMlG8V+eww==
X-Received: by 2002:a02:6610:: with SMTP id k16mr19330487jac.40.1553545397110;
        Mon, 25 Mar 2019 13:23:17 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 134sm6032782itx.29.2019.03.25.13.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 13:23:16 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] thunderbolt: property: fix a missing check of kzalloc
Date:   Mon, 25 Mar 2019 15:23:08 -0500
Message-Id: <20190325202308.3298-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ed992024-d2a6-b3e2-dd19-edb421fa6dd2@codeaurora.org>
References: <ed992024-d2a6-b3e2-dd19-edb421fa6dd2@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No check is enforced for the return value of kzalloc,
which may lead to NULL-pointer dereference.

The patch fixes this issue.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

---
V2: no overflow issue, as pointed out by
Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/property.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 841314deb446..d5b0cdb8f0b1 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -587,7 +587,12 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 		return -ENOMEM;
 
 	property->length = size / 4;
-	property->value.data = kzalloc(size, GFP_KERNEL);
+	property->value.text = kzalloc(size, GFP_KERNEL);
+	if (!property->value.text) {
+		kfree(property);
+		return -ENOMEM;
+	}
+
 	strcpy(property->value.text, text);
 
 	list_add_tail(&property->list, &parent->properties);
-- 
2.17.1

