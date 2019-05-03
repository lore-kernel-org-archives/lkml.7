Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6521FC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1C12075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfECLbp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:31:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23808 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726372AbfECLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:31:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-bsrUedipMsKCwape80AdzQ-1; Fri, 03 May 2019 12:31:41 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 May 2019 12:31:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 May 2019 12:31:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Cyrill Gorcunov' <gorcunov@gmail.com>,
        Joel Savitz <jsavitz@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <norov.maillist@gmail.com>
Subject: RE: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Thread-Topic: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Thread-Index: AQHVAYqqcxRhj7bMTkeIUrrm9JebiKZZRD3w
Date:   Fri, 3 May 2019 11:31:40 +0000
Message-ID: <6cf43408000149d98cc1683943c436cb@AcuMS.aculab.com>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
 <20190502210922.GF2488@uranus.lan>
 <CAL1p7m6eC3-99oFEyp0F1xn7qN4Vx+s-kHQXh14cMUWoVFqbWw@mail.gmail.com>
 <20190503083149.GH2488@uranus.lan>
In-Reply-To: <20190503083149.GH2488@uranus.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: bsrUedipMsKCwape80AdzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrill Gorcunov
> Sent: 03 May 2019 09:32
> On Thu, May 02, 2019 at 05:46:08PM -0400, Joel Savitz wrote:
> > > Won't be possible to use put_user here? Something like
> > >
> > > static int prctl_get_tasksize(unsigned long __user *uaddr)
> > > {
> > >         return put_user(TASK_SIZE, uaddr) ? -EFAULT : 0;
> > > }
> >
> > What would be the benefit of using put_user() over copy_to_user() in
> > this context?
> 
> It is a common pattern to use put_user with native types, where
> copy_to_user more biased for composed types transfer.

It also removes all the crappy code that checks whether the
kernel buffer is valid.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

