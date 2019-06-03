Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12294C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD40127552
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URpy1zkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbfFCQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:55:52 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:38893 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfFCQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:50 -0400
Received: by mail-ot1-f73.google.com with SMTP id x23so9223999otp.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZBmZ0AJkpI6Le2BTudY9LfSDHiJInTNRilsGVrjkAC4=;
        b=URpy1zkCsiHDZT4QO7sl51daLEh3EGQ+QBRWhBXCE891aX0bBPmoAKSOA31jx1eR/L
         lVC6wRB0VJkhYxePvRUt+LMH36W5FFHQFgoa3GPev4OVYVi3rHZ7c3DIf31iffj+WRWq
         O/UwDncv5Fut/rLbuSahvZjC3AOwYT8i5PrP8W6A3ApbgszBZnpxe6Ijm9sVziVKebM1
         iMXDrWTNGRgrpGSzVkD4uXSftJythbi88SDUBif5NioLplX3HzpUrRyFyzSWH4dNAKRr
         WMIQ2F6id96lYcVo97o9s2zuDCTDHymNEv75yNnQamJ6cKIMShowZNQgGMTsd3D7DLBr
         FGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZBmZ0AJkpI6Le2BTudY9LfSDHiJInTNRilsGVrjkAC4=;
        b=CG2SSh0rNgFnkszKdbY/Gdv3en0dpl8hzLzkvkhS1vPeJaXutC5imB+dvfcKrz0nqL
         CxopZH6bFxHpJj89X2dJrnzaqu1a/7lQHs0K+BVdE8oKkC1+PW5J/XjZqDP8kntQqLNj
         cul7lZMRYhi9pPLuTyavgodE6IIs8gS37g9B6PR5oe/CEUSxZhK/cFfzbMMvHWn2hl5L
         ZZFKQ41x5/oY960fWXI8aH0Krf01afRev+z5KejwPwL/nNV0KVs4zFvtcAVK8bYtPJp5
         pfyyJEY0XeCNLjgg4aCLfzY6LfU62YR+mZYNHE3plt/x9PACkBFcOlI7hNstg3R8bJ7D
         NABA==
X-Gm-Message-State: APjAAAVAVINIvqdYEB0vsrSguDSoZpRcKrLLpi7irG4LJ6wf9KwUFcHv
        5fLItUTxjsX8FmCMx9PE14YmzOLbnwk167xg
X-Google-Smtp-Source: APXvYqy+jD2zPLosNFGdbJ9ezUNMRGpcmbF5VcOnmGNGlPs/hbYWUHg1PJfAxR5NSiop2ABNMtv5Bkf3tC6COzAd
X-Received: by 2002:aca:4c3:: with SMTP id 186mr1626180oie.12.1559580949610;
 Mon, 03 Jun 2019 09:55:49 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:10 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 08/16] fs, arm64: untag user pointers in copy_mount_options
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
2.22.0.rc1.311.g5d7573a151-goog

