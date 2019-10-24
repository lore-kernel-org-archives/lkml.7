Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CCCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3B21A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571952615;
	bh=e00/yHSlXvXqqf/JB2YJn64yA5+CxFA09Oq6zHURRsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q7ZOBh9gToV+Pa9bhJ6W7i0X/iDpaeGLn67a5A+nn3p0I8I4naKod5KEefO2nT3OW
	 5WqiKpI4uV8yeiJL+C/ZAclDkTWm8X8ztj4ggNWhSepI/FWYe9NzlfOrIqH+3GK0hH
	 9FY2JX0JA4TdWhF+SWGYIrCPfO+JnAtB6XCreFcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbfJXVaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 17:30:14 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38676 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfJXVaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 17:30:13 -0400
Received: by mail-lf1-f68.google.com with SMTP id q28so17082999lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=G+CKE+0sNMbBuosjchwhgzz8NQwfbV/8kKBYcW1zgIA+wCHZXB0W4xnrddKNkrujly
         nBXQf8TMFFxtwDaqAlubm1WQBu/DIP2jq0ClHTeKxpnxD8j4n3vqHGpl41RLHFrD0jXc
         jfdzDY5G/0JxiPvAj8Pc7cihC14c7Kl2f6hiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5FP/voiQdxeaQU3Va8HH5cRZmi1OHTMwBKcRrrOo6E=;
        b=h7A0jEY+aNfAfJ8RCmlZK4neNBVBlJ/+iBd3dpCfmjrZerBvc4pJ/PgVD+YqsiaZhp
         yO7xp1Plxyyw34Do5GAz1Yjt01kZ9EEklsv2MXK3eehzRzNwXjO7fpd055At759178wO
         01B9wKLLCCgeC13iVTlHgSSuk+zhaEFfdWz9w3tciaEwEKZxTdAGaGAhClac/0bcFIOI
         rPzrdyD20SMuuJqjsF5fQoEeXREDIjB1X7fn6I3SRx0kPQciq2NXtZn/yfiEFLi672Wf
         4edVD9FaxkQgWZXaLRTyU5oFcPxIKF1RDtNIHlYgLgfngfZijuQf7tkmYJJpMM86x//e
         Q8Pg==
X-Gm-Message-State: APjAAAVgEdH7QI9s9QtXDhIUvNrz0qWQ/lRy0NMFRp5Q+/VSKsBSAorz
        HkzeLGBsFPYHcbmshJGCpOI2Q+fSXnkCTQ==
X-Google-Smtp-Source: APXvYqxTeYRNDiiFxgFPogFWQ+89fYv2PckFtDlKHrNfp2BhUH5pTla3BE1u6aVeN7d2V9WOPSq74g==
X-Received: by 2002:a19:ac01:: with SMTP id g1mr188110lfc.141.1571952610274;
        Thu, 24 Oct 2019 14:30:10 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id b141sm12566315lfg.67.2019.10.24.14.30.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id y3so257407ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 14:30:08 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3303284ljp.133.1571952607809;
 Thu, 24 Oct 2019 14:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <30394.1571936252@warthog.procyon.org.uk>
In-Reply-To: <30394.1571936252@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Oct 2019 17:29:51 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Message-ID: <CAHk-=wiMho2AhcTWC3-3zGK7639XL9UT=AheMXY0pxGHDACn6g@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:57 PM David Howells <dhowells@redhat.com> wrote:
>
> pipe: Add fsync() support
>
> The keyrings testsuite needs the ability to wait for all the outstanding
> notifications in the queue to have been processed so that it can then go
> through them to find out whether the notifications it expected have been
> emitted.

Can't you just do

    ioctl(fd, FIONREAD, &count);

in a loop instead? "No paperwork. Just sprinkle some msleep() crack on
him, and let's get out of here"

               Linus
