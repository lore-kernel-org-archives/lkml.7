Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCADC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB220637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 05:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLJFNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 00:13:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbfLJFNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 00:13:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBA5CBVj051865
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:12:59 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt598y5y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:12:59 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <linuxram@us.ibm.com>;
        Tue, 10 Dec 2019 05:12:57 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 05:12:52 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBA5C9Ee23658972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 05:12:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 454A452050;
        Tue, 10 Dec 2019 05:12:51 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.80.204.137])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 53E065204E;
        Tue, 10 Dec 2019 05:12:47 +0000 (GMT)
Date:   Mon, 9 Dec 2019 21:12:44 -0800
From:   Ram Pai <linuxram@us.ibm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, mdroth@linux.vnet.ibm.com, hch@lst.de,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, mst@redhat.com,
        ram.n.pai@gmail.com, cai@lca.pw, tglx@linutronix.de,
        bauerman@linux.ibm.com, linux-kernel@vger.kernel.org,
        leonardo@linux.ibm.com
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
 <ed0f048c-bb40-c6c6-887c-ef68c9e411a2@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed0f048c-bb40-c6c6-887c-ef68c9e411a2@ozlabs.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19121005-4275-0000-0000-0000038D7AC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121005-4276-0000-0000-000038A12A28
Message-Id: <20191210051244.GB5702@oc0525413822.ibm.com>
Subject: RE: [PATCH v5 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with
 the hypervisor.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_01:2019-12-10,2019-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=18 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 02:07:36PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 07/12/2019 12:12, Ram Pai wrote:
> > H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> > its parameters.  On secure VMs, hypervisor cannot access the contents of
> > this page since it gets encrypted.  Hence share the page with the
> > hypervisor, and unshare when done.
> 
> 
> I thought the idea was to use H_PUT_TCE and avoid sharing any extra
> pages. There is small problem that when DDW is enabled,
> FW_FEATURE_MULTITCE is ignored (easy to fix); I also noticed complains
> about the performance on slack but this is caused by initial cleanup of
> the default TCE window (which we do not use anyway) and to battle this
> we can simply reduce its size by adding

something that takes hardly any time with H_PUT_TCE_INDIRECT,  takes
13secs per device for H_PUT_TCE approach, during boot. This is with a
30GB guest. With larger guest, the time will further detoriate.

> 
> -global
> spapr-pci-host-bridge.dma_win_size=0x4000000

This option, speeds it up tremendously.  But than should this option be
enabled in qemu by default?  only for secure VMs? for both VMs?


RP

