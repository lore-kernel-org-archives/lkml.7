Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEF1C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876F9208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHtMIDVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfECOG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 10:06:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42657 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfECOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:06:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so6146491eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIkHlNqSnjBvKekWU2vvrbH/hm3F1RI6rjhDUHQ8YbQ=;
        b=JHtMIDVUiritOqCWGomzNEQCggPiA6NeSQ3lGRaP2nhvOANoSP4i/iLCUYXt1kwSFI
         8QyVfDuZBxPieJ17zHM/y0bXd2YeHSymPZVFTyWt8dRxqWVspwQ2Ip/G/I5ZGP4RY0G0
         2AtQKu13MoGMrq0Sdl3l/KIHRU98Rd/86IV7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIkHlNqSnjBvKekWU2vvrbH/hm3F1RI6rjhDUHQ8YbQ=;
        b=M+bpBCCHO3dIcUIK1XO7NVz0NIOetEqVQs62UozSYnLCsdJ3vcOr+L4rLflHf6qQJQ
         naUfKxvYLS9LCdu4EFH3zCPvwjj81Ewor9iv6ByD5zV4y/YUoggutCeJSJHSE1H/Gt5S
         LGwXAT8CVJeaLbprz30Eokn5GNVLaWBJIGRCfX3QH36Iz206ALhpcp1VSF0s6OvntsQS
         ePPUOAP0BH5Qdnk0HRhBmwv8LLq/XmohkthXhATCzxOm2jIApQNvKVAHsPcK8llqpN4n
         Iew85J99WGG4lzCPoZyOArNKAVxxKnqWR43kpKGZjfa9f5Fll0SphQz/LrUfD+ivTAyz
         JvpA==
X-Gm-Message-State: APjAAAUW9q25x5aFK+FJUcWJxEg9VX0x3pAFYdJNKyYn1WCJ13/itxnb
        MLi8wP6jgx7Hr4YL/pd6Uq8DdlJz9bg=
X-Google-Smtp-Source: APXvYqzyWpS/5Lx+o3mCp+vJm5EYQHP3vOAuLxpGxhPe3fn/Ikdq4F+edF4+6GnfOTxPIxkJVHbB/g==
X-Received: by 2002:aa7:c483:: with SMTP id m3mr8739297edq.161.1556892416808;
        Fri, 03 May 2019 07:06:56 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id k37sm617698edb.11.2019.05.03.07.06.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 07:06:54 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id f37so6119011edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 07:06:52 -0700 (PDT)
X-Received: by 2002:a50:9056:: with SMTP id z22mr8689692edz.72.1556892412452;
 Fri, 03 May 2019 07:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190502172700.215737-1-zwisler@google.com> <s5hr29grlz9.wl-tiwai@suse.de>
In-Reply-To: <s5hr29grlz9.wl-tiwai@suse.de>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Fri, 3 May 2019 08:06:40 -0600
X-Gmail-Original-Message-ID: <CAGRrVHxXFSOKFW6Di49OwAEnqvak6W+gkpA_TB3ULGe2PHjZ-w@mail.gmail.com>
Message-ID: <CAGRrVHxXFSOKFW6Di49OwAEnqvak6W+gkpA_TB3ULGe2PHjZ-w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update git tree for sound entries
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 2:17 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 02 May 2019 19:27:00 +0200,
> Ross Zwisler wrote:
> >
> > Several sound related entries in MAINTAINERS refer to the old git tree
> > at "git://git.alsa-project.org/alsa-kernel.git".  This is no longer used
> > for development, and Takashi Iwai's kernel.org tree is used instead.
> >
> > Signed-off-by: Ross Zwisler <zwisler@google.com>
>
> Ross, would you like to keep @chromium.org as your author address
> while the sign-off is with @google.com?  It's OK and some people even
> prefer giving different addresses, but it's often an overlook.  So,
> just for confirmation.

Hi Takashi,

It's fine to leave the author address as @chromium.org with the
sign-off @google.com.  Thank you for checking.

- Ross
