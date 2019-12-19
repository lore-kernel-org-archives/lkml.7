Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B81C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/pPQutH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLSRGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:06:51 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52618 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfLSRGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:06:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id w23so2808364pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggI/u1Hdyu9CCu5/c+HTrd/ZpT0m9d7Vzr8WRuTSKCk=;
        b=r/pPQutHWlw6VyAXT2bxHLFev0H77LHp66kYaujlhy2o/5XPZsJkCza1NueqSMvjEu
         Gfn9MrWzJrPce9mN4Bilc40mvgfzFP8McDHK1PnY0IXO/OSgnwi5SRCqzgdxoj8vOVYg
         JGhEJ06OTFGsQP4VTCnUz0aT9hwY0kNFczwWppHEX1v62UTsIK8JI6q+TWiZLA2B9ibf
         OQWNovQd5GsCjBjjNcjeUu1pdQLQj23MTufOY5GeueFFn8VACLt85aPFPnV7NiFby4mV
         In5qUzMSPj1ld61/PaIYVAxDq3EMfhc3h6wHsAmMhJjayWoPHALPPtp8zgOGPnLNzwbL
         VuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggI/u1Hdyu9CCu5/c+HTrd/ZpT0m9d7Vzr8WRuTSKCk=;
        b=s6xv7J5c9AvptVj5rr+almC6ITE/rq3KDqvEnFEECHOHGiEE/NpCVd+PRbE2tQnd9u
         KoAyVh6Yxin8OH6ePce9zWfUbHAm9gDf/v6MHslfcZKpMgg7g3QDta/NfV75FTzwHxPA
         vYTZ9V6bcKBB6+cfdUwY7ozMGhZXVw0JeKy5sRSW8uSBGLOhEna31nphqdSG92g5arxw
         c0MoPTk/eajgExpC7SqgW9zNtbIYb9BqoVgbR+fmp23HOia8AiAyHwm7eEo1+sU3pAdv
         7I7fR3oXA7ACeUyddQ8AhxzzY5oFtvzhGC2JPgIGYxORuhuFw0rVdtPz628jQdXDuK1H
         VL2g==
X-Gm-Message-State: APjAAAWVYEN1VB/ru6xLMevYYCz97L+JUbOSkwsvcL43wwE7YNf6wXCW
        9J7DkBg4mhAn6pKGjd1iAickzF1pEstofaXDAjM2QQ==
X-Google-Smtp-Source: APXvYqxqxsEj2OttOz43YW9dsdsZ9JH2CzkLhBO906Jga6l6c3H9XIl47GBiSOLZiapTHFUKrg0ydPLQ+JWIDI9HDIw=
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr9829302plt.223.1576775209535;
 Thu, 19 Dec 2019 09:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20191211192252.35024-1-natechancellor@gmail.com>
 <CAKwvOdmQp+Rjgh49kbTp1ocLCjv4SUACEO4+tX5vz4stX-pPpg@mail.gmail.com> <87a77o786o.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87a77o786o.fsf@kamboji.qca.qualcomm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 19 Dec 2019 09:06:37 -0800
Message-ID: <CAKwvOdk3EPurHLMf81VHowauRYZ4FZXxNg98hJvp8CLgu=SSPw@mail.gmail.com>
Subject: Re: [PATCH] ath11k: Remove unnecessary enum scan_priority
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 5:32 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
>
> > On Wed, Dec 11, 2019 at 11:23 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> >> wmi_scan_priority and scan_priority have the same values but the wmi one
> >> has WMI prefixed to the names. Since that enum is already being used,
> >> get rid of scan_priority and switch its one use to wmi_scan_priority to
> >> fix this warning.
> >>
> > Also, I don't know if the more concisely named enum is preferable?
>
> I didn't get this comment.

Given two enums with the same values:
enum scan_priority
enum wmi_scan_priority
wouldn't you prefer to type wmi_ a few times less?  Doesn't really
matter, but that was the point I was making.
-- 
Thanks,
~Nick Desaulniers
