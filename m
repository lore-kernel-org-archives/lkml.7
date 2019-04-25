Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513E620651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556209283;
	bh=eKc5a7nYo7l+VygNnYqr9GRSzHx7PmTC52K0esyFDZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GzXO5Y0nABf0dxCsZecWAo/awTwEmHhgg42TOy1hCYAOlzjreAzYRhz8tBEHUnXhO
	 kGGaYs84puXwIlmjLmOSuVeqiqd5CYUxHSTWFBnI8xnc1plPetFjwzTKlVhMEGBItS
	 ejfO0Knp8YGZXcrxY/u9DAoqGkyBm9bCL+lV7O5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfDYQVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:21:21 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:34537 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfDYQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:21:20 -0400
Received: by mail-lf1-f49.google.com with SMTP id h5so247601lfm.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDOKxfRFTpYLt4v4rvtbLyH8OHWGeJYXaVHAsiid0U4=;
        b=b7oe+SMwOPoIjwYg+opPKHEslSXlS7xUtHzkGg2Wfas2AOHW7dqK7u7L36SDg8fhve
         oNE0V5DAE+2z3cwDhKENXVlSc6OuOkDIu/hyYthA3fOy/fXAz1ZoVorwahkSf8eufaDO
         aMXo+vrrotdB329xlN530nGUIHojyGlYHY07k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDOKxfRFTpYLt4v4rvtbLyH8OHWGeJYXaVHAsiid0U4=;
        b=Yci3FM7sQHunV+rcAUeq5UAdtOkio4DJ9PDEaW2OJfS1ww2ApDkQhs7V2JaLAV7XCB
         n9Lujb33idVE6WqhiG0kpbIoSlhH8RrnH8VUhag42ozuvfR0dY6ta+foz9ihw8JLfXhe
         J/flUYXGVPgN4efkCX99BhnCdgppAM6q/SdtXEy8M20zMDtYFjnzbA9atKm+rHr7N4dr
         t7BDsVW3X7RXxI9bKaJEz7ap2VVDBkBnQC0bXz9WQTVr60eqvomuxKBUK0c9+Q1Z9W9V
         0+HN6Ljv6wsJiZJ+FYaCKK2ysT0fzIEguLe9mqgqQtQk0cmJHSjGFHN2q8adwDEpARud
         hRjA==
X-Gm-Message-State: APjAAAWCFebMeN8+KXMTzddajH9SoJnyR7Y6MZ3I3VENoqKMT730BFbw
        dE1gxLx2Ln0+4apm8Erb5y1tjl7Kkq8=
X-Google-Smtp-Source: APXvYqxIwTMCyPGQbkKNwGhieXvUcno7kvvi907Ue1IZ47zGGL9NBVbQ+0UqR+KhmLX/3g/zPCAHTw==
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr21255377lfa.79.1556209278583;
        Thu, 25 Apr 2019 09:21:18 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a28sm6313419lfk.54.2019.04.25.09.21.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 09:21:17 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id o16so214277lfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:21:17 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr22512786lfn.62.1556209277188;
 Thu, 25 Apr 2019 09:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <1556181403-3881-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1556181403-3881-1-git-send-email-guoren@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 09:21:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
Message-ID: <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixes for v5.1-rc7
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 1:36 AM <guoren@kernel.org> wrote:
>
> Here are the patches which made on 5.1-rc6 and all are tested in our
> buildroot gitlab CI:

This really looks like it should come in the next merge window, not during rc7.

You had absolutely zero csky updates during the merge window, you
can't then magically come up with "look, here's 1300 lines of fixes"
during the late rc series.

Re-send when the merge window opens.

                   Linus
