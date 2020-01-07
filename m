Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F2C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01058207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFJcxeTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgAGLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:55:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727806AbgAGLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578398129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKDZj81sAccgrzkhgIj794ifqolNRhLOvA0CIx37wWs=;
        b=WFJcxeTLfbM3CgWgC55v3gvcfSIwpc/qCDiuBzQbAbe0VoBdCJpWs1y88gC1nPs/2zOftu
        8VweNe97R7CRNHuR/Zc33qXPuDDGKBnQ9usdm4TS+dKXobofWav+/FdKrG2aun5fIX0aje
        onRKeSek6TMdtTu07bzLH4JP3qXlfp0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-z3vgXvPtMOaZXZ-35yh0yQ-1; Tue, 07 Jan 2020 06:55:28 -0500
X-MC-Unique: z3vgXvPtMOaZXZ-35yh0yQ-1
Received: by mail-qv1-f72.google.com with SMTP id j10so6404265qvi.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 03:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KKDZj81sAccgrzkhgIj794ifqolNRhLOvA0CIx37wWs=;
        b=qVKHSIhzVHS94Sn9MjnWOvYfBu64tNRmEWZezyJheEw0Yb5Iqk66aHzayolO2h7jr1
         M3HRZYWgXv/vjYMv6E3xa+ISjRyxbrWprEpeUVIqiKDUa1nSGuN+0lmdhvhQYpvwkMWG
         LBr+in4PqiqDFrEK65pDpKUGqn/d/d2a55T8+EQi5VXii/wuSvnB5Due9hnA2cPtup+i
         IOurPIdps21lXAxFLUcZ+5X9g51lWoYF0PSfV57p3r/qjGaUSdau87yEvkQam9mnnMJK
         jyiB1dhbhuQSHeHppyJUGSqNRbkG7G9HqfQD1F/MCEFwEDa0JEvDazjsMw9KMMbi/Af/
         E9AQ==
X-Gm-Message-State: APjAAAXkz6/6K7qAC/oLO/XEsTl4YljJQMWiabwY7N5vXMbeZnW2twtA
        Yvsv9PbUA7snNu01+ZFrIQwySo8EL+7OcTTrzHxSQHU8uBTaLN0Tmwrixf78WmqWCvQa7IB4ylJ
        6xoTPHFxnAEHqbrpMnw4/a2Vf
X-Received: by 2002:a37:a642:: with SMTP id p63mr80587784qke.85.1578398127872;
        Tue, 07 Jan 2020 03:55:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyq1n8OiAxkRvySBU4BNoH32+bCXpIgv5dDJl00BVFh2v1+ue0mG4WwIqiHHC8FA0mwU5qoug==
X-Received: by 2002:a37:a642:: with SMTP id p63mr80587764qke.85.1578398127536;
        Tue, 07 Jan 2020 03:55:27 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
        by smtp.gmail.com with ESMTPSA id d71sm22259619qkg.4.2020.01.07.03.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:55:26 -0800 (PST)
Date:   Tue, 7 Jan 2020 06:55:22 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: vhost changes (batched) in linux-next after 12/13 trigger random
 crashes in KVM guests after reboot
Message-ID: <20200107065434-mutt-send-email-mst@kernel.org>
References: <c022e1d6-0d57-ae07-5e6b-8e40d3b01f4b@de.ibm.com>
 <20191218100926-mutt-send-email-mst@kernel.org>
 <2ffdbd95-e375-a627-55a1-6990b0a0e37a@de.ibm.com>
 <20200106054041-mutt-send-email-mst@kernel.org>
 <08ae8d28-3d8c-04e8-bdeb-0117d06c6dc7@de.ibm.com>
 <20200107042401-mutt-send-email-mst@kernel.org>
 <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6795e53-d12c-0709-c2e9-e35d9af1f693@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:34:50PM +0100, Christian Borntraeger wrote:
