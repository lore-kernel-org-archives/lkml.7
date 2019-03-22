Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436242190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQW2MlE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfCVOk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:40:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52196 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfCVOkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:40:25 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so4036542itl.1;
        Fri, 22 Mar 2019 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48yk/kKv2vk8VliMqaCYm5My0bn+/54+xGQYxR6rmnI=;
        b=aQW2MlE2Wm6jo80cpNkG/VkisdxgPHVKZDxwsKWcg24wgegP+5U7ditICQyEexAUE/
         shrVsHpZ0pt1pPA7OqEdpHBRIee9tkIyUnDzAABCgzG/BcBezdEr+1rJVbO6RwyeJ1rd
         jVF3G20Qlivv4XzC+99+O0YjJ77yRJ0P2PMybXyfgYnyiy/UANtoBFNgrgoKj1hr4b5V
         hOCs6nuamQvTRtFBvZd25nhucoNbTEJWSZWEHwD83Pxn/u9Yc+sg0JYw/ehCzZ3gh0Uj
         JhAGziXg+wDZQRmRB9j/61mUFsRuJWtBJmzCYy8if7iZADMsbwarIGCeo6tJtQaEwimj
         kD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48yk/kKv2vk8VliMqaCYm5My0bn+/54+xGQYxR6rmnI=;
        b=DmoV9Yk43YewByp0lMCma+/27h4cD/Hf0XJ9QlaeHoNtI3A3yY12oq7DsVs3IbgTKB
         /uSj+4VdzUf5wJ4uw795O8OAVe83W2EeeVHLD21PE/tkZ0cWa2F2lwPxC3/ZRRyz7dh4
         hWJFQPO160KgaL45nAyMnWHRO/+G13xEQf0CAm8jmyJhe3E3SABQVnOfVmNd3a+f9Vhd
         RieVnyMvLCpfR8KPZqqiyMUtFkwGFg9wLp4kqBjCdM2M7tI4txnTMppJKn3txj6LN/hV
         JFVUHSa4mr7KHwewRo0lsPgGLKeWzKeyBEodYGaEh+MokFCwS8wwTrXiogjvrSxiURpH
         g+AA==
X-Gm-Message-State: APjAAAUgYPx7XLX/JM/BMiJ9M+kNPQOy5wftO+22DqUTjrhaFXxlcj5D
        BLl2n3qAattYnZjKBXTBKfJ3M25zmh5FJWOCACw=
X-Google-Smtp-Source: APXvYqz41D5YtjfPQR7XJ58873YvIXDHGFXe6HhFpddYQkrDXClYr6GstTnNOnpwLY10U896hG7jeZbvbWCFvgtII1I=
X-Received: by 2002:a24:b649:: with SMTP id d9mr1414851itj.18.1553265624273;
 Fri, 22 Mar 2019 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190322140819.300740-1-arnd@arndb.de>
In-Reply-To: <20190322140819.300740-1-arnd@arndb.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 22 Mar 2019 15:41:39 +0100
Message-ID: <CAOi1vP_=5gBUFLCofhaCNbMkfdwYNSkJ06Rmw-bJkLXNC4v8fA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang complains about assigning a variable to itself during the
> declaration:
>
> fs/ceph/ioctl.c:187:26: error: variable 'oid' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
>         CEPH_DEFINE_OID_ONSTACK(oid);
>                                 ^~~
> include/linux/ceph/osdmap.h:122:52: note: expanded from macro 'CEPH_DEFINE_OID_ONSTACK'
>         struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
>                               ~~~                         ^~~
> include/linux/ceph/osdmap.h:120:29: note: expanded from macro 'CEPH_OID_INIT_ONSTACK'
>     ({ ceph_oid_init(&oid); oid; })
>                             ^~~
>
> We use this trick in other places, but it is completely unnecessary
> here, as we can just use a regular struct initializer.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/ceph/osdmap.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 5675b1f09bc5..82f957a7a0d6 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -116,10 +116,8 @@ static inline void ceph_oid_init(struct ceph_object_id *oid)
>         oid->name_len = 0;
>  }
>
> -#define CEPH_OID_INIT_ONSTACK(oid)                                     \
> -    ({ ceph_oid_init(&oid); oid; })
>  #define CEPH_DEFINE_OID_ONSTACK(oid)                                   \
> -       struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
> +       struct ceph_object_id oid = { .name = oid.inline_name }
>
>  static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
>  {

Hi Arnd,

I don't like this because the initialization is no longer contained to
ceph_oid_init().  Now there are two things to patch instead of one.

How is this going to be fixed in other places?

Thanks,

                Ilya
