Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4311C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92641215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 20:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DE7SwvGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfFSUqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 16:46:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37146 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfFSUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 16:46:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so340892plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1hoWgXM/3sJXE0yzoEO9MJswGh6V3NEiQS35pfe8xs=;
        b=DE7SwvGJQoDgdPZwnJjXq3/xBzZ49J16GbQvaq3+CHo3OOGAmoQxMsckz7arQjwRdZ
         wiy5it8XOYRDMaIHk6idFtABMqjrytaCLe209QHxK1RVnszyZi7t5OF9mAniHjiaVosK
         MQrSwl2pxkdIep5s5ZEzTstBCVBdsK8/Y6T6UPnLLp8r6AIcap5hUwQYcAURuSovAHf9
         avuU8OxdSGnoCZ86gtmaud6e2GjZm1ouMLwslCxcxcWnHPf/GOwg0wZe0mA48TcXdLPY
         X87SVTjIufSVYzM27oh0Hoxt3nHUpGoOCcl+AnYyiA+h3/5X7FMPGwrQGE2Pt92c7f3m
         fTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1hoWgXM/3sJXE0yzoEO9MJswGh6V3NEiQS35pfe8xs=;
        b=CPGbW74vs8tBEj0lnFpLJNB8sWuM3WSoBM6tgq4tu8oOgJBCX3cGa1oF9YtS8WoQfR
         62Py8KifbZhFcnRqptwcEN6n+pjHno911WyUeL7UfHU29qezNl5zRkVND9x6H+i84LlR
         gdpVVwUiKVCPpkHKiUePvgdC3DpYHVGo8VOX55C3seT47JAa6/AgJHN6S2Aw6jpo7Jpl
         H6Q77wos+8ruC1SwgabLd0nU91gUsWjbuJPhiP8rrs8TIegmkHvqit5nNSMvCH89Ff7Z
         ffnWc+t6C1joLp6PtnnUyvGn4Ui8V+JcXheHzwtVsXZsGkLq8nIqzeLMid/1r8VOXOV8
         VAeA==
X-Gm-Message-State: APjAAAX7/Hn+UTQWqjyToz03MzZ+NN9oGK8RIAPqH4iAuZHPgjgYqBiU
        lsSkjZsZiWXEC+XWoIcXpZswsuG6pzYCq9lRoJ76Pw==
X-Google-Smtp-Source: APXvYqyHoOeUqsmfRiTdpCJaQhtM0n+ZHM7LvnKSRbOhC6JZDM1tV2GWvItN2O+RfkS2vCrqHX0e9cQ54R0YoJpWBnM=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr105536923plq.223.1560977206524;
 Wed, 19 Jun 2019 13:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190619084921.7e1310e0@bootlin.com> <20190619181715.253903-1-nhuck@google.com>
In-Reply-To: <20190619181715.253903-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Jun 2019 13:46:35 -0700
Message-ID: <CAKwvOdk7xOF8=xv5A7TQUWY29dH4agDWgMJVeO9emTMbH8CNQA@mail.gmail.com>
Subject: Re: [PATCH v2] net: mvpp2: debugfs: Add pmap to fs dump
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:17 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> There was an unused variable 'mvpp2_dbgfs_prs_pmap_fops'
> Added a usage consistent with other fops to dump pmap
> to userspace.

> Changes from v1 -> v2
> * Fix typo
> * Change commit prefix to debugfs

Compile-
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Requires `make ... W=1` before the patch to observe the warning.

>  drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> index 0ee39ea47b6b..274fb07362cb 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> @@ -566,6 +566,9 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
>         debugfs_create_file("hits", 0444, prs_entry_dir, entry,
>                             &mvpp2_dbgfs_prs_hits_fops);
>
> +       debugfs_create_file("pmap", 0444, prs_entry_dir, entry,
> +                            &mvpp2_dbgfs_prs_pmap_fops);
> +

Thanks,
~Nick Desaulniers
