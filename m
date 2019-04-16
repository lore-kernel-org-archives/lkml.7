Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCBAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1A72075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXE6OB/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfDPVes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:34:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38201 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:34:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so13131962qki.5;
        Tue, 16 Apr 2019 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZOuUpDP+oEE8zDag4TP7D7kvRREI+1dnU6iGVWD2sU=;
        b=FXE6OB/ezKLiHvoQ0/xaHOaSD0SWvQJpKsvHzjQ3qihM6Zp4EklHykA/oDlbIVKvhd
         a56h0vTB8BorLrOQiMaIHVnZ1OvidMLdwqw20WezQyec0GRG5aOCmEAupU/tsz4A0IMW
         zgxT7tln40r8COh3oIhIQUCefg6LKCJYdrYv/ohVjYS+X8AIJA0IVlLjlQ7zjYRmKb1V
         BxGPKEJjnVHVKueoSpDdvkijE6oprlQPgah7Vl1COZ9YX0G/St6Dac1eFtq+UaB8pUTc
         9yfAAGu3bDxwwUZGRkzz5aLs4knhKGOM9D6D3c6Jflqz8oI590DlDxH1c9Wp5kplFI9m
         WRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZOuUpDP+oEE8zDag4TP7D7kvRREI+1dnU6iGVWD2sU=;
        b=M0Rz+SGFMk2WikanAq0sOoIJQ6sYhLN6DlJw+PFnEorvgzXPA5/bHCbc971TnDhuGJ
         jRVCpMFOen0z1ZHZtqimfoUnMCD6JhzqN1ab/piUsi3yfCfLth2ePZqgAmO+f0IRRIbM
         ikpd0IcSqSycDCnIIcU3hrkFCJZ/kajFBHxfPVFRpzG0Y6Jhl0Qg3vtf1Udo3gTmEpVz
         iYjLdQuZhba7GPCXLKf35FL7zZ7Ysc5rApnN9NUb/1OqgQLHdfQ269p+1xcNd5qKI0vO
         c1DUg4ky5wC2W6Je3h6KQfmGN4KL4zPA1K3xVoInZnSXSaAf1Q6zJmDbn6dvzy81rJsK
         t7vQ==
X-Gm-Message-State: APjAAAV1Un8fY1Lm+Zzlje+u9v3A4nO57LyfIn5tzB7+OhADsz88vB6b
        VDOvXPZn/p/LiI0xapyLvIcWD2kodXE047MIHeY=
X-Google-Smtp-Source: APXvYqwTWzQSxDLkqfcRhDCYTP38ecfFberjeHFzDz1rWDT0McEstnZpZVd8Xsp7ktBGmF5B6eY6j6KlGguw6AATZi8=
X-Received: by 2002:a05:620a:16c5:: with SMTP id a5mr66496802qkn.212.1555450486494;
 Tue, 16 Apr 2019 14:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-44-viro@ZenIV.linux.org.uk> <CAADnVQJTQXcxckKMZQ4Lg9R++=618wEsymjTUsVQVMce7CfdZg@mail.gmail.com>
In-Reply-To: <CAADnVQJTQXcxckKMZQ4Lg9R++=618wEsymjTUsVQVMce7CfdZg@mail.gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 16 Apr 2019 14:34:35 -0700
Message-ID: <CAPhsuW5+7SdYERewTQFjp7pDSwzP9p9j=K71Cf4O96vxCqAf-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 44/62] bpf: switch to ->free_inode()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:07 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 16, 2019 at 10:55 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

>
> > ---
> >  kernel/bpf/inode.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> > index 4a8f390a2b82..bc53e5b20ddc 100644
> > --- a/kernel/bpf/inode.c
> > +++ b/kernel/bpf/inode.c
> > @@ -566,9 +566,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
> >         return 0;
> >  }
> >
> > -static void bpf_destroy_inode_deferred(struct rcu_head *head)
> > +static void bpf_free_inode(struct inode *inode)
> >  {
> > -       struct inode *inode = container_of(head, struct inode, i_rcu);
> >         enum bpf_type type;
> >
> >         if (S_ISLNK(inode->i_mode))
> > @@ -578,16 +577,11 @@ static void bpf_destroy_inode_deferred(struct rcu_head *head)
> >         free_inode_nonrcu(inode);
> >  }
> >
> > -static void bpf_destroy_inode(struct inode *inode)
> > -{
> > -       call_rcu(&inode->i_rcu, bpf_destroy_inode_deferred);
> > -}
> > -
> >  static const struct super_operations bpf_super_ops = {
> >         .statfs         = simple_statfs,
> >         .drop_inode     = generic_delete_inode,
> >         .show_options   = bpf_show_options,
> > -       .destroy_inode  = bpf_destroy_inode,
> > +       .free_inode     = bpf_free_inode,
> >  };
> >
> >  enum {
> > --
> > 2.11.0
> >
