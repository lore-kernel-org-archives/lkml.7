Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82022C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593AE206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="kKgwjlUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKOKcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:32:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33991 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKOKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:32:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id y186so7661097lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 02:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LEboKIm4XtYUXiW1Vq6xcXCe3zY0ylQ/Sqx7enK/HH0=;
        b=kKgwjlUa0n1nWif0RELshhBBhRTkumivvKv5zGSPuMJXP0PGwQRe+V0QxOeL2/rbqP
         /rUoBJlJLRf0/ER76UH6Ehiw1Gaek8IVIbWXvLqDdX+lcmylJVdZygdlx8yCdCc6K0Zd
         WBS3NeSIrhK9DlrnmvfQ3Dw9ScQOwqvQ83frLLb16yhIfadkeqiGI6+WqrrbGmTmS8IR
         wWBvYFCq9C0FN/gD8hPEaU6S6rzKLITZ4jI55LLNe4kG65y7FNZvlbZ7U18SGTE08Qb8
         lae3dgXXh+z/VhLvDs6Mdhdp4q1wVyMdp8NPw42wuOWmP/AF+481TzuY4oeWIqnf9Qz/
         oFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=LEboKIm4XtYUXiW1Vq6xcXCe3zY0ylQ/Sqx7enK/HH0=;
        b=Yr05rts9H7IfddUs+EJuXjSJamCtpvl2A/1Hoziki6v99L4foKNxKFT79k9dGi4Tdf
         lVgWsGTYlYbxGigj3WbfZMd/5g6PLu2iWQjUduaPxDpvHnF9GBXnlCRSniM6KG9Y8QKO
         q+wuMSexTxLPzg+ayycplYtSQdQnwqCRblA5/XJH35GLk1SaumNb36l975A1V1hkPDeF
         wBGJkswhrE1r620svB1KwCbdOTRMvngf7EooBsUQ1JWbXUC5tFblAayXlJZBsvLrWlVh
         q6+kVydC1mTjlxZnS87HH3z9T/unTJy5wTlbAAvdrqm8PUWESaszKSHNvj0HiSkEkoAG
         DArg==
X-Gm-Message-State: APjAAAXClJDJblwHBFeju+/7/wIQ5YtFy4O/ZEjdNS/kfJTsTWtts12i
        Cquu0PyOsrpYKGJwyq15d8abNQ==
X-Google-Smtp-Source: APXvYqx4AjGfhwhLgmZVL/5isI0vcHIA+bgEWl38mBG43hAXzCmNi0w9qQFhMAYDmeYTWjP1IEdK3g==
X-Received: by 2002:a19:790c:: with SMTP id u12mr11108700lfc.183.1573813953142;
        Fri, 15 Nov 2019 02:32:33 -0800 (PST)
Received: from GL-434 ([109.204.235.119])
        by smtp.gmail.com with ESMTPSA id t12sm4030431lfc.73.2019.11.15.02.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Nov 2019 02:32:32 -0800 (PST)
From:   jouni.hogander@unikie.com (Jouni =?utf-8?Q?H=C3=B6gander?=)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] drivers/base: Fix memory leak in error paths
References: <20191114121840.5585-1-jouni.hogander@unikie.com>
        <20191115032603.GG793701@kroah.com> <878soha7tc.fsf@unikie.com>
        <20191115082022.GB55909@kroah.com> <8736epa202.fsf@unikie.com>
        <20191115101902.GB337025@kroah.com>
Date:   Fri, 15 Nov 2019 12:32:31 +0200
In-Reply-To: <20191115101902.GB337025@kroah.com> (Greg Kroah-Hartman's message
        of "Fri, 15 Nov 2019 18:19:02 +0800")
Message-ID: <87y2wh8m68.fsf@unikie.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>>=20
>> Ok, did some more debugging on
>> this. net/core/net-sysfs.c:netdev_register_kobject is doing
>> device_initialize(dev). This is in
>> drivers/base/core.c:device_initialize:
>>=20
>>  * NOTE: Use put_device() to give up your reference instead of freeing
>>  * @dev directly once you have called this function.
>>=20
>> My understanding is that remaining reference on error path is taken by
>> device_initialize and as instructed in the note above it should be given
>> up using put_device?
>
> Yes, that is correct.
>
>> Tested this and it's fixing the memory leak I found in my Syzkaller
>> exercise. Addition to that it seems to be fixing also this one:
>>=20
>> https://syzkaller.appspot.com/bug?id=3Df5f4af9fb9ffb3112ad6e30f717f769de=
cdccdfc
>
> Great!  Care to submit a patch for this?

I will submit another patch and Cc you there. This patch should be ignored.

BR,

Jouni H=C3=B6gander
