Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91BA2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e07d0lQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEBVfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:35:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46379 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBVfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:35:02 -0400
Received: by mail-io1-f66.google.com with SMTP id m14so3511749ion.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pMCFqBmZdC2vIWtn/6JNsusyEuOW8+QTsv2O54WuzUg=;
        b=e07d0lQCKzDv9Pdj3LJf94ZrkmLPrhGTTb9t5r/pMCO0MFre+kVK6z18QHIbdfEFqe
         QIPvdNmtAqexsvZAQxjRjex0UbMOHX5cjV8s33nyOEvtLOloHXwFV/1oeTPmkkzb0W2x
         M9AgCuMRjJKsNmF4F8UMagA1FEY5uZJFRKPrfruKh/4diYXqEQeXax/jOnxIyLmvgkil
         VBOLEim18u7aTcqZEt1Mj7ycE7SPVU0+LfDJ033T8IRPKK6cos4W7op2HYn3sJr1Dmgz
         iZRKMTWtA+ysQTxVYsQOsOFjkcj4F23sV5uVBWWuRgqYrUZI/n2W2MRnm4UWSJDrrpzb
         e5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pMCFqBmZdC2vIWtn/6JNsusyEuOW8+QTsv2O54WuzUg=;
        b=sqaAROpaTHg36iEOl8nAW9+qPdRgFMrt5CNN29vxAp9YHfbzzbNgGx0DVHWYaDy1MS
         YhnfhHTuv0xoMYPv6Obb+FSFwbxujx2Gixy9WsseySsjFT07GW8nPEga76P9Kmuv6gvz
         uInLHV3iRx1r6fdw6NK0Z9SN4W/luqoSrRjAlmEMk3MnauCaxQLrEaUidFi5osO5j15B
         JMhWvnHuDNKUCJWLPJyvH4k0HEcg1VWSkgxcQlAo6ctsjbg4Fv+EuoR1axgHTHBwurJb
         3Qdr0uv6Xv7j2+ms47hFPrWMZKVe8rQNB9999Fw8JkUd3F5aUVjO/7nlMFy78BixClQf
         2fIw==
X-Gm-Message-State: APjAAAXlutc/VDejXE+q8o2d+nete0dCykk+7ktGyg+oUP7Wh3RNWnun
        FVzeU0VOQB2D1iAvWdifBJDLkRxH+XJUA5U3lR4=
X-Google-Smtp-Source: APXvYqwzSOceS5/xcw0gTuP+SY/RE9jqNlomRR/cAUf+hVXzMB+xebhHX9V5hy7mideq/+9iuaJ31DO64FWCni88ey0=
X-Received: by 2002:a5d:9d48:: with SMTP id k8mr4642213iok.194.1556832901192;
 Thu, 02 May 2019 14:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <8bb9fe29-65d3-e977-1932-4a2f17ead333@redhat.com> <20190502211002.GG2488@uranus.lan>
 <CAL1p7m6sYp_A4PB-K9gc8QKnPLHe92y2yMq7TqnUJuQPqR+MOA@mail.gmail.com>
In-Reply-To: <CAL1p7m6sYp_A4PB-K9gc8QKnPLHe92y2yMq7TqnUJuQPqR+MOA@mail.gmail.com>
From:   Yury Norov <norov.maillist@gmail.com>
Date:   Thu, 2 May 2019 14:34:49 -0700
Message-ID: <CAJu-Uz4rnMCR5-zHj=Ub1xZD=mmw3z1-mEg+M=qWXV3yO7OJkg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sys/prctl: expose TASK_SIZE value to userspace
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=87=D1=82, 2 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 14:23, Joel Savitz <=
jsavitz@redhat.com>:
>
> Yes, this the change, thanks to the suggestion of Yury Norov.

Joel, could you please stop top-posting?

> I also now explicitly mention the expected userspace destination type
> in the manpage patch.
>
> Best,
> Joel Savitz
>
>
> On Thu, May 2, 2019 at 5:10 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote=
:
> >
> > On Thu, May 02, 2019 at 05:01:38PM -0400, Waiman Long wrote:
> > >
> > > What did you change in v2 versus v1?
> >
> > Seems unsigned long long has been changed to unsigned long.

Sorry guys, I replied to Joel, but accidentally dropped the folks.
Find discussion below.

=D1=87=D1=82, 2 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 13:50, Joel Savitz <=
jsavitz@redhat.com>:
>
> While I disagree that kernel memory is exposed, as the 8-byte
> (unsigned long long) value of task_size is initialized by the
> assignment of TASK_SIZE, I agree with your suggestion, as the current
> code may corrupt the userspace stack of the caller unless provided
> with the address of an unsigned long long, an unusual type to store a
> value of word size.
>
> As such, I have adopted your suggestion and added type information to
> my manpage patch. Expect the v2 to be posted shortly.
>
> Thank you for your review.
>
> Best,
> Joel Savitz
>
> On Thu, May 2, 2019 at 3:41 PM Yury Norov <norov.maillist@gmail.com> wrot=
e:
> >
> > =D1=87=D1=82, 2 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 12:15, Joel Savi=
tz <jsavitz@redhat.com>:
> > >
> > > When PR_GET_TASK_SIZE is passed to prctl, the kernel will attempt to
> > > copy the value of TASK_SIZE to the userspace address in arg2.
> >
> > but you copy the value of task_size.
> >
> > > Suggested-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > > ---
> > >  include/uapi/linux/prctl.h |  3 +++
> > >  kernel/sys.c               | 10 ++++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > > index 094bb03b9cc2..2335fe0a8db8 100644
> > > --- a/include/uapi/linux/prctl.h
> > > +++ b/include/uapi/linux/prctl.h
> > > @@ -229,4 +229,7 @@ struct prctl_mm_map {
> > >  # define PR_PAC_APDBKEY                        (1UL << 3)
> > >  # define PR_PAC_APGAKEY                        (1UL << 4)
> > >
> > > +/* Get the process virtual memory size */
> > > +#define PR_GET_TASK_SIZE               55
> > > +
> > >  #endif /* _LINUX_PRCTL_H */
> > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > index 12df0e5434b8..7ced7dbd035d 100644
> > > --- a/kernel/sys.c
> > > +++ b/kernel/sys.c
> > > @@ -2252,6 +2252,13 @@ static int propagate_has_child_subreaper(struc=
t task_struct *p, void *data)
> > >         return 1;
> > >  }
> > >
> > > +static int prctl_get_tasksize(void __user * uaddr)
> > > +{
> > > +       unsigned long long task_size =3D TASK_SIZE;
> > > +       return copy_to_user(uaddr, &task_size, sizeof(unsigned long l=
ong))
> > > +                       ? -EFAULT : 0;
> > > +}
> > > +
> >
> > task_size is unsigned long. On 32-bit systems you will end up exposing =
4 bytes
> > of kernel memory. You should switch to sizeof(unsigned long).
> >
> > Your code is broken for compat arches. Take a look at the definition
> > of TASK_SIZE
> > for arm64, for example.
> >
> > Thanks,
> > Yury
