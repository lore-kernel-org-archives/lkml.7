Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFC1C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A122C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YF/qqa7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390564AbfFJPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:35:54 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37771 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390415AbfFJPfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:35:54 -0400
Received: by mail-ua1-f68.google.com with SMTP id z13so2929327uaa.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uh6CdMohZorEgVN9vXbSY/UeOknex/E8iFCG0M5wD8=;
        b=YF/qqa7RPVilOMXhPggTQ2tpP/u5TBkNMkf0tWkNDuY71XiWzKl9NLQvhH3Yc9YH26
         VUKd1InO3NfUJHMKYkTx5o+qwWpdkk/hXfKrXve3eDM/0L4UKXbC8gw8CgPDQPZjt+I5
         eSAHC5TD/9yiJ0Zg2UzHjyeSga9rve4ZZNGF8RnOjZBy9eTLyiIV4AEeNtXMcO4zrvIy
         vYIf0XEmyd6tEuSgEH8yuYT2nTVOCICSlZXbE2Nhf615F+EqfYJFAWd1ZWD1Q62pqVdO
         Q4jI4iwBEBNfvr2+p2FesRQtB57J+Jt/Y/O2qK4THXTbXH5xok4FtX3G7a81IggvA9ZG
         QGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uh6CdMohZorEgVN9vXbSY/UeOknex/E8iFCG0M5wD8=;
        b=rHurR7rLFr/4Ewb+n+pNq1tTkEzjhGaSg7GSa9YwVdH317J99Fqgn3rPHarcNWPAyH
         wePaKWIiqQWXGJ5h7Z09+2z9i01RrB8oa0qKW7vUvw93i/DSljnFlPqmQWbIH6IJl1mP
         bRH7FP/NftFUPmmG6yuyh1tD74kyakztcNdOD51b2kGbevrDTVyRP8MTC+l8CCEAsI/y
         WQxLMoyrR9BM2vEwZLNTDZpFyYkhbmZWvOJLWUDlbIGYq7Cocnb8phRsg7l3niiSTnEJ
         49qjOst5OmMhJ3N9dUPvGHAFk9DSAfHGbDzpa8JXne9k2psYdCBiT7Nt9MvNrsjtcvR2
         36+w==
X-Gm-Message-State: APjAAAVt4cuZztDIqWP0wyQF10e74YOp7geSzgcPy1GDHCxPh542AQx4
        hZKJ/tGy3tLsdutOG2C+7xhZnQ==
X-Google-Smtp-Source: APXvYqyW9RNpBmY0FT2Gai4VoQlPQfeHqIXLI3ebTPQFn1eeym5qId9EdeBiL1wmZFiH0a1CNyFiNw==
X-Received: by 2002:ab0:6896:: with SMTP id t22mr25091588uar.127.1560180953301;
        Mon, 10 Jun 2019 08:35:53 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z21sm2809391vsk.30.2019.06.10.08.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 08:35:52 -0700 (PDT)
Message-ID: <1560180947.6132.67.camel@lca.pw>
Subject: Re: [PATCH] locking/lockdep: Fix lock IRQ usage initialization bug
From:   Qian Cai <cai@lca.pw>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 10 Jun 2019 11:35:47 -0400
In-Reply-To: <20190610055258.6424-1-duyuyang@gmail.com>
References: <20190610055258.6424-1-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-10 at 13:52 +0800, Yuyang Du wrote:
> The commit:
> 
>   091806515124b20 ("locking/lockdep: Consolidate lock usage bit
> initialization")
> 
> misses marking LOCK_USED flag at IRQ usage initialization when
> CONFIG_TRACE_IRQFLAGS
> or CONFIG_PROVE_LOCKING is not defined. Fix it.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>

It works fine.
