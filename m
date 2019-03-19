Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ED62070D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjn6u9Uh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCSRi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:38:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39696 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSRi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:38:27 -0400
Received: by mail-it1-f193.google.com with SMTP id 139so3422808ita.4;
        Tue, 19 Mar 2019 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=//6bJVPXTE+ulhYW1YAmEulcMC4EvIB5HfsoXpgdswY=;
        b=kjn6u9Uhm0Mzv90rFpeNyX9BrUlGK6IgsmkuNpwKi09lq2P6AW9divckauwVU15cHX
         gVxolcWorbrvXon2TnouzUlJfqkbqZGSszvvioll9iGjp1Tu4KG1gBrLd/KepNk1vo9H
         8c28HapsynjnmZ4Y0UcC7fIfeJj1tVd5Q8di24FHG8TRPcbiqatG9SXRw6jp1KmcYl8U
         UWD4doBJpI+kGXLaMgJp41u4RcW2Db7XeTnB61WTbIW+gm9J8DBmxo5Rxh4ZipRAgtkM
         5Ua7ngBLtp+0BGlg+dWjSatxt/viJ0QMujZ6opDK4uaQzfUl+tXfqfR7cudaOSOcS8Xk
         4HUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=//6bJVPXTE+ulhYW1YAmEulcMC4EvIB5HfsoXpgdswY=;
        b=RUfxpTtZplb02CmPG1zMPKf0FhM2pHkcTDeeOhMuodHYFAzi7RkzwCrL/Pn5YvynyS
         EBo2Ey2vGhVchHHy0Wd6K4pllVzRIhdPwdAOTACd0zBXlDsjVa5wJsbEMMKvrFbEs5Sc
         0lB5O7+3ONWlPc/7kLwL5aUr/wbg5gwWCoKLx/ABbr3BVuy6j1YWghgDzlwlx7j2m+di
         sybnQL/svTf7YslkPFzt5VOGY/ld8pmImNPm22oiP5FTm4bWSdthxABrgxmRELPTtE42
         cVXUfiDYymPu7T6sxMPIPsNKTPaK0sZRBzyfI3Ir3naqjhs6HVVcv/SMV15BC5wannOX
         OCSw==
X-Gm-Message-State: APjAAAW8WkPfTOdfNu5g4F/o46LPbLHI3tOKO4QLmcadaOwEhOCvFd2i
        Sh4gmxB1/jhumVYlPWLyxSGEZ+ExW1CLZaXjxbA=
X-Google-Smtp-Source: APXvYqyHQRSFM1NpPLRTJdY/Wn0yEOw/S67WqRrj5XFJ24vVAfK3niA+bjiPg/uqGcfuFhQx2CzhJDAa0iEVdwpRmJQ=
X-Received: by 2002:a02:b46c:: with SMTP id w41mr2114137jaj.83.1553017106256;
 Tue, 19 Mar 2019 10:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306110501-mutt-send-email-mst@kernel.org>
 <bd029eb2-501a-8d2d-5f75-5d2b229c7e75@redhat.com> <20190306130955-mutt-send-email-mst@kernel.org>
 <ce55943e-87b6-c102-9827-2cfd45b7192c@redhat.com> <CAKgT0UcGCFNQRZFmp8oMkG+wKzRtwN292vtFWgyLsdyRnO04gQ@mail.gmail.com>
 <ed9f7c2e-a7e3-a990-bcc3-459e4f2b4a44@redhat.com> <4bd54f8b-3e9a-3493-40be-668962282431@redhat.com>
 <6d744ed6-9c1c-b29f-aa32-d38387187b74@redhat.com>
