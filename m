Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A683C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF2820693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfGDLsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:48:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727669AbfGDLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:48:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64BmjmL116942
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 07:48:49 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2thee260r3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:48:48 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Jul 2019 12:48:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 12:48:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64BmFsV41812092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 11:48:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E0B611C066;
        Thu,  4 Jul 2019 11:48:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AFEC11C050;
        Thu,  4 Jul 2019 11:48:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 11:48:12 +0000 (GMT)
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 04 Jul 2019 07:48:02 -0400
In-Reply-To: <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
References: <20190701131505.17759-1-msuchanek@suse.de>
         <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
         <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070411-0012-0000-0000-0000032F3A18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070411-0013-0000-0000-00002168908F
Message-Id: <1562240882.6165.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=747 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
> On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
> > On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
> >> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
> >> following crash:
> > 
> > Thank you. I think this the right choice for the moment. I fixed
> > a trivial checkpatch.pl error and added the mandatory tags. Can
> > you check quickly v2 (just posted)?
> > 
> > I already made it available in my master and next.
> 
> Could you please wait few days? I would prefer to fix this issue instead
> of reverting the whole patch.

Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
allocated banks for IBM vtpm driver", which addresses this bug.

Mimi

