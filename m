Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBD0206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E36Be5xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKMT3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:29:19 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41349 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfKMT3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:29:18 -0500
Received: by mail-yw1-f68.google.com with SMTP id j190so1096536ywf.8;
        Wed, 13 Nov 2019 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kQ68XjiOoLFQO29m9ZubDfCA9B0WpxaoMFVqWdXaE0=;
        b=E36Be5xN6c156DfFSUBAAvPzWllod27IArdI7KEIWCemI6cebs9cvDnofu5xB1v+eu
         RwQsIyqteW5knGZ/EjVtNem7zilzhQnwLzPbxKKgjl0j8ALLSqB/hyrRqVEBgK2FfGe0
         ycYWZI4zClAVk5MlP6kTlcHMP3giswZ8HonVFcs3mgt54gnrpZGPlTePpu+oV4lMlOqF
         bEAFai9txcfKW47ai+J3CGgEWuSPBXPresG401SyGuuuVuWcEa04VBAaeCnpFpbBZIy5
         58jJCnsitmDBvztlRiumr+M9yZhzvGwDLNmQPdQqgL1Kzh8v9ffHZnHUPBcQIhxx3esc
         ExpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kQ68XjiOoLFQO29m9ZubDfCA9B0WpxaoMFVqWdXaE0=;
        b=eX24gVgzLphD6/eYdtRBhsvAYdaJ4V775YwPzwKtCymcbLbKrSouEG6TvO58L6brEh
         eIk8WsFvlqIsupe6CN8320Bet9r4vjV3gnX8yEPJWrWRbvchK0bhdDNZQwUVX4AHMdz8
         TnQ+dbIRQ55u4Q+StbFjii5Sd4AdXShfCanpzJ2/Kp+H2Uw70Du5hYuwpqGybbzpJ+i7
         JjJ1hMRvPXZ3rxZc727D7hROV+0HZQLebraMrtCTz/ebLBB2uxMJE/uBNVbjSdnZjjkW
         RonbRo35hKMSdwBcZj1FGinogyaajdU6pQzmTtQ0NLkF6UdqPMzI1DVgcEiW5gVIltsb
         lyrA==
X-Gm-Message-State: APjAAAXr3f1EDuGdpm4DqRV9TRpUQoCGx6oR1+TK4npyWroyaoBXZFIs
        SEVF/6g9g4YBgzZ7ERdAv8m30//ir+BYNZfuiTQ=
X-Google-Smtp-Source: APXvYqxkEZrdQl1uOBMAAMLpLATKMCQ90dYIYoTfySvAsOr0x8SC61GKIQdxWAVl0gjKPIYj5IBvWnICc7Ec+RJKj44=
X-Received: by 2002:a0d:f305:: with SMTP id c5mr3180153ywf.31.1573673356152;
 Wed, 13 Nov 2019 11:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20191113175746.110933-1-colin.king@canonical.com>
 <CAOQ4uxiV06H9s8WMso6A1A7mhdvQ_AuWM0n71VoGYTdryi8KNA@mail.gmail.com> <a494f07f-c1e3-a9e3-2af5-252d59df4bfd@canonical.com>
In-Reply-To: <a494f07f-c1e3-a9e3-2af5-252d59df4bfd@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Nov 2019 21:29:05 +0200
Message-ID: <CAOQ4uxjrON7FvEgOUvKP8DoHfbVY+LxinTMa=uAeHwAp=--zuw@mail.gmail.com>
Subject: Re: [PATCH][V3] ovl: fix lookup failure on multi lower squashfs
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sorry I wasn't clear.
> > Miklos is right. the test ofs->upper_mnt here is bogus because
> > nfs_export could be enabled without upper.
> > The change you made in v3 to ovl_lower_uuid_ok() should be enough.
>
> OK, so the following is required for V4:
>
> +       if (!ovl_lower_uuid_ok(ofs, &sb->s_uuid)) {
>

Yes. more accurately there should be no change to this line.

Thanks,
Amir.
