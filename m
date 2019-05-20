Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B25DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED72220656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfETIUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:20:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727878AbfETIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:20:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4K8HOA4121409
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:20:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2skrbdrwen-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 04:20:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Mon, 20 May 2019 09:20:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 May 2019 09:20:39 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4K8KcNM41615518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 08:20:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC194C044;
        Mon, 20 May 2019 08:20:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F1874C050;
        Mon, 20 May 2019 08:20:37 +0000 (GMT)
Received: from in.ibm.com (unknown [9.124.35.55])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 May 2019 08:20:37 +0000 (GMT)
Date:   Mon, 20 May 2019 13:50:35 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     aneesh.kumar@linux.ibm.com, bharata@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        srikanth <sraithal@linux.vnet.ibm.com>
Subject: Re: PROBLEM: Power9: kernel oops on memory hotunplug from ppc64le
 guest
Reply-To: bharata@linux.ibm.com
References: <16a7a635-c592-27e2-75b4-d02071833278@linux.vnet.ibm.com>
 <20190518141434.GA22939@in.ibm.com>
 <878sv1993k.fsf@concordia.ellerman.id.au>
 <20190520042533.GB22939@in.ibm.com>
 <1558327521.633yjtl8ki.astroid@bobo.none>
 <20190520055622.GC22939@in.ibm.com>
 <1558335484.9inx69a7ea.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558335484.9inx69a7ea.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19052008-0016-0000-0000-0000027D850F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052008-0017-0000-0000-000032DA6802
Message-Id: <20190520082035.GD22939@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-20_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905200060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 05:00:21PM +1000, Nicholas Piggin wrote:
> Bharata B Rao's on May 20, 2019 3:56 pm:
> > On Mon, May 20, 2019 at 02:48:35PM +1000, Nicholas Piggin wrote:
> >> >> > git bisect points to
> >> >> >
> >> >> > commit 4231aba000f5a4583dd9f67057aadb68c3eca99d
> >> >> > Author: Nicholas Piggin <npiggin@gmail.com>
> >> >> > Date:   Fri Jul 27 21:48:17 2018 +1000
> >> >> >
> >> >> >     powerpc/64s: Fix page table fragment refcount race vs speculative references
> >> >> >
> >> >> >     The page table fragment allocator uses the main page refcount racily
> >> >> >     with respect to speculative references. A customer observed a BUG due
> >> >> >     to page table page refcount underflow in the fragment allocator. This
> >> >> >     can be caused by the fragment allocator set_page_count stomping on a
> >> >> >     speculative reference, and then the speculative failure handler
> >> >> >     decrements the new reference, and the underflow eventually pops when
> >> >> >     the page tables are freed.
> >> >> >
> >> >> >     Fix this by using a dedicated field in the struct page for the page
> >> >> >     table fragment allocator.
> >> >> >
> >> >> >     Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage")
> >> >> >     Cc: stable@vger.kernel.org # v3.10+
> >> >> 
> >> >> That's the commit that added the BUG_ON(), so prior to that you won't
> >> >> see the crash.
> >> > 
> >> > Right, but the commit says it fixes page table page refcount underflow by
> >> > introducing a new field &page->pt_frag_refcount. Now we are hitting the underflow
> >> > for this pt_frag_refcount.
> >> 
> >> The fixed underflow is caused by a bug (race on page count) that got 
> >> fixed by that patch. You are hitting a different underflow here. It's
> >> not certain my patch caused it, I'm just trying to reproduce now.
> > 
> > Ok.
> 
> Can't reproduce I'm afraid, tried adding and removing 8GB memory from a
> 4GB guest (via host adding / removing memory device), and it just works.

Boot, add 8G, reboot, remove 8G is the sequence to reproduce.

> 
> It's likely to be an edge case like an off by one or rounding error
> that just happens to trigger in your config. Might be easiest if you
> could test with a debug patch.

Sure, I will continue debugging.

Regards,
Bharata.

