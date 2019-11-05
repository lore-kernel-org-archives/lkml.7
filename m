Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD847CA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813D2214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 07:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVbPVVm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfKEH4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 02:56:16 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43400 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbfKEH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 02:56:16 -0500
Received: by mail-yw1-f66.google.com with SMTP id g77so7978300ywb.10;
        Mon, 04 Nov 2019 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Sw1HL7Q7exzJotrSp6tCwUKxBPvJqTFu7l+7aIJqKg=;
        b=OVbPVVm7K3EvDzJQwMdKxlvHSCl4q1LrRSoYZWY30q7dVSRRnQU3Q5Z4HurO+gsw4P
         pzlSjByiXPf19mwvaoSpHm8NX6Dbcrydpe0WFARfJPEeocp6h7juG2JThGeOburIUCoO
         O/J8CBV3FIQDdnNpdBVVbMV1lxDxivXtW+Lsn60q0tK/lI1YAAaSw6pdCL8gpVLzrRoG
         izBdrJVoPKJKZ5IE/mnvo0zHCKiiIvqAAFYUVUu6CzXC3NJVRsYlqDatf8H/82UAvK5v
         78dkgGlhzy5wOx/51udKlV1AC019OtTMyeZSm6grUBaAAUorOJV6cW3NVROmRAUlMzHJ
         ZFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Sw1HL7Q7exzJotrSp6tCwUKxBPvJqTFu7l+7aIJqKg=;
        b=Oz+N4Pv68/5K6r7DHYOHRlDt1Kl+8llZk5Bh4eUkXd5FVcF7Yk04sjeYdkCRloDUAf
         8xR9lnKxSIoy/LxyNamEE1XKBxlUf9/WPEdKVu0/eAr8aFTzkfomHEQdXur+E+9yEKX7
         c7osrWNwUBQnpDBUqFtGukIvJz9lmG7THsN2jSPekMBp+hrDRoHw9M88q+Bd97n9xRfA
         G53i5d4eF2I+4XTuj4UTRgmmbWcAEwRlasDgIysB2R+7jQHaEnXN22fv6xCou2NyYu4M
         V9uxxGzT5GINhAtQyoGhja20o3yHONvleppi+aNJTVtQ6qoQlPL5LrViP8h0bclYbUHn
         JmVQ==
X-Gm-Message-State: APjAAAUc1ZstRNOWmnmumJXC3zmsYlFYdApDcl1ARjCZEEa2dDiVkpT1
        t15igAG4JgvABaPzc0BeLfzZIdJ1aT+36T2Qyi4=
X-Google-Smtp-Source: APXvYqxKftZebjOlSRQgJEVKt8QAMiNV2AMQkbdXNGu36cI3JUpSsxgpGzMHleM64j8D/XqUlbgQ1syh8coAsCsX/J0=
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr12058238ywv.183.1572940575277;
 Mon, 04 Nov 2019 23:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20191104215253.141818-1-salyzyn@android.com>
In-Reply-To: <20191104215253.141818-1-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Nov 2019 09:56:04 +0200
Message-ID: <CAOQ4uxhoozGgxYmucFpFx8N=b4x9H3sfp60TNzf0dmU9eQi2UQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Patch series:
>
> Mark Salyzyn (4):
>   Add flags option to get xattr method paired to __vfs_getxattr

Sigh.. did not get to fsdevel (again...) I already told you several times
that you need to use a shorter CC list.

>   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
>   overlayfs: internal getxattr operations without sepolicy checking
>   overlayfs: override_creds=off option bypass creator_cred

It would be better for review IMO if you rebase your series on top of
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git ovl-unpriv

1. internal getxattr patch would be a one liner change to ovl_own_getxattr()
2. The documentation of override_creds would be much more
meaningful if it used the overlay permission model terminology
that Miklos added in his patch set and extend it

Thanks,
Amir.
