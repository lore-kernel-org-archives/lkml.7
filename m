Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC4C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0020838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="I456wzre";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="Ie57el/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfHAOFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:05:05 -0400
Received: from mail177-14.suw61.mandrillapp.com ([198.2.177.14]:7564 "EHLO
        mail177-14.suw61.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730581AbfHAOFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=AWunD0Mulf9LulwYiK8CA/275BoKsDBiDIBZMPtwNug=;
 b=I456wzre3VTJs6bhUQ9Ts2GRjPxKK/TFQPhvPP9TsU5godaVALSjbRv9pxTAQaelL9Vp44Jz2bA5
   I3QPCG5vtmVZImF7o4sBK9XjV+iQfeaIaLtTNzAg++g7rW8MJiZRpg2p3iDqoyacyVcOh7NV+nAY
   Oex01Ybf8SoO2SzHgaU=
Received: from pmta06.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail177-14.suw61.mandrillapp.com id h8boou22rtku for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 13:50:02 +0000 (envelope-from <bounce-md_31050260.5d42ee0a.v1-e8c373daa0e24acabc426cc5836a07ea@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1564667402; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=AWunD0Mulf9LulwYiK8CA/275BoKsDBiDIBZMPtwNug=; 
 b=Ie57el/5bWyh4emLQtzCP28JWUHqPeYyBlVJwR0YsqvG/3zSW2/SGh1pSuEYSqi+CZfsIP
 2GB9752T2LqpwpqmpXvbsUHN8e7rX8axXQIswQWDXXb9Hvn9iubW6rAIYR5VXpnPC3eDGnUp
 weIKdFSYl5A74YLTmjiLFrpULbh2o=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH, RESEND3] fuse: require /dev/fuse reads to have enough buffer capacity (take 2)
Received: from [87.98.221.171] by mandrillapp.com id e8c373daa0e24acabc426cc5836a07ea; Thu, 01 Aug 2019 13:50:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, <gluster-devel@gluster.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>
Message-Id: <20190801134955.GA18544@deco.navytux.spb.ru>
References: <20190724094556.GA19383@deco.navytux.spb.ru> <CAJfpegscn7B+TrD5hckXkpHEb_62m6O9-kFOOehWyC89CPFunw@mail.gmail.com>
In-Reply-To: <CAJfpegscn7B+TrD5hckXkpHEb_62m6O9-kFOOehWyC89CPFunw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e8c373daa0e24acabc426cc5836a07ea
X-Mandrill-User: md_31050260
Date:   Thu, 01 Aug 2019 13:50:02 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:35:03PM +0200, Miklos Szeredi wrote:
> On Wed, Jul 24, 2019 at 11:46 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Miklos,
> >
> > I was sending this patch for ~1.5 month without any feedback from you[1,2,3].
> > The patch was tested by Sander Eikelenboom (original GlusterFS problem
> > reporter)[4], and you said that it will be ok to retry for next
> > cycle[5]. I was hoping for this patch to be picked up for 5.3 and queued
> > to Linus's tree, but in despite several resends from me (the same patch;
> > just reminders) nothing is happening. v5.3-rc1 came out on last Sunday,
> > which, in my understanding, denotes the close of 5.3 merge window. What
> > is going on? Could you please pick up the patch and handle it?
> 
> Applied.

Thanks...
