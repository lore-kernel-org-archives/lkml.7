Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CC7217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxgvdGX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730726AbfDEKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:23:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34179 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730292AbfDEKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:23:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so3054186pfd.1;
        Fri, 05 Apr 2019 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c/J2FHNL2RG9r3+RRnc/Tl4gg3PBDI5fKZZjdoCOjyQ=;
        b=SxgvdGX211/3mt8PUz104XBZuIHAqnfEEk2WkeR8XArvU5KJx69KG8yWUsKSlWeOFE
         1K90Khz4iqN6Ou3Hw/p/EA6CDz2a6KAaezYkRLE6rPM8cTAE/BlYE7+KpC1U14b52IR1
         vuuCET2wNZ68rcJW01+BX11zBD2FTM2wmk0FiR7dp4MJ2IDfAnG2zqYzndKl6pmznn8s
         fOuG8g1kpR7z8MfdqybTEQs/tWvbaIMXmAVkqdvGQis8V3N+EUvr/mDVDv+kSMrK8Qkl
         iL4SuG/mu+g1B6TN0bf7rwUon/3BACpcYQHfT1zUTbXuyT4dmiY7VyK0FssltIbSNWyC
         wWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c/J2FHNL2RG9r3+RRnc/Tl4gg3PBDI5fKZZjdoCOjyQ=;
        b=bxodFTdU/lEiqCFjIzpireCJckqfUlhTyVjsXroaoWTg4VST6Gl/vceCHt2AauXTfV
         5pqqfaVNaA0089vDWW13iGPqaCq1tEdVXi3xspsk5t/TBSSd+UwOI1cGBhMlIoG5HXcT
         kEIOOB5NuZYjo1/d7g7mm3wlfTi1LGyYw6HmO8YqxbMjE4GOh+8nvQU13g2TfD2g0N9Q
         v9YbjnrOteSIr7d84ETt6d6MWtZDYtattnYAWLoHGmlSm8u73gxCz+7eu8zP+sW928b5
         13a8+/4+SqOHsst43aYejKNjNLBOSDK/DyhrnW52EqVr33BukPTdArnGImF6V75eH6+o
         3ReA==
X-Gm-Message-State: APjAAAU7ta2X0JDHMLgGvWelOv25xeq03ePQB40vk5xHw4BJtOEBtsyU
        VTdYwKM7N2Om6+pqqL2Oe68vQENIf8gHmAFVMAU=
X-Google-Smtp-Source: APXvYqwpHnbM0eLZNcQx1Ztr33J4NRfJMpbY2jlIPOUlbZu4u1vqVi/reRM2YtChEpxyFXgVpBgv/bRNmnNuT0jLdbk=
X-Received: by 2002:a63:1d26:: with SMTP id d38mr10358643pgd.357.1554459833250;
 Fri, 05 Apr 2019 03:23:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:1781:0:0:0:0 with HTTP; Fri, 5 Apr 2019 03:23:52
 -0700 (PDT)
In-Reply-To: <20190404031455.cn4cc5wxbn6izvwe@localhost>
References: <20190404000958.15236-1-siddarajudh@gmail.com> <20190404031455.cn4cc5wxbn6izvwe@localhost>
From:   Siddaraju DH <siddarajudh@gmail.com>
Date:   Fri, 5 Apr 2019 15:53:52 +0530
Message-ID: <CAGtA63dqBVQNzUMphSKTy_jH98YYVaxVAKYpWDFu3eCXJ0-ykQ@mail.gmail.com>
Subject: Re: [PATCH] ptp/ptp_clock.c: Correct input parameter range check
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     john.stultz@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if there are duplicate emails in your inbox. Trying to solve "We
accept plain text only response but the message has HTML subpart"
error from mail delivery subsystem.

Thank you for the response with example Richard.
Agree, it works. So I take back the statement in my commit message
"Since the tv_sec field will be ZERO in this range, the user will not
be able to specify the signedness of adjustment through the tv_sec
field".

Specifying a -1 ns adjustment like
    tv_sec = 0
    tv_nsec = -1
looks pretty straight forward than specifying it like
    tv_sec = -1
    tv_nsec = 999999999.

And the former way of specifying the adjustment is consistent with how
we specify the values for positive adjustments.

So, the question is "why are we blocking -ve number in tv_nsec"? As
you mentioned, end of the day it's sum of tv_sec & tv_nsec.
If there is really an advantage, just to keep things clear, we could
have made tv_nsec/usec as "unsigned long" instead of "long". Right?
For me, it doesn't look good to expect/restrict a signed input to be unsigned.

Thanks,
Siddaraju DH
