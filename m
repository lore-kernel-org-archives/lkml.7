Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD81C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FCD20725
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrvMLmzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfKNNXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:23:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbfKNNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573737831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQmO1bX1ItKkJ56mUMdf+6chXrpN8htfOF3G6ok4vMU=;
        b=hrvMLmzWjg4X9wy44Iws+faouf/00WbgNcryqTXxWOgVuLkZhQVAwt0cGjigA6w6Zs8KPQ
        7AhpC7W6c2arHeza95TPsuJTR9vc2z91klROiJUNhuppSefGbD8qaD6vNkoxZ06gEsaFGX
        rRNbchqRxU1DWtFcErnGEShxHfKjQnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Tl2fAhoPOLK_4ZwSTijbTA-1; Thu, 14 Nov 2019 08:23:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B460C107ACFB;
        Thu, 14 Nov 2019 13:23:44 +0000 (UTC)
Received: from [10.36.117.13] (ovpn-117-13.ams2.redhat.com [10.36.117.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0472F67580;
        Thu, 14 Nov 2019 13:23:41 +0000 (UTC)
Subject: Re: [RFC v3] writeback: add elastic bdi in cgwb bdp
To:     Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, Rong Chen <rong.a.chen@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20191112034227.3112-1-hdanton@sina.com>
 <20191114093832.8504-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <7c16bc60-5243-07e8-5783-089e477c2693@redhat.com>
Date:   Thu, 14 Nov 2019 14:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114093832.8504-1-hdanton@sina.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Tl2fAhoPOLK_4ZwSTijbTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.19 10:38, Hillf Danton wrote:
>=20
> On Tue, 12 Nov 2019 17:02:36 -0800 Andrew Morton wrote:
>>
>> On Tue, 12 Nov 2019 11:42:27 +0800 Hillf Danton <hdanton@sina.com> wrote=
:
>>>
>>> The elastic bdi (ebdi) which is the mirror bdi of spinning disk,
>>> SSD and USB key on market is introduced to balancing dirty pages
>>> (bdp).
>>>
>>> The risk arises that system runs out of free memory, when dirty
>>> pages are produced too many too soon, so bdp is needed in field.
>>>
>>> Ebdi facilitates bdp in elastic time intervals e.g. from a jiffy
>>> to one HZ, depending on the time it would take to increase dirty
>>> pages by the amount which is defined by the variable
>>> ratelimit_pages.
>>>
>>> During cgroup writeback (cgwb) bdp, ebdi helps observe the
>>> changes both in cgwb's dirty pages (dirty speed) and in
>>> written-out pages (laundry speed) in elastic time intervals,
>>> until a balance is established between the two parties i.e.
>>> the two speeds statistically equal.
>>>
>>> The above mechanism of elastic equilibrium effectively prevents
>>> dirty page hogs, as no chance is left for dirty pages to pile up,
>>> thus cuts the risk that system free memory falls to unsafe level.
>>>
>>> Thanks to Rong Chen for testing.
>>
>> That sounds like a Tested-by:
>>
> Yes, Sir, will add Tested-by: Rong Chen <rong.a.chen@intel.com>
>=20
>> The changelog has no testing results.  Please prepare results which
>> show, amongst other things, the change in performance when the kernel
>> isn't tight on memory.  As well as the alteration in behaviour when
>> memory is short.
>>
> Will do.
>=20
>> Generally, please work on making this code much more understandable?
>>
> Will do.
>=20
>>>
>>> ...
>>>
>>> --- a/fs/fs-writeback.c
>>> +++ b/fs/fs-writeback.c
>>> @@ -811,6 +811,8 @@ static long wb_split_bdi_pages(struct bd
>>>   =09if (nr_pages =3D=3D LONG_MAX)
>>>   =09=09return LONG_MAX;
>>>  =20
>>> +=09return nr_pages;
>>> +
>>>   =09/*
>>>   =09 * This may be called on clean wb's and proportional distribution
>>>   =09 * may not make sense, just use the original @nr_pages in those
>>> @@ -1604,6 +1606,7 @@ static long writeback_chunk_size(struct
>>>   =09=09pages =3D min(pages, work->nr_pages);
>>>   =09=09pages =3D round_down(pages + MIN_WRITEBACK_PAGES,
>>>   =09=09=09=09   MIN_WRITEBACK_PAGES);
>>> +=09=09pages =3D work->nr_pages;
>>
>> It's unclear what this is doing, but it makes the three preceding
>> statements non-operative.
>>
> This change, and the above one as well, is trying to bypass the
> current bandwidth, and a couple of rounds of cleanup are needed
> after it survives the LTP.
>=20
>>>   =09}
>>>  =20
>>>   =09return pages;
>>> @@ -2092,6 +2095,9 @@ void wb_workfn(struct work_struct *work)
>>>   =09=09wb_wakeup_delayed(wb);
>>>  =20
>>>   =09current->flags &=3D ~PF_SWAPWRITE;
>>> +
>>> +=09if (waitqueue_active(&wb->bdp_waitq))
>>> +=09=09wake_up_all(&wb->bdp_waitq);
>>
>> Please add a comment explaining why this is being done here.
>>
> After writing out some dirty pages, it it a check point to see if
> a balance is already set up between the dirty speed and laundry
> speed. Those under throttling will be unthrottled after seeing
> a balance in place.
>=20
> A comment will be added.
>=20
>>>   }
>>>  =20
>>>   /*
>>> --- a/mm/page-writeback.c
>>> +++ b/mm/page-writeback.c
>>> @@ -1830,6 +1830,67 @@ pause:
>>>   =09=09wb_start_background_writeback(wb);
>>>   }
>>>  =20
>>> +/**
>>> + * cgwb_bdp_should_throttle()=09tell if a wb should be throttled
>>> + * @wb bdi_writeback to throttle
>>> + *
>>> + * To avoid the risk of exhausting the system free memory, we check
>>> + * and try much to prevent too many dirty pages from being produced
>>> + * too soon.
>>> + *
>>> + * For cgroup writeback, it is essencially to keep an equilibrium
>>
>> "it is essential"?
>>
> Yes Sir.
>=20
>>> + * between its dirty speed and laundry speed i.e. dirty pages are
>>> + * written out as fast as they are produced in an ideal state.
>>> + */
>>> +static bool cgwb_bdp_should_throttle(struct bdi_writeback *wb)
>>> +{
>>> +=09struct dirty_throttle_control gdtc =3D { GDTC_INIT_NO_WB };
>>> +
>>> +=09if (fatal_signal_pending(current))
>>> +=09=09return false;
>>> +
>>> +=09gdtc.avail =3D global_dirtyable_memory();
>>> +
>>> +=09domain_dirty_limits(&gdtc);
>>> +
>>> +=09gdtc.dirty =3D global_node_page_state(NR_FILE_DIRTY) +
>>> +=09=09     global_node_page_state(NR_UNSTABLE_NFS) +
>>> +=09=09     global_node_page_state(NR_WRITEBACK);
>>> +
>>> +=09if (gdtc.dirty < gdtc.bg_thresh)
>>> +=09=09return false;
>>> +
>>> +=09if (!writeback_in_progress(wb))
>>> +=09=09wb_start_background_writeback(wb);
>>
>> This is a bit ugly.  Something called "bool cgwb_bdp_should_throttle()"
>> shoiuld just check whether we should throttle.  But here it is, also
>> initiating writeback.  That's an inappropriate thing for this function
>> to do?
>>
> It is the current bdp behavior trying to keep dirty pages below the
> user-configurable background threshold by waking up flushers, because
> no dirty page will be sent to disk without flusher's efforts, please
> see 143dfe8611a6 ("writeback: IO-less balance_dirty_pages()").
>=20
> Will try to find some chance to pinch it out.
>=20
>> Also, we don't know *why* this is being done here, because there's no
>> code comment explaining the reasoning to us.
>>
> Will add a comment.
>=20
>>
>>> +=09if (gdtc.dirty < gdtc.thresh)
>>> +=09=09return false;
>>> +
>>> +=09/*
>>> +=09 * throttle wb if there is the risk that wb's dirty speed is
>>> +=09 * running away from its laundry speed, better with statistic
>>> +=09 * error taken into account.
>>> +=09 */
>>> +=09return  wb_stat(wb, WB_DIRTIED) >
>>> +=09=09wb_stat(wb, WB_WRITTEN) + wb_stat_error();
>>> +}
>>> +
>>>
>>> ...
>>>
>>> @@ -1888,29 +1945,38 @@ void balance_dirty_pages_ratelimited(str
>>>   =09 * 1000+ tasks, all of them start dirtying pages at exactly the sa=
me
>>>   =09 * time, hence all honoured too large initial task->nr_dirtied_pau=
se.
>>>   =09 */
>>> -=09p =3D  this_cpu_ptr(&bdp_ratelimits);
>>> -=09if (unlikely(current->nr_dirtied >=3D ratelimit))
>>> -=09=09*p =3D 0;
>>> -=09else if (unlikely(*p >=3D ratelimit_pages)) {
>>> -=09=09*p =3D 0;
>>> -=09=09ratelimit =3D 0;
>>> -=09}
>>> +=09dirty =3D this_cpu_ptr(&bdp_ratelimits);
>>> +
>>>   =09/*
>>>   =09 * Pick up the dirtied pages by the exited tasks. This avoids lots=
 of
>>>   =09 * short-lived tasks (eg. gcc invocations in a kernel build) escap=
ing
>>>   =09 * the dirty throttling and livelock other long-run dirtiers.
>>>   =09 */
>>> -=09p =3D this_cpu_ptr(&dirty_throttle_leaks);
>>> -=09if (*p > 0 && current->nr_dirtied < ratelimit) {
>>> -=09=09unsigned long nr_pages_dirtied;
>>> -=09=09nr_pages_dirtied =3D min(*p, ratelimit - current->nr_dirtied);
>>> -=09=09*p -=3D nr_pages_dirtied;
>>> -=09=09current->nr_dirtied +=3D nr_pages_dirtied;
>>> +=09leak =3D this_cpu_ptr(&dirty_throttle_leaks);
>>> +
>>> +=09if (*dirty + *leak < ratelimit_pages) {
>>> +=09=09/*
>>> +=09=09 * nothing to do as it would take some more time to
>>> +=09=09 * eat out ratelimit_pages
>>> +=09=09 */
>>> +=09=09try_bdp =3D false;
>>> +=09} else {
>>> +=09=09try_bdp =3D true;
>>> +
>>> +=09=09/*
>>> +=09=09 * bdp in flight helps detect dirty page hogs soon
>>> +=09=09 */
>>
>> How?  Please expand on this comment a lot.
>>
> We should be cautious here in red zone after paying the ratelimit_pages
> price; we might soon have to tackle a deluge of dirty page hogs.
>=20
> Will cut it.
>=20
>>> +=09=09flights =3D this_cpu_ptr(&bdp_in_flight);
>>> +
>>> +=09=09if ((*flights)++ & 1) {
>>
>> What is that "& 1" doing?
>>
> It helps to tell if a bdp is alredy in flight.
>=20
> It would have been something like
>=20
> =09=09if (*flights =3D=3D 0) {
> =09=09=09(*flights)++;
> =09=09} else {
> =09=09=09*flights =3D 0;
>>> +=09=09=09*dirty =3D *dirty + *leak - ratelimit_pages;
>>> +=09=09=09*leak =3D 0;
>>> +=09=09}
>=20
> but I was curious to see the flights in long run.
>=20
> Thanks
> Hillf
>=20
>>>   =09}
>>>   =09preempt_enable();
>>>  =20
>>> -=09if (unlikely(current->nr_dirtied >=3D ratelimit))
>>> -=09=09balance_dirty_pages(wb, current->nr_dirtied);
>>> +=09if (try_bdp)
>>> +=09=09cgwb_bdp(wb);
>>>  =20
>>>   =09wb_put(wb);
>=20
>=20

Friendly note that your mail client is messing up the thread hierarchy=20
again (I think it was correct for a while):

Message-Id: <20191114093832.8504-1-hdanton@sina.com>
In-Reply-To: <20191112034227.3112-1-hdanton@sina.com>
References: <20191112034227.3112-1-hdanton@sina.com>

I assume a kernel developer can setup a mail client or switch to a sane=20
one. Please don't prove me wrong. ;)

--=20

Thanks,

David / dhildenb

