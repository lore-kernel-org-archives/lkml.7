Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2098BC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52652053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="p8tjgyT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfHZXby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:31:54 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:31527 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfHZXbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1566862312; x=1598398312;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=kM9Cua1Vg8/QCuVf7JXsyJ3DROfw4JpvuudbKKgV8nw=;
  b=p8tjgyT0lz06lcVIToZ0mdcX/2ueafffnYZGyT+OieParPuAwMB5IKFw
   SjsXJQRUEIfTSO7vcJPL3dY1Ezq0ZWeAo2Y65l7dY9eLQhze04PuSlDEo
   HUs+bAGm7HuwmYl3wPA9u1GZ9krHyBCoQqeN2kuvH2jHZcAle5P34yHp2
   dWMkbKpnwobsCVT8l1jyWvlxqXMmvYg58bxJh2TOp5WDKIDxb/mRZ1Dek
   FLlgQOZhJBmLqlVZpDebh5W5vWEqRBV/NA9zk5dg4EKrpzZ8Pmnjcn2dm
   YhJ/LOCM8kpB2bk1HEfLcuwQ1/xDTOlA5RFrS4Ibws2AAB0VGXWXOUKrM
   w==;
IronPort-SDR: LiLPvJEN93fOxYAYKuC4pOodMneGufyljNSEj/q62ZPs1Olx85l40V/HhWOU/UQ5dKvYHqrcX2
 o/DGtR4SB6VxyuUOxoY8fPAwc310TwnCwKOl2Ig46lW/3vKHmYmw445LHA08Y9RhONEGvEqCPV
 70OEduIaT9sf7ACfDg/otZw3iY6rpxR1gPq5+GUrNuiT70mAxez8ZAX+VzcR6ADn7RqCBul47S
 u8VTm0jqVNvQTR0hFOZE0V9h55sNzGqe3ecdJGBenL/cEL7wDIz/0Y65N3N8D3OaiIEqo/tnMz
 wqo=
IronPort-PHdr: =?us-ascii?q?9a23=3AqGX4+BRFJJcCWF4O/linAExZRNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa69YxGN2/xhgRfzUJnB7Loc0qyK6vqmADFdqszd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAiooQnLq8UbgYtvJqkvxh?=
 =?us-ascii?q?bGv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/XrJgcJskq1UvBOhpwR+w4HKZoGVKOF+db7Zcd8DWG?=
 =?us-ascii?q?ZNQtpdWylHD4ihbYUAEvABMP5XoInzpVQArRWwCwqxCu3x1jBFnWP20bEg3u?=
 =?us-ascii?q?g9DQ3KwA4tEtQTu3rUttX1M6ISXPi3w6nJzDTDb+5W2TDg44fLchAuu/CMVq?=
 =?us-ascii?q?93fMvRyEgvFxnKjlSMpYD5MT6YzfkNvHSB7+Z6S+2glnMnphh3rzOyxckskp?=
 =?us-ascii?q?HEipwJxl3A7yl0w4Y4KcelREN6Y9OoCplduzycOoBrWM0tWXtotzw/yrAevJ?=
 =?us-ascii?q?67ezUFx4o/yh7EbvyHb5CI4hX+VOaNOTt4hGxqeLa4hxuq9Eiv0Oz8Vs2t3F?=
 =?us-ascii?q?ZOoCpJj8DAtn4P2hDO8MSHRfx9/kCu2TaLyQ/f8P1LIUcxlabDKp4hxKA/lo?=
 =?us-ascii?q?YLvEjdAiP7nF/6gayWe0k+5+Sl6ubqbq/kq5OBL4N0jxvxMqUqmsyxG+Q4NQ?=
 =?us-ascii?q?0OUnCb+OW91L3s50z5TKlWgvA4iaTZrYzVJd4BqqGnHgBVz54v6wyjADe+zN?=
 =?us-ascii?q?QYgX4HIUpBeBKGiYjpJl7PLOn7DfihmVSslilkx/TdM73/DZXCMGLDnK3ifb?=
 =?us-ascii?q?lj8U5czhQ8zdRF65JTELEBL6G7ZkiklNXeFVcHPha33ufjQIF9yI4EWn+OBo?=
 =?us-ascii?q?eJK//btVvO4OZ5cMeWY4pAiTfvK+Uir8zuhH5xzU4PfaCohcNMQG2zBLJrL1?=
 =?us-ascii?q?jPMimkucsIDWpf5ll2d+ftklDXFGcLP3s=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2G3CwA3a2RdgEenVdFlHgEGBwaBZ4J?=
 =?us-ascii?q?ARYEFKoQhg0qLPoIPgjKRQIFkhTsBCAEBAQ4bFAEBgQSDOwKCaCM4EwIKAQE?=
 =?us-ascii?q?FAQEBAQEGBAEBAhABAQkNCQgnhTYMgjopAYFLXz4BAQEDEhEEUhALCwMKAgI?=
 =?us-ascii?q?fBwICIhIBBQEcBhMIGoMBggqeJ4EDPIskfzODd4RoAQgMgUkSeiiLcoIXg24?=
 =?us-ascii?q?1PoJIhQeCWASBLgEBAZQ/lXkBBgIBggwUhmqFNIglG4IybYZDjm0thAWdaoQ?=
 =?us-ascii?q?LDyGBRoF6MxolfwZngU4JgnGGBIgpIjCPVAEB?=
