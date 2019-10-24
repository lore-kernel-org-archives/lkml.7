Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBAFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5A12084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 01:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVTdJblk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbfJXBYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 21:24:00 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:57235 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390315AbfJXBYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:24:00 -0400
Received: by mail-pf1-f201.google.com with SMTP id b17so17591091pfo.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 18:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Q/IgTcyWpllq9cHFnznuYs6JbwLGBHOeL0Smj+J7ca0=;
        b=GVTdJblkvvjClYZLs2bPvvMBuk5g/tKBRxCD5d8zrFawK/dUnVTzn3mLelDR1LljIf
         WaPj34fR/p/NSXU5aWa6UCp4wqu1QC+CpeOwH5SunJ8fTwmdg4R0p3g1LrKiwjCP85vw
         aA3z1MQcgTWZ75eQ6nUP5jpZTEVkC9ZoxPk1/ofFb3267KglmdU5Xk6/2/B3P3NZN79G
         YYVZpv2wYExaSdQPW1qKK7+TqSnD1mNb+T6zS2MZ+027vXm5q409SxCtaLizMDnXvyLp
         gpcCvMtjFDWZKF9wDsLW1ghOzLE4/kWrTLT9aTpgJ6Q8+t3t39xEaT/vGRsb1pmn41U5
         l+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Q/IgTcyWpllq9cHFnznuYs6JbwLGBHOeL0Smj+J7ca0=;
        b=mYcCpZMT1Beu/2GqE4/9Ko/kN1/W6xaiEQDA3J2d9MGa+oAv2B1uPlLH5XScT3M/kR
         40qt22ul24Xg2baDzprVeCBB+IiCi64ubPRefv/D8lAJvbR6tGUxt6es+PZ5ftCWOx6T
         Hl1DkmVNCLuwdAsKNmbiZaH7sGqnG0Wk72PuGaAGfwa3v9FulVOK6RA5JlK4ogFZxUxV
         o6CDv+zD6psk6sjurK8/Z+zjyOr9Ik5VX3a8iX+mU8PmLxhhSnkE93zJ9UMZ/dOOuaE3
         mkQx2ycRpMBHlO277ftC3wq0atutlWs1il5UBYaxOGPCiqzNB80OsPdLpRQXpP6tuiG3
         7eaQ==
X-Gm-Message-State: APjAAAW1eM+E0JL6YqGGAiih7ttWtII2ZpJGgHk8KdLg7YTE3ik1Ec2W
        Ru5V6jYzCYmBijtA/6SdtQ4m5BPuE5o=
X-Google-Smtp-Source: APXvYqwxTYWRsvyLKEC+CppJbx1Z24G5t2QVXsJ5xsbKJwDJeCg0MJIZxzpQyX/Vs6LO+ZNkmUnI1gw1ZkM=
X-Received: by 2002:a63:e055:: with SMTP id n21mr13369058pgj.411.1571880239317;
 Wed, 23 Oct 2019 18:23:59 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:23:54 +0900
In-Reply-To: <20191018010846.186484-1-pliard@google.com>
Message-Id: <20191024012354.105261-1-pliard@google.com>
Mime-Version: 1.0
References: <20191018010846.186484-1-pliard@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
From:   Philippe Liard <pliard@google.com>
To:     phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        pliard@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Cristoph for taking a look. I like the idea of simplifying this if
possible. I think I understand your suggestion in principle but I'm not
seeing a way to apply it here. Would it be possible for you to be a little
more specific? Let me try to explain this below.

My admittedly=C2=A0limited understanding is that using BIO indirectly requi=
res
buffer_head or an alternative including some synchronization mechanism at
least.
It's true that the bio_{alloc,add_page,submit}() functions don't require
passing a buffer_head. However because bio_submit() is asynchronous AFAICT
the client needs to use a synchronization mechanism to wait for and notify
the completion of the request which buffer heads provide. This is achieved
respectively by wait_on_buffer() and {set,clear}_buffer_uptodate().

Another dependency on buffer heads is the fact that squashfs_read_data()
calls into other squashfs functions operating on buffer heads outside this
file. For example squashfs_decompress() operates on a buffer_head array.

Given that bio_submit() is asynchronous I'm also not seeing how the
squashfs_bio_request allocation can be removed? There can be multiple BIO
requests in flight each needing to carry some context used on completion
of the request.
