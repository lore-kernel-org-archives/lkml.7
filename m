Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583BC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491DA21670
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGIQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:32:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726496AbfGIQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:32:06 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69GRhPr029144
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 12:32:05 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmw4qm90j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 12:32:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 9 Jul 2019 17:32:03 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 17:31:59 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x69GVjNp13697396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 16:31:45 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E1B44C052;
        Tue,  9 Jul 2019 16:31:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E7374C040;
        Tue,  9 Jul 2019 16:31:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.82.106])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 16:31:56 +0000 (GMT)
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Date:   Tue, 09 Jul 2019 12:31:45 -0400
In-Reply-To: <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
         <1562618099.20748.13.camel@linux.ibm.com>
         <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070916-4275-0000-0000-0000034B1768
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070916-4276-0000-0000-0000385B18AA
Message-Id: <1562689905.28089.52.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 19:24 +0300, Jarkko Sakkinen wrote:
> On Mon, Jul 08, 2019 at 01:34:59PM -0700, James Bottomley wrote:
> > Not a criticism of your patch, but can we please stop doing this. 
> > Single random number sources are horrendously bad practice because it
> > gives an attacker a single target to subvert.  We should ensure the TPM
> > is plugged into the kernel RNG as a source and then take randomness
> > from the mixed pool so it's harder for an attacker because they have to
> > subvert all our sources to predict what came out.
> 
> It is and I agree.

I still haven't quite figured out why the digests need to be
initialized to anything other than 0.

Mimi

