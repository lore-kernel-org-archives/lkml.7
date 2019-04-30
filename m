Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB25C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJdQ1UGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfD3N1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:27:09 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36496 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfD3NZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:46 -0400
Received: by mail-qk1-f201.google.com with SMTP id a12so11848105qkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XhTfun6kQ0RRzRGxeYV1Lxl9M9fvGqRUvmzO5QW1/Iw=;
        b=wJdQ1UGK5yN+4uNr4h/B5QAZg4CL5PwyVx/Pw0wXlRL/1oGZsU8xxjXpZhWnko4SRI
         fd58gicIFCILzVPy4t7gpYBYkZYkBR3FmblDk49rQtqjc+3RWgZP2PESfhPKYuSabBw/
         B0hXw+/teu1vbGfMkq/9KC8ilccnVzEvxDboYdIBbHp/DJQFCI0D5tDe+o/VISE54DyV
         St7L+ZfiWURBvKb49SaxC44tIWiHtqDmkV/TM32oplri8v6dnEdHN+6rXyhwe32Swezt
         x0OHZZDCsWZFgoiC74TFCi6OtAop9i/h8/+cUKSH3r+foqub7XosNX+XNvDEf+4uDkZz
         /4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XhTfun6kQ0RRzRGxeYV1Lxl9M9fvGqRUvmzO5QW1/Iw=;
        b=sy9QUkLRnrpK3fFn2mz7fmXz3MHgg0coxxhg7+D3RuZkS9sLCDE0XCilnhRWmh9nQK
         3NJl6HVj+CMkSoW1KMNCGX1I8sTWE0x/RQnrGtPWdr0Xoz0o0El+/cOY9U7vRQbDP415
         yHgru9B5SrQ9qTQ5GoxXcwDGrFiMD73cks0qFwptlylsDAVJUVRHXPZZj0clkz1pZJWU
         KLr4yBIusiLa8lQRP+ZSl+GK5C+dGfX253U0XVUAxk0VOYvdnXANiGgY+wThhocyPlzO
         dMeTfgQv8sIHclZUMJUWEa4nZnoDZbWA8Jykafty1CDF4ysk8x9A7OT4ZtZDH2+b2mqI
         b13Q==
X-Gm-Message-State: APjAAAWCGoWluAVzXZ+IjOrrLDSG8/WiIH0bNXsEyw3typWcTNYe9MRG
        +NvAR0IB3L1w+cczxx8sQvf6CF7XJz9Omett
X-Google-Smtp-Source: APXvYqznoxmsWRf0TRsMetoUzYzE4dAnT0nzUuom4UB8P1UAcmj3+/tm6hiTUWLYkHc/SM6nPM/1vvtkZ4BWAaOU
X-Received: by 2002:a37:b683:: with SMTP id g125mr147309qkf.249.1556630745179;
 Tue, 30 Apr 2019 06:25:45 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:05 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <f7a89f69f95e471f161e4000d0e13f57364bc90d.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 09/17] fs, arm64: untag user pointers in copy_mount_options
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
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c9cab307fa77..c27e5713bf04 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2825,7 +2825,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.21.0.593.g511ec345e18-goog