X-IPAS-Result: =?us-ascii?q?A2G3CwA3a2RdgEenVdFlHgEGBwaBZ4JARYEFKoQhg0qLP?=
 =?us-ascii?q?oIPgjKRQIFkhTsBCAEBAQ4bFAEBgQSDOwKCaCM4EwIKAQEFAQEBAQEGBAEBA?=
 =?us-ascii?q?hABAQkNCQgnhTYMgjopAYFLXz4BAQEDEhEEUhALCwMKAgIfBwICIhIBBQEcB?=
 =?us-ascii?q?hMIGoMBggqeJ4EDPIskfzODd4RoAQgMgUkSeiiLcoIXg241PoJIhQeCWASBL?=
 =?us-ascii?q?gEBAZQ/lXkBBgIBggwUhmqFNIglG4IybYZDjm0thAWdaoQLDyGBRoF6Mxolf?=
 =?us-ascii?q?wZngU4JgnGGBIgpIjCPVAEB?=
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="4537177"
Received: from mail-lf1-f71.google.com ([209.85.167.71])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 16:31:49 -0700
Received: by mail-lf1-f71.google.com with SMTP id y24so2877170lfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 16:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHZ68SOgALOLBcJLTVPjnAnpRGohAVYDLu1/pi6HRkU=;
        b=JNynOGB1DVNm9biWt323QVNMaMiOqdtQ4F8dNqH1rLBXM3j01D0QDdKsKdoQ/EODsr
         8gPiabsdLhzDJTm8R6CalrkPAGCvk1JiPFfWmzRWkHm0YSPYgA8ecaVYCpfuomeh9SmK
         eDGfc7krjvNIS3YLbzdwFF3KmfjvKV1ZknKuQnEziKqWzG4rO4HBCQKSvxtRRjQUFK2s
         py7Fqw0bRFtIFDD9Ux3nw8tgPpCFrfRJ5Gt9V8OTlZXljwm6OHxMAZjb+L09PVCzb7fI
         ztljI9LXwfu5eno8gwd6cD2iCiBRsEwZHuEI5RYksb5SDhg/6JfCEtTMnBQ1eh8Nt1Zf
         f2RA==
X-Gm-Message-State: APjAAAWe5tshCogRiwWFJE9idGOricC6vbIdT5EqIpJCuweTCQdP84Gv
        7q3aLU7owcc6T8fDcJMF5V0ovoY0DuEjvKYEv/C9IyIyXIU26Gxvni1h/kzUHdUqI26hgD6SKZQ
        GIr3DH1wC4tQBZvCXc1SAnvjGQoqBpYyGwLDuqKC9Mw==
X-Received: by 2002:a2e:b4db:: with SMTP id r27mr12031851ljm.110.1566862308155;
        Mon, 26 Aug 2019 16:31:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtlZX5KlXDKRKPnANcKQ/U2/n2wfoad1fT5Hyfe4LOP+/aJ0H31gi+jf5y1wvH7QxB72GTcBA94U0zxO8nkX8=
X-Received: by 2002:a2e:b4db:: with SMTP id r27mr12031844ljm.110.1566862307961;
 Mon, 26 Aug 2019 16:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190821210931.9621-1-yzhai003@ucr.edu> <afa0a08e-30ff-7958-fb09-3e3d58d47f0e@xs4all.nl>
In-Reply-To: <afa0a08e-30ff-7958-fb09-3e3d58d47f0e@xs4all.nl>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Mon, 26 Aug 2019 16:32:17 -0700
Message-ID: <CABvMjLT8F+a7X6e8T-UHWGT751MyiXsXn_6artQjNzhQgFCYPQ@mail.gmail.com>
Subject: Re: [PATCH] [media] pvrusb2: qctrl.flag will be uninitlaized if
 cx2341x_ctrl_query() returns error code
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the correction, let me send a new patch then.

On Mon, Aug 26, 2019 at 5:09 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 8/21/19 11:09 PM, Yizhuo wrote:
> > Inside function ctrl_cx2341x_getv4lflags(), qctrl.flag
> > will be uninitlaized if cx2341x_ctrl_query() returns -EINVAL.
> > However, it will be used in the later if statement, which is
> > potentially unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
> >  drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> > index ad5b25b89699..1fa05971316a 100644
> > --- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> > +++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
> > @@ -793,6 +793,7 @@ static unsigned int ctrl_cx2341x_getv4lflags(struct pvr2_ctrl *cptr)
> >       struct v4l2_queryctrl qctrl;
> >       struct pvr2_ctl_info *info;
> >       qctrl.id = cptr->info->v4l_id;
> > +     memset(&qctr, 0, sizeof(qctrl))
>
> Please compile test your patches! This doesn't compile due to a typo
> (qctr -> qctrl).
>
> Also, this would overwrite qctrl.id with 0, not what you want.
>
> Instead, just do:
>
>         struct v4l2_queryctrl qctrl = {};
>
> to initialize the struct with all 0.
>
> Regards,
>
>         Hans
>
> >       cx2341x_ctrl_query(&cptr->hdw->enc_ctl_state,&qctrl);
> >       /* Strip out the const so we can adjust a function pointer.  It's
> >          OK to do this here because we know this is a dynamically created
> >
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
