Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFEC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E40E22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfH1PUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:20:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbfH1PUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:20:15 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SFIFlv164848
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:20:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umpb3bt4t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:20:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Aug 2019 16:20:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 16:20:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SFK0Zv24510654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 15:20:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D25411C054;
        Wed, 28 Aug 2019 15:20:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26EF411C04A;
        Wed, 28 Aug 2019 15:19:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 15:19:59 +0000 (GMT)
Subject: Re: [PATCH] sefltest/ima: support appended signatures (modsig)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     shuah <shuah@kernel.org>, linux-integrity@vger.kernel.org
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 11:19:58 -0400
In-Reply-To: <2f89d09f-1b69-3d77-6846-01bef7d20f39@kernel.org>
References: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
         <2f89d09f-1b69-3d77-6846-01bef7d20f39@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082815-0016-0000-0000-000002A3EF99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082815-0017-0000-0000-0000330440F8
Message-Id: <1567005598.6115.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 08:45 -0600, shuah wrote:
> Hi Mimi,
> 
> On 8/28/19 6:39 AM, Mimi Zohar wrote:
> > Detect and allow appended signatures.
> > 
> 
> Can you please add a couple of more sentences on the feature
> and what happens without it? I know this is a test for the
> feature, however, it will be useful for users and testers to
> know more about this test and the feature it is testing.

I've updated the patch description as requested.  

> Also, are there test skip conditions to be concerned about?

The kexec selftests tests the coordination of the different methods of
verifying the kexec kernel image.  As the appended signature support
is part of IMA, there is no new skip conditions.

> Is there a dependency on another tree or would like me to take
> this through kselftest tree?

I would prefer upstreaming this test with the rest of IMA support for
appended signatures.

thanks,

Mimi

