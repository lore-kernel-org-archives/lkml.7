Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB65C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D4720851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkbEsXyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCHSG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:06:27 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:38438 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfCHSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:06:26 -0500
Received: by mail-it1-f169.google.com with SMTP id l66so22594517itg.3;
        Fri, 08 Mar 2019 10:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5rKTyfVZijrMz/zqJoeUoWvK7hLmtFUj70DH++ifvI=;
        b=nkbEsXyMXcEtPbGSAf1kaE6FvSfYAjTcy/5fMk4ANcma+AlXUAnDi9hlng0LmL8mke
         Mf8a+jldG7g3805jNHaVYw3gLTVsQbhrCV19H4sucJiqbD7WwJT/MXjEWbz8YbVnTrdO
         OLbbVRTxDMd/CV1qqTEpRcDhbPbq17hO2TCk4lT53cems5JLRbNodgVs/QwxpGm28fMm
         5V+EGHqfCJJFk5PWu5r7ZQ56DykRUDlqYm+gN0pFFYlO/rPQ3NfuHGu86cnIIBnZ9Uza
         xkRu7gZyjTU8w54CFljY+1KMQUBnPYO80csf/oWXcyvanXfWzjUpGFpwuazreVN64ogb
         vCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5rKTyfVZijrMz/zqJoeUoWvK7hLmtFUj70DH++ifvI=;
        b=edLbU21kIJOy6rV1jUNR94hftBG4T4v8JhrgJk6i9XQZUuJupoXX+iCoprQic3tRL4
         /eyShQ92ENEeNe1jjB66INKbAfmEm+MyPsLWnw6PywwiiP1EifCJQiRdbOOkRycCYJAK
         5NPFKGMztqhLyYmEjlPeD1rKw1WqE14ClWD5x54c7ZLWSPZ9XFqcOg0LvDHyAxaRSaXj
         NH1/l0vqaxVvfoT1w6u+8jxP51tUPLXU1i1KPIfsiysBrfY5dGTKAL41KJCtQXpyGfxh
         5bVjm5EcvRM+oDWb/7mTTsTm5heecNZT22HmxcyZrfpzjw1yoLv6nyRxBci9OdLbH15H
         rTyA==
X-Gm-Message-State: APjAAAX0d2NR30M2yK7v0+H07+QpLSaXjX052X5DuT1JpEspjy4XAWwp
        OyNpbmn6xREHod8Ey72abMHnRPqs4BYHLF2XhrH9HQ==
X-Google-Smtp-Source: APXvYqxe8SAllqyBBiYJBgaC2gPebe+RMsZWPiQrsuncalBXI8HdlDKnm1Ro75y9UtqsMNImF5874Z6e6mBrSivrTG0=
X-Received: by 2002:a02:2309:: with SMTP id u9mr195309jau.114.1552068385617;
 Fri, 08 Mar 2019 10:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com> <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com> <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
 <20190307212845-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190307212845-mutt-send-email-mst@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 8 Mar 2019 10:06:14 -0800
Message-ID: <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest free pages
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Thu, Mar 7, 2019 at 6:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
> > The only other thing I still want to try and see if I can do is to add
> > a jiffies value to the page private data in the case of the buddy
> > pages.
>
> Actually there's one extra thing I think we should do, and that is make
> sure we do not leave less than X% off the free memory at a time.
> This way chances of triggering an OOM are lower.

If nothing else we could probably look at doing a watermark of some
sort so we have to have X amount of memory free but not hinted before
we will start providing the hints. It would just be a matter of
tracking how much memory we have hinted on versus the amount of memory
that has been pulled from that pool. It is another reason why we
probably want a bit in the buddy pages somewhere to indicate if a page
has been hinted or not as we can then use that to determine if we have
to account for it in the statistics.

> > With that we could track the age of the page so it becomes
> > easier to only target pages that are truly going cold rather than
> > trying to grab pages that were added to the freelist recently.
>
> I like that but I have a vague memory of discussing this with Rik van
> Riel and him saying it's actually better to take away recently used
> ones. Can't see why would that be but maybe I remember wrong. Rik - am I
> just confused?

It is probably to cut down on the need for disk writes in the case of
swap. If that is the case it ends up being a trade off.

The sooner we hint the less likely it is that we will need to write a
given page to disk. However the sooner we hint, the more likely it is
we will need to trigger a page fault and pull back in a zero page to
populate the last page we were working on. The sweet spot will be that
period of time that is somewhere in between so we don't trigger
unnecessary page faults and we don't need to perform additional swap
reads/writes.