In-Reply-To: <6d744ed6-9c1c-b29f-aa32-d38387187b74@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 19 Mar 2019 10:38:15 -0700
Message-ID: <CAKgT0UcBDKr0ACHQWUCvmm8atxM6wSu7aCRFJkFvfjT_W_femQ@mail.gmail.com>
Subject: Re: [RFC][Patch v9 0/6] KVM: Guest Free Page Hinting
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 9:04 AM Nitesh Narayan Lal <nitesh@redhat.com> wrot=
e:
>
> On 3/19/19 9:33 AM, David Hildenbrand wrote:
> > On 18.03.19 16:57, Nitesh Narayan Lal wrote:
> >> On 3/14/19 12:58 PM, Alexander Duyck wrote:
> >>> On Thu, Mar 14, 2019 at 9:43 AM Nitesh Narayan Lal <nitesh@redhat.com=
> wrote:
> >>>> On 3/6/19 1:12 PM, Michael S. Tsirkin wrote:
> >>>>> On Wed, Mar 06, 2019 at 01:07:50PM -0500, Nitesh Narayan Lal wrote:
> >>>>>> On 3/6/19 11:09 AM, Michael S. Tsirkin wrote:
> >>>>>>> On Wed, Mar 06, 2019 at 10:50:42AM -0500, Nitesh Narayan Lal wrot=
e:
> >>>>>>>> The following patch-set proposes an efficient mechanism for hand=
ing freed memory between the guest and the host. It enables the guests with=
 no page cache to rapidly free and reclaims memory to and from the host res=
pectively.
> >>>>>>>>
> >>>>>>>> Benefit:
> >>>>>>>> With this patch-series, in our test-case, executed on a single s=
ystem and single NUMA node with 15GB memory, we were able to successfully l=
aunch 5 guests(each with 5 GB memory) when page hinting was enabled and 3 w=
ithout it. (Detailed explanation of the test procedure is provided at the b=
ottom under Test - 1).
> >>>>>>>>
> >>>>>>>> Changelog in v9:
> >>>>>>>>    * Guest free page hinting hook is now invoked after a page ha=
s been merged in the buddy.
> >>>>>>>>         * Free pages only with order FREE_PAGE_HINTING_MIN_ORDER=
(currently defined as MAX_ORDER - 1) are captured.
> >>>>>>>>    * Removed kthread which was earlier used to perform the scann=
ing, isolation & reporting of free pages.
> >>>>>>>>    * Pages, captured in the per cpu array are sorted based on th=
e zone numbers. This is to avoid redundancy of acquiring zone locks.
> >>>>>>>>         * Dynamically allocated space is used to hold the isolat=
ed guest free pages.
> >>>>>>>>         * All the pages are reported asynchronously to the host =
via virtio driver.
> >>>>>>>>         * Pages are returned back to the guest buddy free list o=
nly when the host response is received.
> >>>>>>>>
> >>>>>>>> Pending items:
> >>>>>>>>         * Make sure that the guest free page hinting's current i=
mplementation doesn't break hugepages or device assigned guests.
> >>>>>>>>    * Follow up on VIRTIO_BALLOON_F_PAGE_POISON's device side sup=
port. (It is currently missing)
> >>>>>>>>         * Compare reporting free pages via vring with vhost.
> >>>>>>>>         * Decide between MADV_DONTNEED and MADV_FREE.
> >>>>>>>>    * Analyze overall performance impact due to guest free page h=
inting.
> >>>>>>>>    * Come up with proper/traceable error-message/logs.
> >>>>>>>>
> >>>>>>>> Tests:
> >>>>>>>> 1. Use-case - Number of guests we can launch
> >>>>>>>>
> >>>>>>>>    NUMA Nodes =3D 1 with 15 GB memory
> >>>>>>>>    Guest Memory =3D 5 GB
> >>>>>>>>    Number of cores in guest =3D 1
> >>>>>>>>    Workload =3D test allocation program allocates 4GB memory, to=
uches it via memset and exits.
> >>>>>>>>    Procedure =3D
> >>>>>>>>    The first guest is launched and once its console is up, the t=
est allocation program is executed with 4 GB memory request (Due to this th=
e guest occupies almost 4-5 GB of memory in the host in a system without pa=
ge hinting). Once this program exits at that time another guest is launched=
 in the host and the same process is followed. We continue launching the gu=
