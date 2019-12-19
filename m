Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113C1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27B24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkfDrhY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLSLH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:07:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20620 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726698AbfLSLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576753644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IrcMrSSa7UYXErd11JQFtfowjebCnHuL7Bzv7dIUqcc=;
        b=KkfDrhY3kJJr6AjwPv7M3rWF7TGaGWfPbYbd1QQUYXOrUBnxqlzbKino2aPGWSZuFjrh0b
        VT2kHLBcgu9o74JvUCdV8B2Pb6Mb1WZsce0OSY1f5vXFVdTurselVmOkgKOL2+FDBajWzG
        xZ6BSvkvokFhRVI2Kq2RxvUfB8zmoiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-uwfumKeEMN-nvu4639YtGA-1; Thu, 19 Dec 2019 06:07:21 -0500
X-MC-Unique: uwfumKeEMN-nvu4639YtGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B771883522;
        Thu, 19 Dec 2019 11:07:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 705C960BC7;
        Thu, 19 Dec 2019 11:07:14 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        David Laight <david.laight@aculab.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dev@opencontainers.org, containers@lists.linux-foundation.org,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
References: <20191219105533.12508-1-cyphar@cyphar.com>
        <20191219105533.12508-2-cyphar@cyphar.com>
Date:   Thu, 19 Dec 2019 12:07:13 +0100
In-Reply-To: <20191219105533.12508-2-cyphar@cyphar.com> (Aleksa Sarai's
        message of "Thu, 19 Dec 2019 21:55:29 +1100")
Message-ID: <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aleksa Sarai:

> diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
> new file mode 100644
> index 000000000000..19ef775e8e5e
> --- /dev/null
> +++ b/include/uapi/linux/openat2.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_OPENAT2_H
> +#define _UAPI_LINUX_OPENAT2_H

I think you should include the relevant header for __align_u64
etc. here.

[=E2=80=A6]
> + * Arguments for how openat2(2) should open the target path. If @resolve=
 is
> + * zero, then openat2(2) operates very similarly to openat(2).
> + *
> + * However, unlike openat(2), unknown bits in @flags result in -EINVAL r=
ather
> + * than being silently ignored. @mode must be zero unless one of {O_CREA=
T,
> + * O_TMPFILE} are set.
> + *
> + * @flags: O_* flags.
> + * @mode: O_CREAT/O_TMPFILE file mode.
> + * @resolve: RESOLVE_* flags.
> + */
> +struct open_how {
> +	__aligned_u64 flags;
> +	__u16 mode;
> +	__u16 __padding[3]; /* must be zeroed */
> +	__aligned_u64 resolve;
> +};
> +
> +#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> +#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0

Are these really useful for the UAPI header?  Is there a situation where
OPEN_HOW_SIZE_LATEST would be different from sizeof (struct open_how)?

The header is not compatible with the assembler anyway, so the numeric
constant does not seem useful.

Thanks,
Florian

