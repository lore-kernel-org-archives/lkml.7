Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D897C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD85204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aho2/MXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfFRVOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:14:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46953 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:14:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so963905ljg.13;
        Tue, 18 Jun 2019 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaAxeVjH+EUZnsd2BO4q1H+XTPNcQpQ8tPv3CdubesQ=;
        b=Aho2/MXGHZi2HIa60PJ/lJldDI55R7GhpXD621AhFR2Oqtvt82VMcJ8i5A6kUtswjb
         LXpza6A5txTjRHD8GFim4obhDAlZZIp3zPoVhRp1FpJSgTmEAsNqZP22zyR+iJT+bsMs
         wz337eRgTAhKy4CSrw+F5eUOmPzM49yF6kEuhZFAXN8O0QhA886vMuB8FyoImGFHbS5P
         g82ooHdGVKOj09ZVC8cL17g35temnF7YkW6v0I8mnDmE3viYeeqZYpGPuysKdxBJXm5Y
         IqSw3QPr+/4a+xjDDBUbsxmpJCHHjd8LCW/hTFFYK2IUOhk48LkYpq2PtoZabVxJQbaT
         jXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaAxeVjH+EUZnsd2BO4q1H+XTPNcQpQ8tPv3CdubesQ=;
        b=ZZNSwHVKkeEGMt75FOQ40xNNSm51A/wqr1G5xzoWk6ztAnr4nwT9BCO5FNKwwIQb97
         moPbIy6vGTCXH7jNK7eG8nnV83UjMYSv6eHqHA5Ps448fOZJngO58YY9sKFZAWDfPvJn
         qA3BuLP0rpU4juRt93X2tecaSwzSWxkaCcEDErTHJ2O4F0DDETNhSgNkF0QHhDVIPua6
         unjZDZjGjxwBxnzK7QyxvoGF5RYUTSSp/4PdQlUhm5IjJIirKFuMABEqfllaaFKjryAZ
         UtYFMApT5G2FNOD4WkB/EjJZQPnsIaFYh6erPLvtaTNa2oWzeo22SwSYuAgeNeVDZec9
         ynsg==
X-Gm-Message-State: APjAAAVQ2iqL3ijRF4WIeylaJvUvqbQj465B9c07ST2H8S/wpA0Qwu2V
        HsdG0dGGW8oyCtQV9J4iWklvReschfXiC5nm1iAijRns
X-Google-Smtp-Source: APXvYqwdPHgliYTpMmX+C/KPOU+7/2aAyX6twM47MIh5MRq8ZQKYHgdjCL4q8I6YUXRWxPrzRcCvHgPuQTwVPkWS+Yo=
X-Received: by 2002:a2e:968e:: with SMTP id q14mr21980601lji.195.1560892452920;
 Tue, 18 Jun 2019 14:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560890800.git.mchehab+samsung@kernel.org> <3da3e0379da562d703e6896ded6a7839d1272494.1560890800.git.mchehab+samsung@kernel.org>
In-Reply-To: <3da3e0379da562d703e6896ded6a7839d1272494.1560890800.git.mchehab+samsung@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Jun 2019 23:14:01 +0200
Message-ID: <CANiq72kibf49R+QtUjqcttGiNr4kxBqc0TxSe+HdrQUahTxgng@mail.gmail.com>
Subject: Re: [PATCH v2 02/29] docs: lcd-panel-cgram.txt: convert docs to ReST
 and rename to *.rst
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:56 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> This small text file describes the usage of parallel port LCD
> displays from userspace PoV. So, a good candidate for the
> admin guide.
>
> While this is not part of the admin-guide book, mark it as
> :orphan:, in order to avoid build warnings.

If we are going to move everything else to `.rst` too, even things
outside the guide, then ack.

Cheers,
Miguel
