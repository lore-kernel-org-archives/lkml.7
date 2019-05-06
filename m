Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61190C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADEE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iAd6JRjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfEFSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:13:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36798 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfEFSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:13:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id a8so16234415edx.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF+CoYsepNrGbmmwc3BrcU2vzqm7V7BSod886VJiwv0=;
        b=iAd6JRjOX6cXS5y0FNW2XJ6WvvRPKYhT/6IvHlZ2418SFSqTjnGNEmEfufAH09uPtF
         49VkxpuxGKXyan9FEqMBuwApcLYmGUGixrOhtESpdlpABUMPZ7N8/UovTdziIhU88upK
         j4WE0SwVaZhfG1gNDqVLDDmhA75SiFdXba4UCXOJGgDdqfP1rS3rfmw/9d7SoRbMsGOM
         PO6LGgs5u/jSx2+y8jIHm9f8s43JUgyO4ndaBY82kSijPJK1XE4OCuAAhpxnGmqOtRBv
         IjlfDhj0TrBziM4BsbBli4RPSM49bmx3HScLhwrnqbvdsDMNlfsUYv5y2TfjyWFjkoIM
         dR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF+CoYsepNrGbmmwc3BrcU2vzqm7V7BSod886VJiwv0=;
        b=b53HlnqT8WLErUNRkmilPwgf5Z/EHxBmhwaMkerMDRo4AKi2bg+scGCr2f2ERG4Qo+
         9tfzIfdrWpGdY/Z+Dhaal7GPCk57fGmtdD64hU05xtH7XCdmx6pFnG6wqTwCU+RTONRo
         KuldljYL7Xa+BfpjZfjFvR47oTgghhl+QKdwfpDqSXEE7qVdIRTmMw8avcGJ7sy35mCA
         wq5+lC/P7HZB2OMv3pUUqOl767dOSbp9TshJ21jFi97hmcwxYw5d35KExu9GWAlidRRD
         KBrJolO55YRTkjnhu1jrvpauI0I1ckB0A9wIa9lRtpalVKp65ulkOZFj/GwMAy91gJkK
         ip9g==
X-Gm-Message-State: APjAAAUPUrqr7BmFz9RXT36TnuxXkqu0/tP7Cg/hEJoFGM31BSPRCJfl
        Lr38IdnPQE4fOFC8jOZI+duX3m9UPQUMAtEtBtWXxg==
X-Google-Smtp-Source: APXvYqxFqK4/B5vwBsKri7IYoVOdJaYycRBVOH6nocLuB6+vjdSKCdwCa1fH59QgHqbrELc7DYS3V2Z28fw5LXRcLWU=
X-Received: by 2002:a50:a951:: with SMTP id m17mr26721424edc.79.1557166429629;
 Mon, 06 May 2019 11:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com> <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
In-Reply-To: <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 6 May 2019 14:13:38 -0400
Message-ID: <CA+CK2bAeU7LOSBt7EZ3Cverpgg-0KYgOsJfSakD3aR7NWvxBzg@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 1:57 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > -static inline void remove_memory(int nid, u64 start, u64 size) {}
> > +static inline bool remove_memory(int nid, u64 start, u64 size)
> > +{
> > +     return -EBUSY;
> > +}
>
> This seems like an appropriate place for a WARN_ONCE(), if someone
> manages to call remove_memory() with hotplug disabled.
>
> BTW, I looked and can't think of a better errno, but -EBUSY probably
> isn't the best error code, right?

Same here, I looked and did not find any better then -EBUSY. Also, it
is close to check_cpu_on_node() in the same file.

>
> > -void remove_memory(int nid, u64 start, u64 size)
> > +/**
> > + * remove_memory
> > + * @nid: the node ID
> > + * @start: physical address of the region to remove
> > + * @size: size of the region to remove
> > + *
> > + * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
> > + * and online/offline operations before this call, as required by
> > + * try_offline_node().
> > + */
> > +void __remove_memory(int nid, u64 start, u64 size)
> >  {
> > +
> > +     /*
> > +      * trigger BUG() is some memory is not offlined prior to calling this
> > +      * function
> > +      */
> > +     if (try_remove_memory(nid, start, size))
> > +             BUG();
> > +}
>
> Could we call this remove_offline_memory()?  That way, it makes _some_
> sense why we would BUG() if the memory isn't offline.

Sure, I will rename this function.

Thank you,
Pasha
