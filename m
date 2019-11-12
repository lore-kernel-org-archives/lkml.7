Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B44C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F020679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfKLRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:08:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727178AbfKLRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:08:54 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACGvqir001361
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:08:53 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7yn7u6ym-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:08:52 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:08:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:08:48 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACH8lYT56688850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:08:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C412F4C040;
        Tue, 12 Nov 2019 17:08:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A196A4C04A;
        Tue, 12 Nov 2019 17:08:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:08:46 +0000 (GMT)
Subject: Re: [PATCH v5 0/10] KEYS: Measure keys when they are created or
 updated
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 12:08:46 -0500
In-Reply-To: <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <b135b1ac-add6-aea4-cab3-3e9c12796b6a@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0008-0000-0000-0000032E6DEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0009-0000-0000-00004A4D7443
Message-Id: <1573578526.17949.47.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-11 at 11:41 -0800, Lakshmi Ramasubramanian wrote:
> On 11/11/2019 11:32 AM, Lakshmi Ramasubramanian wrote:
> 
> Hi Mimi,
> 
> > Problem Statement:

The above line isn't needed.

> > 
> > Keys created or updated in the system are currently not being measured.
> > 
> > This change aims to address measuring keys created or updated
> > in the system:
> > 
> >    => Patches #1 through #5 update IMA policy functions to handle
> >       measurement of keys based on configured IMA policy.
> > 
> >    => Patches #6 and #7 add IMA hook for measuring keys and the call
> >       to the IMA hook from key_create_or_update function.
> >       Keys are processed immediately - no support for
> >       deferred processing.
> > 
> >    => Patches #8 through #10 add support for queuing keys if
> >       custom IMA policies have not been applied yet and process
> >       the queued keys when custom IMA policies are applied.
> 
> I was wondering if it'd be better to split this patch set into two sets:
> 
> 1st set including the patches for measuring keys without queuing support 
> (Patches #1 through #7)

I've commented on patches 1 - 4.  There's still so much wrong with
this patch set.  Limiting the scope of the patch set sounds like
really a good idea. 

Mimi

> 
> 2nd set including the patches that add queuing support (Patches #8 
> through #10).