> 
> 
> On 07.01.20 10:39, Michael S. Tsirkin wrote:
> > On Tue, Jan 07, 2020 at 09:59:16AM +0100, Christian Borntraeger wrote:
> >>
> >>
> >> On 06.01.20 11:50, Michael S. Tsirkin wrote:
> >>> On Wed, Dec 18, 2019 at 04:59:02PM +0100, Christian Borntraeger wrote:
> >>>> On 18.12.19 16:10, Michael S. Tsirkin wrote:
> >>>>> On Wed, Dec 18, 2019 at 03:43:43PM +0100, Christian Borntraeger wrote:
> >>>>>> Michael,
> >>>>>>
> >>>>>> with 
> >>>>>> commit db7286b100b503ef80612884453bed53d74c9a16 (refs/bisect/skip-db7286b100b503ef80612884453bed53d74c9a16)
> >>>>>>     vhost: use batched version by default
> >>>>>> plus
> >>>>>> commit 6bd262d5eafcdf8cdfae491e2e748e4e434dcda6 (HEAD, refs/bisect/bad)
> >>>>>>     Revert "vhost/net: add an option to test new code"
> >>>>>> to make things compile (your next tree is not easily bisectable, can you fix that as well?).
> >>>>>
> >>>>> I'll try.
> >>>>>
> >>>>>>
> >>>>>> I get random crashes in my s390 KVM guests after reboot.
> >>>>>> Reverting both patches together with commit decd9b8 "vhost: use vhost_desc instead of vhost_log" to
> >>>>>> make it compile again) on top of linux-next-1218 makes the problem go away.
> >>>>>>
> >>>>>> Looks like the batched version is not yet ready for prime time. Can you drop these patches until
> >>>>>> we have fixed the issues?
> >>>>>>
> >>>>>> Christian
> >>>>>>
> >>>>>
> >>>>> Will do, thanks for letting me know.
> >>>>
> >>>> I have confirmed with the initial reporter (internal test team) that <driver name='qemu'/> 
> >>>> with a known to be broken linux next kernel also fixes the problem, so it is really the
> >>>> vhost changes.
> >>>
> >>> OK I'm back and trying to make it more bisectable.
> >>>
> >>> I pushed a new tag "batch-v2".
> >>> It's same code but with this bisect should get more information.
> >>
> >> I get the following with this tag
> >>
> >> drivers/vhost/net.c: In function ‘vhost_net_tx_get_vq_desc’:
> >> drivers/vhost/net.c:574:7: error: implicit declaration of function ‘vhost_get_vq_desc_batch’; did you mean ‘vhost_get_vq_desc’? [-Werror=implicit-function-declaration]
> >>   574 |   r = vhost_get_vq_desc_batch(tvq, tvq->iov, ARRAY_SIZE(tvq->iov),
> >>       |       ^~~~~~~~~~~~~~~~~~~~~~~
> >>       |       vhost_get_vq_desc
> >>
> > 
> > Not sure why but I pushed a wrong commit. Sorry. Should be good now.
> > 
> 
> during bisect:
> 
> drivers/vhost/vhost.c: In function ‘vhost_get_vq_desc_batch’:
> drivers/vhost/vhost.c:2634:8: error: ‘id’ undeclared (first use in this function); did you mean ‘i’?
>  2634 |  ret = id;
>       |        ^~
>       |        i
> 
> I changed that to i
> 
> 
> The last step then gave me  (on commit 50297a8480b439efc5f3f23088cb2d90b799acef vhost: use batched version by default)
> net enc1: Unexpected TXQ (0) queue failure: -5
> in the guest.
> 
> bisect log so far:
> [cborntra@m83lp52 linux]$ git bisect log
> git bisect start
> # bad: [3131e79bb9e9892a5a6bd33513de9bc90b20e867] vhost: use vhost_desc instead of vhost_log
> git bisect bad 3131e79bb9e9892a5a6bd33513de9bc90b20e867
> # good: [d1281e3a562ec6a08f944a876481dd043ba739b9] virtio-blk: remove VIRTIO_BLK_F_SCSI support
> git bisect good d1281e3a562ec6a08f944a876481dd043ba739b9
> # good: [5b00aab5b6332a67e32dace1dcd3a198ab94ed56] vhost: option to fetch descriptors through an independent struct
> git bisect good 5b00aab5b6332a67e32dace1dcd3a198ab94ed56
> # good: [5b00aab5b6332a67e32dace1dcd3a198ab94ed56] vhost: option to fetch descriptors through an independent struct
> git bisect good 5b00aab5b6332a67e32dace1dcd3a198ab94ed56
> # bad: [1414d7ee3d10d2ec2bc4ee652d1d90ec91da1c79] vhost: batching fetches
> git bisect bad 1414d7ee3d10d2ec2bc4ee652d1d90ec91da1c79
> 
> 

I pushed batched-v3 - same head but bisect should work now.

-- 
MST

