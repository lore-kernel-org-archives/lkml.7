Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074EDC47404
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF03821882
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VtlLw5mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfI3BUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:20:35 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47051 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 21:20:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id 89so1360433oth.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7lhhDWqLRaHzDV4+JuIW5Uv7scUKAboBApuaT0a5VU=;
        b=VtlLw5mNFFrYi6ADq9HYtll04EJgXA+RVcaVtDCnLg3vjwV98cH1i9h6gFt8Re5MRw
         xhUNHJIqxtfZQ29Hy6RqxMzB+j2JcOiYg+7qGB/4jlHkPuasRNjcb0qDnaa4U3l49Cll
         ljVv5KzeVaRDWHI8mzOhgFshktX8b6SF6foHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7lhhDWqLRaHzDV4+JuIW5Uv7scUKAboBApuaT0a5VU=;
        b=LS8qskeeFDzWBLaSJkIaRud2efx+9T0NAOqOOqnYgzenr1RKE6wX4lobTtBz3WOul+
         UeOJa9+d2Wyp3xpwMo+MnT9Ir9Nx5HRYmbioGo+LhgeCR7YDnTCSWZHvAy8C5JgzcHPh
         0i8U1Kd7l08Aw1fPnJCKS2KeWjiu35B0BEYU068NDRgQpfiaSGMZbQ0kPL5Z59NgG1/T
         FchJK9FNEDNEKS/3GOelQ06kof70+3fF/DCPVMCnWCjVQRkEecrBn7TiVM1GDXi5FO2H
         MyBb0Q42xY0V1JE7JX/DCdttVrsXIlNcAzR654cuaDN5cZ42fa8TDaJ+eKn9jdDnk8bm
         XUjg==
X-Gm-Message-State: APjAAAVg67I3RqJqlfVzoZj3JErX9Q3ZVDjoA1eGvQ2aAcyQM1r+peqo
        /T7PunB4+d2EPiYYobXEAFms/iJ3jjYprp2dIk2g/LAD
X-Google-Smtp-Source: APXvYqy/CPhKN5fL4uAv7g4JDTVp2IW0Yw5AYCWAcAkd4NZf7eNDpWH5bxMFvBSQgNFk1KZRzg/UCykWl1cheWXp2Yk=
X-Received: by 2002:a9d:39a5:: with SMTP id y34mr12735987otb.100.1569806433654;
 Sun, 29 Sep 2019 18:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190927092319.v3.1.Ie6289f437ae533d7fcaddfcee9202f0e92c6b2b9@changeid>
In-Reply-To: <20190927092319.v3.1.Ie6289f437ae533d7fcaddfcee9202f0e92c6b2b9@changeid>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 29 Sep 2019 19:20:21 -0600
Message-ID: <CAPnjgZ1EW1t4r2gVeU0L9sJZ-eBD438hWtfxaR4EYTVAv_41Lw@mail.gmail.com>
Subject: Re: [PATCH v3] patman: Use the Change-Id, version, and prefix in the Message-Id
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Joel Fernandes <joelaf@google.com>, groeck@chromium.org,
        Johannes Berg <johannes@sipsolutions.net>,
        lk <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 at 10:25, Douglas Anderson <dianders@chromium.org> wrote:
>
> As per the centithread on ksummit-discuss [1], there are folks who
> feel that if a Change-Id is present in a developer's local commit that
> said Change-Id could be interesting to include in upstream posts.
> Specifically if two commits are posted with the same Change-Id there's
> a reasonable chance that they are either the same commit or a newer
> version of the same commit.  Specifically this is because that's how
> gerrit has trained people to work.
>
> There is much angst about Change-Id in upstream Linux, but one thing
> that seems safe and non-controversial is to include the Change-Id as
> part of the string of crud that makes up a Message-Id.
>
> Let's give that a try.
>
> In theory (if there is enough adoption) this could help a tool more
> reliably find various versions of a commit.  This actually might work
> pretty well for U-Boot where (I believe) quite a number of developers
> use patman, so there could be critical mass (assuming that enough of
> these people also use a git hook that adds Change-Id to their
> commits).  I was able to find this git hook by searching for "gerrit
> change id git hook" in my favorite search engine.
>
> In theory one could imagine something like this could be integrated
> into other tools, possibly even git-send-email.  Getting it into
> patman seems like a sane first step, though.
>
> NOTE: this patch is being posted using a patman containing this patch,
> so you should be able to see the Message-Id of this patch and see that
> it contains my local Change-Id, which ends in 2b9 if you want to
> check.
>
> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2019-August/006739.html
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v3:
> - Allow faking the time of Message-Id for testing (testBasic)
> - Add skip_blank for Change-Id (testBasic).
> - Check the Message-Id in testBasic.

Applied to u-boot-dm/next, thanks!

>
> Changes in v2:
> - Add a "v" before the version part of the Message-Id
> - Reorder the parts of the Message-Id as per Johannes.
>
>  tools/patman/README         |  8 ++++-
>  tools/patman/commit.py      |  3 ++
>  tools/patman/patchstream.py | 64 +++++++++++++++++++++++++++++++++++--
>  tools/patman/test.py        | 15 +++++++--
>  4 files changed, 85 insertions(+), 5 deletions(-)
