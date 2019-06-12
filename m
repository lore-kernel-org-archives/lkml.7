Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A9C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4521734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crJJXXAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438450AbfFLLoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:44:02 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:47530 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438423AbfFLLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:43:59 -0400
Received: by mail-ot1-f73.google.com with SMTP id n19so7599402ota.14
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q196Me2jAIDAnTBGiPK/Cxn0vMZ4fncAn8y7f8WRTyA=;
        b=crJJXXAC2Ku7R2O4W/i46T8MVMbfUT08MJ41XL5/hHP5V9FjHyo0Uen9LNxuGDN5Vy
         63AWsHkedb9O9JWDh7PX7+icF3+aQrjNm9LMqOxXKSXvWvA1aCADx8vQJIjHIcqFjNdS
         lYpx+uRnlnGYhTQ2lQa8QHdE77x+n4mpr2sUjGrEPZ8RUtGTjRZ6moY6dJvWWn+KRbsY
         dQnCJW3fkugzHDg7Z7YzCoAOi+mpWJRQPWYBzTyBpPkH9NOLOyHd9BCpw34BLqWhA4XL
         4AfxwDFDvKPDrbAnUzBzbdpr67Rfah4zZpcEFIF5+I68PhpwUQ4ynpp9B2e02i2b/LFy
         ttKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q196Me2jAIDAnTBGiPK/Cxn0vMZ4fncAn8y7f8WRTyA=;
        b=ofX2CRVb1bpEIXBjAj0IFRvR8eOppBP4ON/47RApw7W1R6k7J7vH84WL/w5nE5PzRT
         9QAQiN77mZWTF39cDcKdnYNWd8jK8KunWgwBF/BdcR1OSOY+Bz34yJSnXL1/FBokKtLm
         Bz1wqwffq01p9YViq6WvPH+JACwou+vs/9fAGmKDvhXlQ/C186R52U4z7nhMY41Hgo1a
         /t+OZH0HNv5DtzJ+WGu9yGycdKLLXY+5m6OeNywTwWeC780OOSKEOfUQX5N5+Sca2/91
         /p8HtbV784ppfZM6nM3hH2yrG/7igD3zfi1LX2rNlBGiDAK9jwu5cJqoM4ssYbA6ZDyf
         ClaA==
X-Gm-Message-State: APjAAAXRSgrtqXMfok44euBVsU0V1I8D8VAgpR3NfmOTR3zEEa+z9Xcb
        cmNDBXyYYmXLqP8JXKOs1Zp44m5t+Ys9LfkN
X-Google-Smtp-Source: APXvYqzBV++HnsJqGVA3TkWLFAlh+OLmBH/rJ20EXP8gbe+qklBNVVp+IuIonV1uuXEIF8K1ppBAgAEKJRpWB8lr
X-Received: by 2002:aca:6c6:: with SMTP id 189mr17818209oig.167.1560339838959;
 Wed, 12 Jun 2019 04:43:58 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:24 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <4ed871e14cc265a519c6ba8660a1827844371791.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 07/15] fs, arm64: untag user pointers in copy_mount_options
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b26778bdc236..2e85712a19ed 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2993,7 +2993,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

