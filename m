Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D2C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPapH70G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfGTRgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 13:36:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45843 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfGTRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 13:36:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so15494888pfq.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jFzEFbXL8zNeFrvM9gtQJVw7kMPeTM3qxkr4uBXj7g=;
        b=UPapH70G8Pzu1pg1x2Iha2h7FKvzz82Nv9TupdtGdQWcSvvtDW6XgGpOhzb6+WWvvO
         UyfByHF80wwI3MBKlBxATaAcS70wQ/N/BvPtoBw6juTuTyuJklnyo6YO+oOVveKIzcTK
         tQdXFARugh8oJMlOzbMXXFpzPXLBElc+7dUjTIB2RKUCS+Rkr/k0HEdNeFEbvAGuUUra
         0gGFoYoIOnBF5r+ljjENAr3kJLaZWURQ28WEyUwNl6P5dnd8GjgifxRLfQNjGT4ki4G5
         QCOIQlE+j15jXUoY3hw4bBKyO7hThGIdgKO4yOIaFXqV+h+G338QIjXtWmzL1ngNUWpn
         X2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jFzEFbXL8zNeFrvM9gtQJVw7kMPeTM3qxkr4uBXj7g=;
        b=QK8MLZZpEeK8nYMbDe+OixIFJaOn0UBSSiP5E5XI5SB8sLqlD00KrqdHH3p9TgGTzC
         F75YnJ+QPyO21Pssls+l1eRC2zjY34AYriZCOMW5uXXskLede9LfpT3hoYYwHoydOu2/
         02hrAQMJtAX1N9sVMvhC3poJ0adbiPUD9b1VbAnL2heP3/KXG3IwoMuNOvUDYJ5id5LD
         BA12JdmNbW9UzSUjVrdkKKFMhG7MUtSDDiBm0Zs8N5umbdm47ndrjqCBwoKuXuEaHbGg
         11aNYb4xkLF/gS8LRfLWCwsBlq5EFDmLzXsFnyE8GpE6o10T/wC0pY/yKx2ElJJddFjS
         d+kQ==
X-Gm-Message-State: APjAAAUJ6YDW3l8U5Fg0zpthxj9V3LcvXezIR75BZIQ//TuEyYxklf45
        AK3pOvYI+LQoaASVj5vz32M=
X-Google-Smtp-Source: APXvYqxNNZGDJ1Z3eY/IfJfUVpvisSu3W4uOc+tNJWgFyRdKEailjCJybjrD7z7wlYqd/BifdGEweQ==
X-Received: by 2002:a63:d944:: with SMTP id e4mr60439916pgj.261.1563644182185;
        Sat, 20 Jul 2019 10:36:22 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.33])
        by smtp.gmail.com with ESMTPSA id f197sm34302222pfa.161.2019.07.20.10.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 10:36:21 -0700 (PDT)
Date:   Sat, 20 Jul 2019 23:06:15 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Matt Sickler <Matt.Sickler@daktronics.com>
Cc:     "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH v3] staging: kpc2000: Convert put_page to put_user_page*()
Message-ID: <20190720173615.GA4323@bharath12345-Inspiron-5559>
References: <20190719200235.GA16122@bharath12345-Inspiron-5559>
 <SN6PR02MB4016754FE1BB6200746281A2EECB0@SN6PR02MB4016.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4016754FE1BB6200746281A2EECB0@SN6PR02MB4016.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:59:02PM +0000, Matt Sickler wrote:
> >From: Bharath Vedartham <linux.bhar@gmail.com>
> >Changes since v2
> >        - Added back PageResevered check as suggested by John Hubbard.
> >
> >The PageReserved check needs a closer look and is not worth messing
> >around with for now.
> >
> >Matt, Could you give any suggestions for testing this patch?
> 
> Myself or someone else from Daktronics would have to do the testing since the
> hardware isn't really commercially available.  I've been toying with the idea
> of asking for a volunteer from the mailing list to help me out with this - I'd
> send them some hardware and they'd do all the development and testing. :)
> I still have to run that idea by Management though.
> 
> >If in-case, you are willing to pick this up to test. Could you
> >apply this patch to this tree and test it with your devices?
> 
> I've been meaning to get to testing the changes to the drivers since upstreaming
> them, but I've been swamped with other development.  I'm keeping an eye on the
> mailing lists, so I'm at least aware of what is coming down the pipe.
> I'm not too worried about this specific change, even though I don't really know
> if the reserved check and the dirtying are even necessary.
> It sounded like John's suggestion was to not do the PageReserved() check and just
> use put_user_pges_dirty() all the time.  John, is that incorrect?
The change is fairly trivial in the upstream kernel. It requires no
testing in the upstream kernel. It would be great if you could test it
on John's git tree with the implemented gup tracking subsystem and check
if gup tracking is working alright with your dma driver. I think this
patch will easily apply to John's git tree.

Thanks!
Bharath
