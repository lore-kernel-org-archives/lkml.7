Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C241C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2146A20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfCRNNF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:13:05 -0400
Received: from albireo.enyo.de ([5.158.152.32]:56212 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCRNNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:13:04 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1h5s4X-0002x0-Ef; Mon, 18 Mar 2019 13:12:57 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1h5s4X-0002Xc-CH; Mon, 18 Mar 2019 14:12:57 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Law <law@redhat.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
References: <20190311153857.563743-1-arnd@arndb.de>
        <87k1h1fgkk.fsf@mid.deneb.enyo.de>
        <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
        <87a7hvded7.fsf@mid.deneb.enyo.de>
        <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
        <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
        <87o968y1uv.fsf@mid.deneb.enyo.de>
        <CAK8P3a1DzRhiuNxBeQaTYSX1NhCaN6+B0Ya7aeGfxUGj35LFhw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 14:12:57 +0100
In-Reply-To: <CAK8P3a1DzRhiuNxBeQaTYSX1NhCaN6+B0Ya7aeGfxUGj35LFhw@mail.gmail.com>
        (Arnd Bergmann's message of "Mon, 18 Mar 2019 13:56:37 +0100")
Message-ID: <877ecwwckm.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann:

> On Mon, Mar 18, 2019 at 10:25 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>>
>> * Arnd Bergmann:
>>
>> > Should we just remove __kernel_fd_set from the exported headers and
>> > define the internal fd_set directly in include/linux/types.h? (Adding the
>> > folks from the old thread to Cc).
>>
>> The type is used in the sanitizers, but incorrectly.  They assume that
>> FD_SETSIZE is always 1024.  (The existence of __kernel_fd_set is
>> itself somewhat questionable because it leads to such bugs.)
>> Moving around the type could cause a build failure in the sanitizers, but I'm
>> not entirely clear how the UAPI headers are included there.
>
> It looks like sanitizer_platform_limits_posix.cc includes
> linux/posix_types.h to ensure that __kernel_fd_set is the same
> size as __sanitizer___kernel_fd_set, and then it uses the
> latter afterwards.
>
> What I don't see here is what kind of operation is actually done
> on the data, I only see a cast to void.

I think it is used to assert that the select family of system calls
writes to the 1024 bits for each of the passed pointers.  Which is not
actually true—the write size is controlled by the file descriptor
count argument.

> If libsanitizer actually does
> anything interesting here, we should definitely fix it to use the
> correct size, especially since this is actually something that
> can trigger a buffer overflow in subtle ways when used carelessly.
> See for example [1], which we still have not addressed

The footnote is missing.

> For this specific use (and probably others like it), renaming the
> fds_bits member to __kernel_fds_bits or something like that
> would keep user space still compiling. That would only break
> if someone was using __kernel_fd_set, and actually doing
> bit operations on it. glibc uses '__fds_bits' unless __USE_XOPEN
> is set, so maybe we should use use that name unconditionally.

Please use something that is more obviously Linux-specific.
