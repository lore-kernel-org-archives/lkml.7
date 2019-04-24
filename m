Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B8DC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171A6206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nexedi.com header.i=kirr@nexedi.com header.b="k7SQY8cO";
	dkim=pass (1024-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="lTkg+YB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfDXS7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:59:42 -0400
Received: from mail133-30.atl131.mandrillapp.com ([198.2.133.30]:27276 "EHLO
        mail133-30.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729709AbfDXS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=0SFZTwefYxxEhG5Zzs/c11j2Lv9Aa2aD9xm+qQxMma8=;
 b=k7SQY8cO3RBxXWSeNIGvUX2ea4v/jQPmIAWDmwrRVAf+AB22yJgYxdI6EvCgv0eiksk6N/w3ljbr
   Y4qzoB1/pVMvQOzQIogvkbX4g28wwrXN36iYEdpjSQ3HpqY0GHCPQEorMjWua49VZib+jmg5x78k
   El/xSMD97OqF/Xfrcgc=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-30.atl131.mandrillapp.com id ho2p1o1sar8f for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:59:38 +0000 (envelope-from <bounce-md_31050260.5cc0b21a.v1-e92a58d8c5874603a3dd4953bdf96229@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1556132378; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=0SFZTwefYxxEhG5Zzs/c11j2Lv9Aa2aD9xm+qQxMma8=; 
 b=lTkg+YB3VX7h0ZeYraqUPjqy1KU9BNDvyOrtGkMfQ50eX+8MjTy/BRKlWres8pD2UIwWZr
 MT3F9ggNdABTWzy6bLUbEUSvrGIq7zR1wACtaqxvhhzDCXeRxT2skQfwGp7DJNLwh0PR7Nny
 yPQlObFj+5eVtg5fAYz9ZmW94AgQg=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to negotiated max_write
Received: from [87.98.221.171] by mandrillapp.com id e92a58d8c5874603a3dd4953bdf96229; Wed, 24 Apr 2019 18:59:38 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Message-Id: <20190424185935.GD3798@deco.navytux.spb.ru>
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com> <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com> <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com> <20190424123107.GA32024@deco.navytux.spb.ru> <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com> <20190424142249.GA28070@deco.navytux.spb.ru> <CAJfpegtX6p+j+kRuudZ=yVM9Tgj7x4mBaiGuDoDCrZoRvBOt9Q@mail.gmail.com> <20190424180958.GA3798@deco.navytux.spb.ru>
In-Reply-To: <20190424180958.GA3798@deco.navytux.spb.ru>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.e92a58d8c5874603a3dd4953bdf96229
X-Mandrill-User: md_31050260
Date:   Wed, 24 Apr 2019 18:59:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 09:09:58PM +0300, Kirill Smelkov wrote:
> Thanks again for tossing the patches,

I have to appologize here: I used the word "tossing" here as if it would
mean "processing" or "applying", but a friend of mine just said that it
means something like "throwing away" which completely changes the
message. Sorry, I did not meant that - it's just my english for which I
beg you pardon.

All I wanted to say is that I'm grateful that you reviewed and applied
the patches. So thanks and appologize for the inconveninece.

Kirill
