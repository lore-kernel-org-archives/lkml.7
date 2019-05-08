Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A6CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A1204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dLgN7Mwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfEHONv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:13:51 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51951 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfEHONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:13:50 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so4298623itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OELUENc3UGFI4n64xtHyWctIjuS1FHXlpju+VHmaEhI=;
        b=dLgN7MwfahWL5KRvq3nO48znS+N9vOxoLsZ0QKbz7QjqM81X6SYBt5biQTM7+yWxNn
         61hwvNv4/Xge+ia6X9lVvgneqZgtbYVP2Fu0ONbXMlWp9sMU4vqYUuo0GiNV349YSA2l
         oiebe0j3GbK+pGQNSEjH0cQ+geiyC6ydVuvIjaZmTua1E2WPE0b1k3VP/lh0cTvcJ/Px
         Nl4FNQ8D6JkogwX2s8u8O8CZ/VlqG8itnONJUFQoHub+tPKUqEXZ4rUDrkPQFZWPNfOm
         VzpBSYTemWyOdzXnZ++1T28ctbhpB5M7GrKg9Ws5SQgbnaArchI0+JMZvrI4IdIDQaPD
         4ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OELUENc3UGFI4n64xtHyWctIjuS1FHXlpju+VHmaEhI=;
        b=IMbsDQXBp8J71P5AsX4e/DJAfHakepg0vCUxJyPilSOTDYA9io53hU2lWPYzAX86ZF
         qGB4lj3ggf0+1Ul/fXnSjIXaCJg3/b/uYza1iubuwZeQk3GtahBUIEI/sikNhq9J+32V
         W7gt0o/Q+35hVTmn82QnbdRSI16o3vjxfuNigDSkincHhvUYJ12By5Uj0RoZVVYmZa9U
         sKw+2Zwt5bBXKo74U1QAu64XCgx2jQ5cwyhpzGLFz4AHHUpH+rwzdhFk5KYY9WP/v4eO
         B8E0sbPAVKh91wfU4xmVm88XhiCP2we1q/zDi/jkmeHkMChWEHxiKGHfCWasULWWq2bA
         K6Uw==
X-Gm-Message-State: APjAAAUGMoHFOJgvtO/Gc+migPu9cfhr/3cJJJCblY9LMxcevSeQE7e5
        /oiL5i2YnswKGcPcd+fcOB6r9w==
X-Google-Smtp-Source: APXvYqxyZFk7D1oD/2eJU/YNb79OWIUwIVwdt2F+Z5X5GYcbtQ+wiIBOk/azDs0gGrN5+XNcPkN1bg==
X-Received: by 2002:a05:6638:94:: with SMTP id v20mr27688629jao.2.1557324829960;
        Wed, 08 May 2019 07:13:49 -0700 (PDT)
Received: from [26.66.241.113] ([172.56.12.182])
        by smtp.gmail.com with ESMTPSA id r6sm2554802iog.38.2019.05.08.07.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:13:48 -0700 (PDT)
Date:   Wed, 08 May 2019 16:13:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <4158.1557324343@warthog.procyon.org.uk>
References: <20190508132218.3617-1-christian@brauner.io> <4158.1557324343@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fs: make all new mount api fds cloexec by default
To:     David Howells <dhowells@redhat.com>
CC:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <937AFC55-9B52-44C1-893E-CE396F1BD5B7@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 8, 2019 4:05:43 PM GMT+02:00, David Howells <dhowells@redhat=2Ecom> =
wrote:
>Christian Brauner <christian@brauner=2Eio> wrote:
>
>> -	fd =3D get_unused_fd_flags(flags & O_CLOEXEC);
>> +	fd =3D get_unused_fd_flags(flags | O_CLOEXEC);
>
>That'll break if there are any flags other than O_CLOEXEC=2E
>
>> -	ret =3D get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC :
>0);
>> +	ret =3D get_unused_fd_flags(flags | O_CLOEXEC);
>
>That'll break because flags is not compatible with what
>get_unused_fd_flags()
>is expecting=2E

Technically only when new flags are added=2E
Right now it works correctly=2E
I'll send a v1 soon=2E

Thanks for catching that, David=2E
Christian

