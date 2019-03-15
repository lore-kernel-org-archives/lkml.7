Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D18218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552687525;
	bh=/dwYMtZNojuciEZtYVhSa0op80b+1ysFEJisjYx8Cuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bnyuDEZMas3AK9fImzd1w+JM9RiXpBYZhTTFoeaDGCKWS9tYUwG2KQF3MoBvQsBFA
	 DYh+DvFtrQTyG5HmpScQiqGq2rvJLk5opoBq4g/us4SasENxWzRx865yH2+fi4WqQY
	 hSPftw5CP8jZljmgXqMjasNu7flj9pBWADoYPya8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCOWFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:05:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35492 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfCOWFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:05:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id t13so9241740lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPowlvMhOrE2iPnrm0qQxZAvItkJZclhKDhFCcnt+90=;
        b=IiU2Rhr/MEJxJ9FOhUSnw11Py1r4GVRnd1EUacGLuGcK+UGBOjnQsOIyyZ/Si3NuVi
         QuuD49ZXNKxVBIzTDzuLhZPzD7YgJDrOFnIEtrAK6dIJM3qVS3qyEdTJCS7IzFHLbxU7
         t/LSPAz7dZ5jyyL1ycJQJH5Q8J+PiC7ZjJqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPowlvMhOrE2iPnrm0qQxZAvItkJZclhKDhFCcnt+90=;
        b=eVwdO4I2KkJZYngo37EoHnEb/BWymcRxXZ6dV+h9vi10Don/df9zvbbh/8prSQHieG
         q0eCDYB/LcaqEBUMITotvuzDnQJsVhvmx8EnqpoCM95vRZAOIJVt1g9/tncth3Npv6Tp
         U9cnzwUzndCmE8Q7ziUpmXUKIq9NpBB8ZUG0Si+rmuBK50wD5GDrY9JOIBOaPI2jQ1oE
         ODFHyLc67lC4q28wjGMjOzOmJtOAl5kBnA6l+HI+zfzSpwj0NHHG7H6UdQupKfsGiycn
         mogXTtOoFUrjWL2uGmABmk8D5/m4XqyCn0oKKTRThvXnZTQyeTGi1cPXsOcRXZTmgVMh
         iwYQ==
X-Gm-Message-State: APjAAAWVc9ssYXnpN6KP915FJRFrEp+vvJLu6+UXrTDh5rR/G/sYLPp2
        w0Aj1R+kta+NR339bQhJ8YkhnImsAN0=
X-Google-Smtp-Source: APXvYqwLBQZ2bYkKBtp12NmbqOkT1XDgMd5oMprJbjKbRtIvmkEabsZQfNs1Z28V+6sCbaxzGDPHmw==
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr3424673ljb.182.1552687521333;
        Fri, 15 Mar 2019 15:05:21 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id h125sm642501lfh.67.2019.03.15.15.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 15:05:20 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id z25so9233205ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 15:05:20 -0700 (PDT)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr3284600lji.2.1552687519873;
 Fri, 15 Mar 2019 15:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <31705653.NnsrL61LRB@blindfold> <CAFLxGvy54Fa0Dr9jbqvv2utSi3WvCusAHbYreJ1C=wg2bWtPRg@mail.gmail.com>
In-Reply-To: <CAFLxGvy54Fa0Dr9jbqvv2utSi3WvCusAHbYreJ1C=wg2bWtPRg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Mar 2019 15:05:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfc=JP7JAz0DKbQkrsvTYeAypjp_a0i13tMuD6Yk9szA@mail.gmail.com>
Message-ID: <CAHk-=whfc=JP7JAz0DKbQkrsvTYeAypjp_a0i13tMuD6Yk9szA@mail.gmail.com>
Subject: Re: [GIT PULL] UML updates for 5.1-rc1
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 3:01 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> *kind ping* to make sure this PR is not lost. :-)
> I guess you skipped this one too after the git.infradead.org outage.

Right you are. Thanks for the ping,

                Linus
