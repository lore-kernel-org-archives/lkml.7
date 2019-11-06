Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D569C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457B2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBcR4sd/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfKFStg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:49:36 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45528 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKFStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:49:36 -0500
Received: by mail-pl1-f201.google.com with SMTP id f7so5213130plj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iuhKlytJBZM6z4JfLv4nGpswwtwyGQLqGn2PJIaoWCM=;
        b=hBcR4sd/6XYZVq594jdQ+i79/9ZXlBpq2iJFRWLOmD3spNkjRNe+mVflTyHP8Q9dE+
         u3MGAM0kFdZVliTFaJ6Qk9/890kOPzZbf2e/gSGu/ItaVXE1P1pokh38IrmGSc4mGHwK
         hh91R71Am9AIlz9pdsTW5DBI3EBeUPP2sdwOUIXZiWEcOwWd16+5p8KPTuoaCPmiyaS8
         MMTLvoKIqB19NjchLW6yehriOwyfxo0Dw61hP/zAK254hzGmC3yxOpx2QxmKpfYGIehp
         Y3fkduB2rrSbrS0JadmAg1FM16FV5yzhUozU8h0fgl19HVmEXr8Exms7TV/i5xKXmiJh
         ZXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iuhKlytJBZM6z4JfLv4nGpswwtwyGQLqGn2PJIaoWCM=;
        b=oWBwycOZySr+XiLnGGzm0vEuTXDI33D9bfhLNdZGBW0KlnngCQTyincuzKVvkz0tac
         LRA6qFrNpk1jMFNc62sOfusY0cCJd4luphNZL5zSYq3IAwHOTsxlG/wTRbiDU9P0VMOr
         bQItYXFN2V2aFdnglxctJHio2ZIHk0TsOdIa3expaL26iNria48AXbznm8dU4nWnH4BW
         +VszO+32mFMzqYLh/l1JT7htmWP6e/gm1yhV1meDW0PUw2iSrIvewEnVTtPStkya9A4q
         xLJWQwuxEySTuykv24avbC8LT0lAJA0wn7SS6ZbHhM0FasvdQ4wJzmroYyStZ/cE78FA
         D59Q==
X-Gm-Message-State: APjAAAUv7tYFor+OPyBy1este53dj1rhT9i+K2TU0IOX/zb4XS5+Fu3r
        WTTkbvzbHmkv1MgY41aj4SdOyhkTlQ==
X-Google-Smtp-Source: APXvYqxwRyZ8JO9BSn9Wbg9rolgzDQlfODKPEiZ6igpaIr0m8nKCMYQGHG735BO75tms3/j1xkDgEPQZ94I=
X-Received: by 2002:a63:1001:: with SMTP id f1mr4574203pgl.373.1573066175512;
 Wed, 06 Nov 2019 10:49:35 -0800 (PST)
Date:   Wed,  6 Nov 2019 10:49:31 -0800
In-Reply-To: <20191106115651.113943-1-weiyongjun1@huawei.com>
Message-Id: <20191106184931.200312-1-yabinc@google.com>
Mime-Version: 1.0
References: <20191106115651.113943-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH -next] coresight: replicator: Fix missing spin_lock_init()
From:   Yabin Cui <yabinc@google.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the fix! I should have tested with CONFIG_DEBUG_SPINLOCK.

Tested-by: Yabin Cui <yabinc@google.com>
