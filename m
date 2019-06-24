Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6693AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C81A208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EdyxEJFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbfFXOd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:33:29 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:39939 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfFXOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:23 -0400
Received: by mail-vk1-f201.google.com with SMTP id p193so6453821vkd.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6wOlIN9RCqtC4EMjbsO9NIyMZhz6XW377zGYJAhhjSw=;
        b=EdyxEJFnWG9rQS7GXNgeJyNTxEu5LtqPTYYbN/QLe+5zlbDexboGyDqBC815Hrokjj
         qfAzqSeaTKPFvVv9WWYIndqnAPiRljjB3TIDjGP/0IMssQbdVP4BzrpsfzCXDKI9BDHt
         WeSswvJDxczfbCTt3IQqYPH1jX0VOQ5O+GZOEn825FLst0HqKs8RjnFS0DrDqqOlKlcm
         +N5mzxkUilj5uw0wDqYjDhK1/db8t8dLQzbwnNuEhal4y8tjJfxP9svgAu0LB4ORTyVD
         OZMU426HgS0vYo8hjqCwVk8ERda/jHZQ5JXLr2v38JKqFFajbtzb+/rl5BB+KXJN5rjD
         80IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6wOlIN9RCqtC4EMjbsO9NIyMZhz6XW377zGYJAhhjSw=;
        b=fwVpmuiVssh6eRjNzcPybaRSo5G8K3v3TMYu0MqYd9/R4CdeXGp4sL82UiQUOoMT6J
         Y/PVSvwmvOFO42ItF2+uau28NQL314I0jHdbkbG865QPMXhwP9dV/O+lbU0dpLihK3o+
         TgBRhh9aCVLVEYQ222ecitgCXRjQtKD0d0ugVY0+qVvDA7PgKgHbEXJqwtJFDAzpGwwX
         RQTXHreg8wFn6SZB4ACV6jHKs6amN3kZJ5TX3PRMPH9EAyYk8EM++WqiXIc0wGpwjBoK
         V0thL2ooycRxPpOk14A7MSZ61Wr6fWlr6fftuFEeKiD6h1X91VDvBmDGzz4qh7/4XrsD
         qxHQ==
X-Gm-Message-State: APjAAAXvOY5haUNqcXmEjqjYfUvgR4unuyxsLX94uA5H6Hk6iT7G2s3k
        KL6gmHcFrUAUKChBUC5GYl8S00djt1fDB0pN
X-Google-Smtp-Source: APXvYqypfx2HThdGezp/oUedjYKv44Fb8n5lNK45oyS/vOtxc58Rwt4c9Y+yK17e0xs6J7fV+AYN9l/kG2KmENab
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr54849002uae.10.1561386803022;
 Mon, 24 Jun 2019 07:33:23 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:51 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <cf7bc20a86d45f690c211ebf284e9ecdaf6d4869.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 06/15] mm: untag user pointers in get_vaddr_frames
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

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

get_vaddr_frames uses provided user pointers for vma lookups, which can
only by done with untagged pointers. Instead of locating and changing
all callers of this function, perform untagging in it.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/frame_vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index c64dca6e27c2..c431ca81dad5 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -46,6 +46,8 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 
+	start = untagged_addr(start);
+
 	down_read(&mm->mmap_sem);
 	locked = 1;
 	vma = find_vma_intersection(mm, start, start + 1);
-- 
2.22.0.410.gd8fdbe21b5-goog

