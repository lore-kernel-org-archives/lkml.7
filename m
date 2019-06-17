Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72AFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B251208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfFQSH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:07:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725764AbfFQSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:07:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HI7PwW079167
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:07:27 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6fmfrjp2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:07:26 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 19:07:23 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 19:07:19 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HI7ImH53543130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 18:07:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32CFA4053;
        Mon, 17 Jun 2019 18:07:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B031A4059;
        Mon, 17 Jun 2019 18:07:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 18:07:17 +0000 (GMT)
Subject: Re: [PATCH] ima: dynamically allocate shash_desc
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jun 2019 14:07:06 -0400
In-Reply-To: <1560786951.4072.103.camel@linux.ibm.com>
References: <20190617115838.2397872-1-arnd@arndb.de>
         <1560786951.4072.103.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061718-0008-0000-0000-000002F48A92
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061718-0009-0000-0000-000022619DAC
Message-Id: <1560794826.4072.169.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-17 at 11:55 -0400, Mimi Zohar wrote:
> On Mon, 2019-06-17 at 13:20 +0200, Arnd Bergmann wrote:
> > On 32-bit ARM, we get a warning about excessive stack usage when
> > building with clang.
> > 
> > security/integrity/ima/ima_crypto.c:504:5: error: stack frame size
> > of 1152 bytes in function 'ima_calc_field_array_hash' [-Werror,-
> > Wframe-larger-than=]
> 
> I'm definitely not seeing this.  Is this problem a result of non
> upstreamed patches?  For sha1, currently the only possible hash
> algorithm, I'm seeing 664.

Every time a measurement is added to the measurement list, the memory
would be allocated/freed.  The frequency of new measurements is policy
dependent.  For performance reasons, I'd prefer if the allocation
remains on the stack.

Mimi

