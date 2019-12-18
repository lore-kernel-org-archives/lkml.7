Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48645C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178662176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576678321;
	bh=79rqH2dBnJXkD/dI4OB9vOcFaCGucTm5WBmcXtm6njE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o0ZxOIEcyl3upEGmYqCVio0p7YzHjAJJ3Zg8+dn/beQSB16LjXK4TwBk5RNwxnEYE
	 WfDmRJHk68QFO7lout34N0hKG1ikqZWeRwXb+lk137cIRkrjl6HLsDjG9cQOFe9QP6
	 yOA/kgBPSQ0o/ad7Pik5+PyrdZh//HkYq8plzNBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLROMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:12:00 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28395 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLROL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:11:59 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xBIEBbkj031244;
        Wed, 18 Dec 2019 23:11:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xBIEBbkj031244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576678298;
        bh=GIh5bV342PmYX3igG3YsIMFCEsrn8iROsnE6Fi/UqLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yJaTFc+ZccMZJ1WJ7g3tqLlwkWqkScEFFFAsSxSWUnhutDdCzjuLO0szKnsU4MVMf
         +FKzThElVleTcsLuufgEW/Lqm1SI7QICgutZnGMEke1w8MhkFpHFDyX46XuK9SC20O
         WZ/+BtaVuCn//rHTJLGmLZjJjj9k7B97HZL1MHGBDp8rrh8zZKyQ/o79zB3SmQA5TE
         zTZrb02J9ysizcD2m7smCLW9fODsH/LMY+RdcCwP3xslM6ST8O2M3HD8XTrloUjCUe
         pq5Qi2A6itN+hZbJV+rqfMCfNgSIU3i5ni54fzOPImPUwUCU8rfVTqKHwfYeuazRHn
         DsAW11B9tAzRw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id b79so1442447vsd.9;
        Wed, 18 Dec 2019 06:11:38 -0800 (PST)
X-Gm-Message-State: APjAAAVH3TXgA88JpLohUHw1OzsBdTtYaVpz2I0uFdHu8YHcRZdr+9KN
        uxXiGFx1J2ho0KQmVrumBq1acWFygakT1hADVZA=
X-Google-Smtp-Source: APXvYqwWJN2/aMPXJa20FY+DxxzTnJCSC+hWu1BfsV6WIJIJH7WdfyfiiPS90ix3XP62luBc2lWN4vHuTO1/VyD7zAw=
X-Received: by 2002:a05:6102:3102:: with SMTP id e2mr1493360vsh.179.1576678296929;
 Wed, 18 Dec 2019 06:11:36 -0800 (PST)
MIME-Version: 1.0
References: <5a473c6c-cc1f-6648-31ec-3b40e415a836@infradead.org>
 <20191207014238.5507-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAK7LNATj5RBHov_w05q1XSiOPN7fYQCKhVMDzHNwHSB1Eq2rmQ@mail.gmail.com>
 <cedbe416-844e-2bb8-5d05-4cd34eae8619@i-love.sakura.ne.jp>
 <CAK7LNATpAbRVbCuHQjq2e493aP0p1F9=Nd8+goQm-JnHzMEesw@mail.gmail.com> <ced8ab1c-9c35-c7b0-6b9e-bcee7ffdf469@i-love.sakura.ne.jp>
In-Reply-To: <ced8ab1c-9c35-c7b0-6b9e-bcee7ffdf469@i-love.sakura.ne.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Dec 2019 23:11:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATNY1oP5XgFH3+fuUU=Z7pEz7Sqz0vKCzvhM4Kem7RkOg@mail.gmail.com>
Message-ID: <CAK7LNATNY1oP5XgFH3+fuUU=Z7pEz7Sqz0vKCzvhM4Kem7RkOg@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig: Add yes2modconfig and mod2yesconfig targets.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:42 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since kernel configs provided by syzbot are close to "make allyesconfig",
> it takes long time to rebuild. This is especially waste of time when we
> need to rebuild for many times (e.g. doing manual printk() inspection,
> bisect operations).
>
> We can save time if we can exclude modules which are irrelevant to each
> problem. But "make localmodconfig" cannot exclude modules which are built
> into vmlinux because /sbin/lsmod output is used as the source of modules.
>
> Therefore, this patch adds "make yes2modconfig" which converts from =y
> to =m if possible. After confirming that the interested problem is still
> reproducible, we can try "make localmodconfig" (and/or manually tune
> based on "Modules linked in:" line) in order to exclude modules which are
> irrelevant to the interested problem. While we are at it, this patch also
> adds "make mod2yesconfig" which converts from =m to =y in case someone
> wants to convert from =m to =y after "make localmodconfig".
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
> Changelog since v2:
> - Add 'if possible' to help message.
> - Make conf_rewrite_mod_or_yes() void.
> - Don't call check_conf() loop, for conf_write() takes care.
> - Use sym_add_change_count(1) to tell something has changed.
>
> Changelog since v1:
> - Updated the available 'help' targets in Makefile.

Applied to linux-kbuild. Thanks.



-- 
Best Regards
Masahiro Yamada
