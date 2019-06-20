Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D828C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506DB2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uROPwNcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfFTIhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:37:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43930 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfFTIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:37:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so1786270lfk.10;
        Thu, 20 Jun 2019 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd7GiCQM8lenqTJUOIcXTj7Cl91pjK/khn5nN598vIg=;
        b=uROPwNcNTJqAQG0/+kFLBBKVf+WoVVIwEVSI5tLTUrF7LMwmhylDtvhbKkbD2M6n4A
         TnyB3prmmqSGH5yg9xQLybKYZxb6+CzMMKFkwYkzdfNFLrIivGQLaaMYFmuLyLxsl1ua
         bIoTwZ9z8+UZ+KahQwv4r0lY4WZHTXA5HFbHNxCk39h7eoPjHUTw9TFZ7swNyxwboJyD
         jY1oTdznM72mGWYF26b5GSpW3tor1LqcW3FkN1tvdl7HIHoRE9yMDeirigsAqOXV5dm3
         znkyc9zJpwDn+ACidqqspXSExcbMuWqbYFZYEpi9m333xDvAjYt0JdYn9mbOsQKJ2zUG
         IJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd7GiCQM8lenqTJUOIcXTj7Cl91pjK/khn5nN598vIg=;
        b=G9G2JFHwOyq8IDpP0JgxAVXRn+gMndiYnr0tH8qlq/gVYD5rpGD/pyeZSHKffaikB3
         jLwjjJNCQqBZKyfh9RE8Tb/s+Uc8/m8dM0qXQV2wH8KbsLxqaso9KskIfURUKNQauYrd
         rTuigTYkv33fvOxwurjioGKVd3S+LYZq0fDyuNQwWavtBabFV1zA04a0ur9IcJudiq3B
         NTMpiDT5zTP+68TE7F1vtv13b/6iyJAq28Hn+k2UdobG5QO6TrAekR2xyJginUPGZ041
         m7JmBP6BCPYg+PfGuNaKS/3M3z0UmnS+M5pWh4ZKm8r/LljaUD+r0EGfOsI4WDEu6rJp
         JAnA==
X-Gm-Message-State: APjAAAVDl5KVDYIIeiVya/d+9ZxXlOHbXLZN4CX6pEAFOKAZzfCxRc+C
        6zhVfuWqPI5xEbwcxZFMknJfHXJx8hZonDzxaGBplb8i
X-Google-Smtp-Source: APXvYqwUeG/IbxPt0AU798ZtGxOv7ueKTuOTf1lRMOiUH38RoZgvNZkd38TqiqzpU8ogg8c9rQAvqztPwICLvXH9AxM=
X-Received: by 2002:ac2:4466:: with SMTP id y6mr2477936lfl.0.1561019864061;
 Thu, 20 Jun 2019 01:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
 <3da3e0379da562d703e6896ded6a7839d1272494.1560890800.git.mchehab+samsung@kernel.org>
 <CANiq72kibf49R+QtUjqcttGiNr4kxBqc0TxSe+HdrQUahTxgng@mail.gmail.com> <20190618201455.04e8743d@coco.lan>
In-Reply-To: <20190618201455.04e8743d@coco.lan>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jun 2019 10:37:33 +0200
Message-ID: <CANiq72k+y9a6Ct8AOxkc663ULJ7Q=0uqQzKCBx+PkiYnEuu6AA@mail.gmail.com>
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

On Wed, Jun 19, 2019 at 1:15 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> Yeah, the plan is to move all text files inside Documentation/ to .rst[1].
>
> [1] There are some exceptions: for ABI and features, the current plan
> is to have a script that parses their strict formats and produce
> a ReST output.
>
>
> Btw, Still pending to be sent, I have already a patch removing the
> :orphan: from this file and adding it to the admin guide:
>
>         https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_renames_v5.1&id=eae5b48cab115c83be8dd59ee99b9e45f8142134
>
> And the corresponding output, after the patches I currently have:
>
>         https://www.infradead.org/~mchehab/rst_conversion/admin-guide/lcd-panel-cgram.html

Thanks for the pointers! I guess you will take all these
patches/series on your tree(s), but if you want maintainers to do it,
please let me know!

Cheers,
Miguel
