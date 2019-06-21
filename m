Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071CC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D27421530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fD9bJpf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFUNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:16:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfFUNQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:16:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so6546471wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mPUnKUErQwOwXGwZBT5Ey56iJmCW0WfZLXR1krZvrYU=;
        b=fD9bJpf/v260yqw6OCPl1c6n2YVUF0/+/KN9FwDYvuyHsOQBVQq1DBZjeuryVlfcBL
         RsWyvBi2ngVB5Bz4O9OFKhDgrMYtWSb8sXoKxPeAyQpjI8bmS7oX7Mwiuf1BSNFJz1YW
         noP8uwIdfxl4GC1SIAl5z3/2CrOQVXQ0Zt3cDqK2CG4Tra+hjpUhdJxRRwoMpIQ8w15g
         sa78XKp20dDfNHM5QcIPAB37+UIm3Oq5G3edOMxMqul/E+yQdk/9c1OKB93I3DO4lth1
         L2KkxAkYN2msyRPNWVguqDaOpKXJwT+S9KmRsweiuWd7SqtSLS0l2bqMp0wdPgNnofuq
         3YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mPUnKUErQwOwXGwZBT5Ey56iJmCW0WfZLXR1krZvrYU=;
        b=o6otatH2KWaQSHvNh+OpLNyosV6qHPRZb6JjR3h03HsL7PRXX6QLKp/HwwcwR+w0oa
         OH0XstMLBUSuz0m0tkL0yqBA2FOh29VqCZWj/Gkv9SpaPeMzm/FEm4D1rV7hoXNQsE1P
         6gUW3JPbXEltNVmQsQY0EcM6zEKGeLHhUkCxneflM/qrYgzX//aOS0Syvyo0Xe/oJ1tK
         SfP5WSlAwUpj4TDHoj68Y9KcHiGUkIRgWp9ToZINE11NtJ344cHghOP+thF74NGQN4R5
         L6M8eG6W0aYfSieASmYOEeZ0d47U8W17WmXZBHgWh4b3gLktPiOl/QJKihrgArDkChHE
         X6Gg==
X-Gm-Message-State: APjAAAWD0mkodgAPZfDdDniJCdax0Fl1wT1nozkrvrSpNtAujxMxbBCQ
        mWZwPZbQ/gfz1/Ku+z1RqoLpCQb60aC41Q==
X-Google-Smtp-Source: APXvYqyY/SkUhuw7VmjzjNPeIV0bd+A0X6khk42a4daELIRF/NW12Xrlr++mVLsuuQ0AHummNggz+g==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr11788420wrs.348.1561122968459;
        Fri, 21 Jun 2019 06:16:08 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id a7sm2668821wrs.94.2019.06.21.06.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:16:07 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:16:04 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <21652.1561122763@warthog.procyon.org.uk>
References: <20190621094757.zijugn6cfulmchnf@brauner.io> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk> <21652.1561122763@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an fs_context [ver #13]
To:     David Howells <dhowells@redhat.com>
CC:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <E76F5188-CED8-4472-9136-BDCDFDAF57F0@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 21, 2019 3:12:43 PM GMT+02:00, David Howells <dhowells@redhat=2Ecom=
> wrote:
>Christian Brauner <christian@brauner=2Eio> wrote:
>
>> >  static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams
>*params)
>> >  {
>> >  	struct fd f =3D fdget_raw(fd);
>>=20
>> You're using fdget_raw() which means you want to allow O_PATH fds but
>> below you're checking whether the f_ops correspond to
>> fscontext_fops=2E If it's an O_PATH
>
>It can't be=2E  The only way to get an fs_context fd is from fsopen() or
>fspick() - neither of which allow O_PATH to be specified=2E
>
>If you tried to go through /proc/pid/fd with open(O_PATH), I think
>you'd get
>the symlink, not the target=2E

Then you should use fdget(), no? :)

Christian

