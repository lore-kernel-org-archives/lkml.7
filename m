Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A636C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9C021926
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mF8OyWPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbfGWSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:00:11 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:46966 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391407AbfGWR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:49 -0400
Received: by mail-qt1-f201.google.com with SMTP id k31so39190907qte.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IHvI+dZahLSsu4iMw8K110v852ALNB6rzz3nOC21G6Y=;
        b=mF8OyWPtPa27KaGkiSCnss6c8b+Y3jxSBp/iDga+MY7c9cKbX9nGHJwK2xlzSk0dvM
         46/b1IA06ke81wJzctvuMT0KvjYlT0hkwU/YFyMD3O3ZkppaxsJ6Qh96lV4fTWRGdGnB
         ViGf78WRhfhot+50mrRcEJP8ehDMTkQZYjXXgXUH6rOFs4T1KVaDzPVU6ktcbKr8zaRJ
         i3A/F+iOLc+6M6QJ7QteIj4THksgVZVnbx5C2fEtCjTVS1TOypq05pLtbtct8EtWO8pG
         Q61f0pOK8VaMaWwFM4favMJo4cb+2j4wmdeEX5CGZBr0ScIwqtpQSHdV7dFwlIUR9Dz4
         yLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IHvI+dZahLSsu4iMw8K110v852ALNB6rzz3nOC21G6Y=;
        b=Lh5SWlAserkRCVhAQi3NBwZuUfr0NzNVquN57PMy/cttiPWJYvg/X7rAuIbNUR7eKH
         l2mUjo2pwKXfxYlJ12nvmugOPM+uVnXpRWmkLVYj+6atl4DHkkPZnZ9m9z6x6sMD4Veo
         Hkfv0VNB+vhYm4QCVGM+sMYMd5NJPWrEEeb3KH8s2BOClqT6x9gjjNeR2ytyDqWwtKB6
         0Sa6XMvDHS1WpixCgJq75FQG8ulfJusTvdnk6cdCUBCpRcvSskxDqZf+XAAGj5mWbP3s
         JxHjjLXIBGK45Gz1ftHaJyl6YMxt3Wk3Ye/6KpoXD+nZWt7enJWPCXNfFUvtpLvx9+p8
         9fFA==
X-Gm-Message-State: APjAAAVszqLiNkyqrbJ2rqS/+I+69mBHpZab57gTm8UG7NN+rPymPcWg
        NRHPboxS/DsjtDbPKzlQARLEYMu8IYdb8NOs
X-Google-Smtp-Source: APXvYqzRyHp7WBTqlPGt29onShJXh3Cp/pE5/lej0P3nE1XW0gw1bUQxpG45N1NN4OdbAYc7oUndTzJUESDpF144
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr55634338qvv.43.1563904788555;
 Tue, 23 Jul 2019 10:59:48 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:50 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <4b993f33196b3566ac81285ff8453219e2079b45.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 13/15] tee/shm: untag user pointers in tee_shm_register
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

tee_shm_register()->optee_shm_unregister()->check_mem_type() uses provided
user pointers for vma lookups (via __check_mem_type()), which can only by
done with untagged pointers.

Untag user pointers in this function.

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2da026fd12c9..09ddcd06c715 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -254,6 +254,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm->teedev = teedev;
 	shm->ctx = ctx;
 	shm->id = -1;
+	addr = untagged_addr(addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
 	shm->size = length;
-- 
2.22.0.709.g102302147b-goog

