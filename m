Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D16C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC0217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="QPwVNsf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391805AbfEXUB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:01:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39917 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfEXUB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:01:26 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so7164966qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MCwCqfjoZ8d95LiJVDhxA5XYJ+Tj0Dl3KZTdK/joyg=;
        b=QPwVNsf12m0Ku3ysuAaKBpvuJ8a3v8BLq8bmJgIiNhWhchdu4WhWI2Rexbzv1BrOv6
         vHy80gDcR04xvAP1Ui/TbWCdoaksT+uNOFkBVQpnK4esy54HDNjzBP1RSnGq9fm/uI9u
         CbqMvLYx7Tv+AwKwCjKX8gnYXnt3zY0V/pAhrQeC97pXJxyb8VyJ2nCUHwG0Oy8Sf9rg
         hkRl/ADp/emeDS5wlzE/5L/bPxWGmky3EbGtEPeRmWar30IO6KVy39x3QCfwWFMaoOmm
         tFOqNavX3JitsMfMi9ZnllGycKEgnz6qLYs+mNTJ/SQyYUON+YXSeYb/5iFBt+GXIEC1
         ekuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MCwCqfjoZ8d95LiJVDhxA5XYJ+Tj0Dl3KZTdK/joyg=;
        b=nouD51xnz0mTVGtfiOteHGzsCSBj7au9rYUK1CnLp2/4Y92GI2ge51AGtETEO3q9ou
         MNqD7I+SYUL/It2zTi3DyBbySvHa1kYl9QZrBLGDwgF07xv58W2BKOhwdbnCL6QkmpWF
         tn9ZOIIfx2gkybODC+vCpO/NY+2R0PALkUGI7LaqRWIlyDv6cMynV2CeZBSSFcZs2Vwt
         +Zs0D1wvBHm8sJrD5lu6iBHQbGp3jrXS328Hm/mTnUo2hmSA0fxdDvpT44JiNPwxNA4E
         0zh0bRob2KAlUBrNpgqNzlqA1MrjKnfdGlJH2U1MHXSD49OQdYAP2muQruNpaNxZqNdw
         AbmA==
X-Gm-Message-State: APjAAAUHUP8RFQvBG7cVoNFgObwb9jwgTbSZd6d/FWA4Ev383qF0Lw9g
        AHkzgCyC904Sgy58rY6akrGyXM38+fiwxDxRPBIC5g==
X-Google-Smtp-Source: APXvYqwmQ8vdr/LlrWLOpFql9wh2DV/r+PF+HEzE73QWbEFTFSebC6c4U3R9GbbX9W5aU+gRPziPL17BiM5hloLyPHI=
X-Received: by 2002:a0c:d4ee:: with SMTP id y43mr83524858qvh.26.1558728085164;
 Fri, 24 May 2019 13:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com> <4613f54b-b6ba-c9ad-15ca-e43d440b9f63@gmail.com>
In-Reply-To: <4613f54b-b6ba-c9ad-15ca-e43d440b9f63@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 24 May 2019 14:01:14 -0600
Message-ID: <CAD8Lp46s0agX15gSXq_hXc2TFn9v9dfZYi7+j=HuQJdGBK2Hug@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] platform/x86: asus-wmi: Increase input buffer
 size of WMI methods
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:54 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The asus-nb-wmi driver is matched by WMI alias but fails to load on TUF
> Gaming series laptops producing multiple ACPI errors in the kernel log.
>
> The input buffer for WMI method invocation size is 2 dwords, whereas
> 3 are expected by this model.
>
> FX505GM:
> ..
> Method (WMNB, 3, Serialized)
> {
>     P8XH (Zero, 0x11)
>     CreateDWordField (Arg2, Zero, IIA0)
>     CreateDWordField (Arg2, 0x04, IIA1)
>     CreateDWordField (Arg2, 0x08, IIA2)
>     Local0 = (Arg1 & 0xFFFFFFFF)
>     ...
>
> Compare with older K54C:
> ...
> Method (WMNB, 3, NotSerialized)
> {
>     CreateDWordField (Arg2, 0x00, IIA0)
>     CreateDWordField (Arg2, 0x04, IIA1)
>     Local0 = (Arg1 & 0xFFFFFFFF)
>     ...
>
> Increase buffer size to 3 dwords. No negative consequences of this change
> are expected, as the input buffer size is not verified. The original
> function is replaced by a wrapper for a new method passing value 0 for the
> last parameter. The new function will be used to control RGB keyboard
> backlight.
>
> Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>

Reviewed-by: Daniel Drake <drake@endlessm.com>
