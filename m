Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A1C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D155920869
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 03:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMfJpiCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfKGDON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:14:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37552 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfKGDOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 22:14:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id k14so651394eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAfjo+6GX40N8x/qOoAPJLTNhLDPy6SYwK6lSBU1urk=;
        b=YMfJpiCN4Ig8D+LLOBNrepFfMz7Ze5j63f+c9Uw8V5q9niZmdpwGA+CXuQuw5PrWS3
         7dTE+HC+yEBDy3rtNxNpUJeDPn2L8svDkdkUHIxc9CIRoxICSYDdy1kzKdOnOPS2U2cX
         ak6fy7fMi6PIbdJJLXbqqFBQHk80kW0gbEpmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAfjo+6GX40N8x/qOoAPJLTNhLDPy6SYwK6lSBU1urk=;
        b=hv2IvbzmuSTSn8Hjj7X3HHZ1X5o2zHi8InfIzZTaOmRN6y+rjYFj7h8WKSfiRcNhZW
         sEnabxbS67vZKLvv3yZxyTP4XQZvcNl3Gy9/pZGn+TGiMk8HR7aU2HjBZ1ObeStmNvnk
         +IehSxxaOSXMP4tEc+5If1O3C0yYdkrDOqOKmBUUlsLW/LSmw/5uAi/R8btqQS6uGPbR
         OXMzlr0KigNRHQn8rNmPNvqFNhMgAqa8d/RfLfLgEPdHC1LSOzbA2Dd8Z3x0Gd0A1cV6
         uczVGvldyPQfnmbJsEw391kdHXBHuLUVxXNAVOnYj2OV4m+SjzV5ZRz1ny/xRQbd4HtB
         IQnQ==
X-Gm-Message-State: APjAAAWKogiZ2qyAJyRuTL1dgJ4gGfBuMRfIUSvpan7xgG6hUhXYA4iP
        R8AOFtFqBeTKbYD4EdRVhcws8/SQ3fiWuQ==
X-Google-Smtp-Source: APXvYqwlcGhGNxjKpRmK4qM6afv8VQqC6uiGIxGnFYGj1odSAlIwuJMcOvJLp2OJ8C/l+irvBMrSaw==
X-Received: by 2002:a17:906:7e08:: with SMTP id e8mr919980ejr.199.1573096448836;
        Wed, 06 Nov 2019 19:14:08 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id d8sm16585edb.18.2019.11.06.19.14.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:14:08 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id h3so1218864wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 19:14:08 -0800 (PST)
X-Received: by 2002:a5d:4946:: with SMTP id r6mr52152wrs.155.1573096120434;
 Wed, 06 Nov 2019 19:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20191106120132.6876-1-helen.koike@collabora.com>
 <20191106120132.6876-2-helen.koike@collabora.com> <9102bcf8-0279-7972-daff-b15aaf98804d@cisco.com>
 <28cff7ab-ef56-791e-0342-571f64cb9807@collabora.com> <b1a8fa60a3c8922c364a18b0583dab55660f2fb4.camel@collabora.com>
 <c3b03fc7-100d-4c16-f561-b26969d13fea@collabora.com>
In-Reply-To: <c3b03fc7-100d-4c16-f561-b26969d13fea@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 7 Nov 2019 12:08:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AtZ+MiAWVDVkE3PLj-TuwjZd=zg9ozE6P_6bNW_o0oBg@mail.gmail.com>
Message-ID: <CAAFQd5AtZ+MiAWVDVkE3PLj-TuwjZd=zg9ozE6P_6bNW_o0oBg@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] media: videodev2.h, v4l2-ioctl: add rkisp1 meta
 buffer format
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        "Hans Verkuil (hansverk)" <hansverk@cisco.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "eddie.cai.linux@gmail.com" <eddie.cai.linux@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "zyc@rock-chips.com" <zyc@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengsq@rock-chips.com" <zhengsq@rock-chips.com>,
        Jacob Chen <jacob2.chen@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:26 AM Helen Koike <helen.koike@collabora.com> wrote:
