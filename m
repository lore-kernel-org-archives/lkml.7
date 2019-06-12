Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A12082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440063AbfFLPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:09:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439910AbfFLPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:09:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CF5Vpf015821
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:09:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t32ff450g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 11:09:19 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Wed, 12 Jun 2019 16:09:09 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 16:08:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CF8qKU27787328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 15:08:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214F85204E;
        Wed, 12 Jun 2019 15:08:52 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AFDCF52052;
        Wed, 12 Jun 2019 15:08:51 +0000 (GMT)
Date:   Wed, 12 Jun 2019 17:08:50 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/4] s390/crypto: Use -ENODEV instead of -EOPNOTSUPP
References: <20190612133306.10231-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612133306.10231-1-david@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19061215-0008-0000-0000-000002F327F4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061215-0009-0000-0000-000022602A52
Message-Id: <20190612150850.GA4038@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 03:33:02PM +0200, David Hildenbrand wrote:
> s390x crypto is one of the rare modules that returns -EOPNOTSUPP instead of
> -ENODEV in case HW support is not available.
> 
> Convert to -ENODEV, so e.g., systemd's systemd-modules-load.service
> ignores this error properly.
> 
> v2 -> v3:
> - "s390/pkey: Use -ENODEV instead of -EOPNOTSUPP"
> -- Also convert pkey_clr2protkey() as requested by Harald
> - Add r-b's (thanks!)
> 
> v1 -> v2:
> - Include
> -- "s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP"
> -- "s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP"
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> 
> David Hildenbrand (4):
>   s390/pkey: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: ghash: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: prng: Use -ENODEV instead of -EOPNOTSUPP
>   s390/crypto: sha: Use -ENODEV instead of -EOPNOTSUPP

Should I pick these up so they can go upstream via the s390 tree?

