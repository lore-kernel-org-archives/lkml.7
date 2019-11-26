Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325D2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E42075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 11:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfKZLef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 06:34:35 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:33713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfKZLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 06:34:34 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MplPf-1i1Mpg0g4T-00qA97; Tue, 26 Nov 2019 12:34:33 +0100
Received: by mail-qv1-f44.google.com with SMTP id d3so7085023qvs.11;
        Tue, 26 Nov 2019 03:34:32 -0800 (PST)
X-Gm-Message-State: APjAAAU+pH51GEjIlhW6eo4VkhwYVMC1FqNj7q87+1Kq5+e39faVEjNz
        Aj6Lir6edEJywp+2W5/FVJX6XaPkCU+40ZXtdYI=
X-Google-Smtp-Source: APXvYqyP0ubV+wbmtUnKnlLA9Dg95JHEfh5NUlQS2Rfnof25MN29f8oIJkRplALMOpCBO0IcGYxWRhEARVn65P2Yuig=
X-Received: by 2002:a05:6214:811:: with SMTP id df17mr15089086qvb.197.1574768071947;
 Tue, 26 Nov 2019 03:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20191111203835.2260382-1-arnd@arndb.de> <20191111203835.2260382-3-arnd@arndb.de>
 <00fea162-508a-b6e1-84ba-1472a94f6945@xs4all.nl>
In-Reply-To: <00fea162-508a-b6e1-84ba-1472a94f6945@xs4all.nl>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Nov 2019 12:34:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dhruU1k9XtVHZsfmTxt+jL5Pf8jhT77+vce5p=h9U8w@mail.gmail.com>
Message-ID: <CAK8P3a3dhruU1k9XtVHZsfmTxt+jL5Pf8jhT77+vce5p=h9U8w@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] media: v4l2: abstract timeval handling in v4l2_buffer
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B8Mm1ukgYdV+UTz5ZKRGto5znAMBY5Yzedr8KxBSXwWDyRZmsyV
 s5EswmhenIXGdXlggmKO7s5D2k9vr9b/efZT6a1B5PfwdXmbhfCsp7VnIJcWUDBmZ7NNm0n
 EBG1JSNKueZEaQZGxkqILWGH5dHwGfi23+K48Bf2ABaVywyPw0YrQoc/aZSjM1efO8hBNb3
 vBs0ShRfPRuaCBqahmS7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eG/ROzqDxMQ=:suFoLOANhTR+3jeZTwNp94
 mZfBfkPYQwicWWAj9VsTDIzOk5+EUDrrt2QFadEDK8ohz5cOuH2WbFdMOmy1+bJcEu/PX95ST
 mn7SIMLnRhOLWAlJvviK9MaQ3xCd0s4i8mZqJrzs3G0aNz65tAr2IasFhvYY6Gkcu/+R4BkG3
 /LuXoiqxx+EjVMMRb201/cX8LulSG1uC9gcK7cwOZOeRitFuVC0DoF6Gn7u83IhnROr5y1ZC3
 WzAXwKY2X1Va2J56dUke3gmQ8B80fJg0vsu5LXo/KerLRi3/5Fg0iPbXYHCnKlhMFPbFZJoY5
 NXu5cMazlTJQsQ3zbsr+37Vtk8MaeW0XlDFH/d3xfTz6bloZDUcPAgKz7Wae9xcBrSYgNzKaB
 nLmEaKEbQouBj523WgmG+O5wL02t3SecOYHx/zY0sGBLkO7Iv4WZF4AfWewnyr0/60kuS+ong
 BvJIF7q9keqaUnx6eLOLS8JbmpZYAepoGNrFrzpZhRkJ3EEhGSJPIn4FvVHKyyOvZkffJ5c5i
 7fd4DBmDiJAaVly0G4P62/qET0FpAOO0OLkb14m1rRVrZeIEqXQaj164FsvcWgTbabwsHw6cF
 a+q+8GokLbEihtivvP6jMg4DOxF1JRgvfq7dff8XBpf1B/+FAeyxgCIKZZ5wUSLdNHC1JixFY
 5uDtudquWhZH+xPthMdeUFnO5Y46IyMf8KXq0F2bqPVW6DloMF5xF60qTGAP8SZYRwedJCBZR
 dQwNndDT92ms7h8dm6hPnkq6rYId4OFJIXzbMzEdbSI6POrHqO7Cx0GpV4p7pYhFXWHEdfT78
 o8SZ0MY+5T+rnJzK9s31TFTTKikfwtUYjWlr6mS/YPfHQsSSznTgs+Af64v3jSAuppnSLJ7zI
 pDPqBiAJ+X904gJepheA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 4:52 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 11/11/19 9:38 PM, Arnd Bergmann wrote:
> > As a preparation for adding 64-bit time_t support in the uapi,
> > change the drivers to no longer care about the format of the
> > timestamp field in struct v4l2_buffer.
> >
> > The v4l2_timeval_to_ns() function is no longer needed in the
> > kernel after this, but there may be userspace code relying on
> > it because it is part of the uapi header.
>
> There is indeed userspace code that relies on this.

Ok, good to know. I rephrased the changelog text as

The v4l2_timeval_to_ns() function is no longer needed in the
kernel after this, but there is userspace code relying on
it to be part of the uapi header.

> >
> > +static inline u64 v4l2_buffer_get_timestamp(const struct v4l2_buffer *buf)
> > +{
> > +     return buf->timestamp.tv_sec * NSEC_PER_SEC +
> > +            (u32)buf->timestamp.tv_usec * NSEC_PER_USEC;
>
> Why the (u32) cast?

Simple question, long answer:

on 32-bit architectures, the tv_usec member may be 32-bit wide plus
padding in user space when interpreted as a regular 'struct timeval',
but the kernel implementation now sees it as a 64-bit member,
with half of it being possibly uninitialized user space data.

The 32-bit cast avoids that uninitialized data and ensures user space
passing garbage in the upper half gets ignored, as it has to be on 32-bit
user space.

On 64-bit native user space, the tv_usec field is always 64 bit wide,
so this is a change in behavior for denormalized timeval data
with tv_usec > U32_MAX, but the current behavior does not appear
worth preserving either.

The correct way would probably be to return an error for
 tv_usec >USEC_PER_SEC, but as the code never did that, this
would risk a regression for user space that relies on passing
invalid timestamps without getting an error.

> > +static inline void v4l2_buffer_set_timestamp(struct v4l2_buffer *buf,
> > +                                          u64 timestamp)
> > +{
> > +     struct timespec64 ts = ns_to_timespec64(timestamp);
> > +
> > +     buf->timestamp.tv_sec  = ts.tv_sec;
> > +     buf->timestamp.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
> > +}
> > +
>
> This does not belong in the public header. This is kernel specific,

Note: this is not the uapi header but the in-kernel one.

> so media/v4l2-common.h would be a good place.

Ok, sounds good. I wasn't sure where to put it, and ended up
with include/linux/videodev2.h as the best replacement for
include/uapi/linux/videodev2.h, changed it to
include/media/v4l2-common.h now.

       Arnd
