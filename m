Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78752146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GS9KcqR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDKUsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:48:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41795 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKUsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:48:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so4354337qke.8;
        Thu, 11 Apr 2019 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFxx8aXhh0G/CS6goo7udzq09ZCw/FPJwQJNH7tq1kU=;
        b=GS9KcqR50oOE6DZenl/eg2vjZV9mXtAQl3FhcV8lXa5DSQjBr8sriYOzsBIgNUay04
         EEkqYcTyqlfKHxsNJaGFolfJSa+BRb8AfT6C5EZRZlAeZI+S2Jxq2OqorJa2pMT1KfLi
         j3WED/jwBH4sHdeCFRHadMRVbYv/EEIqrCdBbZIgWnErgYIpbuK17yN5kCOs+O/0r7xR
         BCuJnlnzFcsmbgYa7OAP/v+jicgedYArQSFQVz/OtH/KpC2dUQ9rlPoewIEzbpO8RVgv
         M22jEIGZ97J4WQ4HcZH8MZlwxxGijlvEnLKkvYg/RkSLcKvJb9SC6NtSecGtlkkI/Rx+
         PXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFxx8aXhh0G/CS6goo7udzq09ZCw/FPJwQJNH7tq1kU=;
        b=NTpQ7c4nLRTdcW8/u3JxVBxVfMNRwFT9dY2J+5YDazHjXDJIDVdB9vFcuLcNtAZJds
         U01v/kEgcEZ5zJtsRsBwCax0EVRWuzlQCURenV9ElE/6I+VNW0ubBwxny7WDl/O5HyeI
         +LeziseYMnnLYWLw1MuRw8FRGvim736ERUUQHCvQmK3afY/KMNOZ1iDcIKVc36kQwYKB
         qcqZySzlNoBXbVyH1MmD0Ydu9PapdbTKP3yyMp9LXlc8cv8KoTz5rvXKsRkw/tJ33YH/
         uueJDghsn2fyZlcAdzQV2aKbZwiRhEq2yqvUU0zED3JWnJ5fknWLYerk7A/axBppUJU2
         WlWQ==
X-Gm-Message-State: APjAAAXiEG8EekUrTmSCsN4FXMgv57TeIvyy2cJC0iPEZug6uVFUdQXA
        Lziu221kg3K7O97iwu5/37/xmvOVO14IT9FsXUY=
X-Google-Smtp-Source: APXvYqxwQLpGHtJsQPkPcAXLOJqtbc3Kfhu5iIYHmKQgrUf26yhZfXRnMdMyjBzS3i7Nd+tOiwXfcuWo2eObcqVMc8k=
X-Received: by 2002:a05:620a:16c5:: with SMTP id a5mr42060684qkn.212.1555015730985;
 Thu, 11 Apr 2019 13:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <3c15d21d2b6896e76e8801dc07de2bae1dadceb1.1554827560.git.joe@perches.com>
 <20190410181901.1e40252e@mschwideX1>
In-Reply-To: <20190410181901.1e40252e@mschwideX1>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 13:48:39 -0700
Message-ID: <CAPhsuW54C34tB82-g0uzyt-pWnYh616=fR9cGT6hp5t0L5h+HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: Convert IS_ENABLED uses to __is_defined
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Joe Perches <joe@perches.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:43 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Tue,  9 Apr 2019 09:33:12 -0700
> Joe Perches <joe@perches.com> wrote:
>
> > IS_ENABLED should be reserved for CONFIG_<FOO> uses so convert
> > the uses of IS_ENABLED with a #define to __is_defined.
> >
> > Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Song Liu <songliubraving@fb.com>

>
> That makes a lot of sense. Added to s390/linux:features. Thanks.
>
> --
> blue skies,
>    Martin.
>
> "Reality continues to ruin my life." - Calvin.
>
