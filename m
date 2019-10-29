Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE8C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D503E21721
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N549/5ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfJ2A1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:27:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36790 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfJ2A1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:27:24 -0400
Received: by mail-ot1-f68.google.com with SMTP id c7so8300645otm.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=;
        b=N549/5eirfYiMcEkpgmhVSSpEyVRHSOgPEz645xTJulyOKXBFmbS+kttzA1bI4775t
         KEB4cnQ8CSDgEaf3xORF5wcjxQN4e+EJo3f0Vm0GOg/j+Ahj2Dk1sSIozG/tGExY4mmZ
         KhHByJXLiNKUABr8oFs+9R4n4hLJs7TWoSpR0lCSSWO8XFfPKqYjYdevQPekSBIPqxA3
         HvsjCa7jokmArh/ClM6pBzyipGOeaECa9E50bk2n6MCgYC8hn9dVW/OmmX25MFTC7gjG
         xTo47H1OBR74DUU0lbosTDLdnRM84NtxVrWeadlk+AwZH22SaGHJUA/R32VBcK01dqt0
         VAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFG/NUMsi6FfdyRZ+1e8lH7DWnn/2sbhoHTkW1LTspQ=;
        b=IIMuinP32IDZjw5+dxN/WBEwHnosvG6VgRgAWm+tOBHU8JYAdx+2FCNx+wVuswJSlN
         sC1IrOeeXI2MdPukipzuDLoLeSFKZ/VbTNeUz3edxA9aHv7fnzCAPW0GlFteBaFfN1PZ
         xr0tgxRURO+6n9f4MruTta6OW1pjfJvioeb4zUsfsHFfV9wVBQ7gQw4HXhZnYn6yLYxn
         KumWHFERmZHH+ZbbmjYIvV3bch7dLq8dXGYuwoMT+GkQH/Ra4pX59FRRibAl/5BOVWC4
         HTIJl1083hZj5xEGLC6kGH+S38yoNt0ktOjdLOvSD1c+zOHPTLFHnW1xpqw2t6ky6kxJ
         2UAA==
X-Gm-Message-State: APjAAAWHZeaYRRvRv04ZJ2wkw22J5VqeAxNw92VHzW7GGyoRXoCGS5kt
        YzZyYOZVpD7hPOJvRWKYz5WcZaHTvx/2WSEUJNUtJA==
X-Google-Smtp-Source: APXvYqyyMmC6akibUD0ctyx6cZAI+MIQu4fGSJOdVD9ulOLlox6OONUlRS6Dqd0X3Ff0CgmITcC9+WmmkjuDol9LmWE=
X-Received: by 2002:a05:6830:1bea:: with SMTP id k10mr11448680otb.190.1572308842618;
 Mon, 28 Oct 2019 17:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191023214821.107615-1-hridya@google.com> <20191023214821.107615-2-hridya@google.com>
 <e61510b8-c8d7-349f-b297-9df367c26a9f@huawei.com> <CA+wgaPNas7ixNtepJE_6e7b6Dcutb9a1Who4WrUfKSw1ZnQhTA@mail.gmail.com>
 <96f89e7c-d91e-e263-99f7-16998cc443a7@huawei.com> <20191025182229.GB24183@jaegeuk-macbookpro.roam.corp.google.com>
 <eb08716f-2f56-30bb-d71d-28125b3b0608@huawei.com>
In-Reply-To: <eb08716f-2f56-30bb-d71d-28125b3b0608@huawei.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 28 Oct 2019 17:26:46 -0700
Message-ID: <CA+wgaPMcJWqwiQwt9z0+C5AFMbAB7wSuNeE9wvp3PDOYF_6kew@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: Add f2fs stats to sysfs
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 6:38 PM Chao Yu <yuchao0@huawei.com> wrote:
>
> On 2019/10/26 2:22, Jaegeuk Kim wrote:
> > On 10/25, Chao Yu wrote:
> >> On 2019/10/25 11:51, Hridya Valsaraju wrote:
> >>> On Thu, Oct 24, 2019 at 2:26 AM Chao Yu <yuchao0@huawei.com> wrote:
> >>>>
> >>>> On 2019/10/24 5:48, Hridya Valsaraju wrote:
> >>>>> Currently f2fs stats are only available from /d/f2fs/status. This patch
> >>>>> adds some of the f2fs stats to sysfs so that they are accessible even
> >>>>> when debugfs is not mounted.
> >>>>
> >>>> Why don't we mount debugfs first?
> >>>
> >>> Thank you for taking a look at the patch Chao. We will not be mounting
> >>> debugfs for security reasons.
> >>
> >> Hi, Hridya,
> >>
> >> May I ask is there any use case for those new entries?
> >>
> >> So many sysfs entries exist, if there is real use case, how about backuping
> >> entire /d/f2fs/status entry into /proc/fs/f2fs/<dev>/ directory rather than
> >> adding some of stats as a single entry in sysfs directory?
> >
> > These will be useful to keep a track on f2fs health status by one value
> > per entry, which doesn't require user-land parsing stuff. Of course, Android
> > can exploit them by IdleMaint, rollback feature, and so on.
>
> Alright, I suggest to add a sub-directory for those statistic entries, we can
> manage them more easily isolated from those existed switch entries.

Thank you Chao and Jaegeuk. I will make this change and send out a new version.

Regards,
Hridya

>
> Thanks,
>
> >
> >>
> >> Thanks,
> >>
> >>>
> >>> Regards,
> >>> Hridya
> >>>
> >>>>
> >>>> Thanks,
> >>> .
> >>>
> > .
> >
