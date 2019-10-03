Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC31C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B42520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 06:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E1EqupMg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfJCGzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 02:55:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38863 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJCGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 02:55:44 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so3071254iom.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 23:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bU7eEWTqDVJAzVoRac0rizP1WsKz1rzNUUO0iZVJmNQ=;
        b=E1EqupMg730dahrp+6/NFq2OamGjeULfhizL/aUqK1IMHs6JmoAZkeUxeqF1uwf+ZL
         eyQt8lAC4bfdpSCJComxGlNEy5LOrSZvqwfEcLDKooentutky+aiizYXAhwx2FYshOvy
         7A+i90ioBBDKtqAGAwHtOaaD7o5I8h+y5zez8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bU7eEWTqDVJAzVoRac0rizP1WsKz1rzNUUO0iZVJmNQ=;
        b=T6JEFIP7Mmnh/xlflFpEEBq8vIT/cC2JjnqUueFuaBXxQWrBWogJSRYTpY9s8GMTc5
         rGsE1x0i6VG8LVvUuOF+i94SITbu0oULe7pFIN7fjvoRNHEYJPNCAQ3GwhW8PcjA0Q72
         Yum3RjFJVaXPsmKNvICX0cZC0wa2Fap5HM3vZkM9Zc8p91mTQLOXLaNqgxnWJ/drjgDO
         a0LR3+PzLt/A6JxysjB3buBSa2r4Gag9RMuPH9BIQ3xGknGd0Ec8ZCN2EHbvGG/SZuAG
         vYGBXl8qa3Ydx+e1pI0AtJpDeqr56W2VGszldMFvCCxv05nIubkdhhoMDieFhxHOg55C
         654g==
X-Gm-Message-State: APjAAAVEAu5RAV7UaIyt++00Q0pVitrCP0QTUytEL7jlNWRB/6zT9DQG
        thCVtr3HVLACt4aLTErqEP9RiRkD5SF6qSv5d6Rj1g==
X-Google-Smtp-Source: APXvYqw/JqRqbQzudnEFtsSEFiBBZMcwV+TKk69UO/Ob6QYkQJ0sHL6YVsqN1DKW1le5yW1GE5acz24BJ2zaF85Yy5g=
X-Received: by 2002:a5d:89da:: with SMTP id a26mr6650973iot.61.1570085743213;
 Wed, 02 Oct 2019 23:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191003064527.15128-1-jagan@amarulasolutions.com>
 <20191003064527.15128-2-jagan@amarulasolutions.com> <DB2FB6E5-E4B5-40F4-A05F-9A2303FCA1AE@aosc.io>
In-Reply-To: <DB2FB6E5-E4B5-40F4-A05F-9A2303FCA1AE@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Oct 2019 12:25:32 +0530
Message-ID: <CAMty3ZDZBctSRcgfMTc3moTzrJZXL_S-tKKNKyOa4jUKT8rW+Q@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v11 1/7] drm/sun4i: dsi: Fix TCON DRQ
 set bits
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 12:21 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
>
> =E4=BA=8E 2019=E5=B9=B410=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
2:45:21, Jagan Teki <jagan@amarulasolutions.com> =E5=86=99=E5=88=B0:
> >The LCD timing definitions between Linux DRM vs Allwinner are
> >different,
> >below diagram shows this clear differences.
> >
> >           Active                 Front           Sync           Back
> >           Region                 Porch                          Porch
> ><-----------------------><----------------><--------------><------------=
-->
> >  //////////////////////|
> > ////////////////////// |
> >//////////////////////  |..................
> >................
> >                                           ________________
> ><----- [hv]display ----->
> ><------------- [hv]sync_start ------------>
> ><--------------------- [hv]sync_end ---------------------->
> ><-------------------------------- [hv]total
> >------------------------------>
> >
> ><----- lcd_[xy] -------->                <- lcd_[hv]spw ->
> >                                         <---------- lcd_[hv]bp --------=
->
> ><-------------------------------- lcd_[hv]t
> >------------------------------>
> >
> >The DSI driver misinterpreted the hbp term from the BSP code to refer
> >only to the backporch, when in fact it was backporch + sync. Thus the
> >driver incorrectly used the horizontal front porch plus sync in its
> >calculation of the DRQ set bit value, when it should not have included
> >the sync timing.
> >
> >Including additional sync timings leads to flip_done timed out as:
>
> I don't think attaching this error infomation is useful at all.

Since the error would be common irrespective of panels and it would
trigger from dsi controller, I thought this would be useful for
reference. I have had this conversation in previous version changes,
so I have added it. let me know if have any comments.
