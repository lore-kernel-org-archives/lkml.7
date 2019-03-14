Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE83A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOH0f7Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfCNFHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:07:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45537 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfCNFHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:07:45 -0400
Received: by mail-io1-f66.google.com with SMTP id x9so3830622iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=qIfz2MYxtV3lIq0a4Yn0Ym2PlsacFa9dXHJGs5Q3BH0=;
        b=fOH0f7Am2JlStMBziup+mWPqCoZqF/8tqJLlebZGk5/xuMzgav2XTTrgtSyL+Ke5Ye
         eLjAse0D8KmgybmYPrCvn/rwkmuYstVAyiG6sWXcFQurKRdYnbqzjYs/D/cCdPZ8LQJ1
         RK6ADe1ZbOn/kwWGLrXHQ0zOsDICSywb/An9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=qIfz2MYxtV3lIq0a4Yn0Ym2PlsacFa9dXHJGs5Q3BH0=;
        b=UirI64MkEHYpScoGhM5EF0gGUHC8ooEq4uHTREZLeQbHSsFwaABVfO+OU98ftatmdV
         ZlYonC6IjBFxXdh5toX2iIext4AQv+PbdoEdB0IHY+VUIG1R/lduyCc71iar4NvMkKmV
         fjkSj1gzbRFLgnSlsnWB24TMSRmSBzvJBYFizlqbDkDmfoMcQy4yYHUgW9y9LlKsOYw4
         7V3aHa7z8tcHwy5xSJVzkQavH+RQCiu9x8b9HltH8CfCrRHau/kGUY0Jn3pivZa44IWz
         PQJmFdpY7MsD5t762Z0hGKtGAjT3aTaXEEqW+4rV+jmuSbQllo3oYCYf+SMG0ZkX0Hl4
         GF0w==
X-Gm-Message-State: APjAAAU+lAlfO6q6LZjX6GvVGE/AdDQ2aYQ6fIX2JXFEKv0/TA6qzzJi
        VnVxjfMfSMfTXjJ5Ve/8kPCgERwYDZLlz7D2EGDglA==
X-Google-Smtp-Source: APXvYqw7vBN2co7SWgIQmy5sV69ceZMt84tL3wCUoaBo1vYn5R3wz9eDVC15I7wG1GGhqHNPsLH7ePV5gPxAoG1IR9M=
X-Received: by 2002:a5d:8b42:: with SMTP id c2mr8154480iot.192.1552540064355;
 Wed, 13 Mar 2019 22:07:44 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Mar 2019 22:07:43 -0700
From:   Gwendal Grignou <gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
References: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
MIME-Version: 1.0
Date:   Wed, 13 Mar 2019 22:07:43 -0700
Message-ID: <CAPUE2uushZ3Zc6mt01q3OkSx63YmQLq7SKqAktdZVnrb9bVnHA@mail.gmail.com>
Subject: Re: [PATCH] loop: drop caches if offset or block_size are changed
To:     axboe@kernel.dk
Cc:     jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

We have observed an issue in production with this patch.
(ihttps://bugs.chromium.org/p/chromium/issues/detail?id=938958#c38)
If we mount -o loop,offset=... $file, mount will issue 2 ioctl back to back:
- LOOP_SET_FD
- LOOP_SET_STATUS64 with offset change.

Looking at kill_bdev, it calls truncate_inode_pages(). From its
comment, mapping->nrpages can still be non-zero:
"""
 * Note: When this function returns, there can be a page in the process of
 * deletion (inside __delete_from_page_cache()) in the specified range.  Thus
 * mapping->nrpages can be non-zero when this function returns even after
 * truncation of the whole mapping.
"""
It is therefore possible to have truncated all the pages, but nr_page
still be !0.
We would fail the mount with -EAGAIN while it was perfectly valid.

Is the test for nrpages really necessary in the second part of the patch?

Gwendal.
