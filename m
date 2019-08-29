Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA66C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2814922CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfH2DZL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:25:11 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:39604 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfH2DZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:25:10 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x7T3Or8A010001
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Aug 2019 12:24:53 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7T3Or60018255;
        Thu, 29 Aug 2019 12:24:53 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x7T3Or8q018852;
        Thu, 29 Aug 2019 12:24:53 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-545660; Thu, 29 Aug 2019 10:47:15 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Thu,
 29 Aug 2019 10:47:14 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>
CC:     Dan Williams <dan.j.williams@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
Thread-Topic: [PATCH v2] fs/proc/page: Skip uninitialized page when
 iterating page structures
Thread-Index: AQHVXab+AB6W4hF4zE+DO3WxOpzL56cQAkYAgAACh4CAAMCOgA==
Date:   Thu, 29 Aug 2019 01:47:13 +0000
Message-ID: <9a1395bc-d568-c4d7-2dde-7dde7b48ac0b@vx.jp.nec.com>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190827142238.GB10223@dhcp22.suse.cz>
 <20190828080006.GG7386@dhcp22.suse.cz>
 <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
 <20190828140938.GL28313@dhcp22.suse.cz>
 <4367f507-97ba-a74e-6bf5-811cdd6ecdf9@redhat.com>
In-Reply-To: <4367f507-97ba-a74e-6bf5-811cdd6ecdf9@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <43FF7CD7AC5C9E4DA042E82DA36846D9@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/08/28 23:18, Waiman Long wrote:
> On 8/28/19 10:09 AM, Michal Hocko wrote:
>> On Wed 28-08-19 09:46:21, Waiman Long wrote:
>>> On 8/28/19 4:00 AM, Michal Hocko wrote:
>>>> On Tue 27-08-19 16:22:38, Michal Hocko wrote:
>>>>> Dan, isn't this something we have discussed recently?
>>>> This was http://lkml.kernel.org/r/20190725023100.31141-3-t-fukasawa@vx.jp.nec.com
>>>> and talked about /proc/kpageflags but this is essentially the same thing
>>>> AFAIU. I hope we get a consistent solution for both issues.
>>>>
>>> Yes, it is the same problem. The uninitialized page structure problem
>>> affects all the 3 /proc/kpage{cgroup,count,flags) files.
>>>
>>> Toshiki's patch seems to fix it just for /proc/kpageflags, though.
>> Yup. I was arguing that whacking a mole kinda fix is far from good. Dan
>> had some arguments on why initializing those struct pages is a problem.
>> The discussion had a half open end though. I hoped that Dan would try
>> out the initialization side but I migh have misunderstood.
> 
> If the page structures of the reserved PFNs are always initialized, that
> will fix the problem too. I am not familiar with the zone device code.
> So I didn't attempt to do that.
> 
> Cheers,
> Longman
> 
> 
I also think that the struct pages should be initialized.
I'm preparing to post the patch.

Toshiki Fukasawa
