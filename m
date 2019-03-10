Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6074207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552238391;
	bh=JOyyyV2TOQmZN4yO68UzqYaFtxeRKHVuWNIzQRPgudg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xq30z7Ln2GXT3V/xGLSKEQkJAw7Pz/fqeUbIJb5/xggj0ifn4eAjUIv4wvD+wwySi
	 diAYmHrYNxSRt/jGTVj4xW7SiZbb3d8Pjxx+mNuHZGNuKO+ovgjUWjBUT2MmRNe4TT
	 Q8HsEXXKPkMc999wIo3zWL/dgEriojWny1ctcN2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfCJRTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:19:50 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:43000 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:19:50 -0400
Received: by mail-lj1-f182.google.com with SMTP id d14so2007521ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fL4V2W4f9ovqpOg5svwlM4GhENM3AOsK9QMvSaIgz/4=;
        b=GF8Cp6y8MolRy5cK4wRwa9I7ncVCacW4mVJOxRnWr5zDIEuEbKfs46zE1vspPfl3mt
         TQWtaxeM1O3E8bzWYDbkoULlDUPdzBGK2OkEtpb4T5hksTrdp92FhF5CMMIxZEdumOJo
         WYOJnAMW7VgPGD8VG411HEbRfbC8AEgb4fx1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL4V2W4f9ovqpOg5svwlM4GhENM3AOsK9QMvSaIgz/4=;
        b=Odoko44Tyd2x+1SNBaE/9OyfYMWYBkXv9ab/hFjMykB5VdfyHJRwEaSPsXU+3mVbUk
         PkSamFgDUzOI4lbTeeHNokjwXoP4k3/s6ZD7vMVopWHY5o27MJPBsTriZ+bxK2WpsId6
         i451moOwsSANOGNkf/8P4zMwuwLI+IBViY9f6tTuY2cXh6h9oVhtsPdo7Qdft5bLpvKZ
         igqV95MkJaBLT2kPmzhiEhEjgWRL3w6naP5Vt+swiRA5U800b7PGY07SJR8fMF49XWOT
         VvOufRHh+lA2ud4VTfP3sx/kTZuPiDTxadat0UriWMDF35tfaoz5s4ijD+6WD7DD+0xo
         lsRQ==
X-Gm-Message-State: APjAAAUhPUIT/ar5L5FVcMLemRwiGhIntsZGnbbYEwCdEKVo6zkBWi4P
        JqcnaS2uM2+Is2DOsfgPnTGmcZRY5Lk=
X-Google-Smtp-Source: APXvYqxyGtGG96dmA0bao2SMJJbVkPMrqlilesHfJCqYiK5w7Ncu60JyDXW1cEDfajKZyHTEvSskjg==
X-Received: by 2002:a2e:8589:: with SMTP id b9mr14462139lji.56.1552238387238;
        Sun, 10 Mar 2019 10:19:47 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r124sm714920lfr.93.2019.03.10.10.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 10:19:46 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id p1so1687834lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 10:19:45 -0700 (PDT)
X-Received: by 2002:ac2:424c:: with SMTP id m12mr16331460lfl.62.1552238385469;
 Sun, 10 Mar 2019 10:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190308164221.GA126180@arrakis.emea.arm.com> <20190310102444.GA48401@MBP.local>
In-Reply-To: <20190310102444.GA48401@MBP.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 10:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghd3QfSwVuaYv5eCUmgf5mBguNytfC-D-Dt4TN34U=7g@mail.gmail.com>
Message-ID: <CAHk-=wghd3QfSwVuaYv5eCUmgf5mBguNytfC-D-Dt4TN34U=7g@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 updates for 5.1-rc1
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 3:24 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Were there any issues with this pull request or you haven't got around
> to merging it yet?

All good, just hadn't gotten around to it yet.

Your pull request hadn't come in when I did the first round of
architecture updates, so then it waited until I started doing arch
updates again this morning.

                    Linus
