Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8455C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9467217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfKFQqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:46:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbfKFQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:46:52 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6Gfvna008943
        for <linux-kernel@vger.kernel.org>; Wed, 6 Nov 2019 11:46:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w41wug488-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:46:49 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Wed, 6 Nov 2019 16:46:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 16:46:38 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6Gkb5357802864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 16:46:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF90B4C046;
        Wed,  6 Nov 2019 16:46:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED6954C058;
        Wed,  6 Nov 2019 16:46:33 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.236.142])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Nov 2019 16:46:33 +0000 (GMT)
Date:   Wed, 6 Nov 2019 08:46:30 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
        david@gibson.dropbear.id.au, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1572902923-8096-1-git-send-email-linuxram@us.ibm.com>
 <265679db-9cb3-1660-0cf6-97f740b1b48b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265679db-9cb3-1660-0cf6-97f740b1b48b@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19110616-0016-0000-0000-000002C14FB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110616-0017-0000-0000-00003322CCF4
Message-Id: <20191106164630.GB5201@oc0525413822.ibm.com>
Subject: RE: [RFC v1 0/2] Enable IOMMU support for pseries Secure VMs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=597 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 12:59:50PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 05/11/2019 08:28, Ram Pai wrote:
> > This patch series enables IOMMU support for pseries Secure VMs.
> > 
> > 
> > Tested using QEMU command line option:
> > 
> >  "-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4,
> >  	iommu_platform=on,disable-modern=off,disable-legacy=on"
> >  and 
> > 
> >  "-device virtio-blk-pci,scsi=off,bus=pci.0,
> >  	addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,
> >  	iommu_platform=on,disable-modern=off,disable-legacy=on"
> 
> 
> Worth mentioning that SLOF won't boot with such devices as SLOF does not know about iommu_platform=on.

I did see SLOF complaining, but that did not stop it from booting the guest.
My boot device was a virtio device, with iommu platform flag
enabled.

So I am not sure, under what conditions SLOF will fail to boot.   Any
idea?

RP

