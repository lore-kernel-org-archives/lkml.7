Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5EDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9762075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMCBXP7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfDDTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:33:26 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44975 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:33:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id c4so1410743ywa.11;
        Thu, 04 Apr 2019 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqMcnDJTEUURualgLe3iPccCVQvXW9AheCllYh2Rvac=;
        b=YMCBXP7kL+YSuhnPUPXglx6l67Y2ETdKhA/Zl6Xf/Jq4PfLdJty9CcbRu/2v4ReN+m
         P4di8G9dcHDEymgQQ/6xLLPaa/v4MZYWYxDjhxxB8/WZrppzs190C9OmOwTlPEnkFWdM
         pTj4qPXd510MAzGr5tZVtpM3Ga/BElEotvfOfLzif0tMsDHVEi4VoK07irT0XuNVR4yK
         7ZBHZxXVy5hiMiuXTx+rdVV2nc5NUnz6HSExiRkP68Er52WppG/HnHFgZBwBLTKLabPY
         lEBAJOSEHCfxRq99MFCxsdL9zAaWO7e9sj/k0bAx30DDEIveueKRue6zU5EYiBcHtdC5
         YGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqMcnDJTEUURualgLe3iPccCVQvXW9AheCllYh2Rvac=;
        b=Jwudqv2N6JfpOmnsrACU8C+kEkeqQL9BFhY3s++PbpfQQAajCLe6NoMKo7PWBvg0KT
         GRjzV8Pgkj8dn6/NRVi1Gndikx66MBPGDzbTiCVudQ/93VViS114y6CF6oXo1TeO5QIg
         D3iq4fQpN55hp9Uf+MdMLl9IkY68a/74YBs08pG1B3/OZtAu6ZR8/2Ia05h3wPgEufHq
         jJewuB0FavIQLbYBkTB1aU7Zlx035F4dn89lmMS+W8TDoeEdT0cOeWg0bUhR4CnnlHl0
         vPbD21z+XWRJNC2QlGWmOkVXaNRoOuH5YfRvrTh23hflB23bBnSAoAxNXVhQjlW5NN4q
         t72w==
X-Gm-Message-State: APjAAAV3h8dhTP/Ja9/2bKX2QYGcleUdA1b6SytzazNFk+F+Oa+s9ZeX
        GiUZOwXf1Q1OBOTEyiabuyCk4t1dLPYivcyUOFQ=
X-Google-Smtp-Source: APXvYqyOEmKUsOwh5NQSsS7ZZ6VsrzcRPGxRPm3+C5dmw6EsbsSaF1kISRQVRj7t55VqRzQEnPE+ywe/z8jWqWn/3dc=
X-Received: by 2002:a81:2f88:: with SMTP id v130mr6506495ywv.7.1554406405782;
 Thu, 04 Apr 2019 12:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190404105255.12189-1-amir73il@gmail.com> <20190404184448.GC2217@ZenIV.linux.org.uk>
 <20190404184944.GD2217@ZenIV.linux.org.uk> <20190404190506.GE2217@ZenIV.linux.org.uk>
In-Reply-To: <20190404190506.GE2217@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 Apr 2019 22:33:14 +0300
Message-ID: <CAOQ4uxjuLTTA3Ywfv6kgC6x97bYXa5qbdTePKxo5-YYTdwDQ7A@mail.gmail.com>
Subject: Re: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 10:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
...
> OK, so...  My first reaction had been complete BS.  However, the
> same goes for your analysis - it's not an ordering problem at all.
> What happens is that we are replacing file->path.mnt with a clone
> and we want the write count contribution (file is opened for write)
> to be transferred.  That's it.  We do *NOT* want any kind of
> freeze protection for the duration of switchover.
>
> IOW, the solution is to switch to __mnt_{want,drop}_write() for that
> switchover; we don't want to mess with freeze protection at all.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Cool. That works for me.
Thanks for setting this straight.

You may add:
Tested-by: Amir Goldstein <amir73il@gmail.com>
Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com

Thanks,
Amir.

> ---
> diff --git a/fs/internal.h b/fs/internal.h
> index 6a8b71643af4..2e7362837a6e 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -89,9 +89,7 @@ extern int sb_prepare_remount_readonly(struct super_block *);
>
>  extern void __init mnt_init(void);
>
> -extern int __mnt_want_write(struct vfsmount *);
>  extern int __mnt_want_write_file(struct file *);
> -extern void __mnt_drop_write(struct vfsmount *);
>  extern void __mnt_drop_write_file(struct file *);
>
>  /*
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 9197ddbf35fb..bf8cc4108b8f 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -87,6 +87,8 @@ extern bool mnt_may_suid(struct vfsmount *mnt);
>
>  struct path;
>  extern struct vfsmount *clone_private_mount(const struct path *path);
> +extern int __mnt_want_write(struct vfsmount *);
> +extern void __mnt_drop_write(struct vfsmount *);
>
>  struct file_system_type;
>  extern struct vfsmount *fc_mount(struct fs_context *fc);
> diff --git a/kernel/acct.c b/kernel/acct.c
> index addf7732fb56..81f9831a7859 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -227,7 +227,7 @@ static int acct_on(struct filename *pathname)
>                 filp_close(file, NULL);
>                 return PTR_ERR(internal);
>         }
> -       err = mnt_want_write(internal);
> +       err = __mnt_want_write(internal);
>         if (err) {
>                 mntput(internal);
>                 kfree(acct);
> @@ -252,7 +252,7 @@ static int acct_on(struct filename *pathname)
>         old = xchg(&ns->bacct, &acct->pin);
>         mutex_unlock(&acct->lock);
>         pin_kill(old);
> -       mnt_drop_write(mnt);
> +       __mnt_drop_write(mnt);
>         mntput(mnt);
>         return 0;
>  }
