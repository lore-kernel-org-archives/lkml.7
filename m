Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD683206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfCLScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:32:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbfCLScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:32:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CISjlO053947
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:32:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6gjmnxw2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 14:32:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Mar 2019 18:32:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 18:32:12 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CIWB4l25559154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 18:32:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE03842042;
        Tue, 12 Mar 2019 18:32:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A252D4204B;
        Tue, 12 Mar 2019 18:32:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.217])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 18:32:10 +0000 (GMT)
Subject: Re: [PATCH] tpm: Make timeout logic simpler and more robust
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter =?ISO-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Cc:     Calvin Owens <calvinowens@fb.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Date:   Tue, 12 Mar 2019 14:32:00 -0400
In-Reply-To: <1552410856.3083.28.camel@HansenPartnership.com>
References: <358e89ed2b766d51b5f57abf31ab7a925ac63379.1552348123.git.calvinowens@fb.com>
         <1552350463.23859.8.camel@HansenPartnership.com>
         <20190312125028.GC9243@linux.intel.com>
         <1552401766.3083.3.camel@HansenPartnership.com>
         <1552409969.24794.68.camel@linux.ibm.com>
         <1552410856.3083.28.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031218-0020-0000-0000-00000321C0AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031218-0021-0000-0000-00002173EDB1
Message-Id: <1552415520.24794.87.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 10:14 -0700, James Bottomley wrote:

> > > However, I am saying we should root cause this problem rather than
> > > take a blind shot at the apparent timeout complexity.  My timeout
> > > instability is definitely related to the polling adjustments, so
> > > it's not unreasonable to think Facebooks might be as well.
> > 
> > James, I thought Peter sent you a tis "debug" tool to help you debug
> > the problem you're seeing.  Whatever happened?

https://patchwork.kernel.org/patch/10520247/#22107607

> 
> No, not seen one.  I have tried to debug the problem, but it's really
> odd: my TPM is a polled nuvoton (so no irq line).  If you poll the data
> ready bit on my TPM too often, it simply drops off the bus and every
> TPM operation after that times out.  The only way to recover is to
> reboot.
> 
> James
> 

