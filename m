Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF6C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446A02073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfLDUms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:42:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbfLDUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:42:47 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4Kgg8R016163
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 15:42:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsqvmppm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 15:42:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Wed, 4 Dec 2019 20:42:44 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Dec 2019 20:42:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB4Kgcup52166818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 20:42:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4424C058;
        Wed,  4 Dec 2019 20:42:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 136024C046;
        Wed,  4 Dec 2019 20:42:35 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.193.7])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Dec 2019 20:42:34 +0000 (GMT)
Date:   Wed, 4 Dec 2019 12:42:32 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <f08ace25-fa94-990b-1b6d-a1c0f30d6348@ozlabs.ru>
 <20191203020850.GA12354@oc0525413822.ibm.com>
 <0b56ce3e-6c32-5f3b-e7cc-0d419a61d71d@ozlabs.ru>
 <20191203040509.GB12354@oc0525413822.ibm.com>
 <a0f19e65-81eb-37bd-928b-7a57a8660e3d@ozlabs.ru>
 <20191203165204.GA5079@oc0525413822.ibm.com>
 <3a17372a-fcee-efbf-0a05-282ffb1adc90@ozlabs.ru>
 <20191204004958.GB5063@oc0525413822.ibm.com>
 <5963ff32-2119-be7c-d1e5-63457888a73b@ozlabs.ru>
 <20191204033618.GA5031@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204033618.GA5031@umbus.fritz.box>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19120420-0020-0000-0000-00000393EC24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120420-0021-0000-0000-000021EB164F
Message-Id: <20191204204232.GE5063@oc0525413822.ibm.com>
Subject: RE: [PATCH v4 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with
 the hypervisor.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=18 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912040170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:36:18PM +1100, David Gibson wrote:
> On Wed, Dec 04, 2019 at 12:08:09PM +1100, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 04/12/2019 11:49, Ram Pai wrote:
> > > On Wed, Dec 04, 2019 at 11:04:04AM +1100, Alexey Kardashevskiy wrote:
> > >>
> > >>
> > >> On 04/12/2019 03:52, Ram Pai wrote:
> > >>> On Tue, Dec 03, 2019 at 03:24:37PM +1100, Alexey Kardashevskiy wrote:
> > >>>>
> > >>>>
> > >>>> On 03/12/2019 15:05, Ram Pai wrote:
> > >>>>> On Tue, Dec 03, 2019 at 01:15:04PM +1100, Alexey Kardashevskiy wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> On 03/12/2019 13:08, Ram Pai wrote:
> > >>>>>>> On Tue, Dec 03, 2019 at 11:56:43AM +1100, Alexey Kardashevskiy wrote:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 02/12/2019 17:45, Ram Pai wrote:
> > >>>>>>>>> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> > >>>>>>>>> its parameters. One page is dedicated per cpu, for the lifetime of the
> > >>>>>>>>> kernel for this purpose. On secure VMs, contents of this page, when
> > >>>>>>>>> accessed by the hypervisor, retrieves encrypted TCE entries.  Hypervisor
> > >>>>>>>>> needs to know the unencrypted entries, to update the TCE table
> > >>>>>>>>> accordingly.  There is nothing secret or sensitive about these entries.
> > >>>>>>>>> Hence share the page with the hypervisor.
> > >>>>>>>>
> > >>>>>>>> This unsecures a page in the guest in a random place which creates an
> > >>>>>>>> additional attack surface which is hard to exploit indeed but
> > >>>>>>>> nevertheless it is there.
> > >>>>>>>> A safer option would be not to use the
> > >>>>>>>> hcall-multi-tce hyperrtas option (which translates FW_FEATURE_MULTITCE
> > >>>>>>>> in the guest).
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> Hmm... How do we not use it?  AFAICT hcall-multi-tce option gets invoked
> > >>>>>>> automatically when IOMMU option is enabled.
> > >>>>>>
> > >>>>>> It is advertised by QEMU but the guest does not have to use it.
> > >>>>>
> > >>>>> Are you suggesting that even normal-guest, not use hcall-multi-tce?
> > >>>>> or just secure-guest?  
> > >>>>
> > >>>>
> > >>>> Just secure.
> > >>>
> > >>> hmm..  how are the TCE entries communicated to the hypervisor, if
> > >>> hcall-multi-tce is disabled?
> > >>
> > >> Via H_PUT_TCE which updates 1 entry at once (sets or clears).
> > >> hcall-multi-tce  enables H_PUT_TCE_INDIRECT (512 entries at once) and
> > >> H_STUFF_TCE (clearing, up to 4bln at once? many), these are simply an
> > >> optimization.
> > > 
> > > Do you still think, secure-VM should use H_PUT_TCE and not
> > > H_PUT_TCE_INDIRECT?  And normal VM should use H_PUT_TCE_INDIRECT?
> > > Is there any advantage of special casing it for secure-VMs.
> > 
> > 
> > Reducing the amount of insecure memory at random location.
> 
> The other approach we could use for that - which would still allow
> H_PUT_TCE_INDIRECT, would be to allocate the TCE buffer page from the
> same pool that we use for the bounce buffers.  I assume there must
> already be some sort of allocator for that?

The allocator for swiotlb is buried deep in the swiotlb code. It is 
not exposed to the outside-swiotlb world. Will have to do major surgery
to expose it.

I was thinking, maybe we share the page, finish the INDIRECT_TCE call,
and unshare the page.  This will address Alexey's concern of having
shared pages at random location, and will also give me my performance
optimization.  Alexey: ok?

RP

