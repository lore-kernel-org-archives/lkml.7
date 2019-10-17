Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D26EECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4544221835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcI3xKAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437384AbfJQU3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:29:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46437 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392669AbfJQU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:29:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2341538pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGzfoydrgfLH+6OSNvFJgVCfYe5DZkA2g+Ze13Y0BI0=;
        b=qcI3xKAn9N36dzCGhtZjh5o99q/GwWjpRcDeFYgq9owAiCDNO2KceihyuIcCNNz3E5
         WPxJHg+NoHeJoDfDuM9esl+6ZhDbqYBp3VsY4JybwMD7k1jg2Ys+vPBIv84F+vp7lRyB
         MFNYcbY5a5i7wpXrXCIM5vraJRDH7TvgpzsSKiMKpH/8jsmZKe7YjwMrFC+sAhoeJx0P
         TkYWK8IHVtDju9jvxvfKIGX5UYvHFCAeifnuW+qqfUBejAvskKWzvyyvm2Y7Ik7n4rIc
         6VfqupXReo3U334CVNf5jFwqap+ZLcfM9P/7/K4pk38GmqRm5QxNOhVZ4af3DrhvSP/2
         iqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGzfoydrgfLH+6OSNvFJgVCfYe5DZkA2g+Ze13Y0BI0=;
        b=pFCJLohShHcCb6ES6rtA7817Aau67rYpClOS2OzebeOClXA38GvI1AMpa6uNaF0ROf
         g5RFhmUbENfaRlit0DlMJQ/s/UJkdjXolAgGhE2bmimeM/pYM/zzbwhYMtGWIIMZ1AsZ
         CpU37fAuy7tx3+QVXFbncqC7XckrQ8KGBOyEZxekk3NEGDK/LHezu11obox2uBWxTWCI
         JMxkDxKQwJD/I6+l3NkLxPsxu62g0t5VytTJvtLY5QrEH7WKGNmCjhv5TokUV04h4L/N
         mOSGW6H8mrraI/39iskGPIgvdkAeqqqNnoChU9FZ/6w5pctmpUxf3pIKdiTBY1xaIv3I
         rDSQ==
X-Gm-Message-State: APjAAAUEsunxSlx0xlX999DK2NP/5j35dC4278BGfyciVqp6JAOguJJD
        lbmdcEojTsb6oqgMJoycivLeX56n34fuYqjye6/8/Q==
X-Google-Smtp-Source: APXvYqxQdqUhb/3P8KN/MR06ATDhMAw/8toZltJAt9HJYabqSYrn3OYDB2KZoaJ69l2hgeCLiieQudCtSs2uqLRj1E0=
X-Received: by 2002:a62:5503:: with SMTP id j3mr2232299pfb.93.1571344191179;
 Thu, 17 Oct 2019 13:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571333592.git.andreyknvl@google.com> <af26317c0efd412dd660e81d548a173942f8a0ad.1571333592.git.andreyknvl@google.com>
 <20191017181800.GB1094415@kroah.com> <CAAeHK+yS24KnecLyhnPEHx-dOSk3cvVHhtGHe+9Uf2d96+ZqjQ@mail.gmail.com>
 <20191017202843.GA1103978@kroah.com>
In-Reply-To: <20191017202843.GA1103978@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 17 Oct 2019 22:29:39 +0200
Message-ID: <CAAeHK+wT00vFzddy1q7SWQrnR3idLbpfC-cG+DckqDT_YEOTdw@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vhost, kcov: collect coverage from vhost_worker
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 17, 2019 at 09:00:18PM +0200, Andrey Konovalov wrote:
> > On Thu, Oct 17, 2019 at 8:18 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 07:44:15PM +0200, Andrey Konovalov wrote:
> > > > This patch adds kcov_remote_start/kcov_remote_stop annotations to the
> > > > vhost_worker function, which is responsible for processing vhost works.
> > > > Since vhost_worker is spawned when a vhost device instance is created,
> > > > the common kcov handle is used for kcov_remote_start/stop annotations.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  drivers/vhost/vhost.c | 15 +++++++++++++++
> > > >  drivers/vhost/vhost.h |  3 +++
> > > >  2 files changed, 18 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 36ca2cf419bf..71a349f6b352 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -357,7 +357,13 @@ static int vhost_worker(void *data)
> > > >               llist_for_each_entry_safe(work, work_next, node, node) {
> > > >                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > > >                       __set_current_state(TASK_RUNNING);
> > > > +#ifdef CONFIG_KCOV
> > > > +                     kcov_remote_start(dev->kcov_handle);
> > > > +#endif
> > >
> > > Shouldn't you hide these #ifdefs in a .h file?  This is not a "normal"
> > > kernel coding style at all.
> >
> > Well, if it's acceptable to add a kcov_handle field into vhost_dev
> > even when CONFIG_KCOV is not enabled, then we can get rid of those
> > #ifdefs.
>
> It should be, it's not a big deal and there's not a ton of those
> structures around that one more field is going to hurt anything...

OK, I'll do that in the next version then, thanks!
