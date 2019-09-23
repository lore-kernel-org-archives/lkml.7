Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15144C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EC5206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 09:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pU4T85jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392372AbfIWJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 05:45:26 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:33983 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390596AbfIWJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:45:25 -0400
Received: by mail-io1-f51.google.com with SMTP id q1so31896972ion.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44EOEm7yz0oFG+vheu1aHwVYo1HpDuXq6px8EByvfPc=;
        b=pU4T85jjQHoJV3oD9AWVMWGf12n9L6ApRhOca2y46BeVwOmskUCrUooYRj68YoUKcS
         QC5Uf8USdwzZxwWHF0vJ85KTujKf1tFE6PjbOqE5nZ6P1QVAjCvBT0SRjPUXn8RkC6sC
         QZ5bstTnOS92F6b65gGsTkcSO7g2Eu3DvtmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44EOEm7yz0oFG+vheu1aHwVYo1HpDuXq6px8EByvfPc=;
        b=bg1furccA4jjO2aQOZFvd4sFV0n2pYI/oQM0qHmfzPMfA3rxgGmeSwJr0KkZleDk+6
         XCZI/ngJwm+2gD6aRueoB4YcKCcaPNwuTQ4Wwhn+D+QLe9GZw67EhFiEm5k46G5WZX+X
         i5wLoFjq0WvbImn22hM7bK53MUnGloLFVO0s/MhKMGgWoK89ukGeF/EeIX00b+oLAb4o
         0nVS/aJ3mtsoLKcdjEAl9P0oPQ9KksDRrjo4HoD9dnt6KaNKKM6DTWzLYVDSQkBFRRK1
         kO8v7Qlmt50Q3olO8IAh7OHg73KSkS5+Ec6+Ju1//I4u6zFVKie6/riBrbyFc87zY+WB
         gOZw==
X-Gm-Message-State: APjAAAWJvKVSYqpymEebQ6Vofd68fXTqwmzwb3lqmTqrJEtXmqTgchV4
        bOkw+pKx9vFXVxxBQc6/eG8kqm+rbLIxjfTAvpfFvg==
X-Google-Smtp-Source: APXvYqwguBWvgHxLYx37Mt9hw9WURFWYERqTZpIFrikxCBZgtfE2YeigIK8DqlQvIp2Fr1D4afE8LQFArub6coM6gqQ=
X-Received: by 2002:a6b:b243:: with SMTP id b64mr17114286iof.252.1569231924903;
 Mon, 23 Sep 2019 02:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190923055231.19728-1-yuehaibing@huawei.com>
In-Reply-To: <20190923055231.19728-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Sep 2019 11:45:13 +0200
Message-ID: <CAJfpegs4GzCHw-t4FssF=YNEByhFt3nTeidV+Jfoc-Q-KZ11-A@mail.gmail.com>
Subject: Re: [PATCH -next] fuse: Make fuse_args_to_req static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 7:53 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> fs/fuse/dev.c:468:6: warning: symbol 'fuse_args_to_req' was not declared. Should it be static?

Thanks, applied.

Miklos
