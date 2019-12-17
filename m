Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ABEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA0020716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHiLswZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfLQUGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:06:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43791 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQUGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:06:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so15077595oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgcM3vc0ZSfajVYBW3jpsISkfHzXaQbZ2787YmHbQ6c=;
        b=OHiLswZP/NI5ZTrjsWcf3N5aSKGxVSU34yUgdVuDV2cftv6HYQb+PLBoymqeOqMxP+
         D5qc+EN9YFueg4RiLwD5M+WsD25yBv6JC7A2P4j5UBLRNiMDiaugwfbqdw/CWFyahPXZ
         zZ8oRgJZeNBXStl7HTfdf9Ae9hcvYGh6pDVjj9q4vbtdwiB+pUf2zAWf6HfcwFd+jUrv
         aIoTsEkx1MK6nomOBiRH89FZ+BDIQipj+7pHfvIElupDBtRecWPv9H0Dbj+4fjlDgXVo
         6rwKF/g2otXn/wIqzB8DPrJuQX7MhbURYk21VUSkrEMZiFxCp+57WbaPVi2KLoYF+1QO
         2r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgcM3vc0ZSfajVYBW3jpsISkfHzXaQbZ2787YmHbQ6c=;
        b=Yg9Kr1IisBvZpEhbU5fhl5Rns5U6grk4Nxu6ztgNs0BCoaUhnijck0YbljdKubG5dJ
         +uxmfsNBub/6wmLbee+qXB58SDaFdcVFnhEPm6eeJVrSEd+pfaPy5Gn4gTl+PgSYMDSl
         ksmVrBtPEu68QHW7ejZlqg/KQ8IpQwKdliTykBFE1VUhCd89cFOV42mwHZmC8hwBpK/s
         CGvWSlh58imdKOWmKHUSKSnBUNjqQZl7U0nMQjnSvoex0UFNNz4S0NPLPLd3GIMjJFNy
         gdBzs1KAltCk6HjPF0BIJvMm/boVeM4h88wospr1t/cPnXdLIa9tOoSA5gQgeua7duRU
         802Q==
X-Gm-Message-State: APjAAAUEZ5VZzHPgc9LFwWnmcjYQEpPBOtnsv70F5T0DoPvabwni70qV
        2VNsY0JHqgiILCRloefLJCJunXzrPJTAcXHJ5q/tMw==
X-Google-Smtp-Source: APXvYqz1EBmRWccePNkjo39wUIVivMFlFzt6nqIufy0Ymh7XqrHk183/c4rF9JFEi2L6arjokRalY8S3b7lsAdfkhV8=
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr39578362otp.275.1576613162751;
 Tue, 17 Dec 2019 12:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com> <20191217193755.GA4075755@kroah.com>
In-Reply-To: <20191217193755.GA4075755@kroah.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Tue, 17 Dec 2019 12:05:51 -0800
Message-ID: <CAJmaN=kxg3O+dss2ccfFAP85wAce2a5KS+4ednt71JHOe7CvqQ@mail.gmail.com>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 17, 2019 at 11:33:38AM -0800, Jesse Barnes wrote:
> > Still debugging, but this causes a panic in console_on_rootfs() when we try
> > to dup the fds for stderr and stdout.  Probably because in my config I have
> > VT and framebuffer console disabled?
> > Reverting 8243186f0cc7c57cf9d6a110cd7315c44e3e0be8
> > and b49a733d684e0096340b93e9dfd471f0e3ddc06d worked around it for now...
>
> Should already be fixed in Linus's tree.

Arg sorry for the html mail.  I see the reverts now.

Thanks,
Jesse
