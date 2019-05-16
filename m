Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58531C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2973620881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJWuQZyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfEPJ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:56:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43526 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:56:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id z5so2497744lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMDrVnTjQ1immxiYKmdnHO4lUdJFEpb4jOAuuz/w3MM=;
        b=gJWuQZybohtXg5MERpeUsZNOq4RdyG5oC2punG8BCdPmzF+h5sYNnovAC8Tv6c7l6m
         2qSLM6ZtOKMDC4hPhDjycEgDIcomZLJ8EHVQSwAFzBXz93OJ2RzIX8tM82SWkHtExoRf
         oQvvRoSnD9cOp67mw0tqCEtoQQMz0gbw8f9lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMDrVnTjQ1immxiYKmdnHO4lUdJFEpb4jOAuuz/w3MM=;
        b=Zs3zXjO+q/WXotuD/ysRtBdYPOc7RupHlcsp658Qert0xXzzkHpnsjsixdVTFGylFR
         PYLC98Org+yq61mGqx0Y2PaUut1UfhLQ0mGmqST6jRYI2jXZ7qtTErJOhuIALpb6hNZV
         zeFV7WS4zjROS/5sefoFTJft7X+tVU54fvsNlEPbgxs32OMA5rJ9pmp+oT5vDymqyaSz
         P+0k/eg71xoWiFhGDmliWLy/fvIGqYQtCKu4DIml/Xi6F6oN6g+qPlH0ggWpAn13Z5B9
         RaAF2bQLoXIrkcjLXGliVKGOlVbDSK2TBkNGyWpnHeHKRLOQkkhvMBm/HbFsN26towO3
         /LKg==
X-Gm-Message-State: APjAAAWNNMd0KmHiptgo5AVnjwKLSN8nGmIzOJPqErVHblNrxgQzdKkX
        kBlpwViSN5MHXQFFCvLHtI7dbQ38caqI7g==
X-Google-Smtp-Source: APXvYqx3/Nz6excMDouLmNzcLEfvylPi7B/1sr1r+rJY6WwcySTFg9sUsDpUkqT94vRMnPTxN1yREA==
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr23245233ljg.130.1558000604864;
        Thu, 16 May 2019 02:56:44 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d23sm813876ljj.38.2019.05.16.02.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 02:56:43 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id q17so2150048lfo.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 02:56:43 -0700 (PDT)
X-Received: by 2002:a19:cc95:: with SMTP id c143mr23074476lfg.138.1558000603275;
 Thu, 16 May 2019 02:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190412155915.16849-1-stanimir.varbanov@linaro.org>
 <a1807c37-99cf-d1fa-bcb9-67af2935abaf@xs4all.nl> <ca0e2c94-cca9-567f-5376-f302f79f4ba7@linaro.org>
In-Reply-To: <ca0e2c94-cca9-567f-5376-f302f79f4ba7@linaro.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 16 May 2019 18:56:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DBUUAPV0_=thmRBTFqJE+Nd4LZRzZE20rR0D8d7Cjz5g@mail.gmail.com>
Message-ID: <CAAFQd5DBUUAPV0_=thmRBTFqJE+Nd4LZRzZE20rR0D8d7Cjz5g@mail.gmail.com>
Subject: Re: [PATCH v2] media/doc: Allow sizeimage to be set by v4l clients
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:09 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Hans,
>
> On 5/14/19 11:54 AM, Hans Verkuil wrote:
> > Hi Stanimir,
> >
> > On 4/12/19 5:59 PM, Stanimir Varbanov wrote:
> >> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
> >> field description to allow v4l clients to set bigger image size
> >> in case of variable length compressed data.
> >
> > I've been reconsidering this change. The sizeimage value in the format
> > is the minimum size a buffer should have in order to store the data of
> > an image of the width and height as described in the format.
> >
> > But there is nothing that prevents userspace from calling VIDIOC_CREATEBUFS
> > instead of VIDIOC_REQBUFS to allocate larger buffers.
>
> Sometimes CREATEBUFS cannot be implemented for a particular fw/hw.
>
> CC: Tomasz for his opinion.
>

Thanks Stanimir.

Actually, if called at the same point in time as REQBUFS, CREATE_BUFS
doesn't really differ to much, except that it gives more flexibility
for allocating the buffers and that shouldn't depend on any specific
features of hardware or firmware.

Actually, one could even allocate any buffers any time regardless of
hardware/firmware support, but the ability to use such buffers would
actually depend on such.

Perhaps we should just let the drivers return -EBUSY from CREATE_BUFS
if called at the wrong time?

> >
> > So do we really need this change?
> >

Yes, because this has worked like this all the time, but it was just
not documented. Disallowing this would break quite a bit of existing
userspace.

Best regards,
Tomasz

> > The more I think about this, the more uncomfortable I become with this change.
> >
> > Regards,
> >
> >       Hans
> >
>
> <cut>
>
> --
> regards,
> Stan
