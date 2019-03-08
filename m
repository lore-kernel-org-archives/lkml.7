Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A1C10F09
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D482085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCHS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:59:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42400 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCHS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:59:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so11782747qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13oWsy/a9o3RwpeIQWA/iT9VogWPwGVjX2GBI/RlvM8=;
        b=lLktKJEpscjRhV4XGvbSJELMPGEXX9BlDylnYu+9wr4+3CvmSvtsE/5EV2aLWLQhX2
         i57KYU8NoEkgzyhFhOaEHmHxwq/nJMaA7Dmn8W5H5+QKIZ3CyYmBGid7AyE2h84LaRoi
         5TT/0TrgQwVBYSbZB/U40Q7gX3GOpmBNpK5bRf5dRnWppEVPoeWA07wfdvS40p4ayeQD
         wCOoqiDLzCPtK0r6xZrNA8O8D7pcT7S9IhSp4vQyaU8/t62K/yA2+QfEDvpPdceL8ssC
         FZAj4H35J4yTEoa5dncoaZGDB1PoxJzeDF+b8Y3iXgjw3K/71UTgsmaspEzGI1LNAJkx
         c+dA==
X-Gm-Message-State: APjAAAWzAUfDG8LOXZtvW2Q8v4rSDfRamEWBHOyk1V+i8/0/Lp49wjLe
        3WIceLXTzJVnDl/oL0QfOnipsQ==
X-Google-Smtp-Source: APXvYqxtDg2pEPSqzUac+XPgrm2KksrQJYLXsAqYO3LAbz3jzQ61EOY9bkRsfy0GxkCyLvQM+ozUYw==
X-Received: by 2002:a37:c313:: with SMTP id a19mr14686923qkj.220.1552071547588;
        Fri, 08 Mar 2019 10:59:07 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id u10sm5549480qtu.42.2019.03.08.10.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:59:06 -0800 (PST)
Date:   Fri, 8 Mar 2019 13:59:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
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
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest
 free pages
Message-ID: <20190308135700-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com>
 <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com>
 <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
 <20190307212845-mutt-send-email-mst@kernel.org>
 <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ucu3EMsYBfdKtEiprrn-VBZy3Y+0HdEp5b4PO2SQgGsRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:06:14AM -0800, Alexander Duyck wrote:
> On Thu, Mar 7, 2019 at 6:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
> > > The only other thing I still want to try and see if I can do is to add
> > > a jiffies value to the page private data in the case of the buddy
> > > pages.
> >
> > Actually there's one extra thing I think we should do, and that is make
> > sure we do not leave less than X% off the free memory at a time.
> > This way chances of triggering an OOM are lower.
> 
> If nothing else we could probably look at doing a watermark of some
> sort so we have to have X amount of memory free but not hinted before
> we will start providing the hints. It would just be a matter of
> tracking how much memory we have hinted on versus the amount of memory
> that has been pulled from that pool. It is another reason why we
> probably want a bit in the buddy pages somewhere to indicate if a page
> has been hinted or not as we can then use that to determine if we have
> to account for it in the statistics.
> 
> > > With that we could track the age of the page so it becomes
> > > easier to only target pages that are truly going cold rather than
> > > trying to grab pages that were added to the freelist recently.
> >
> > I like that but I have a vague memory of discussing this with Rik van
> > Riel and him saying it's actually better to take away recently used
> > ones. Can't see why would that be but maybe I remember wrong. Rik - am I
> > just confused?
> 
> It is probably to cut down on the need for disk writes in the case of
> swap. If that is the case it ends up being a trade off.
> 
> The sooner we hint the less likely it is that we will need to write a
> given page to disk. However the sooner we hint, the more likely it is
> we will need to trigger a page fault and pull back in a zero page to
> populate the last page we were working on. The sweet spot will be that
> period of time that is somewhere in between so we don't trigger
> unnecessary page faults and we don't need to perform additional swap
> reads/writes.

Right but the question is - is it better to hint on
least recently used, or most recently used pages?
It looks like LRU should be better, but I vaguely rememeber there
were arguments for why most recently used might be better.
Can't figure out why, maybe I am remembering wrong.

-- 
MST
