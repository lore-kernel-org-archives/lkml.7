Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D2DC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CAB20882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy690DZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfL0P5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:57:11 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44581 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfL0P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:57:11 -0500
Received: by mail-yw1-f68.google.com with SMTP id t141so11415861ywc.11;
        Fri, 27 Dec 2019 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BiQOKb56p1ie1sc7/zk5XIY9A7njVsnU/Z7f74v1ws4=;
        b=Gy690DZ7EtGnqq+4IM4+RF/OnBqcOcaJEYInJ1mD9Ns2ltmazp2u9ihFntKhzb/Fkh
         gNtjvQ971Ph1FX3+9UvBezQfI8dH2i3RBMOTQwEWO7s8LMA4q3rIst1nc4Ty9jMeOIor
         SFyJaQ/Umf+YSe8Uy1sqlKOlGpAHEdNRD+l0ttFhN8945kOoo/O4CtYdkoeBLgelEZ12
         Z3dXHp0NCZ9Un9f/C2FjWxK7m1IbQY+ZS2ifuDNcLZHDEgbPGgHAZ2qP5Xq+ZFo32RZg
         KNk5lALW8LCJRyniatAqE9feGIAf8V3vZdw8qmHVuSgqbVAB3ejfiJ6xdeS8tHwXL91O
         m/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BiQOKb56p1ie1sc7/zk5XIY9A7njVsnU/Z7f74v1ws4=;
        b=sYUosr2w1BQvsCi/kYUaw6b08tqt/+qxJ/8TnStE+OrT1UM1syI64SaMloLO+rtcfH
         BFbdY2aT9yAetGKQQEh4fwnQw10WYsE1XTXFJqwO+S0RHG24wAmjXCS37AJYAWIZxalJ
         9pzghWEfDof9FQFwfu0evLvq9d5HMVkuLWJ3g4VQGDQXobttcrzmCODQvwy6NjR0RE6s
         zXGNIKU0pKk29wcgGd7eSOTxeW2N8twMK9ukwvmtGGsruWpQzXTxgXEkvpb8mzVHY8Wp
         QD2/vEJBAx2ImEhGTrNbek6myRg/Riiw/iSMAzk4yOx09g6/3X3laVhhPCvCV0Gi5Smf
         mQ3Q==
X-Gm-Message-State: APjAAAXlbG6oDVU19y/3MYA6YZubc5i5xfbCQ+9+MgMCdugXSo2IdpzP
        6Vn8KheYVUoqS5mB6IXJww==
X-Google-Smtp-Source: APXvYqwMkbapAIncVSopx3B3vyv8N79XTKlT6CNOA3xgHugUPMHaWnqeiWLplmINdePWP4eoYlpvww==
X-Received: by 2002:a0d:d64d:: with SMTP id y74mr39860256ywd.386.1577462230355;
        Fri, 27 Dec 2019 07:57:10 -0800 (PST)
Received: from localhost ([64.192.53.12])
        by smtp.gmail.com with ESMTPSA id q16sm13916240ywa.110.2019.12.27.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 07:57:10 -0800 (PST)
Date:   Fri, 27 Dec 2019 10:57:09 -0500
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        kbuild test robot <lkp@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: huawei-wmi: Fix a possible NULL deref
Message-ID: <20191227155709.6wztlhhzn6qljalp@960>
References: <20191225235841.14393-1-ayman.bagabas@gmail.com>
 <20191226215418.GA3889@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226215418.GA3889@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/27 12:54AM, Dan Carpenter wrote:
> On Wed, Dec 25, 2019 at 06:58:38PM -0500, Ayman Bagabas wrote:
> > We're iterating over a NULL terminated array.
>
> This changelog is kind of messed up.  This is how it looks in context:
> https://marc.info/?l=linux-kernel&m=157731837511760&w=2
> The subject and the commit message are far apart.  What's wrong with
> iterating over a NULL terminated array?  The changelog doesn't say which
> variable is NULL.
>

I'm really sorry for my poor subject and commit message that shouldn't happen again.

This is not an issue, the problem occurs to me when I try to use this
module on kernel 5.0, particularly, when iterating over the struct
wmi_device_id array. On kernel 5.0, I'm getting a NULL pointer
dereference on *guid->guid_string on the 3rd NULL struct in the array.
This is happening because the definition of struct wmi_device_id in <5.1 is

struct wmi_device_id {
	const char *guid_string;
};

Compared to this where guid->guid_string is not NULL

struct wmi_device_id {
	const char guid_string[UUID_STRING_LEN+1];
};

> >
> > Fixes: 1ac9abeb2e5b ("platform/x86: huawei-wmi: Move to platform driver")
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> > ---
> >  drivers/platform/x86/huawei-wmi.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
> > index a2d846c4a7ee..42d461eeeff4 100644
> > --- a/drivers/platform/x86/huawei-wmi.c
> > +++ b/drivers/platform/x86/huawei-wmi.c
> > @@ -784,13 +784,13 @@ static const struct wmi_device_id huawei_wmi_events_id_table[] = {
> >  static int huawei_wmi_probe(struct platform_device *pdev)
> >  {
> >  	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
> > +	struct input_dev *idev = *huawei_wmi->idev;
>
> This line seems like an unrelated change.  I'm still not sure the
> justification for this.  I really hate puzzling over patches to try
> figure out why a patch is making changes.

This one is a logical error, we have an array of input_dev pointers for
each guid. Defining idev in the loop would always reset the pointer to
the first element in the array. The address of each pointer then passed
to huawei_wmi_input_setup to allocate an input device. We want to keep a
pointer to each allocated input device in the static huawei_wmi struct.

>
> regards,
> dan carpenter
>
>

--
Thank you,
Ayman
