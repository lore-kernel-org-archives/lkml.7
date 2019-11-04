Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2FACA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E507B217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572866515;
	bh=96Xpoc/uVtwx5sks7uBs9fZALQDX0cp/me08MYObkJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KfhAQ6F7uYmGvAYK45WZov2IzU/LuuhSeEeqnItZST8I5yTkedqV4froBheju8qtS
	 IYS66qOSdaKYyDxrJnT8GP7r8CYntLDDkN+vQBGEaY3JjnfY6cXpHfT9WuvuFAP2h1
	 XorVQmDySg4xTN0yvoD9dNZ/PDyupyuZ1jKpZykU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfKDLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfKDLVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:21:53 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61EB217F4;
        Mon,  4 Nov 2019 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572866513;
        bh=96Xpoc/uVtwx5sks7uBs9fZALQDX0cp/me08MYObkJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2EULUqB+KxT0HyLmrdPk/Fh6pSP/c44XKkaKgR3i1HcrMFqYqqRkWAo1d0yTty1Qp
         m/woenT/dbIA/s4RzQMqPyVOUFzaUglk0m0a86SDM4FNWt2iJm5qDr/Z8PQk+QHDU7
         pzvZqrFAGD93PIY8ZR18CNJ5q4PxBPfisSP8QCbI=
Received: by mail-lj1-f176.google.com with SMTP id t5so17170369ljk.0;
        Mon, 04 Nov 2019 03:21:52 -0800 (PST)
X-Gm-Message-State: APjAAAWMVL0s+TzjUV3EBkX3zViU4NoWsqPzY6KiHgn5g5/SQmdA59B8
        ZnVHQC7A9ZTLMCqeSoeZg3ZX4waJLqE0WE8gmhQ=
X-Google-Smtp-Source: APXvYqwrByhfSz1Og4orpYlVbmqQ7yQvvFLxd2RumxXWW7lAgaRhOaTIdoH5HsDhLj5+/kJI93Ld4rWw6nXcBaH06Nc=
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr14516275lji.175.1572866511030;
 Mon, 04 Nov 2019 03:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20191101112509.29723-1-ribalda@kernel.org> <20191101112509.29723-4-ribalda@kernel.org>
 <31815641-550c-88ab-c037-2e743cea59b3@xs4all.nl>
In-Reply-To: <31815641-550c-88ab-c037-2e743cea59b3@xs4all.nl>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Mon, 4 Nov 2019 12:21:33 +0100
X-Gmail-Original-Message-ID: <CAPybu_3DQbmuamHmTXWnF15B1tzPzf1Sh_YJe6VS-Uk8z81q1Q@mail.gmail.com>
Message-ID: <CAPybu_3DQbmuamHmTXWnF15B1tzPzf1Sh_YJe6VS-Uk8z81q1Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] v4l2-ctl: Support setting V4L2_CTRL_TYPE_AREA controls
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans

Sure I will fix this. Shall I resend it once you have updated the
headers on v4l-utils?

Best regards

On Mon, Nov 4, 2019 at 10:41 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 11/1/19 12:25 PM, Ricardo Ribalda Delgado wrote:
> > $ v4l2-ctl  -d /dev/video1  -c area=123123x233
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
> > ---
> >  utils/v4l2-ctl/v4l2-ctl-common.cpp | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/utils/v4l2-ctl/v4l2-ctl-common.cpp b/utils/v4l2-ctl/v4l2-ctl-common.cpp
> > index 95339561..676b05e0 100644
> > --- a/utils/v4l2-ctl/v4l2-ctl-common.cpp
> > +++ b/utils/v4l2-ctl/v4l2-ctl-common.cpp
> > @@ -973,6 +973,10 @@ void common_set(cv4l_fd &_fd)
> >                                       strncpy(ctrl.string, iter->second.c_str(), qc.maximum);
> >                                       ctrl.string[qc.maximum] = 0;
> >                                       break;
> > +                             case V4L2_CTRL_TYPE_AREA:
> > +                                     sscanf(iter->second.c_str(), "%dx%d",
>
> Use %ux%u since these are unsigned values.
>
> Regards,
>
>         Hans
>
> > +                                            &ctrl.p_area->width, &ctrl.p_area->height);
> > +                                     break;
> >                               default:
> >                                       fprintf(stderr, "%s: unsupported payload type\n",
> >                                                       qc.name);
> >
>
