Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1FC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AEF21721
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbfGOU3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:29:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731054AbfGOU3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:29:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FKSgDN143944
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 16:29:39 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trxbe5fmr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 16:29:38 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 15 Jul 2019 21:29:38 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 21:29:32 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FKTVfV61276602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 20:29:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30FF3BE053;
        Mon, 15 Jul 2019 20:29:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ADF2BE04F;
        Mon, 15 Jul 2019 20:29:17 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.238.93])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Jul 2019 20:29:17 +0000 (GMT)
References: <20190320171027-mutt-send-email-mst@kernel.org> <87tvfvbwpb.fsf@morokweng.localdomain> <20190323165456-mutt-send-email-mst@kernel.org> <87a7go71hz.fsf@morokweng.localdomain> <20190520090939-mutt-send-email-mst@kernel.org> <877ea26tk8.fsf@morokweng.localdomain> <20190603211528-mutt-send-email-mst@kernel.org> <877e96qxm7.fsf@morokweng.localdomain> <20190701092212-mutt-send-email-mst@kernel.org> <87d0id9nah.fsf@morokweng.localdomain> <20190715103411-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <20190715103411-mutt-send-email-mst@kernel.org>
Date:   Mon, 15 Jul 2019 17:29:06 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19071520-0012-0000-0000-0000174FE71F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011434; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01232674; UDB=6.00649454; IPR=6.01013976;
 MB=3.00027729; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-15 20:29:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071520-0013-0000-0000-00005813BEDE
Message-Id: <874l3nnist.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michael S. Tsirkin <mst@redhat.com> writes:

> On Sun, Jul 14, 2019 at 02:51:18AM -0300, Thiago Jung Bauermann wrote:
>>
>>
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>
>> > So this is what I would call this option:
>> >
>> > VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS
>> >
>> > and the explanation should state that all device
>> > addresses are translated by the platform to identical
>> > addresses.
>> >
>> > In fact this option then becomes more, not less restrictive
>> > than VIRTIO_F_ACCESS_PLATFORM - it's a promise
>> > by guest to only create identity mappings,
>> > and only before driver_ok is set.
>> > This option then would always be negotiated together with
>> > VIRTIO_F_ACCESS_PLATFORM.
>> >
>> > Host then must verify that
>> > 1. full 1:1 mappings are created before driver_ok
>> >     or can we make sure this happens before features_ok?
>> >     that would be ideal as we could require that features_ok fails
>> > 2. mappings are not modified between driver_ok and reset
>> >     i guess attempts to change them will fail -
>> >     possibly by causing a guest crash
>> >     or some other kind of platform-specific error
>>
>> I think VIRTIO_F_ACCESS_PLATFORM_IDENTITY_ADDRESS is good, but requiring
>> it to be accompanied by ACCESS_PLATFORM can be a problem. One reason is
>> SLOF as I mentioned above, another is that we would be requiring all
>> guests running on the machine (secure guests or not, since we would use
>> the same configuration for all guests) to support it. But
>> ACCESS_PLATFORM is relatively recent so it's a bit early for that. For
>> instance, Ubuntu 16.04 LTS (which is still supported) doesn't know about
>> it and wouldn't be able to use the device.
>
> OK and your target is to enable use with kernel drivers within
> guests, right?

Right.

> My question is, we are defining a new flag here, I guess old guests
> then do not set it. How does it help old guests? Or maybe it's
> not designed to ...

Indeed. The idea is that QEMU can offer the flag, old guests can reject
it (or even new guests can reject it, if they decide not to convert into
secure VMs) and the feature negotiation will succeed with the flag
unset.

--
Thiago Jung Bauermann
IBM Linux Technology Center

