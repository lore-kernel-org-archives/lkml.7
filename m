Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7336C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6612148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obydRoeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDBUcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:32:16 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:55715 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:32:15 -0400
Received: by mail-it1-f180.google.com with SMTP id z126so7427405itd.5;
        Tue, 02 Apr 2019 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tc8hZ8L4fi++Tw9DLZC3eVfYKxd9pX9rhYuoyQAvDdY=;
        b=obydRoeEGZnksP9jGuzxEUd2LyttqTQ2VETVqPXmM4wAYfnphVjfMih2mLqbJoIdR2
         dGMx5GcmRJDkFrndo0+wJfhVUVLWyD55SB4dX/3ij2kNPWne5pnutCUU4eMobhcW0WMR
         SWFMjxyLfOgEH84bPK/rV4XDQupb4/83BNMzeUJJLBgD8PG0DevnjydxXTnHHETQc87B
         Ocd5QpAzQ9NfF07daUzLZ3J9hnjz4Vy/NmqzlVIR5YOHtkFfGf8Wpibo7VHP4c4BaGr7
         At8YCrFhTm/etCxfjb7ezt4EJiKdBSsXtlckoO5OW7tFQW3zxJC1HdgxgFiMyNKjwRO7
         1UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc8hZ8L4fi++Tw9DLZC3eVfYKxd9pX9rhYuoyQAvDdY=;
        b=fWkubKgfjllC7PMod5vrFb7WVEvzfXsl3rQC02Oe/ANfpoq5CzbKUKKKaAGfVofuUe
         EBC8opLyURnXRulTXuqY40x4u/ABIbs0EYTAfTLEcmoNqj+gQwbqTgMBop/ixzHqXi47
         CyH7hTox+0bsWRflD9wQfJHrWQszJJdmC9XQk12GZxp0mmDx7QeTCvu0aSWKuwwYO3qp
         VhVHIonEm1kraHh2NO7jEkyYyxQh24OfQyKr68q/2hUn9epadRcS3JlXbsYKeMk7mfwW
         mPFiHWgOAEeY0wPGdEUOijjRVQX8BsmIYILu24wjKbtINkDt+PqnAYi0+bcPunai4JqG
         G0iQ==
X-Gm-Message-State: APjAAAX+LngIP5ezDZNmg0rSo614uccP0IrguGv1TQKNeiWeM934cS4I
        LoX3NTF7gw8j8rPiDCMbSv1wvU2rtfu8zRgJ4u6uug==
X-Google-Smtp-Source: APXvYqxC1u78KAXj8zZQ3IqH24rndQYPRU5w27rDMpCPRpJr/Q00SxbPZ9VNpm2UZeX41ObAYByqBsJ8PtxwORJ5BF8=
X-Received: by 2002:a05:660c:243:: with SMTP id t3mr5942207itk.124.1554237134400;
 Tue, 02 Apr 2019 13:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
 <20190401104608-mutt-send-email-mst@kernel.org> <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com> <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
 <20190402112115-mutt-send-email-mst@kernel.org> <3dd76ce6-c138-b019-3a43-0bb0b793690a@redhat.com>
 <CAKgT0Uc78NYnva4T+G5uas_iSnE_YHGz+S5rkBckCvhNPV96gw@mail.gmail.com>
 <6b0a3610-0e7b-08dc-8b5f-707062f87bea@redhat.com> <CAKgT0UdHA66z1j=3H06AfgtiF4ThFdXwQ6i8p1MszdL2bRHeZQ@mail.gmail.com>
 <20190402134722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190402134722-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 2 Apr 2019 13:32:03 -0700
Message-ID: <CAKgT0UeZE29qBOAxDb2EmLr_hr1_W-m3Rw3gKs-UAPbD80K_+Q@mail.gmail.com>
Subject: Re: On guest free page hinting and OOM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 10:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 02, 2019 at 10:45:43AM -0700, Alexander Duyck wrote:
> > We went through this back in the day with
> > networking. Adding more buffers is not the solution. The solution is
> > to have a way to gracefully recover and keep our hinting latency and
> > buffer bloat to a minimum.
>
> That's an interesting approach, I think that things that end up working
> well are NAPI (asychronous notifications), limited batching, XDP (big
> aligned buffers) and BQL (accounting). Is that your perspective too?
>

Yes, that is kind of what I was getting at.

Basically we could have a kthread running somewhere that goes through
and pulls something like 64M of pages out of the MAX_ORDER - 1
freelist, does what is necessary to isolate them, puts them on a queue
somewhere, kicks the virtio ring, and waits for the response to come
back indicating that the hints have been processed. We would just have
to keep it running until the list doesn't have enough non-"Offline"
memory to fulfill the request. Then we just wait until we again reach
a level necessary to justify waking the thread back up and repeat.

In my mind it looks a lot like your standard Rx ring in that we
allocate some fixed number of buffers and wait for hardware to tell us
when the buffers are ready. The only extra complexity is having to add
tracking using the PageType "Offline" bit which should be cheap when
we are already having to manipulate the "Buddy" PageType anyway.

It would let us get away from having to do the per-cpu queues and
complicated coordination logic to translate free pages to their buddy.
