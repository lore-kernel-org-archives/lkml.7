Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38442C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D9A224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nggjd37z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfI3Unk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:43:40 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36399 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbfI3Uni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:38 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so41952019iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPd3byGg8NZfzcv3aKP+mxndVvl0xeZNKWuO2JR2c/8=;
        b=nggjd37zd1DtLjL08AsL9IBJT5Ao/nhQiTij8lP4Ng3qnDh10YvsjscKb9R2EW1SwQ
         zbbB7NQSN73QkBwKbdACptlry0DAAPMeUMU+FE825Pa+I/npdBaB1wPFqQ59Y+WOVIyT
         ETSQq6+bQNWfejvrgeB0hd9af8YDrZG89XmlFG5K0P5g1kCZK52/qFBng1QPHZTLeIjB
         vbxPbHyuPMHcksmkycBUUhw9VxrIvOu6RBmxPDfP3HkxoEQ/xKYvNAXf7rAwV5WVPEG6
         aJdkih+lxEv3SLPG4yShSXDUnaoo/xwjSl1tZHeSekWHSciWywdBVdp1k99A6v2VQk7K
         7gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPd3byGg8NZfzcv3aKP+mxndVvl0xeZNKWuO2JR2c/8=;
        b=W0BPW5RCy7fdlZTnoW3HF4VXzTou7OSnKz0MvvlRoUGM0p4L/OsAD6u+2VtGPD66pl
         JMzAvpFOww+KMeZn49P1Zk7jVZNvH+Co4K+8RqrOtIvTrnpJnMJAtTduOnHHI3G2n7qv
         s5bebSX2zsBNc0M/2jYiKhtyhgnwtiIT2Y9yIBiQw0+lFdXCO+i2xBb16H6skq/JUQ/S
         As+zwwPCXeKjkI6IMWbtdKYeFMIgYug3fyYEJEADW53cxRsLbxAtnPPXGysBoPte/aKe
         3EVUeeLpdLxUPnwkkOyIXuAW0mMr0Tag2LyMgHVsA1qBXBCABHYQYB4c8R8W3pkZSILV
         EsUA==
X-Gm-Message-State: APjAAAUtgMc5dbQvXuQrNnBlp/XaX0l+x2o5EvTzoqOIoqpWxiXnKP7l
        JW7Ev/MqGNDiJLeTlIy07q0qVU29Ij9mvrOsl94=
X-Google-Smtp-Source: APXvYqwOsdNh+2RsghVkp9WNgS5Dz5xGjtw9EVP2Qjs5jPFIqUZ3j8HzdWHHuoX5bIB6bfeAXyUbgtdraIlScNRu1NM=
X-Received: by 2002:a5e:8216:: with SMTP id l22mr1897092iom.252.1569876217922;
 Mon, 30 Sep 2019 13:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190927230421.20837-1-navid.emamdoost@gmail.com>
 <3b5913e3-856a-db81-7708-929e62ee53d4@redhat.com> <CAEkB2ER7xVU3vzK4ohj7f9=b=ZpNx++dyNrtLhOieeDgyeVBDg@mail.gmail.com>
 <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
In-Reply-To: <664aab6a-37c9-7239-a817-25dfbab00c7f@redhat.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 15:43:26 -0500
Message-ID: <CAEkB2EQqS0g7XLNbvrEzjLjn=mTyRWf-CRszdcvBxuZh61iAPw@mail.gmail.com>
Subject: Re: [PATCH] virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>, kjlu@umn.edu,
        Stephen McCamant <smccaman@umn.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 3:22 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 30-09-2019 04:22, Navid Emamdoost wrote:
> > It is a neat fix now, thank you.
>
> Can you submit a new version of your patch with the fix I proposed please ?
>
> Regards,
>
> Hans
>

Sure, v2 was sent.

