Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46970213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552429126;
	bh=B5C0SFdr+ig+Ro9gsuxeBKthQVKuSWX4/BvQ22yCcPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wJ1O/H+tELqXsoqKlT+KsOiChOHNvK2z2hDfmfwW8yUoqy+2dlnHNQRPQKeJ7iXg4
	 6N/gHfgYN/eY5dovK6JOItqbC8aYC8gd7j9lDN0c1vNnBA+kznlWRXdoA/EWAfRPZL
	 d1sjytM9BeFFErRP8Bf0mHcNuuURr7SwJFND+bIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCLWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:18:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41286 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfCLWSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:18:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id z25so3744530ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oCK2bBSjJElYeA1ihvX+ozoLOyZerfA8IGPq/A1/T8=;
        b=CcX/NJUYUS/PzcPQOmiJRxxxzx/7kD3/OhTdlkZnRb1Vh50+bufppcz9JU2p+vYgHe
         +ZtmO07B+HqiItCnN5M5YmSLKD8uuYq1sQqpY7QSphTwMPi3q1HdVJvVTmjYJHoXDoGy
         eas/9slYLGfAP6p2puKcid6amGx5qo9Av+A1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oCK2bBSjJElYeA1ihvX+ozoLOyZerfA8IGPq/A1/T8=;
        b=HLu4u7UG+cFsvrJFpXwK6Duu3jBWP3wtDei1RfBYIu0omlU17p5jua+fAvkQZ0yH0j
         zPBVbWTDw6McPtF5UlEDZWqB4PIKrgvQUhDpfquJwFndFHJj1n6rkjIAMAMoJkQXmZkA
         G33cu1h1mqWhKV+3iN0vDJ/Vo8/PzoJmhn5KFy/P5wh2p/KflgECbLT2uWGIGB/ymkyw
         jb3l4PUXskpOImbmdj720+37FIOT3uDzHQb/48pz0COLXpXGTmdDG/kp7BE6xAYuroYC
         1cpa+yDAeXyVXdwvXJRw69Sh64WsQjav5y6l6bXYtPuXpzV6mbxp+OUWDN610JRcugMz
         Vqlw==
X-Gm-Message-State: APjAAAVzTWYhs+nENvPjykwP4azTbi/NR9KvIVu5loVACViXekcMoJuB
        pgrubxC6ug1NYECfKEZ2e+fQKmUSNpE=
X-Google-Smtp-Source: APXvYqwKyFSkydkCYBGwFthqOCgZ1U7yogjvp51iVSSrm/iVgRhL3w0/YOQVyjjYA6D60f8CHEZZ3w==
X-Received: by 2002:a2e:2419:: with SMTP id k25mr20692133ljk.38.1552429121217;
        Tue, 12 Mar 2019 15:18:41 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z29sm1082064lfg.52.2019.03.12.15.18.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 15:18:40 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t13so3768895lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:18:40 -0700 (PDT)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr13942668lji.2.1552429119879;
 Tue, 12 Mar 2019 15:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <6283638.XALati16HY@blindfold>
In-Reply-To: <6283638.XALati16HY@blindfold>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Mar 2019 15:18:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixZBzR5nbPZ3Y1=VahyVDsqVZhRfRhewJybx2-yA_FEQ@mail.gmail.com>
Message-ID: <CAHk-=wixZBzR5nbPZ3Y1=VahyVDsqVZhRfRhewJybx2-yA_FEQ@mail.gmail.com>
Subject: Re: [GIT PULL] UBI/UBIFS updates for 5.1-rc1
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 8:13 AM Richard Weinberger <richard@nod.at> wrote:
>
>   git://git.infradead.org/linux-ubifs.git tags/upstream-5.1-rc1

Pulling this thing is taking forever for me. I can _ping_ the site,
but the "git pull" has been hanging for a while.

I really tjhink people need to stop using infradead.org for git
hosting. It really is annoyingly slow.

If you don't have a kernel.org account, use github or gitlab or
something. But use something that isn't excruciatingly slow, ok?

I don't know _why_ infradead.org is so slow, and I don't much care.

It doesn't seem to be due to network issues, because quick look at
things, there's no real network traffic, it's just waiting for the
server to start sending git object information. And git tends to be
good about network bandwidth anyway. But git *does* require some
reasonable server-side resources, and they seem to be lacking in this
case.

                Linus
