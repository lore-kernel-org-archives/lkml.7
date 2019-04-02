Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE94C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04FA204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHnsUCSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfDBQSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:18:32 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:36813 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729063AbfDBQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:18:32 -0400
Received: by mail-it1-f180.google.com with SMTP id y10so6254527itc.1;
        Tue, 02 Apr 2019 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Re+RFOGNndaiMDA2vDzD5LwdmPcg3nxlGPP85IpTjik=;
        b=PHnsUCSY/qiykMhJ4pa9KK5JKO3Ze7zSHPJ79uUnDsBRGMw6hIDkR7+DcjMXQQYjPH
         nB7e1TsSudWHd8n1C4IYRhdkyNIXY5kUqyJ6zgVVQpaAmkoJV18cekhQhcPTXFFMnPTi
         t5dsHs3ikGRI5XwwZjWY4/kWN0GeLjJTzxCnOg51/Kkaop8NVvCmUixCZ538zIy9bRG7
         tcNmaT1ItOUct5VDhqjIS2/Z60StmPMOWOlROAXsP30qkFUeLdj3GIXCEQChdDb6EmcA
         9/2ta9d+qH7zKSOyNPXCZNc9lgyEcf6nOdr2EOgrYEJGPnN9Fkx3mDVDH3c2JUwzAqP7
         KY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Re+RFOGNndaiMDA2vDzD5LwdmPcg3nxlGPP85IpTjik=;
        b=WucyT7YJvvoWrlCcnGaWT5QqTR04l7YaulzdxdTNvAZ9H3NEq0rRYigCMfWweRH0Kh
         anJg+H/rSLJzACKp20zetuUCOVi9iVz5uZtvrP2r2bKms5IRjX09oshz5os3wfrUk4p5
         YxqBkoKEeDxYvBNiKbPIrflisXF4ir7TjTgvotB6M0DjiJsM+WLqbV3SD3GLdwI/fxpA
         dWxwPJCTo1huoD/AOwKBh8iJ0YS6cA+Mu0oUVJeP6zGBk2aRxyMDJPVn1T3lx3zkCltQ
         w++sTRs77qnCbiVDEWpWsxtQOtPQaRiMHg4NsAVRq9zdDOQvwQjYWNtB+ABx09EuM+Rz
         aXLw==
X-Gm-Message-State: APjAAAXI6vI2JzglatDxI6eWWDugIYXslSO3N9ZIMxKHPXFaNAQQ0ika
        cp/H/tHAvSgmisx7pUyhhI9RXsA2UvHGXtQxWgU=
X-Google-Smtp-Source: APXvYqy3Rrz4CRj+wlX1B/s3NmvOSbnBxyJoOkkdOzK2bOS6mXJEXcERmnbqRdRmUCESfRrIxxTPqIyWF9egxW07qxY=
X-Received: by 2002:a02:c6d8:: with SMTP id r24mr5372138jan.93.1554221911086;
 Tue, 02 Apr 2019 09:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org> <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org> <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com> <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com> <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <20190402112115-mutt-send-email-mst@kernel.org> <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
In-Reply-To: <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 2 Apr 2019 09:18:19 -0700
Message-ID: <CAKgT0Uc78NYnva4T+G5uas_iSnE_YHGz+S5rkBckCvhNPV96gw@mail.gmail.com>
Subject: Re: On guest free page hinting and OOM
To:     David Hildenbrand <david@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Tue, Apr 2, 2019 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 02.04.19 17:25, Michael S. Tsirkin wrote:
> > On Tue, Apr 02, 2019 at 08:04:00AM -0700, Alexander Duyck wrote:
> >> Basically what we would be doing is providing a means for
> >> incrementally transitioning the buddy memory into the idle/offline
> >> state to reduce guest memory overhead. It would require one function
> >> that would walk the free page lists and pluck out pages that don't
> >> have the "Offline" page type set,
> >
> > I think we will need an interface that gets
> > an offline page and returns the next online free page.
> >
> > If we restart the list walk each time we can't guarantee progress.
>
> Yes, and essentially we are scanning all the time for chunks vs. we get
> notified which chunks are possible hinting candidates. Totally different
> design.

The problem as I see it is that we can miss notifications if we become
too backlogged, and that will lead to us having to fall back to
scanning anyway. So instead of trying to implement both why don't we
just focus on the scanning approach. Otherwise the only other option
is to hold up the guest and make it wait until the hint processing has
completed and at that point we are back to what is essentially just a
synchronous solution with batching anyway.
