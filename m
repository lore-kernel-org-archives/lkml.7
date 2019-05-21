Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09699C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B0C2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEUJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:03:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55518 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEUJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:03:11 -0400
Received: by mail-it1-f194.google.com with SMTP id g24so3676913iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+o3MggDFa5h86+zTYSOS2v1g0Pwh3ExeN5LLHg8kpM=;
        b=LvlQ1EHGOJ4PML3+MkBw2hi4csjNfgONV4ChUORxa8Gt3gPLIqWDr6hTNLBz9XT3wE
         DRRqwDINrY9Kdf+5rKrQDXftplOQ9aKA3d4BOrgBM4tfZuz+VwhY3pbH0yhOzV4TeoGZ
         Hx3ckXDtXSzVZQ2ZEznb8SzBlWmENRdWudlPVqZ2t8epnzjtXBhNb+7aQjV3MPtJzRsR
         BU5qKYTjos22asjR0jRqSJKT3av1LST+JOaEHv1FywmlCQXf11tUku7jzH2aToEXXim9
         nq07SVoy7TN5lVSlzB1hgTkfJGCFIdhnTHm74L3Zb8t/21xCGxvbtVREoH5AyYscL+Hu
         0GuA==
X-Gm-Message-State: APjAAAXmY7SAUqFNl1msZWqUN9rV9kUh/ZOPAx1eiOeXV0j/dhgrykcZ
        Wd1LGv4uoKsHNa4ykxDSy9y+mPbSZVUk3VIegj/0DA==
X-Google-Smtp-Source: APXvYqx6/3duGjSKVU51wlNci+m1IvtUM+dSUVqcFGB7rGWF5JLBFlHDnLLy8ordPh0Anh/n4sL9BxhUc4JSTx6a+bM=
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr2897433ita.9.1558429390460;
 Tue, 21 May 2019 02:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092944.30481-2-bhe@redhat.com> <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic> <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp> <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 21 May 2019 17:02:59 +0800
Message-ID: <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Baoquan He <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 3:10 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>
> On 5/15/19 3:58 PM, Borislav Petkov wrote:
> > On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
> >> Hi Kairui,
> >>
> >> On 5/13/19 5:02 PM, Baoquan He wrote:
> >>> On 05/13/19 at 09:50am, Borislav Petkov wrote:
> >>>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> >>>> So we're going to try it again this cycle and if there's no fallout, it
> >>>> will go upstream. If not, it will have to be fixed. The usual thing.
> >>>>
> >>>> And I don't care if Kairui's patch fixes this one problem - judging by
> >>>> the fragility of this whole thing, it should be hammered on one more
> >>>> cycle on as many boxes as possible to make sure there's no other SNAFUs.
> >>>>
> >>>> So go test it on more machines instead. I've pushed it here:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> >>>
> >>> Pingfan has got a machine to reproduce the kexec breakage issue, and
> >>> applying these two patches fix it. He planned to paste the test result.
> >>> I will ask him to try this branch if he has time, or I can get his
> >>> machine to test.
> >>>
> >>> Junichi, also have a try on Boris's branch in NEC's test environment?
> >>
> >> while the patch set works on most of the machines I'm testing around,
> >> I found kexec(1) fails to load kernel on a few machines if this patch
> >> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
> >> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.
> >
> > Why? What kind of machines are those?
>
> I don't know.  They are just general purpose Xeon-based servers
> and not some special purpose machines.  So I guess there are other
> such machines in the wild.
>

Hi, I think it's reasonable to update the patch to include the
NV_STORAGE regions as well, most likely the firmware only provided
NV_STORAGE region? Can you help confirm if the e820 didn't contain
ACPI data, and only ACPI NVS?

I had a try with this update patch, it worked and didn't break anything.

Hi Boris, would you prefer to just fold Junichi update patch into the
previous one or I should send an updated patch?


--
Best Regards,
Kairui Song
