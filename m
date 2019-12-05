Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE2FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EA021744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfLECPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbfLECPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:20 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB52CdJE100403
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 21:15:19 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wnqm3vxmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 21:15:19 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Thu, 5 Dec 2019 02:15:16 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 02:15:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB52FBTa47055262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 02:15:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACDB852051;
        Thu,  5 Dec 2019 02:15:11 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.193.7])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 890735205A;
        Thu,  5 Dec 2019 02:15:08 +0000 (GMT)
Date:   Wed, 4 Dec 2019 18:15:05 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <0b56ce3e-6c32-5f3b-e7cc-0d419a61d71d@ozlabs.ru>
 <20191203040509.GB12354@oc0525413822.ibm.com>
 <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru>
 <20191203165204.GA5079@oc0525413822.ibm.com>
 <3a17372a-fcee-efbf-0a05-282ffb1adc90@ozlabs.ru>
 <20191204004958.GB5063@oc0525413822.ibm.com>
 <5963ff32-2119-be7c-d1e5-63457888a73b@ozlabs.ru>
 <20191204033618.GA5031@umbus.fritz.box>
 <20191204204232.GE5063@oc0525413822.ibm.com>
 <c2dda233-2a11-a066-5d44-68e2a0b5121e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2dda233-2a11-a066-5d44-68e2a0b5121e@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120502-0012-0000-0000-0000037155A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120502-0013-0000-0000-000021AD186A
Message-Id: <20191205021505.GF5063@oc0525413822.ibm.com>
Subject: RE: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with
 the hypervisor.y
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_04:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 suspectscore=18 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 09:26:14AM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 05/12/2019 07:42, Ram Pai wrote:
> > On Wed, Dec 04, 2019 at 02:36:18PM +1100, David Gibson wrote:
> >> On Wed, Dec 04, 2019 at 12:08:09PM +1100, Alexey Kardashevskiy wrote:
> >>>
> >>>
> >>> On 04/12/2019 11:49, Ram Pai wrote:
> >>>> On Wed, Dec 04, 2019 at 11:04:04AM +1100, Alexey Kardashevskiy wrote:
> >>>>>
> >>>>>
> >>>>> On 04/12/2019 03:52, Ram Pai wrote:
> >>>>>> On Tue, Dec 03, 2019 at 03:24:37PM +1100, Alexey Kardashevskiy wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 03/12/2019 15:05, Ram Pai wrote:
> >>>>>>>> On Tue, Dec 03, 2019 at 01:15:04PM +1100, Alexey Kardashevskiy wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 03/12/2019 13:08, Ram Pai wrote:
> >>>>>>>>>> On Tue, Dec 03, 2019 at 11:56:43AM +1100, Alexey Kardashevskiy wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On 02/12/2019 17:45, Ram Pai wrote:
> >>>>>>>>>>>> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> >>>>>>>>>>>> its parameters. One page is dedicated per cpu, for the lifetime of the
> >>>>>>>>>>>> kernel for this purpose. On secure VMs, contents of this page, when
> >>>>>>>>>>>> accessed by the hypervisor, retrieves encrypted TCE entries.  Hypervisor
> >>>>>>>>>>>> needs to know the unencrypted entries, to update the TCE table
> >>>>>>>>>>>> accordingly.  There is nothing secret or sensitive about these entries.
> >>>>>>>>>>>> Hence share the page with the hypervisor.
> >>>>>>>>>>>
> >>>>>>>>>>> This unsecures a page in the guest in a random place which creates an
> >>>>>>>>>>> additional attack surface which is hard to exploit indeed but
> >>>>>>>>>>> nevertheless it is there.
> >>>>>>>>>>> A safer option would be not to use the
> >>>>>>>>>>> hcall-multi-tce hyperrtas option (which translates FW_FEATURE_MULTITCE
> >>>>>>>>>>> in the guest).
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Hmm... How do we not use it?  AFAICT hcall-multi-tce option gets invoked
> >>>>>>>>>> automatically when IOMMU option is enabled.
> >>>>>>>>>
> >>>>>>>>> It is advertised by QEMU but the guest does not have to use it.
> >>>>>>>>
> >>>>>>>> Are you suggesting that even normal-guest, not use hcall-multi-tce?
> >>>>>>>> or just secure-guest?  
> >>>>>>>
> >>>>>>>
> >>>>>>> Just secure.
> >>>>>>
> >>>>>> hmm..  how are the TCE entries communicated to the hypervisor, if
> >>>>>> hcall-multi-tce is disabled?
> >>>>>
> >>>>> Via H_PUT_TCE which updates 1 entry at once (sets or clears).
> >>>>> hcall-multi-tce  enables H_PUT_TCE_INDIRECT (512 entries at once) and
> >>>>> H_STUFF_TCE (clearing, up to 4bln at once? many), these are simply an
> >>>>> optimization.
> >>>>
> >>>> Do you still think, secure-VM should use H_PUT_TCE and not
> >>>> H_PUT_TCE_INDIRECT?  And normal VM should use H_PUT_TCE_INDIRECT?
> >>>> Is there any advantage of special casing it for secure-VMs.
> >>>
> >>>
> >>> Reducing the amount of insecure memory at random location.
> >>
> >> The other approach we could use for that - which would still allow
> >> H_PUT_TCE_INDIRECT, would be to allocate the TCE buffer page from the
> >> same pool that we use for the bounce buffers.  I assume there must
> >> already be some sort of allocator for that?
> > 
> > The allocator for swiotlb is buried deep in the swiotlb code. It is 
> > not exposed to the outside-swiotlb world. Will have to do major surgery
> > to expose it.
> > 
> > I was thinking, maybe we share the page, finish the INDIRECT_TCE call,
> > and unshare the page.  This will address Alexey's concern of having
> > shared pages at random location, and will also give me my performance
> > optimization.  Alexey: ok?
> 
> 
> I really do not see the point. I really think we should to 1:1 mapping
> of swtiotlb buffers using the default 32bit window using H_PUT_TCE and
> this should be more than enough, I do not think the amount of code will
> be dramatically different compared to unsecuring and securing a page or
> using one of swtiotlb pages for this purpose. Thanks,

Ok. I will address your major concern -- "do not create new shared pages
at random location"  in my next version of the patch.  Using the 32bit
DMA window just to map the SWIOTLB buffers, will be some effort. Hope 
we can stage it that way.

RP

