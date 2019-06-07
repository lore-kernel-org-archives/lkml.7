Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BF9C468BD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E682B2067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559925669;
	bh=4qVWoZokjDgBZvYJ5lk1cJVg3BvI5JKoufcaQXGGA04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jm5s6fSRZc09JW9+mFtDOiuEqdQMPT5XDr5Cajekg/36Vj6+1djPa9BGMAaSD/tGQ
	 /zhkggaPCw/84z6xhIij1KqvGutq9Xf1Nre17HeBsoA8fdPMd75hDc2n1CMQPqtX/G
	 R2rpyx4DHAKklN1e0zW839+OspM3HdbZW5b7K2hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbfFGQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:41:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41647 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfFGQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:41:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so2311594lji.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hjS06kksmvXKKACQCnPiaKbtP2R8cOVn1m0gpdsIsk=;
        b=OZMxqdUWGyNBlPYl3DcxShmsv9iCdGBuWVI8mpGyqO8IwRynjBT9fPkhnJaQggffy5
         rmXtERqcYDfoLeheyZW8mY4tYKc5XVa0lHT+e7AVmf5v4Zq68YwtRhbLe0i713O8d/rD
         Ko4pfrfcY7S8q1zPpMy8L6jrtTFnSd+HzC884=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hjS06kksmvXKKACQCnPiaKbtP2R8cOVn1m0gpdsIsk=;
        b=LntgGC4q89eEVh9MPcHFblklnOsV0z/Y7ihr65WiQmaj+cQmuBN/arG9q0EML7BGTE
         q3OoophJAtytR2sXYeDJaoUz/0sNBGHkx6XtyjW8fjvMZ4Fdsb/uHtaBeTgCZFb/5d7R
         TaZTTuFdR7MT76FOIQ+Yvaz+Ilsb8HazXRfwOEFn6bTKxZPTb3e6Vkvrs5TE1nf/NfPF
         bFsyuMTcZER3j9+J4MEuXM0BdbT/kf33dshOG6XFyBHywOL9s6bSb6th2AGVX65x15y6
         PzZAPYoFDNfofBAvZ5Jp3CDzVcVipKkFqVknJnzZPgbvc6Qv0AwOjluY/NMTq/OQnOie
         5B3g==
X-Gm-Message-State: APjAAAWpFsD+g6F4VnqGWr//8hJBVOlKBrJUjT7nrsgDjWkTgE3YuyTf
        Rl01VHIvEswjOe238tvfdXmjkyat+Pg=
X-Google-Smtp-Source: APXvYqyefIcHnyiN1VpkeyxT8KwMDjs/hdJK2WObBEz+xZ5HT+i1FSAaCrygtFCqceSaOxKRLaXNwA==
X-Received: by 2002:a2e:9ed6:: with SMTP id h22mr14699907ljk.29.1559925665010;
        Fri, 07 Jun 2019 09:41:05 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v17sm533307ljg.36.2019.06.07.09.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 09:41:04 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y13so2097812lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 09:41:04 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr27015971lfn.52.1559925663867;
 Fri, 07 Jun 2019 09:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <de770db0-5451-c57f-df52-75114ad290e9@canonical.com>
In-Reply-To: <de770db0-5451-c57f-df52-75114ad290e9@canonical.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 09:40:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=io4rX2qzupdd4XdYy6okMx5jjzEwXe_UvLQgLsSUFA@mail.gmail.com>
Message-ID: <CAHk-=wg=io4rX2qzupdd4XdYy6okMx5jjzEwXe_UvLQgLsSUFA@mail.gmail.com>
Subject: Re: [GIT PULL] apparmor bug fixes for v5.3-rc4
To:     John Johansen <john.johansen@canonical.com>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 5:39 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> Can you please pull the following bug fixes for apparmor

No I can not.

You have for some completely unrecognizable reason rebased OTHER PEOPLES WORK.

There are two new apparmor commits in there, but there are also 89
random rebased patches from the networking tree.

What is going with all the security subsystem issues? Why does this
garbage keep on happening, and why are the security trees doing this
when everybody else has learnt.

DO NOT REBASE. NOT EVER. YOU CLEARLY DO NOT KNOW WHAT YOU ARE DOING.
"git rebase" and "git merge" are not commands you should ever EVER
EVER use, because you don't seem to understand what they do.

I'm seriously fed up with all the security subsystem by now. This is
not ok. It's not even one person, it seems to be a common issue where
people do completely odd things that make zero sense.

                   Linus
