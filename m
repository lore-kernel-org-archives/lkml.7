Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A79C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B67207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8DyC4SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfLIQwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:52:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42607 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:52:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so13251784edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zb0O7/LwKYH143X+6l5E3Fj6uEuU7EkNQVWfYFUfj4=;
        b=R8DyC4SJif5fVWBO524oVJpk1bTByjLg6rffPOe2CObHTVQVLs8DMD98fhCfTkxXrm
         BiRW/sMbj/zdF620Xt+OkKmi1VBpO6s+xM1T4sw4dAYBk9+7JEIv/XENB5TOfxqnVPTE
         QaiZFvFZu6tlZF+g3knX9LOGpEz+pNCD2OWFY15bNrsWCWWvRbWu4iuxBPMKshjCBjel
         1Dld7PWw/Bmr8tCJmX4Tdzx/cyD3ZzYrCvJKQKSdi3onCGroZNXxZLwUELqRS5CoSHVN
         2WV6O4JuMZc8f5S3saRx3gg/10fDV778lTPEEF7XWuHR7ROba6NcuHwrlSBDehdb3nAB
         L1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zb0O7/LwKYH143X+6l5E3Fj6uEuU7EkNQVWfYFUfj4=;
        b=WMR5wWjRoVYp8ymsjAFa2ARKbroXeFstiiitSW48c4l9PK0MkuOR0GVrTPIYXtX7ZU
         0jvMheA+O+6xbZqySuVryC6cP5labb8iRVfds3cyQUZC7mdd5DXLu30naBpfJK9B9KSC
         lV7ou/+N083c+uZF3kUWMTVTXuY5i7aCP0xYa2oVyOJkeBkxvF0SHUNvuyKMOA8/sSIo
         Mp3gPEoro6Zh1cl/pXwyVmpJLgXYMIITisY/A5GjTj+30TSXj8eD3Sh6qvjt6syVu4yE
         OvcS1LrdWaKZROjwDE87MlzpDXY0+vg5G4oEGcGII8WD/j+Yqwlamirt9t1Psb9Dw4f0
         sfkw==
X-Gm-Message-State: APjAAAVHO4erK5bCU5dy1UE70TgIoMsTTyfSxqjX/6kDSqOu8/r9q0NJ
        vYFDq2Y9zQcGizcxt1NznXSSsfYR8DMphAXoKDY=
X-Google-Smtp-Source: APXvYqyNsx38P1d/a+3EYY+Ki8O7R5tdU+IpHxRUnoVyPmu4I5pFVmX+12pzttLM5wSIGAzNEVL5CINVLP+IlewF0wI=
X-Received: by 2002:a05:6402:1a36:: with SMTP id be22mr33403291edb.202.1575910360149;
 Mon, 09 Dec 2019 08:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20191206075209.18068-1-hslester96@gmail.com> <20191209162417.GD5483@sirena.org.uk>
In-Reply-To: <20191209162417.GD5483@sirena.org.uk>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 10 Dec 2019 00:52:30 +0800
Message-ID: <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in
 remove and fix probe failure
To:     Mark Brown <broonie@kernel.org>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 12:24 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Dec 06, 2019 at 03:52:09PM +0800, Chuhong Yuan wrote:
> > The driver forgets to call regulator_bulk_disable() in remove like that
> > in probe failure.
> > Besides, some failed branches in probe do not handle failure correctly.
> > Add the missed call and revise wrong direct returns to fix it.
>
> Same issue with runtime PM here.
>
> Also please submit one patch per change, each with a clear changelog, as
> covered in SubmittingPatches.  This makes it much easier to review
> things since it's easier to tell if the patch does what it was intended
> to do.  When splitting patches up git gui can be helpful, you can stage
> and unstage individual lines by right clicking on them.

I'm sorry that I didn't notice this problem and these patches should be merged
into a series.

I have a question that what if CONFIG_PM is not defined?
Since I have met runtime PM before in the patch
a31eda65ba21 ("net: fec: fix clock count mis-match").
I learned there that in some cases CONFIG_PM is not defined so runtime PM
cannot take effect.
Therefore, undo operations should still exist in remove functions.

Regards,
Chuhong
