Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D22BC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDC21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFNQ4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:56:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41780 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfFNQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:56:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id 107so3268138otj.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 09:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNzgw8zU6lYxY9116+VTCavjD+4v/EZJ92kV6MCy3Hw=;
        b=s/5eC/OJh3nz2/Aj9YrYRVi6F6dv1odBaUTahO++IAPH2Tdb4trqt0Dg4kHvUrNMd1
         4STt5E105y7IcCO/v6O7LkRc7hjTeKeMUhb0XriPB5lIJGuCzRGPkS3FSBipt0YSCP+J
         wMHm7eyrFPrG2kOWeAql8GiFGD2MQ5BgNagzd5lXP3fMNoeM02Utfsiu0X4gT7bbqytK
         4WEqGORuuZxcEkxDXv8WwFnWmWETxWMKNqRMpejYLjog/+yQ+OtiAmGEC4u7bZg2hZUJ
         U5kXRNNnOTIF1/gbGmiuN/5NzG1W16e3f5Yiklk4xWFy/NKArraHBpZIpyqUZJPNsGrr
         AbxA==
X-Gm-Message-State: APjAAAUqZgvucR+S99Ecdpac6dHrAy9Mi04ljAD2XPdsB0EdZ8aM3xI2
        YM5LGUAQDD0sFLFp9eRBveyyNWDFNIEXtNNF1uFxsQ==
X-Google-Smtp-Source: APXvYqy2rNq9+R6u/xnYlzAgf1nwxm3PpCU3YNzHzhAoC+UXWr4Wmm6PlURMQyQ3rNfDdi+Dv87oUDmHrlRke6mba2A=
X-Received: by 2002:a9d:704f:: with SMTP id x15mr17973354otj.297.1560531405363;
 Fri, 14 Jun 2019 09:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190614134625.6870-1-jlayton@kernel.org>
In-Reply-To: <20190614134625.6870-1-jlayton@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 14 Jun 2019 18:56:34 +0200
Message-ID: <CAHc6FU5QVQQ43TZNZ7A53D3Ka3e_qq9GEtV_fZt7C5A+xrWm_A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ceph: don't NULL terminate virtual xattr values
To:     Jeff Layton <jlayton@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 at 15:46, Jeff Layton <jlayton@kernel.org> wrote:
> kcephfs has several "virtual" xattrs that return strings that are
> currently populated using snprintf(), which always NULL terminates the
> string.
>
> This leads to the string being truncated when we use a buffer length
> acquired by calling getxattr with a 0 size first. The last character
> of the string ends up being clobbered by the termination.
>
> The convention with xattrs is to not store the termination with string
> data, given that we have the length. This is how setfattr/getfattr
> operate.
>
> This patch makes ceph's virtual xattrs not include NULL termination
> when formatting their values. In order to handle this, a new
> snprintf_noterm function is added, and ceph is changed over to use
> this to populate the xattr value buffer. Finally, we fix ceph to
> return -ERANGE properly when the string didn't fit in the buffer.

This looks reasonable from an xattr point of view.

Thanks,
Andreas

> Jeff Layton (3):
>   lib/vsprintf: add snprintf_noterm
>   ceph: don't NULL terminate virtual xattr strings
>   ceph: return -ERANGE if virtual xattr value didn't fit in buffer
>
>  fs/ceph/xattr.c        |  49 +++++++-------
>  include/linux/kernel.h |   2 +
>  lib/vsprintf.c         | 145 ++++++++++++++++++++++++++++-------------
>  3 files changed, 130 insertions(+), 66 deletions(-)
>
> --
> 2.21.0
>