ests until a guest gets killed due to low memory condition in the host.
> >>>>>>>>
> >>>>>>>>    Results:
> >>>>>>>>    Without hinting =3D 3
> >>>>>>>>    With hinting =3D 5
> >>>>>>>>
> >>>>>>>> 2. Hackbench
> >>>>>>>>    Guest Memory =3D 5 GB
> >>>>>>>>    Number of cores =3D 4
> >>>>>>>>    Number of tasks         Time with Hinting       Time without =
Hinting
> >>>>>>>>    4000                    19.540                  17.818
> >>>>>>>>
> >>>>>>> How about memhog btw?
> >>>>>>> Alex reported:
> >>>>>>>
> >>>>>>>     My testing up till now has consisted of setting up 4 8GB VMs =
on a system
> >>>>>>>     with 32GB of memory and 4GB of swap. To stress the memory on =
the system I
> >>>>>>>     would run "memhog 8G" sequentially on each of the guests and =
observe how
> >>>>>>>     long it took to complete the run. The observed behavior is th=
at on the
> >>>>>>>     systems with these patches applied in both the guest and on t=
he host I was
> >>>>>>>     able to complete the test with a time of 5 to 7 seconds per g=
uest. On a
> >>>>>>>     system without these patches the time ranged from 7 to 49 sec=
onds per
> >>>>>>>     guest. I am assuming the variability is due to time being spe=
nt writing
> >>>>>>>     pages out to disk in order to free up space for the guest.
> >>>>>>>
> >>>>>> Here are the results:
> >>>>>>
> >>>>>> Procedure: 3 Guests of size 5GB is launched on a single NUMA node =
with
> >>>>>> total memory of 15GB and no swap. In each of the guest, memhog is =
run
> >>>>>> with 5GB. Post-execution of memhog, Host memory usage is monitored=
 by
> >>>>>> using Free command.
> >>>>>>
> >>>>>> Without Hinting:
> >>>>>>                  Time of execution    Host used memory
> >>>>>> Guest 1:        45 seconds            5.4 GB
> >>>>>> Guest 2:        45 seconds            10 GB
> >>>>>> Guest 3:        1  minute               15 GB
> >>>>>>
> >>>>>> With Hinting:
> >>>>>>                 Time of execution     Host used memory
> >>>>>> Guest 1:        49 seconds            2.4 GB
> >>>>>> Guest 2:        40 seconds            4.3 GB
> >>>>>> Guest 3:        50 seconds            6.3 GB
> >>>>> OK so no improvement. OTOH Alex's patches cut time down to 5-7 seco=
nds
> >>>>> which seems better. Want to try testing Alex's patches for comparis=
on?
> >>>>>
> >>>> I realized that the last time I reported the memhog numbers, I didn'=
t
> >>>> enable the swap due to which the actual benefits of the series were =
not
> >>>> shown.
> >>>> I have re-run the test by including some of the changes suggested by
> >>>> Alexander and David:
> >>>>     * Reduced the size of the per-cpu array to 32 and minimum hintin=
g
> >>>> threshold to 16.
> >>>>     * Reported length of isolated pages along with start pfn, instea=
d of
> >>>> the order from the guest.
> >>>>     * Used the reported length to madvise the entire length of addre=
ss
> >>>> instead of a single 4K page.
> >>>>     * Replaced MADV_DONTNEED with MADV_FREE.
> >>>>
> >>>> Setup for the test:
> >>>> NUMA node:1
> >>>> Memory: 15GB
> >>>> Swap: 4GB
> >>>> Guest memory: 6GB
> >>>> Number of core: 1
> >>>>
> >>>> Process: A guest is launched and memhog is run with 6GB. As its
> >>>> execution is over next guest is launched. Everytime memhog execution
> >>>> time is monitored.
> >>>> Results:
> >>>>     Without Hinting:
> >>>>                  Time of execution
> >>>>     Guest1:    22s
> >>>>     Guest2:    24s
> >>>>     Guest3: 1m29s
> >>>>
> >>>>     With Hinting:
> >>>>                 Time of execution
> >>>>     Guest1:    24s
> >>>>     Guest2:    25s
> >>>>     Guest3:    28s
> >>>>
> >>>> When hinting is enabled swap space is not used until memhog with 6GB=
 is
