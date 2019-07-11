Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE6C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1733221019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="BWUkxdYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfGKNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:45:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46049 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfGKNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:45:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id e2so5841076edi.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 06:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Osxf+bNmRWplx05FCFX6Jw4X940F4YMRAtN+KD1L80M=;
        b=BWUkxdYrwRk4QO6cw+CCGQLCmmrE9aF/PFrdYGs+8f6nNv6ByI7LCLurp8+DALuUUR
         Z1ofWLt7DoC/hBA8wv3C0C/NgW+ci0hF3r5TLzfwBL3Y817KJ4oZgKdKUMCTOIDLihAP
         TcLMIlJKhXcLtSwZAEtsiYHsnLi1LMj/o5VdCUPT9cjROEfYTJSjnbcurljYVIuzFkmh
         BmCzjej4+rbPeeeaxK5+0+g2IrJSSaQdgKMnggKNWWTxVriZs7zE/es67goGvnNw0FRx
         Ixonk4rG14acwMVibgqqmOaW2iHbtFW6WIsOVdFfoxOM5IKjEDueISVppPuBgvtLgXFo
         Xhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Osxf+bNmRWplx05FCFX6Jw4X940F4YMRAtN+KD1L80M=;
        b=ZyPUpK54SxO7HC0nx5thoaPXVSX38UBZkSAgkbGBbmqBp4JjXB/C3MwqdXTSaJxBwL
         CCOwvNjT12L7kNwthtePgd0NKYSrkJo2G/EcbuWmvGyZK6Gt529env7x6POwH3TXEBT8
         xNktKxH5rBThbDTSZed6iZiR9tZXc1c5J29YbmZO+vjJywz/trpW52fA6rt4CD0iSGjA
         T2HxNDCWkbvioWfTeEYxxT2KrqGhfe7iU/BDZeehKzuWzMkqALVAkK/qL7KW9zgCOVzf
         wXkHfCbSqL4O0SyOOl6MFShApYoGFJLDOfi/gweXPsM/12f9zI5Yble4BqMi1JBwhd1S
         IC9w==
X-Gm-Message-State: APjAAAX0okQXycnCBoKhEuSXvNkNcYmY/tcq3CuxKCpdihS7C0O2rZ5o
        oRVvAjJcwN0XyRqjcv3Rj/XHuYFcrgw=
X-Google-Smtp-Source: APXvYqwd8Wy9UejCMZQY0P+7uYfmadKSV5vOhnywGcMFhKltfK819yupNBjvQoCQ1b/6nGfDct0ujQ==
X-Received: by 2002:a50:941c:: with SMTP id p28mr3744158eda.103.1562852755782;
        Thu, 11 Jul 2019 06:45:55 -0700 (PDT)
Received: from brauner.io ([185.66.195.251])
        by smtp.gmail.com with ESMTPSA id x21sm1678096edb.0.2019.07.11.06.45.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 06:45:55 -0700 (PDT)
Date:   Thu, 11 Jul 2019 15:45:53 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] clone3 for v5.3
Message-ID: <20190711134552.jvahfwhvaxykbgfl@brauner.io>
References: <20190708150042.11590-1-christian@brauner.io>
 <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
 <20190711053428.ofapcx7nn5xkyru4@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711053428.ofapcx7nn5xkyru4@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 07:34:28AM +0200, Christian Brauner wrote:
> On Wed, Jul 10, 2019 at 10:24:26PM -0700, Linus Torvalds wrote:
> > On Mon, Jul 8, 2019 at 8:05 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > /* Syscall number 435 */
> > > clone3() uses syscall number 435 and is coordinated with pidfd_open() which
> > > uses syscall number 434. I'm not aware of any other syscall targeted for
> > > 5.3 that has chosen the same number.
> > 
> > You say that, and 434/435 would make sense, but that's not what the
> > code I see in the pull request actually does.
> > 
> > It seems to use syscall 436.
> > 
> > I think it's because openat2() is looking to use 435, but I'm a bit
> > nervous about the conflict between the code and your commentary..
> 
> Sorry, that was just me being dumb and forgetting that there was
> close_range() which had a chance of going through Al's tree. So I left a
> hole for it.
> 
> I don't terribly mind if it's 435 or 436. People pointed out you might
> even renumber yourself if something makes more sense to you.

Just in case you prefer pulling from a __rebased__ tree. I prepared one.
It does use syscall number 435 as advertised here and has the merge
conflict I pointed out in the PR resolved:

The following changes since commit 5450e8a316a64cddcbc15f90733ebc78aa736545:

  Merge tag 'pidfd-updates-v5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux (2019-07-10 22:17:21 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/clone3-rebased-v5.3

for you to fetch changes up to 611e04b559151c441deedc79f1e57471c953bda7:

  arch: handle arches who do not yet define clone3 (2019-07-11 14:59:15 +0200)

Christian
