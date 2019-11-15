Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB3B2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKONOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:14:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727223AbfKONOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:14:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFD2817054943
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:14:48 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsmfns7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:14:47 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 15 Nov 2019 13:14:46 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Nov 2019 13:14:42 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAFDEfI943713012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 13:14:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90D2811C052;
        Fri, 15 Nov 2019 13:14:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6655311C04A;
        Fri, 15 Nov 2019 13:14:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.176])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Nov 2019 13:14:40 +0000 (GMT)
Subject: Re: [PATCH v7 3/5] KEYS: Call the IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 08:14:39 -0500
In-Reply-To: <24262d82-c90b-b64d-f237-9ef038f38d0e@linux.microsoft.com>
References: <20191114031202.18012-1-nramas@linux.microsoft.com>
         <20191114031202.18012-4-nramas@linux.microsoft.com>
         <1573743267.4793.43.camel@linux.ibm.com>
         <24262d82-c90b-b64d-f237-9ef038f38d0e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111513-0028-0000-0000-000003B72858
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111513-0029-0000-0000-0000247A39C3
Message-Id: <1573823679.4793.121.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-14 at 10:24 -0800, Lakshmi Ramasubramanian wrote:
> On 11/14/2019 6:54 AM, Mimi Zohar wrote:
> > With this patch, keys are now being measured.  With the boot command
> > line, we can verify the measurement entry against /proc/cmdline.  How
> > can the key measurement entry be verified?  Please include that
> > information, here, in this patch description.
> 
> Glad you could verify measurement of keys. Thanks a lot for trying it.
> 
> Will add information on testing\validating the feature.

Thank you.

> 
> > Also, can the key data, now included in the measurement list, be used
> > to verify signatures in the ima-sig or ima-modsig templates?  Is there
> > a way of correlating a signature with a key?  Perhaps include a
> > kselftest as an example.
> 
> I am not familiar with kselftest. Will take a look and see if it'd be 
> possible to correlate a signature with a key.

I'd like the measurement list to be self contained, allowing a
regression test, for example, to walk the measurement list, verifying
the file signatures stored in the measurement list based on the key
measurement(s).

It isn't so much about Kselftest, but implementing a regression test
(eg. Kselftest, LTP, ima-evm-utils, ...) as a PoC, in order to know
that the key measurement contains everything needed to identify the
key (eg. keyid, certificate serial number, ...) and verify file
signatures.

Mimi