> >>>> ran in 6th guest.
> >>> So one change you may want to make to your test setup would be to
> >>> launch the tests sequentially after all the guests all up, instead of
> >>> combining the test and guest bring-up. In addition you could run
> >>> through the guests more than once to determine a more-or-less steady
> >>> state in terms of the performance as you move between the guests afte=
r
> >>> they have hit the point of having to either swap or pull MADV_FREE
> >>> pages.
> >> I tried running memhog as you suggested, here are the results:
> >> Setup for the test:
> >> NUMA node:1
> >> Memory: 15GB
> >> Swap: 4GB
> >> Guest memory: 6GB
> >> Number of core: 1
> >>
> >> Process: 3 guests are launched and memhog is run with 6GB. Results are
> >> monitored after 1st-time execution of memhog. Memhog is launched
> >> sequentially in each of the guests and time is observed after the
> >> execution of all 3 memhog is over.
> >>
> >> Results:
> >> Without Hinting
> >>     Time of Execution
> >> 1.    6m48s
> >> 2.    6m9s
> >>
> >> With Hinting
> >> Array size:16 Minimum Threshold:8
> >> 1.    2m57s
> >> 2.    2m20s
> >>
> >> The memhog execution time in the case of hinting is still not that low
> >> as we would have expected. This is due to the usage of swap space.
> >> Although wrt to non-hinting when swap used space is around 3.5G, with
> >> hinting it remains to around 1.1-1.5G.
> >> I did try using a zone free page barrier which prevented hinting when
> >> free pages of order HINTING_ORDER goes below 256. This further brings
> >> down the swap usage to 100-150 MB. The tricky part of this approach is
> >> to configure this barrier condition for different guests.
> >>
> >> Array size:16 Minimum Threshold:8
> >> 1.    1m16s
> >> 2.    1m41s
> >>
> >> Note: Memhog time does seem to vary a little bit on every boot with or
> >> without hinting.
> >>
> > I don't quite understand yet why "hinting more pages" (no free page
> > barrier) should result in a higher swap usage in the hypervisor
> > (1.1-1.5GB vs. 100-150 MB). If we are "hinting more pages" I would have
> > guessed that runtime could get slower, but not that we need more swap.
> >
> > One theory:
> >
> > If you hint all MAX_ORDER - 1 pages, at one point it could be that all
> > "remaining" free pages are currently isolated to be hinted. As MM needs
> > more pages for a process, it will fallback to using "MAX_ORDER - 2"
> > pages and so on. These pages, when they are freed, you won't hint
> > anymore unless they get merged. But after all they won't get merged
> > because they can't be merged (otherwise they wouldn't be "MAX_ORDER - 2=
"
> > after all right from the beginning).
> >
> > Try hinting a smaller granularity to see if this could actually be the =
case.
> So I have two questions in my mind after looking at the results now:
> 1. Why swap is coming into the picture when hinting is enabled?
> 2. Same to what you have raised.
> For the 1st question, I think the answer is: (correct me if I am wrong.)
> Memhog while writing the memory does free memory but the pages it frees
> are of a lower order which doesn't merge until the memhog write
> completes. After which we do get the MAX_ORDER - 1 page from the buddy
> resulting in hinting.
> As all 3 memhog are running parallelly we don't get free memory until
> one of them completes.
> This does explain that when 3 guests each of 6GB on a 15GB host tries to
> run memhog with 6GB parallelly, swap comes into the picture even if
> hinting is enabled.

Are you running them in parallel or sequentially? I had suggested
running them serially so that the previous one could complete and free
the memory before the next one allocated memory. In that setup you
should see the guests still swapping without hints, but with hints the
guest should free the memory up before the next one starts using it.
If you are running them in parallel then you are going to see things
going to swap because memhog does like what the name implies and it
will use all of the memory you give it. It isn't until it completes
that the memory is freed.

> This doesn't explain why putting a barrier or avoid hinting reduced the
> swap usage. It seems I possibly had a wrong impression of the delaying
> hinting idea which we discussed.
> As I was observing the value of the swap at the end of the memhog
> execution which is logically incorrect. I will re-run the test and
> observe the highest swap usage during the entire execution of memhog for
> hinting vs non-hinting.

So one option you may look at if you are wanting to run the tests in
parallel would be to limit the number of tests you have running at the
same time. If you have 15G of memory and 6G per guest you should be
able to run 2 sessions at a time without going to swap, however if you
run all 3 then you are likely going to be going to swap even with
hinting.

- Alex
