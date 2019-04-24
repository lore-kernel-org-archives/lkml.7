Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED09C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9C021773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="Pa0cExVC";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="lsEuEuFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfDXM0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:26:36 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:57609 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726880AbfDXM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:26:36 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 08:26:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=Y4gh16yRKthXYUFJ18BdzPm1Qo+DH8p1EAbtj3YooGM=;
 b=Pa0cExVCRZHPlIU6IfYtJafweLQT6X9/0I3j1Cp7BB/5IuB5wXxc8fRqcdzQRBitSV/teeNSyLjS
   E7om3A+GUyaagd9x2qYllYYV9NJ3uAO19ixKoYnoG/aDD5orDwBl/42LsegYPQPL6G1K/0WEdZ3j
   RELP9vT9IMd9xKN8lzg=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho1avk1sar8d for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 11:58:19 +0000 (envelope-from <bounce-md_31050260.5cc04f5b.v1-ce4cab2a23e344bfa7a08370b8b1c832@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556107099; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=Y4gh16yRKthXYUFJ18BdzPm1Qo+DH8p1EAbtj3YooGM=; 
 b=lsEuEuFgeOS42WgPIymv9J7fFnHK0dV3C8JR4AmphIydAEoxbiztHHPIOBS86QfnbifAY3
 x/TgUBVdp+nwGl3BlaRusMnTuGPPUKNsIxSF9+BvD/cMMpwMPtGne42beMw99RL9v5hfAsMd
 9eVEhpIL61ZQ2M5GL04ZwjXcOmGrI=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 2/2] fuse: require /dev/fuse reads to have enough buffer capacity as negotiated
Received: from [87.98.221.171] by mandrillapp.com id ce4cab2a23e344bfa7a08370b8b1c832; Wed, 24 Apr 2019 11:58:19 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Message-Id: <20190424115815.GB2723@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <d74b17b9d33c3dcc7a1f2fa2914fb3c4e7cda127.1553680185.git.kirr@nexedi.com> <CAJfpegurLOLoNd9p2avcXPhSvP+ux8V+A=ghBySSpn0pX_Afpg@mail.gmail.com>
In-Reply-To: <CAJfpegurLOLoNd9p2avcXPhSvP+ux8V+A=ghBySSpn0pX_Afpg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.ce4cab2a23e344bfa7a08370b8b1c832
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 11:58:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:48:36PM +0200, Miklos Szeredi wrote:
> On Wed, Mar 27, 2019 at 11:44 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > A FUSE filesystem server queues /dev/fuse sys_read calls to get
> > filesystem requests to handle. It does not know in advance what would be
> > that request as it can be anything that client issues - LOOKUP, READ,
> > WRITE, ... Many requests are short and retrieve data from the
> > filesystem. However WRITE and NOTIFY_REPLY write data into filesystem.
> >
> > Before getting into operation phase, FUSE filesystem server and kernel
> > client negotiate what should be the maximum write size the client will
> > ever issue. After negotiation the contract in between server/client is
> > that the filesystem server then should queue /dev/fuse sys_read calls with
> > enough buffer capacity to receive any client request - WRITE in
> > particular, while FUSE client should not, in particular, send WRITE
> > requests with > negotiated max_write payload. FUSE client in kernel and
> > libfuse historically reserve 4K for request header. This way the
> > contract is that filesystem server should queue sys_reads with
> > 4K+max_write buffer.
> >
> > If the filesystem server does not follow this contract, what can happen
> > is that fuse_dev_do_read will see that request size is > buffer size,
> > and then it will return EIO to client who issued the request but won't
> > indicate in any way that there is a problem to filesystem server.
> > This can be hard to diagnose because for some requests, e.g. for
> > NOTIFY_REPLY which mimics WRITE, there is no client thread that is
> > waiting for request completion and that EIO goes nowhere, while on
> > filesystem server side things look like the kernel is not replying back
> > after successful NOTIFY_RETRIEVE request made by the server.
> >
> > -> We can make the problem easy to diagnose if we indicate via error
> > return to filesystem server when it is violating the contract.
> > This should not practically cause problems because if a filesystem
> > server is using shorter buffer, writes to it were already very likely to
> > cause EIO, and if the filesystem is read-only it should be too following
> > 8K minimum buffer size (= either FUSE_MIN_READ_BUFFER, see 1d3d752b47,
> > or = 4K + min(max_write)=4k cared to be so by process_init_reply).
> >
> > Please see [1] for context where the problem of stuck filesystem was hit
> > for real (because kernel client was incorrectly sending more than
> > max_write data with NOTIFY_REPLY; see also previous patch), how the
> > situation was traced and for more involving patch that did not make it
> > into the tree.
> >
> > [1] https://marc.info/?l=linux-fsdevel&m=155057023600853&w=2
> 
> Applied.

Thanks. Looking forward for it to appear in fuse.git#for-next

Kirill
