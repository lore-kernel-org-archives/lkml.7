Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F33C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E612184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxRbC/c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfC2Ro5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:44:57 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2Ro5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:44:57 -0400
Received: by mail-io1-f67.google.com with SMTP id x7so2445718ioh.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSoSoTEwEz2C2mx0S0YjQ+QHcEZ43OMJjIGT79L9SGc=;
        b=WxRbC/c5DraIonP/lh9kajBPKoezkd+RRHdP+xtP4nbP6CDzlOanp5YsAq1VF8Vu4D
         R1rkRPJ3bs4ym1HWgOEMC0pUYRcbhtIURh5jsuIO2cJC626WOfdTI7nADs0DQtm2QcjQ
         xaVg0pvBXm0JUVo7Z4N/h0xk1ag5bp4Vd3zIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSoSoTEwEz2C2mx0S0YjQ+QHcEZ43OMJjIGT79L9SGc=;
        b=ZcqkCOuADhv0OlUEvbip1Fo0XTD0QF2T44RK+XuAw4fVhz3tajGnQUfYDRd5JLMIPS
         gBkM+PekLHoCksQTAHZcArP10wO8RxarP+T41ZZmiKdWh7FOoSxeFygMz+c+nFmCXqA1
         AKueKDq8VnCPl9+tdnVY9X+NaPWe/EobfV3DmCv/Nxm7se6NCX+PU08TpHcffm0Gux9M
         +6aIj3zLh9SZGsdcNR2/8VJzs2DQpUudNuCEJyriJUzeMYnVB9JAIW/1otZ9RUOZ5UL6
         yJr9YexfpT+fMJu69BSrIny18DwoNaRN1i6elihI0AFaMim/pnVUROCo2gOLPvbBRE4Z
         1mUA==
X-Gm-Message-State: APjAAAW34rULFJOj4toyyri4Fi417QJ9hfBDTLg9dsO2ZO+YUqCugSyF
        x0Bcd6QhBVoOcqst+Wu59VF+e5V/o/+2jixa+VPEDQ==
X-Google-Smtp-Source: APXvYqwS8JP2UOecHM7zy5qjCUBCj93fVblh/4fZqNj9UZoBDp2auPgK/lc3c55XhIamnAieKFuG124tLpEk1jplkt8=
X-Received: by 2002:a6b:b3c4:: with SMTP id c187mr34322273iof.198.1553881496301;
 Fri, 29 Mar 2019 10:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2ut9MjVuvOxZuVNBnZiFvz9Y2XBgCPSQRrdM=6w+p4Rv1Q@mail.gmail.com>
 <CAPUE2uvhfwwt31=AMKvH-kPGYZsjpGqbetGJ46sBU4owFPRgsg@mail.gmail.com> <af561dfd-ae1d-16a6-ed2b-b3876486e5e0@collabora.com>
In-Reply-To: <af561dfd-ae1d-16a6-ed2b-b3876486e5e0@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 29 Mar 2019 10:44:45 -0700
Message-ID: <CAPUE2uti=fketJ4vJw34et_y9L_gsEUwXNDdjg0sG8Z27ir1Hg@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: cros: Update EC protocol to match current EC code
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Eric,
I will split the v2 patch. It seems adding the BIT() change caused
patchwork to not process the patch correctly:
https://lore.kernel.org/patchwork/patch/1055029/ has the end of the
patch, https://lore.kernel.org/patchwork/patch/1055029/mbox/ has the
beginning.
I am also fixing the codec error.
Gwendal.

On Fri, Mar 29, 2019 at 6:36 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> After fix my problems manually ...
>
> On 28/3/19 22:52, Gwendal Grignou wrote:
> > Chromebook Embedded Controller protocol is defined in the kernel at
> > cros_ec_commands.h.
> > The source of trust for the EC protocol is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >
> > Only needed changes have been picked up from this file to the kernel
> > include file leading to gaps between the upstream version and what the
> > latest ECs can do.
> >
> > Fill the gaps to ease future integrations. Changes from the original
> > files is header/footer for license and include files for alignment.
> >
> > Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes in v3:
> > - No changes, resending
> >
> > Changes in v2:
> > - Replace 1 << with BIT()
> > - Check checkpatch warning/errors are outside kernel scope.
> > - Update .h with latest changes.
> >
> >  include/linux/mfd/cros_ec_commands.h | 3723 +++++++++++++++++++++-----
> >  1 file changed, 2992 insertions(+), 731 deletions(-)
> >
> > diff --git a/include/linux/mfd/cros_ec_commands.h
> > b/include/linux/mfd/cros_ec_commands.h
> > index fc91082d4c35..5c4764e3db6f 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
>
> [snip]
>
> >
> >  /*
> > - * For subcommand EC_CODEC_GET_GAIN.
> > + * Entering Verified Boot Mode Command
> > + * Default mode is VBOOT_MODE_NORMAL if EC did not receive this command.
> > + * Valid Modes are: normal, developer, and recovery.
> >   */
> > -struct ec_response_codec_gain {
> > -     uint8_t left;
> > -     uint8_t right;
> > -} __packed;
>
> This causes a build problem in mainline as ec_response_codec_gain is used in
> sound/soc/codecs/cros_ec_codec.c file, I don't see this struct anymore.
>
> Apart from this the patch looks good to me.
>
> Thanks,
>  Enric
