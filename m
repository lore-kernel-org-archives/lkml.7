Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9937C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1DB2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgAGWwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:52:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22762 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727046AbgAGWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:52:02 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007MlMKO085323
        for <linux-kernel@vger.kernel.org>; Tue, 7 Jan 2020 17:52:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xapd6w3k4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 17:52:01 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 7 Jan 2020 22:51:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 7 Jan 2020 22:51:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 007Mprt349283092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 22:51:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D635D11C06F;
        Tue,  7 Jan 2020 22:51:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B4C011C05E;
        Tue,  7 Jan 2020 22:51:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.234.104])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jan 2020 22:51:52 +0000 (GMT)
Subject: Re: [PATCH 2/4] KEYS: Call the IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 07 Jan 2020 17:51:52 -0500
In-Reply-To: <20200107194350.3782-3-nramas@linux.microsoft.com>
References: <20200107194350.3782-1-nramas@linux.microsoft.com>
         <20200107194350.3782-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010722-0012-0000-0000-0000037B5193
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010722-0013-0000-0000-000021B76E8D
Message-Id: <1578437512.5222.110.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_07:2020-01-07,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 11:43 -0800, Lakshmi Ramasubramanian wrote:
> Call the IMA hook from key_create_or_update() function to measure
> the payload when a new key is created or an existing key is updated.
> 
> This patch adds the call to the IMA hook from key_create_or_update()
> function to measure the key on key create or update.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reported-by: kbuild test robot <lkp@intel.com> # ima_asymmetric_keys.c
> is built as a kernel module when it is actually not.
> Fixes: cb1aa3823c92 ("KEYS: Call the IMA hook to measure keys")

There are two ways of addressing a bug report.  One is by fixing the
original patch, while the other addresses the bug as a separate patch.
 If the fix is squashed into the original patch, the commit number
will change.  Only if the fix is a separate patch, would you include
the "Fixes" tag.

Mimi

