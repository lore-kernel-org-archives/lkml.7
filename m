Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCEC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B002063F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n930NhSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfDPSH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:07:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40257 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfDPSH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:07:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so4870562ljq.7;
        Tue, 16 Apr 2019 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4y0QlVztKLYzhyoXzFPZ8tuZcqavZHdJ+gdepaRcJA=;
        b=n930NhSm3EeRNp10ARBxj98OtL86w99Mw/uMn/cGSHovzQyenduSFWXkzSyDEYp3my
         1+3/k1MrsJjh2vFtqTHMta8KzCr+Vyd332q6bMQw04HTWgHUoxCfrx9TKTmuc9EKurgr
         NP4sD6mASxoT8s0TAjAFT2jE3b5CYNnvWn8MLUqjQQgbkORF1uRWA90QOb0AGnkXdIUg
         HDUzvh4oXK1GkWXLlc84CmXT1ELwonuRZA8T+eaO0D3nzMbYL2EsLtGY2nc+HuOoz1HZ
         yfHMLEqczakFljSAFYh10OzbZOUFUXNaDWKetVZrrYd5rP2j4jzdPnDGhp9Bn3bvokHn
         uc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4y0QlVztKLYzhyoXzFPZ8tuZcqavZHdJ+gdepaRcJA=;
        b=CdjQNt5TaVLiTdgjYMMjWoWJAm5hCncMh+gT+EQf0UtirvTRltDdEDJ6l3hj1yMox7
         h79aemXwzLkcOGzI96catu6L8xxEs5OpS+m74J4r7dvpKgxEyRnTjftYkdPj1grTA1Sx
         5g5IUxHqsJ37CkSQsanKRY1I6YaYrCzlPDPsph0LT515VTGR7oJZCHpTS3l9AdlTkqJI
         IHcbyrqb/k24Hrd0wMqfl9NVF//e9biIOg/Fl3i6WtJrAHhpDoYf0I+bvAXcUXX9SXy6
         5i13UtQTPCPMrp3ws4n5yCdyzARrw0puCAuXJ4P33g2ZLn4d597OnCwH9g24/qVIa/i/
         Nzgg==
X-Gm-Message-State: APjAAAUBUqENTz94ADpF31r7e4UFCTKJMpG/c7BKG0vz3qirLiJ4LU7f
        iNYYrIjn6VPrbf+/WLtY1MnYtljQ6GbQTmaDmQA=
X-Google-Smtp-Source: APXvYqwHiqaOiwNRqHHldxLBihupOxnDWQq8FvelFZXtn0Bx5sOLYLvVaUREzFu3HczyBhdYrEQGBS5Mm+2gTfmyVZA=
X-Received: by 2002:a2e:9655:: with SMTP id z21mr20039172ljh.60.1555438043915;
 Tue, 16 Apr 2019 11:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190416174900.GT2217@ZenIV.linux.org.uk> <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
 <20190416175340.21068-44-viro@ZenIV.linux.org.uk>
In-Reply-To: <20190416175340.21068-44-viro@ZenIV.linux.org.uk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 11:07:11 -0700
Message-ID: <CAADnVQJTQXcxckKMZQ4Lg9R++=618wEsymjTUsVQVMce7CfdZg@mail.gmail.com>
Subject: Re: [RFC PATCH 44/62] bpf: switch to ->free_inode()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:55 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Alexei Starovoitov <ast@kernel.org>

> ---
>  kernel/bpf/inode.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 4a8f390a2b82..bc53e5b20ddc 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -566,9 +566,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>         return 0;
>  }
>
> -static void bpf_destroy_inode_deferred(struct rcu_head *head)
> +static void bpf_free_inode(struct inode *inode)
>  {
> -       struct inode *inode = container_of(head, struct inode, i_rcu);
>         enum bpf_type type;
>
>         if (S_ISLNK(inode->i_mode))
> @@ -578,16 +577,11 @@ static void bpf_destroy_inode_deferred(struct rcu_head *head)
>         free_inode_nonrcu(inode);
>  }
>
> -static void bpf_destroy_inode(struct inode *inode)
> -{
> -       call_rcu(&inode->i_rcu, bpf_destroy_inode_deferred);
> -}
> -
>  static const struct super_operations bpf_super_ops = {
>         .statfs         = simple_statfs,
>         .drop_inode     = generic_delete_inode,
>         .show_options   = bpf_show_options,
> -       .destroy_inode  = bpf_destroy_inode,
> +       .free_inode     = bpf_free_inode,
>  };
>
>  enum {
> --
> 2.11.0
>
