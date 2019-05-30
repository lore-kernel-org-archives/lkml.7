Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBCDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C812586E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="V5ZBBqW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfE3Lng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:43:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfE3Lnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:43:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so3984321wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=x7Qyy1KyQMpKaNghFb+JOHZdFPq1/NIbfTjt3A+5EHs=;
        b=V5ZBBqW2T06RqnvJVzT3AO8/ouFOu/LNxk7BIU7QtYl4402Th+Nm1rmpB/wGMbPZwL
         Jj7mH5BsTRf0ANI4qiDv6PVjNRr+mwfmr0Zt6u07WXcC3j3VQkvuM/sAITId7ZIRvOKU
         OrmOToyll1UmmqRp6fr+JGZ/kEDZvbOqaCIcsDKr2tNA4CzUEgpDb0T2/i4Gt/QSoqSj
         RVmogbtHxynyT8dYrvNft6PPfDD+v/Rhxk1dUVj8A1XIjcyc53o+q/vY5pXJbBsCb/Ls
         bJBj5FQXvuwN6tPfmcuPaW8oOP/oCYkO2PBygQmfO2jf/7QUpihAhGrl1ZItIqgnGjdi
         X+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=x7Qyy1KyQMpKaNghFb+JOHZdFPq1/NIbfTjt3A+5EHs=;
        b=fO6THnM9g9/QiTnPIYArXrPbMpbQJKdKchPsxVyV9xBF9kmOoI7YVqGcQ3T8+GwzoE
         TJRgBjT/7EScjf7m8rGyJNzhcqTVG4SPF2joPPHWelrTEgZZcRzTLHGQXqdAY7m8RgIT
         orq/e/AFOULrUAsC1CUc0H2Qsfk6Ls4Qin739VkGX4qbnHCl+ib/N4O4OAeL7kEd4gHI
         cUyH5XkaKyUAtd0VNbhCtrGHRtKpFLIYCj4ucrhOssxGbFnc/21o+e5WZrA91uxMF2Uh
         n4srepD8+LzSwrbjRz+awzHzeqgIM8KhGn9lhg/JWi3Bw3XkrwuekoblX22tii3xNWSK
         YFyg==
X-Gm-Message-State: APjAAAUYl+5Fz8WAwjDxXy1r2liRGru5Hg2eyBnyQ2GJ7G/PkqOnYUin
        HgxD+DRuho7qKdCyYSeDDjHumBzq9dLKbw==
X-Google-Smtp-Source: APXvYqx7eo2IJq8TtX8+mg3zeaoQIHvU24aNQ2F00GoN/ZR8ZliFL6QkTniZ3/dMyJm1NRP2tp7kng==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr2358129wrt.177.1559216613878;
        Thu, 30 May 2019 04:43:33 -0700 (PDT)
Received: from [192.168.1.161] (93-32-55-82.ip32.fastwebnet.it. [93.32.55.82])
        by smtp.gmail.com with ESMTPSA id c18sm3206011wrm.7.2019.05.30.04.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:43:33 -0700 (PDT)
Date:   Thu, 30 May 2019 13:43:31 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <1559216447-28355-1-git-send-email-linux@roeck-us.net>
References: <1559216447-28355-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] samples: pidfd: Fix compile error seen if __NR_pidfd_send_signal is undefined
To:     Guenter Roeck <linux@roeck-us.net>, Jann Horn <jannh@google.com>
CC:     linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <CAB50BEC-4816-4D92-AC46-921C62B1D344@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2019 1:40:47 PM GMT+02:00, Guenter Roeck <linux@roeck-us=2Enet> =
wrote:
>To make pidfd-metadata compile on all arches, irrespective of whether
>or not syscall numbers are assigned, define the syscall number to -1
>if it isn't to cause the kernel to return -ENOSYS=2E
>
>Fixes: 43c6afee48d4 ("samples: show race-free pidfd metadata access")
>Cc: Christian Brauner <christian@brauner=2Eio>
>Signed-off-by: Guenter Roeck <linux@roeck-us=2Enet>
>---
> samples/pidfd/pidfd-metadata=2Ec | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/samples/pidfd/pidfd-metadata=2Ec
>b/samples/pidfd/pidfd-metadata=2Ec
>index 640f5f757c57=2E=2E1e125ddde268 100644
>--- a/samples/pidfd/pidfd-metadata=2Ec
>+++ b/samples/pidfd/pidfd-metadata=2Ec
>@@ -21,6 +21,10 @@
> #define CLONE_PIDFD 0x00001000
> #endif
>=20
>+#ifndef __NR_pidfd_send_signal
>+#define __NR_pidfd_send_signal	-1
>+#endif
>+
> static int do_child(void *args)
> {
> 	printf("%d\n", getpid());

Couldn't you just use the actual syscall number?=20
That should still fail if the kernel is to old=20
and still work on kernels that support it
but for whatever reason the unistd=2Eh h
header doesn't have it defined=2E

Thanks!
Christian
