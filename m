Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C19D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEhisnPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfDXTlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:41:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54037 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDXTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:41:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 26so288239wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eeu0VdWqrZ6e5bSepj8FvMYq/eoETKJmYH05R9Lv9TY=;
        b=iEhisnPKZ03OhRojrf3cjSN7zDEW4FrDT/DL+INz8tZNk+FgyxN/X8G8b0oTVkq7cU
         mv33ggxtkq0IV0wOloCdUdNJsZwVxtxQKo43aaovXTHN6+4aigKRch1TjHMsyeVRMGAS
         3L0nB+XKp+7RFCZU7jiiofw/5eIqN5xr8YkGM45ft6CmkAL23oS0QMQ5slkWARMrU5mS
         owl+e5uB6NGun+88qpiGCJ/n9e3gTo65mkYn1v58pKFzKewG/js+RJN3z66YJLsQf+IO
         JJSszhjhluay5f6/Jo9/7JwrcUt0gkD4/hiAljSzVTlw12j7bs81gudVcorPuyk4iQ1O
         EcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eeu0VdWqrZ6e5bSepj8FvMYq/eoETKJmYH05R9Lv9TY=;
        b=MX9WbbWfM33enGpOajLeFGtLkO5tnIPDw1oQCEepFE3ZRfBPy/Kuw6XWfGzEmMzymh
         Q5vsdT7MC6tLzSn/QlEm8Nwmv6qBpYyDAmTZOqgW1mJDhD7EREzJDcKiYLiQ7Y6+gO5m
         hETj15MhzBAD1TzFdYcEDvAkq0D9oQZTiW2nw/zUyW+tELItkeAMHX4KUL56TzNa3lsY
         ZFRVS0rbn1F+VgXgsau1P+bXLuQ3T12+OGrcN8cBBghiBzFDFxoz3SyK52gkfLp197yB
         xuXAr/iVjVDmDQchjzNRED7CnB4XUNm7uhxouCtIVkdAPFQT4M2p7Dh6N57dSHH6O9y6
         zaxg==
X-Gm-Message-State: APjAAAW8V/whJAIDKZPi4BiTJqYOF0SL0SlBlQWj9WhkweS1OBOq/Iya
        TrPExX0cqCRuEJYv8r79L+RKFIu3l8HHtZn+1NhXzA==
X-Google-Smtp-Source: APXvYqzMPYOI/UcdRqvu9XnNcNDX7crKpCAhmcSP5LsMA0L+LI9hDUGzBL7sk0aySleP7+zlpBoG3tHTx2LbCp8jw7Y=
X-Received: by 2002:a1c:9691:: with SMTP id y139mr518954wmd.64.1556134862977;
 Wed, 24 Apr 2019 12:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org> <20190424171333.GA21290@ravnborg.org>
In-Reply-To: <20190424171333.GA21290@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 12:40:51 -0700
Message-ID: <CALAqxLVWf5MYm+gh3JsdCidzBp4XFMM-LeAnVMykmCtP7g9W0w@mail.gmail.com>
Subject: Re: [PATCH 00/25] drm: Kirin driver cleanups to prep for Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        YiPing Xu <xuyiping@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:13 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi John.
>
> On Tue, Apr 23, 2019 at 04:20:31PM -0700, John Stultz wrote:
> > This patchset contains one fix (in the front, so its easier to
> > eventually backport), and a series of changes from YiPing to
> > refactor the kirin drm driver so that it can be used on both
> > kirin620 based devices (like the original HiKey board) as well
> > as kirin960 based devices (like the HiKey960 board).
> >
> > The full kirin960 drm support is still being refactored, but as
> > this base kirin rework was getting to be substantial, I wanted
> > to send out the first chunk for some initial review, so that the
> > review burden wasn't overwhelming.
> I have been through all 25 patches and it triggered a few minor
> comments here and there.
> I know nothing about the hisilicon driver but based on the fact
> that I know nothing about the driver you can give them all
> a (smallish)
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> I trust your judgement to decide the feedback you want to address and
> what to ignore.

Thanks again for your time and thoughts here! I really appreciate it!

> One request:
> Could you please in a follow-up patch kill the use of drmP.h.
> We want to get rid of it one day and three fewer users are one
> small step towards this goal.

I'll take a swing at this. Thanks!
-john