>
>
>
> On 11/6/19 11:44 AM, Ezequiel Garcia wrote:
> > Hi Hans, Helen:
> >
> > On Wed, 2019-11-06 at 09:30 -0300, Helen Koike wrote:
> >>
> >> On 11/6/19 10:22 AM, Hans Verkuil (hansverk) wrote:
> >>> On 11/6/19 1:01 PM, Helen Koike wrote:
> >>>> From: Shunqian Zheng <zhengsq@rock-chips.com>
> >>>>
> >>>> Add the Rockchip ISP1 specific processing parameter format
> >>>> V4L2_META_FMT_RK_ISP1_PARAMS and metadata format
> >>>> V4L2_META_FMT_RK_ISP1_STAT_3A for 3A.
> >>>>
> >>>> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> >>>> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> >>>> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> >>>
> >>> I acked this? It is missing documentation for these new formats.
> >>
> >> I think so https://www.spinics.net/lists/linux-rockchip/msg18999.html :)
> >>
> >> I'll update the docs and the fixes you pointed below.
> >>
> >> Thanks.
> >> Helen
> >>
> >>>> [refactored for upstream]
> >>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>>
> >>>> ---
> >>>>
> >>>> Changes in v9:
> >>>> - Add reviewed-by tag from Laurent
> >>>>
> >>>> Changes in v8: None
> >>>> Changes in v7:
> >>>> - s/IPU3/RK_ISP1
> >>>>
> >>>>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
> >>>>  include/uapi/linux/videodev2.h       | 4 ++++
> >>>>  2 files changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>> index 315ac12c3e0a..ade990554caf 100644
> >>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >>>> @@ -1341,6 +1341,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >>>>    case V4L2_META_FMT_UVC:         descr = "UVC Payload Header Metadata"; break;
> >>>>    case V4L2_META_FMT_D4XX:        descr = "Intel D4xx UVC Metadata"; break;
> >>>>    case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
> >>>> +  case V4L2_META_FMT_RK_ISP1_PARAMS:      descr = "Rockchip ISP1 3A params"; break;
> >>>
> >>> params -> Params
> >>>
> >>>> +  case V4L2_META_FMT_RK_ISP1_STAT_3A:     descr = "Rockchip ISP1 3A statistics"; break;
> >>>
> >>> statistics -> Statistics
> >>>
> >>>>
> >>>>    default:
> >>>>            /* Compressed formats */
> >>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> >>>> index f98bbcced8ff..56798b09cd85 100644
> >>>> --- a/include/uapi/linux/videodev2.h
> >>>> +++ b/include/uapi/linux/videodev2.h
> >
> > Can we avoid touching videodev2.h, as we did for the stateless codec pixfmts?
>
> I think it should be part of the uapi, as it is the metadata format used in the video output device.
> I propose to leave it inside drivers/staging/media/rkisp1/uapi/rkisp1-config.h while the driver is in staging,
> then we expose it later with a better documentation too. Make sense?

Makes sense, as it's also what we've done for ipu3, +/- a slightly
different path:
https://elixir.bootlin.com/linux/latest/source/drivers/staging/media/ipu3/include/intel-ipu3.h#L12

We could possibly move the header to include/rockchip-isp1.h to be consistent.

Best regards,
Tomasz

>
> Thanks,
> Helen
>
> >
> > Thanks,
> > Ezequiel
> >
> >>>> @@ -762,6 +762,10 @@ struct v4l2_pix_format {
> >>>>  #define V4L2_META_FMT_D4XX        v4l2_fourcc('D', '4', 'X', 'X') /* D4XX Payload Header metadata */
> >>>>  #define V4L2_META_FMT_VIVID         v4l2_fourcc('V', 'I', 'V', 'D') /* Vivid Metadata */
> >>>>
> >>>> +/* Vendor specific - used for RK_ISP1 camera sub-system */
> >>>> +#define V4L2_META_FMT_RK_ISP1_PARAMS      v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 params */
> >>>> +#define V4L2_META_FMT_RK_ISP1_STAT_3A     v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A statistics */
> >>>> +
> >>>>  /* priv field value to indicates that subsequent fields are valid. */
> >>>>  #define V4L2_PIX_FMT_PRIV_MAGIC           0xfeedcafe
> >>>>
> >>>>
> >>>
> >>> Regards,
> >>>
> >>>     Hans
> >>>
> >
> >
