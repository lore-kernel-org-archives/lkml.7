Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDE5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC5320848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558114817;
	bh=T/8wXz9l9u+fj9UrhPR8AAU6pfF/744FskxDqKU6LJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UGkgxvp3wgMs3H1XqUww3O6qa7LZWtQ3Et+7P1qa6VGnD74uJNnkxT58QsClzMc8z
	 TZayHezkJMUX7hPGDoZdHyWaXffSzYT9qRgvy8FnjuuX40eSE7KNyXA31BK/gLI7aW
	 PFU+VbKHLNlDyJoeY0/piOE9gtELTif5cRoQaf2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfEQRkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:40:16 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:43344 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfEQRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:40:16 -0400
Received: by mail-lf1-f49.google.com with SMTP id u27so5899575lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47UMyUJ+CBYPd1QpBMevlO6cvjKR6YwFCa/M8mKYz3o=;
        b=FBIXKm9hakIxDw4DTZlObC695gPR+rkW9asB4sOkO6J3LDvqrKyN7XuepIETwrTJCv
         ZGawi2ZDJVjQg2C2GJCQRfrfY7D+xe0IV0uS4qtTo25UFA2fZroV6zVfxQ/266OBybNE
         xEztCgDlBKLuYs7p74e+KFnHSnd+ZMi/pm2Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47UMyUJ+CBYPd1QpBMevlO6cvjKR6YwFCa/M8mKYz3o=;
        b=AqEyWIfn/ia21atVA7TsCSYXJ9GN7kFnMBWo0nqTgD49yIlTn2UxJUE22imZFntR+E
         42T6+3FPytzkt9UC9HCC3NGa7ojOGiJq3X7GwVduuTorlZXRcIQ9oXldtFxIcqjDVnib
         fSjfGcHEgbym5jiSUnDtkCeAqzCUHAuBrQRIL8fpA7W/YNy1KtUGCYcVaWU0av5k0oX4
         XWyUo6ODL6wtZiqQODbP+XIWngEyEEvkK1qElHcNs66yWIGky7pDEJt6huXX7xbbXqo5
         Ogrda/QmRIbmzuoe13ipevT5QP6hFYLjL3jz3nUkDxpAB1vTrLGeQupQxSLsVnV4XpIB
         L/Qg==
X-Gm-Message-State: APjAAAUaXDG1mXvH+zrT58mO4VVHUoV3AhEsxrXGPi9VRMdcvqYMQhAH
        FTPDHqbJesqp/MgZ+4FJh+3Mm2pYP0U=
X-Google-Smtp-Source: APXvYqxfzTEitWoXk8vJvR6Su2zYDH/vd7/rWl0ox4vhgEP3gfaHurn9JObpc+3/xt133OcNzcIDKw==
X-Received: by 2002:a05:6512:6c:: with SMTP id i12mr9905390lfo.130.1558114813940;
        Fri, 17 May 2019 10:40:13 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id f9sm1605046ljf.69.2019.05.17.10.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 10:40:13 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y19so5917767lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:40:12 -0700 (PDT)
X-Received: by 2002:a19:f501:: with SMTP id j1mr8047212lfb.156.1558114812565;
 Fri, 17 May 2019 10:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <1558065576-21115-1-git-send-email-pbonzini@redhat.com>
 <20190517062214.GA127599@archlinux-epyc> <a8170dab-7c7d-de3d-9461-9eecb73026ff@redhat.com>
In-Reply-To: <a8170dab-7c7d-de3d-9461-9eecb73026ff@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 May 2019 10:39:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1DYeY9WHP7cf-Ka-HP=6xfqrUj=FCYUCwox5vo2ANKw@mail.gmail.com>
Message-ID: <CAHk-=wg1DYeY9WHP7cf-Ka-HP=6xfqrUj=FCYUCwox5vo2ANKw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 5.2 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 4:49 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Ouch, thanks. :/  I'll send a new pull request as soon as I finish
> testing the change you suggested.

I see that you added the trivial fix to things and re-tagged using the
same tag name. I've pulled it,

                  Linus
