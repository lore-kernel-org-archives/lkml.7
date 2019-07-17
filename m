Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3019AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC052173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfGQFjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:39:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfGQFjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:39:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6H5bYWH101663
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:39:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsurwv7h7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:39:05 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 17 Jul 2019 06:39:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 06:38:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6H5cwd743843590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:38:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F244F11C052;
        Wed, 17 Jul 2019 05:38:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A03411C04A;
        Wed, 17 Jul 2019 05:38:56 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.35.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jul 2019 05:38:56 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     dan.j.williams@intel.com, david@redhat.com,
        pasha.tatashin@soleen.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: Fix shrink_{zone,node}_span
In-Reply-To: <1563225851.3143.24.camel@suse.de>
References: <20190715081549.32577-1-osalvador@suse.de> <20190715081549.32577-3-osalvador@suse.de> <87tvbne0rd.fsf@linux.ibm.com> <1563225851.3143.24.camel@suse.de>
Date:   Wed, 17 Jul 2019 11:08:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071705-0008-0000-0000-000002FE32CD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071705-0009-0000-0000-0000226BAB32
Message-Id: <87o91tcj9t.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Mon, 2019-07-15 at 21:41 +0530, Aneesh Kumar K.V wrote:
>> Oscar Salvador <osalvador@suse.de> writes:
>> 
>> > Since [1], shrink_{zone,node}_span work on PAGES_PER_SUBSECTION
>> > granularity.
>> > The problem is that deactivation of the section occurs later on in
>> > sparse_remove_section, so pfn_valid()->pfn_section_valid() will
>> > always return
>> > true before we deactivate the {sub}section.
>> 
>> Can you explain this more? The patch doesn't update section_mem_map
>> update sequence. So what changed? What is the problem in finding
>> pfn_valid() return true there?
>
> I realized that the changelog was quite modest, so a better explanation
>  will follow.
>
> Let us analize what shrink_{zone,node}_span does.
> We have to remember that shrink_zone_span gets called every time a
> section is to be removed.
>
> There can be three possibilites:
>
> 1) section to be removed is the first one of the zone
> 2) section to be removed is the last one of the zone
> 3) section to be removed falls in the middle
>  
> For 1) and 2) cases, we will try to find the next section from
> bottom/top, and in the third case we will check whether the section
> contains only holes.
>
> Now, let us take the example where a ZONE contains only 1 section, and
> we remove it.
> The last loop of shrink_zone_span, will check for {start_pfn,end_pfn]
> PAGES_PER_SECTION block the following:
>
> - section is valid
> - pfn relates to the current zone/nid
> - section is not the section to be removed
>
> Since we only got 1 section here, the check "start_pfn == pfn" will make us to continue the loop and then we are done.
>
> Now, what happens after the patch?
>
> We increment pfn on subsection basis, since "start_pfn == pfn", we jump
> to the next sub-section (pfn+512), and call pfn_valid()-
>>pfn_section_valid().
> Since section has not been yet deactivded, pfn_section_valid() will
> return true, and we will repeat this until the end of the loop.
>
> What should happen instead is:
>
> - we deactivate the {sub}-section before calling
> shirnk_{zone,node}_span
> - calls to pfn_valid() will now return false for the sections that have
> been deactivated, and so we will get the pfn from the next activaded
> sub-section, or nothing if the section is empty (section do not contain
> active sub-sections).
>
> The example relates to the last loop in shrink_zone_span, but the same
> applies to find_{smalles,biggest}_section.
>
> Please, note that we could probably do some hack like replacing:
>
> start_pfn == pfn 
>
> with
>
> pfn < end_pfn

Why do you consider this a hack? 

 /* If the section is current section, it continues the loop */
	if (start_pfn == pfn)
		continue;

The comment explains that check is there to handle the exact scenario
that you are fixing in this patch. With subsection patch that check is
not sufficient. Shouldn't we just fix the check to handle that?

Not sure about your comment w.r.t find_{smalles,biggest}_section. We
search with pfn range outside the subsection we are trying to remove.
So this should not have an impact there?


>
> But the way to fix this is to 1) deactivate {sub}-section and 2) let
> shrink_{node,zone}_span find the next active {sub-section}.
>
> I hope this makes it more clear.

-aneesh

