Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30AD20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pNZr09HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfCHSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:19:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46731 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:19:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so14709904pfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9E1RtucpClX9JPnyrfI3RA4M8vk12wnyerrbZa60sRs=;
        b=pNZr09HNIdo7AX9hMQYIvtdFBT48wqf91GR51LH5R8rDaii6S3rSHrsTMrCe6US368
         90JAV6d61SL+33ZsOexztnSTLxiQXesUVkKYA9oYWWAvx3CW46TTNY2/uYGxTJ7LYt8v
         lAB+e6dFYX26RqFyru5YzSQqD38Yn6IJv3dOSvc08nYHEMdP0BSoff2CrDmZabj6BCNT
         KLVqztXq+hxJfWCBlTU21j3chfPuIVhrcOhvIywa/UtcRagDLBy5yAvHJZs2JbjYl5fs
         3htQQLF6AkPJb2w1U03VfGewVldIlx6nmO7TFmsx3wi1SCVm/OZRNP6kJMriBpzv3906
         r+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9E1RtucpClX9JPnyrfI3RA4M8vk12wnyerrbZa60sRs=;
        b=umBYbMEXfSiPmNk09DDS8XiV76iBi53ouVmvvEHETPB9vWYjLDDNi8+Tq9Uui/adZH
         i+NZWhMvtfMZ9Y9dHvdeel6M06De7CeRLpwFdbODjQ+aIt3I5iCf5SNwZJHnjltIBFXy
         oPkwwjXHXF9Md7A2DvDPo8tEsSubh4ZTFGL4lMXfBB64mmqwfbh+87mFwkQQe7A3JWDH
         oeWhW5SUgmLduy3Oi2S1LI1atOx8UnllAhvoeFDRjPalfbTu36trJk/h744lKNk40e2h
         7JaKfsVFnPdFhf1/dqD0dBbJEsT/zoundtsU12tatCdq2Lio8UceYHNrhFVjTvykzd7q
         2dhQ==
X-Gm-Message-State: APjAAAUKNxgLiAm7f5pQAipVVFsujH0nOmRsRHsE9Bte4dPZaoZmXBQd
        xYmc10OniE0/Iv4IRAn1cBc2wiUG8QyOwEeeQ1t2kw==
X-Google-Smtp-Source: APXvYqzbzEGvbYuV0AUuxw55zYZ2lEhmUAqI5s0kHD27vnm02bXQDBME5zE3SnEvGNlymdGSHAHxihdS77x/2hws2vk=
X-Received: by 2002:a17:902:42d:: with SMTP id 42mr20700362ple.229.1552069145988;
 Fri, 08 Mar 2019 10:19:05 -0800 (PST)
MIME-Version: 1.0
References: <20190307223628.21270-1-natechancellor@gmail.com> <20190308085831.6c4gorhjxg62tkea@pengutronix.de>
In-Reply-To: <20190308085831.6c4gorhjxg62tkea@pengutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 10:18:54 -0800
Message-ID: <CAKwvOdnV2LE0-Q5-QaBrmajr=re7mmvTr3v3v+9SbLSO+V9+kQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 12:58 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Nathan,
>
> the copy of my mail sent to clang-built-linux@googlegroups.com was not
> accepted. (So I dropped this address from the recipients for this
> reply.) Probably this list isn't open for non-members to post to. This
> is a bit annoying, so I ask you to either fix that or don't add this
> address to the recipients of your posts where non-members might answer.

Ah, sorry, I did not realize that it would annoy people like this when
I set it up.  We've email vger post master to get us set up with a
list.  No response yet.
--=20
Thanks,
~Nick Desaulniers
