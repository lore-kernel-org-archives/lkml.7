Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E3C32759
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4DB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHNI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:58:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfHNI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:58:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7E8vBds027453
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:58:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucd5fvwnb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:58:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Wed, 14 Aug 2019 09:58:34 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Aug 2019 09:58:31 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7E8wBnK29950288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 08:58:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1EE4C044;
        Wed, 14 Aug 2019 08:58:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07FE44C040;
        Wed, 14 Aug 2019 08:58:29 +0000 (GMT)
Received: from in.ibm.com (unknown [9.124.35.250])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Aug 2019 08:58:28 +0000 (GMT)
Date:   Wed, 14 Aug 2019 14:28:26 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 5/5] memremap: provide a not device managed memremap_pages
Reply-To: bharata@linux.ibm.com
References: <20190811081247.22111-1-hch@lst.de>
 <20190811081247.22111-6-hch@lst.de>
 <20190812145058.GA16950@in.ibm.com>
 <20190812150012.GA12700@lst.de>
 <20190813045611.GB16950@in.ibm.com>
 <20190814061150.GA24835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814061150.GA24835@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-TM-AS-GCONF: 00
x-cbid: 19081408-0016-0000-0000-0000029EA913
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081408-0017-0000-0000-000032FEC1E3
Message-Id: <20190814085826.GB8784@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=335 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 08:11:50AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 13, 2019 at 10:26:11AM +0530, Bharata B Rao wrote:
> > Yes, this patchset works non-modular and with kvm-hv as module, it
> > works with devm_memremap_pages_release() and release_mem_region() in the
> > cleanup path. The cleanup path will be required in the non-modular
> > case too for proper recovery from failures.
> 
> Can you check if the version here:
> 
>     git://git.infradead.org/users/hch/misc.git pgmap-remove-dev
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/pgmap-remove-dev
> 
> works for you fully before I resend?

Yes, this works for us. This and migrate-vma-cleanup series helps to
really simplify the kvmppc secure pages management code. Thanks.

Regards,
Bharata.

