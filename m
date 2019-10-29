Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B9CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85986214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxuiK8t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfJ2EKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:10:20 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46323 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2EKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:10:20 -0400
Received: by mail-pg1-f202.google.com with SMTP id 195so10103830pgc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=czBj5iiyb2avkPaBBfY6a4eoR3k0n1KTRJeBk9+xohE=;
        b=gxuiK8t7b1l9J+ede3Wdzp6UYjkJG581WVbXyHzn7x7V4xDTN3fzvf/yQVizPEVDom
         AOLhNYP7ghbMWKIAAUjYP606jeGf4vR2rnVuFbi45pomkT0tBHvhqGdJVb2YQqFufo/+
         3pgD/WHwbjQ2i9Q1+Lj01BhwpBCvJGqpTuTO4GR46BSbaoUkBVsAqMEYYJBzSDKxqSsH
         n7o3b992almzi3sbMQsIeoaxBy8l3s4EcwmJSMHCdzDVkSAlfHYM5ksGyWVP9G2znN2J
         p1La4c6RwgN9dzC3sag0z+CUnMtJdSDXDyjLJ7jx39xfGXagJM2FfczBEt53wo0xFxqz
         eBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=czBj5iiyb2avkPaBBfY6a4eoR3k0n1KTRJeBk9+xohE=;
        b=VNNN7V3/luXVAgjR7/sJm4D2T5/zwg4Th6E/ypq/f57APtq3xUkaQj9SiLFmIEGJrX
         CsfoCoxhQs5xBYq+P5+l/62KYtJQc7l3Zlve/hopNEg+k3YVNC+p8JS1JYEusen+KCT0
         FUMrBzt1p5CDr6SIs396RWDIE8neLwjdyHmEr8zGrqvPPjTQ22lANP10MLyr7qo2twXy
         cTCRK2XmDrNfgIHsRK5vRJR0gmUIPs5GP0JAlxgwuhGHeY/kwxDvlp5gIs1pqntpbdx/
         UaTTxbxT9PSCh/7aLy2q+PY5uMaOuwliV9bSGzA2BPzfzE8VFdnEcGc6Vv8SQSSByi7i
         jOwA==
X-Gm-Message-State: APjAAAWTs7HUhfgXX/t/HE8r2z9ttO/CjJxUMyQVvPEyHDAz3tFE1cWw
        2VF2jwu1GLG6a1sWOitBfgpXq458wbw=
X-Google-Smtp-Source: APXvYqwqXTMFNoIpwHeXuo9on4sLaxON2YuoG2Ily/6j/rQRUpKUszZ8hDawtzsD1lR9Jp/zlgoqV95Ty30=
X-Received: by 2002:a63:da04:: with SMTP id c4mr24123103pgh.172.1572322219069;
 Mon, 28 Oct 2019 21:10:19 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:10:13 +0900
In-Reply-To: <20191018010846.186484-1-pliard@google.com>
Message-Id: <20191029041013.175636-1-pliard@google.com>
Mime-Version: 1.0
References: <20191018010846.186484-1-pliard@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        pliard@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't see why you still need buffer_heads at all.  Basically if
> > you replace each of your allocated buffer heads with a simple page
> > allocation the code will be much simpler (this version adds more
> > than 100 lines of code!) and probaby still a bit faster as you
> > don't need the squashfs_bio_request allocation either.
>
> Thanks Christoph for taking a look. I like the idea of simplifying
> this if possible. I think I understand your suggestion in principle
> but I'm not seeing a way to apply it here. Would it be possible for
> you to be a little more specific? Let me try to explain this below.
> 
> My admittedly limited understanding is that using BIO indirectly
> requires buffer_head or an alternative including some
> synchronization mechanism at least.
> It's true that the bio_{alloc,add_page,submit}() functions don't
> require passing a buffer_head. However because bio_submit() is
> asynchronous AFAICT the client needs to use a synchronization
> mechanism to wait for and notify the completion of the request which
> buffer heads provide. This is achieved respectively by
> wait_on_buffer() and {set,clear}_buffer_uptodate().
> 
> Another dependency on buffer heads is the fact that
> squashfs_read_data() calls into other squashfs functions operating
> on buffer heads outside this file. For example squashfs_decompress()
> operates on a buffer_head array.
> 
> Given that bio_submit() is asynchronous I'm also not seeing how the
> squashfs_bio_request allocation can be removed? There can be
> multiple BIO requests in flight each needing to carry some context
> used on completion of the request.

Christoph, do you still think this could be simplified as you
suggested?
