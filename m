Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262D9C04AB3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C723D2184D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557614668;
	bh=DBGXq/wo5eO+VqLPrQODgPeSLnJ8AW0XoIMolnMCp6Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sjq18f+7IZXNw8RZ+aW5ebc3+6bp8GfejdFq04CcuvyA8X4fswyokYDmcAOmmHrUA
	 HBVzt0ExiPNfTEeH/XIsQKywEf3Qx5U+ZUOgCn68/pifRyEXzlqnGotDQiYA7OHglu
	 V5RqI+VYqzgiF3i0g8b08WElwvP/b0K4SceHk3cU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEKWo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfEKWo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:44:26 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EC8C21883
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 22:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557614665;
        bh=DBGXq/wo5eO+VqLPrQODgPeSLnJ8AW0XoIMolnMCp6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2T1xXzIyLDFtQqcxDJubuIMPoaEwT56pjInA0mlMgeInYHftrgyEJJ1vJcvv+Tkuf
         eA8Y/MST6nLsAmwk6H3JEMwXXqquGK0WICtADAdRVPD2CSlR8kj0BwKZncxL4LGmv8
         hdsfKVy1tsrMoucuy5dczDnqZPdjIjsc/GSodU54=
Received: by mail-wr1-f51.google.com with SMTP id d12so11307059wrm.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 15:44:25 -0700 (PDT)
X-Gm-Message-State: APjAAAUEA8grB2Kv9XYfJry0qSgx9GTV+iH9bFGB+9PJdPg2T0R4tS9I
        T1QFM6dRhYI7p6keb2o05ZBK0i+IZU59CGf0gSaHQQ==
X-Google-Smtp-Source: APXvYqz9VVf+0M9zlAhmu/aFtD6QMQ36wIxFeD0UzE/oiKErAKWSOoq0eUm7WmnOKqEkU517LcD4VC3J8VtYROM702w=
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr12063994wrs.309.1557614663619;
 Sat, 11 May 2019 15:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 11 May 2019 15:44:12 -0700
X-Gmail-Original-Message-ID: <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
Message-ID: <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Rob Landley <rob@landley.net>, james.w.mcmechan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:27 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> This patch set aims at solving the following use case: appraise files from
> the initial ram disk. To do that, IMA checks the signature/hash from the
> security.ima xattr. Unfortunately, this use case cannot be implemented
> currently, as the CPIO format does not support xattrs.
>
> This proposal consists in marshaling pathnames and xattrs in a file called
> .xattr-list. They are unmarshaled by the CPIO parser after all files have
> been extracted.
>
> The difference from v1 (https://lkml.org/lkml/2018/11/22/1182) is that all
> xattrs are stored in a single file and not per file (solves the file name
> limitation issue, as it is not necessary to add a suffix to files
> containing xattrs).
>
> The difference with another proposal
> (https://lore.kernel.org/patchwork/cover/888071/) is that xattrs can be
> included in an image without changing the image format, as opposed to
> defining a new one. As seen from the discussion, if a new format has to be
> defined, it should fix the issues of the existing format, which requires
> more time.

I read some of those emails.  ISTM that adding TAR support should be
seriously considered.  Sure, it's baroque, but it's very, very well
supported, and it does exactly what we need.

--Andy
