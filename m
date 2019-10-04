Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF38C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D76B2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbfJDRhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:37:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387428AbfJDRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:37:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x94HW1Ww140861
        for <linux-kernel@vger.kernel.org>; Fri, 4 Oct 2019 13:37:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ve9k4te0q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:37:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 4 Oct 2019 18:37:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 4 Oct 2019 18:37:30 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x94HbT3f45547756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Oct 2019 17:37:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C19645204E;
        Fri,  4 Oct 2019 17:37:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B8A752050;
        Fri,  4 Oct 2019 17:37:28 +0000 (GMT)
Subject: Re: [PATCH v3 2/2] tpm: Detach page allocation from tpm_buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Oct 2019 13:37:27 -0400
In-Reply-To: <1570207062.3563.17.camel@HansenPartnership.com>
References: <20191003185103.26347-1-jarkko.sakkinen@linux.intel.com>
         <20191003185103.26347-3-jarkko.sakkinen@linux.intel.com>
         <1570207062.3563.17.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19100417-0016-0000-0000-000002B41761
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100417-0017-0000-0000-00003315282D
Message-Id: <1570210647.5046.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 09:37 -0700, James Bottomley wrote:
> On Thu, 2019-10-03 at 21:51 +0300, Jarkko Sakkinen wrote:
> > As has been seen recently, binding the buffer allocation and tpm_buf
> > together is sometimes far from optimal.
> 
> Can you elaborate on this a bit more?  I must have missed the
> discussion.

Refer to e13cd21ffd50 ("tpm: Wrap the buffer from the caller to
tpm_buf in tpm_send()") for the details.

Mimi



