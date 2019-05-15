Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BDC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A864720818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 21:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igEIO6/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfEOVAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 17:00:44 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52918 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEOVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 17:00:44 -0400
Received: by mail-wm1-f49.google.com with SMTP id y3so1418245wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YwmpvP+rMpFcNcCho3HpAkjJLkgqW1dbm3WkulvRrg=;
        b=igEIO6/J8K34sgtKNUjPKDPsKN4vkuUys4KMlg8IopQ026OHeRqSWSKdNHpCUUZbqd
         D1Xrfcqgm06WwwCF5wsT6Vu9S8eZa1YMbxrsTPu0Yq2FSGPWe+uFs6Q/uKEibkc+zJQA
         PIvIQgHoMgpKbH99CgjKjTXXTLCXC85NDt61lASu5p7w1XcxmQrbgKbXhfCVHkxBmoAF
         Pv+OAyCev9MUXZL/saXvt+HJpppNBYI2Guhfo6oXnjlgmma1pWOSKgfXRL9AZVMtIYjy
         TQhJnMLNPTSiaxtWQWY6TP/USDuMoqn2/OwNJxvhrxHWxE3mlzHhMyvXFPpefNVVhBWM
         kiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YwmpvP+rMpFcNcCho3HpAkjJLkgqW1dbm3WkulvRrg=;
        b=XQumMDl7XqWi/VTEyy3AyAayEipXGQHR3VH6OigcPVNyCvbI7ZAJLpz+YdVopABUXX
         AOst5zFPZlhl8gPgaCLND5l/RaOrtyFieMqwzta5XQ6jGMQPUweP+TlH++InWqQqZLnW
         2kUGaFt3u7tz33ZJyJD0It4BOoWSuyOSIH6WnrY0fU1uDlWT24B6MmuCPXywZbvLpnSP
         iCoBlpd0SGCKRuLQ/Op+t55P//w7kL6AY8Y7CzTZBuh+KFW6N8uD81FHF56158wdKsC6
         j0hervqrLDvr18LxIDqCxet7GRYl6r3zuxX/Uj6bqtcwMq6Oyc0iAuvmnNfHmxVfgED2
         UkOQ==
X-Gm-Message-State: APjAAAU9Ba7yuZoil/uAPO6hAGftv/FObT9R5SRqo8ruofjaRCNHp3XZ
        R2WPnGmjobg1tt1gov4mSKhhNCD/jDhQMp3Lxn+d7pmOtkI=
X-Google-Smtp-Source: APXvYqzOhb4qdA6w14C+vrWsULjPKfJUFNLRxCbEb37m0m1lC0od8W87ILCrAJqKG9Nv/1YErUKc1n4rT3NsNXLX2Rw=
X-Received: by 2002:a1c:2245:: with SMTP id i66mr9223843wmi.19.1557954043034;
 Wed, 15 May 2019 14:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <E44E4181-1CFB-493C-8023-147472049D19@cisco.com>
In-Reply-To: <E44E4181-1CFB-493C-8023-147472049D19@cisco.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 15 May 2019 23:00:31 +0200
Message-ID: <CAFLxGvysPg3FO4kT0QrRsYTr219WVttQMeat_StqbifTPrGLmA@mail.gmail.com>
Subject: Re: Removal of dump_stack()s from /fs/ubifs/io.c
To:     "Shreya Gangan (shgangan)" <shgangan@cisco.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 10:45 PM Shreya Gangan (shgangan)
<shgangan@cisco.com> wrote:
>
> Hi,
>
>  /fs/ubifs/io.c has dump_stack() in multiple functions upon errors and sometimes warnings.
> Since the error and warning messages seem to be unique, the functional value of these dump_stacks is not apparent.
> Why are these dump_stacks required and what issues might occur upon the removal of these?

They are not required, but they are just useful. While you are right
that the locations within UBIFS
are unique, they are not for the whole kernel context.
Filesystem functions can get called via many different paths from VFS...

Why do you want to remove them, what is the benefit?

-- 
Thanks,
//richard
