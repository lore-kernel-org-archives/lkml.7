Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB1EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68DB92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSiPsDRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfD3N1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:27:33 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42310 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfD3NZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:40 -0400
Received: by mail-qt1-f201.google.com with SMTP id c44so13462871qtb.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=buRPOjJBA3ZIe0xT2AqduI9dnmEg9opX2ORFfRDPnW0=;
        b=MSiPsDRD20G5RApt1tKO2qR1lu+49IUxbNva1JnuQQuFWBLmYjGsyYMIbTfczh9PgZ
         LZDjXLLUSTuHLQNcWT+JZ9uqhm42MotSkIywGhSEtO5Qo/efiUjRdnETJ9HiPnIEMC0G
         Psfny8eMA3Hhr5M3y/dGxBagnarVCzNzCOPBE7unSjVZRyN7RZGPxN+EiQrIg6TYKayd
         TbH8puePOyzHgUDHu0r16X0QIZiy8sIilI5NkVuEFwagLhwm1Doy6sj5Nc20vSi1QEC6
         U4ZuKp24KxWFzfXdfPQJckkIwH9zeR4BqyMjbNu7gnM8XYqQKJF/hqcaAUToZRnS5F/8
         +rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=buRPOjJBA3ZIe0xT2AqduI9dnmEg9opX2ORFfRDPnW0=;
        b=RBEr/+VpXBiCJ8bWvy66i7rg4UMdPmvGVDclj9olkMcVt/OENCG9ZSZTw2PBuNLjnW
         xmu4XR1udCpaBXmurh83eOW6LNJWNt/la041KXX7r2W/R95ndaugii7nmidkLFRsvXdy
         jRhXDtkeuobokHeder2RxXV+VzfGCxMxtuOE9/eg0cF2/Y1W+JUHgfcZv70nrpP5N8iS
         0Xsnoc5Cbnebq0ppaFDfosACazX9il5Zs0/Lj9dmEy221uMAJFFBYk2st+zEdmBhLN5m
         1LAOVkx5U8BumMcFmabQXm9caA0DorGvRdq3+9lRuyU9UCzpTGUgxYRVxJH6TYqRXnRN
         +yKQ==
X-Gm-Message-State: APjAAAX5VMLBbZrCZ9jwyljq8lelzmc5fci1DUY3ANxqnbfJO/QB+7hx
        fVztMl2t6rJEXsZI48XeydT+MvU7LRtWItJt
X-Google-Smtp-Source: APXvYqzAjOcf9MQ3Z/Pp48cxI+z95y8oMsVd6n1et+BqzlTkjxro8PcOOzrVkSjDVN6zaY8gkVAdj4JwROetfHnZ
X-Received: by 2002:a37:78f:: with SMTP id 137mr13240464qkh.66.1556630738975;
 Tue, 30 Apr 2019 06:25:38 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:03 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <373d33e4cb0087da32ad019fd212414292ce04c8.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 07/17] mm, arm64: untag user pointers in mm/gup.c
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

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle this case.

Add untagging to gup.c functions that use user addresses for vma lookups.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index 91819b8ad9cc..2f477a0a7180 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -696,6 +696,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -858,6 +860,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.21.0.593.g511ec345e18-goog

