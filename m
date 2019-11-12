Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ACDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AB321925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKLBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:15:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfKLBPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:15:45 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAC1C79T087445
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 20:15:44 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7hqf1y6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 20:15:44 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 12 Nov 2019 01:15:41 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 01:15:38 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAC1Fbdv56754268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:15:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BA8DAE057;
        Tue, 12 Nov 2019 01:15:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC6DBAE051;
        Tue, 12 Nov 2019 01:15:33 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.85.181.122])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Nov 2019 01:15:33 +0000 (GMT)
Date:   Mon, 11 Nov 2019 17:15:30 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        hch@lst.de, andmike@us.ibm.com, sukadev@linux.vnet.ibm.com,
        mst@redhat.com, ram.n.pai@gmail.com, aik@ozlabs.ru, cai@lca.pw,
        tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1573254011-1604-1-git-send-email-linuxram@us.ibm.com>
 <1573254011-1604-2-git-send-email-linuxram@us.ibm.com>
 <20191110194006.GQ2461@umbus.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110194006.GQ2461@umbus.Home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19111201-0012-0000-0000-00000362CBB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111201-0013-0000-0000-0000219E38AA
Message-Id: <20191112011530.GC5159@oc0525413822.ibm.com>
Subject: RE: [RFC v2 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with the
 hypervisor.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 07:40:06PM +0000, David Gibson wrote:
> On Fri, Nov 08, 2019 at 03:00:10PM -0800, Ram Pai wrote:
> > The hypervisor needs to access the contents of the page holding the TCE
> > entries while setting up the TCE entries in the IOMMU's TCE table.
> > 
> > For SecureVMs, since this page is encrypted, the hypervisor cannot
> > access valid entries. Share the page with the hypervisor. This ensures
> > that the hypervisor sees those valid entries.
> > 
> > Why is this safe?
> >    The page contains only TCE entries; not any sensitive data
> >    belonging to the Secure VM. The hypervisor has a genuine need to know
> >    the value of the TCE entries, without which it will not be able to
> >    DMA to/from the pages pointed to by the TCE entries. In a Secure
> >    VM the TCE entries point to pages that are also shared with the
> >    hypervisor; example: pages containing bounce buffers.
> 
> The bit that may not be obvious to reviewers from the above is this:
> 
> This is *not* a page of "live" TCEs which are actively used for
> translation.  Instead this is just a transient buffer with a batch of
> TCEs to set, passed to the hypervisor with the H_PUT_TCE_INDIRECT call.


That is true.  I should have stated that explicitly. Thanks. will
update the commit log.


RP