>
> >
> >
> > On Sat, Sep 28, 2019 at 4:54 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 28-09-2019 01:04, Navid Emamdoost wrote:
> >>> In hgcm_call_preprocess_linaddr memory is allocated for bounce_buf but
> >>> is not released if copy_form_user fails. The release is added.
> >>>
> >>> Fixes: 579db9d45cb4 ("virt: Add vboxguest VMMDEV communication code")
> >>>
> >>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> >>
> >> Thank you for catching this, I agree this is a bug, but I think we
> >> can fix it in a cleaner way (see below).
> >>
> >>> ---
> >>>    drivers/virt/vboxguest/vboxguest_utils.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
> >>> index 75fd140b02ff..7965885a50fa 100644
> >>> --- a/drivers/virt/vboxguest/vboxguest_utils.c
> >>> +++ b/drivers/virt/vboxguest/vboxguest_utils.c
> >>> @@ -222,8 +222,10 @@ static int hgcm_call_preprocess_linaddr(
> >>>
> >>>        if (copy_in) {
> >>>                ret = copy_from_user(bounce_buf, (void __user *)buf, len);
> >>> -             if (ret)
> >>> +             if (ret) {
> >>> +                     kvfree(bounce_buf);
> >>>                        return -EFAULT;
> >>> +             }
> >>>        } else {
> >>>                memset(bounce_buf, 0, len);
> >>>        }
> >>>
> >>
> >> First let me quote some more of the function, pre leak fix, for context:
> >>
> >>          bounce_buf = kvmalloc(len, GFP_KERNEL);
> >>          if (!bounce_buf)
> >>                  return -ENOMEM;
> >>
> >>          if (copy_in) {
> >>                  ret = copy_from_user(bounce_buf, (void __user *)buf, len);
> >>                  if (ret)
> >>                          return -EFAULT;
> >>          } else {
> >>                  memset(bounce_buf, 0, len);
> >>          }
> >>
> >>          *bounce_buf_ret = bounce_buf;
> >>
> >> This function gets called repeatedly by hgcm_call_preprocess(), and the
> >> caller of hgcm_call_preprocess() already takes care of freeing the
> >> bounce bufs both on a (later) error and on success:
> >>
> >>          ret = hgcm_call_preprocess(parms, parm_count, &bounce_bufs, &size);
> >>          if (ret) {
> >>                  /* Even on error bounce bufs may still have been allocated */
> >>                  goto free_bounce_bufs;
> >>          }
> >>
> >>          ...
> >>
> >> free_bounce_bufs:
> >>          if (bounce_bufs) {
> >>                  for (i = 0; i < parm_count; i++)
> >>                          kvfree(bounce_bufs[i]);
> >>                  kfree(bounce_bufs);
> >>          }
> >>
> >> So we are already taking care of freeing bounce-bufs allocated for previous
> >> parameters to the call (which me must do anyways), so a cleaner fix would
> >> be to store the allocated bounce_buf in the bounce_bufs array before
> >> doing the copy_from_user, then if copy_from_user fails it will be cleaned
> >> up by the code at the free_bounce_bufs label.
> >>
> >> IOW I believe it is better to fix this by changing the part of
> >> hgcm_call_preprocess_linaddr I quoted to:
> >>
> >>          bounce_buf = kvmalloc(len, GFP_KERNEL);
> >>          if (!bounce_buf)
> >>                  return -ENOMEM;
> >>
> >>          *bounce_buf_ret = bounce_buf;
> >>
> >>          if (copy_in) {
> >>                  ret = copy_from_user(bounce_buf, (void __user *)buf, len);
> >>                  if (ret)
> >>                          return -EFAULT;
> >>          } else {
> >>                  memset(bounce_buf, 0, len);
> >>          }
> >>
> >> This should also fix the leak in IMHO is a clear way of doing so.
> >>
> >> Regards,
> >>
> >> Hans
> >>
> >>
> >>
> >>
> >>
> >
> >
>


-- 
Navid.
