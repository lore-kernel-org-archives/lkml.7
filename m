Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7769C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C16274E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyCC5R6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfFCQ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:56:02 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:35335 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbfFCQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:00 -0400
Received: by mail-ot1-f74.google.com with SMTP id 71so7252528oti.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J9pRn7M3NANi3nsm6t0U9rkGUXnmKvJ1SqswIr7oBNs=;
        b=uyCC5R6PocJkucx1jg/Ao87LrvuuxuIBF6MJgtDNhRfSLGfd93TT+616KNBdU1kmQ0
         AgUDtRxuemeCNPWARnIzmKXOHJHBg+nlDVnGcRWa1zFo9sO/boLQmVSMKTOceUEyeuWg
         mQemhEJH0YpA4zNTW5udZ12GKI5bnl80kC7VZlC60TPzrs4d4KpnJ4TkMFczujBnqjPI
         s1PIMD6Bv9mJiTZ+Ezsulw1mODRNfzAxvwpKccvPVlqp//q9tEM3ODpqGbBulPCkTHr1
         l2f+hVLNHUHhV92giHpjab5jQ7AF27XvPV9Duk2JrwjNtkOIOBAX18N6EpfDx4AK8S9m
         dKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J9pRn7M3NANi3nsm6t0U9rkGUXnmKvJ1SqswIr7oBNs=;
        b=k0isUDY8oAX0t431zFxPTlKh9uKbaHciTioNbW6XQPOc8fvy3NqgwI1IRGu7yeXIiU
         2zWiqEM2Qiu3LGODEFxQ6PjxZw96PS/lJUKt/N0AcgrroZEq2BW2ncP/3Nr25HgavEin
         MQzfuQbR+5oCDXy/6za/ghYz07qIgQL6sBXnMPHDFrp4c/nxQX40uGNH2BWeKxYY87uW
         OctitYCwt6oZYhxC2UvALQAAoR2jgdk81OfXm8d6QuwJWKHLgOoYBp80bop/xRrMJUep
         QRTGergT9JkHpLtRLynjnq7oc6hHu3L140Ttr7+R1A8LGhunbZpKBcTShIwnlD/LjPeV
         C9/g==
X-Gm-Message-State: APjAAAUo6Nj1iy+leXsS+RBGAyRAt6yRnMRMdy118CeTZVwE4oZqQqg6
        uCXPJxKitpPD/utSFfHB2IT6l81QR+6Fefqa
X-Google-Smtp-Source: APXvYqxkxhXEjx8ehUwO+4U+/PSwW95cfpd51BrO1CGROW1JbuARWLoPLbgzmMBGokFlEw6Kw7ByzaocLX6whXWc
X-Received: by 2002:aca:4341:: with SMTP id q62mr1665112oia.140.1559580959661;
 Mon, 03 Jun 2019 09:55:59 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:13 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <f293884fad5f741b9202a9db6006f4bfdaedc2bd.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 11/16] drm/radeon, arm64: untag user pointers in radeon_gem_userptr_ioctl
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
        Andrey Konovalov <andreyknvl@google.com>, Kuehling@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

In radeon_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)
userspace pointer. The untagged address should be used so that MMU
notifiers for the untagged address get correctly matched up with the right
BO. This funcation also calls radeon_ttm_tt_pin_userptr(), which uses
provided user pointers for vma lookups, which can only by done with
untagged pointers.

This patch untags user pointers in radeon_gem_userptr_ioctl().

Suggested-by: Kuehling, Felix <Felix.Kuehling@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 44617dec8183..90eb78fb5eb2 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -291,6 +291,8 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
+	args->addr = untagged_addr(args->addr);
+
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

