Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4433C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BF2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u70am0s9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfC0Qbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:31:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35699 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfC0Qbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:31:49 -0400
Received: by mail-io1-f66.google.com with SMTP id p16so14618168iod.2;
        Wed, 27 Mar 2019 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ex4pqnXYsy1BXvNitwbeNq0NgbqhTx+5/3uhKIC6nk=;
        b=u70am0s9UAWChG1dc5BBws3VJTrY9tkChZkHIRk8q7i9hN90OG6Z+EBfzzjTQmOGpp
         aFIQt2NTeg/hXhqkb+oLpUWdhgDjEySxFgeydS1MZ9xQqJgjUQs/wBCsTgOINDyhjbGQ
         tl11QaNQ8S0FiuR57+5jNt9jUjLYjSnWoSGlwoEHXO59rsFZyMfIB8PHyEruIOPUWZ/P
         mZ8sgCBTcB2BJnU/4BhWWgoEddIelS5lqG7rwb5m8R5aTBpKsFduRqwReu+UvaY3AmsX
         fnLpUNxRbUaBNVpex+Oh9JloUmq0jJUyqc/b9nw9zbDKsbzbkkbucpVMuY+2ybGHIY8j
         oznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ex4pqnXYsy1BXvNitwbeNq0NgbqhTx+5/3uhKIC6nk=;
        b=gYd0XCbJIYzZb84gF+PJlpkQ7eY+QnFxDVpZbBGK598Xxm6UkrQC7tD40K1Ed1rv4P
         QczTDTyWdF9siuqEns2k/wC8cQFWTfLLENn1N1PsuBGhdrehs/Z8/0UxnOo7r+x1ZE9y
         PjgE3YjIodOymKGf/8UC43kEyd5K0+vluTzIYjdOi0icVI4H+2pU1Hv9vVwyVHtmy7HY
         ETLABgPc42QdDh+3g06UA5fApb+wEnjgbFGt8Vj1GSwQCvAacqwH0/3uzMG21sRYDX4l
         J+FbTDcaA3wjNAdKuA8UizOA78W1fkvu7FepZBFE2mNeafInIUdalRljIZGUbg0T81u8
         MtVA==
X-Gm-Message-State: APjAAAXOFe2ACgOsIBxAw+xObNXk9n+wkf/M9FoQpvANthd6YzMG6roE
        ggH24Xlx+/k41igYtPAf8EXGvRdjEQcpx4FUfwg=
X-Google-Smtp-Source: APXvYqzNhUlm0w9a0aPfgs0MUTYDX86mLVN97/LJy/iCJUdteOLlCie9INwkfnHkNFb6kAhDEi1rALq2kuuuAZAUZck=
X-Received: by 2002:a5d:984a:: with SMTP id p10mr26291828ios.217.1553704308626;
 Wed, 27 Mar 2019 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125147.1436083-1-arnd@arndb.de>
In-Reply-To: <20190325125147.1436083-1-arnd@arndb.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 27 Mar 2019 17:33:07 +0100
Message-ID: <CAOi1vP8-LZj2wCDHvm7aOxRRgM=Gk7cA2bAJ2Oipnfv-yPyCtQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
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

On Mon, Mar 25, 2019 at 1:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
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
> v2: rearrange to only have one instance of the initializer
> ---
>  include/linux/ceph/osdmap.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
> index 5675b1f09bc5..8794cf0f0b39 100644
> --- a/include/linux/ceph/osdmap.h
> +++ b/include/linux/ceph/osdmap.h
> @@ -110,17 +110,16 @@ struct ceph_object_id {
>         int name_len;
>  };
>
> +#define CEPH_OID_INITIALIZER(oid) { .name = (oid).inline_name }
> +
> +#define CEPH_DEFINE_OID_ONSTACK(oid)                           \
> +       struct ceph_object_id oid = CEPH_OID_INITIALIZER(oid)
> +
>  static inline void ceph_oid_init(struct ceph_object_id *oid)
>  {
> -       oid->name = oid->inline_name;
> -       oid->name_len = 0;
> +       *oid = (struct ceph_object_id)CEPH_OID_INITIALIZER(*oid);
>  }
>
> -#define CEPH_OID_INIT_ONSTACK(oid)                                     \
> -    ({ ceph_oid_init(&oid); oid; })
> -#define CEPH_DEFINE_OID_ONSTACK(oid)                                   \
> -       struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
> -
>  static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
>  {
>         return oid->name == oid->inline_name && !oid->name_len;

Applied.

Thanks,

                Ilya
