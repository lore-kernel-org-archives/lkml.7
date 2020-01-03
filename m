Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8708C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F7524699
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgACPIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:08:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727786AbgACPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:08:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003F5IlY042234
        for <linux-kernel@vger.kernel.org>; Fri, 3 Jan 2020 10:08:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x9y3nx1sg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 10:08:28 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Jan 2020 15:08:26 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 15:08:21 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003F8LgI36700630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 15:08:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA203A4040;
        Fri,  3 Jan 2020 15:08:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DA9EA4053;
        Fri,  3 Jan 2020 15:08:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.213.69])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 15:08:19 +0000 (GMT)
Subject: Re: [PATCH v6 0/3] IMA: Deferred measurement of keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Fri, 03 Jan 2020 10:08:19 -0500
In-Reply-To: <20200103055608.22491-1-nramas@linux.microsoft.com>
References: <20200103055608.22491-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010315-0020-0000-0000-0000039D9086
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010315-0021-0000-0000-000021F4E294
Message-Id: <1578064099.5874.170.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_04:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

Instead of loosing the cover letter, Jonathan Corbet suggested
including it as the merge comment.  I'd like to do that with this
cover letter.

On Thu, 2020-01-02 at 21:56 -0800, Lakshmi Ramasubramanian wrote:
> This patchset extends the previous version[1] by adding support for
> deferred processing of keys.
> 
> With the patchset referenced above, the IMA subsystem supports
> measuring asymmetric keys when the key is created or updated.

The first sentence and the clause of the next sentence are
unnecessary.  I would begin the cover letter with "The IMA subsystem
supports" and add the reference afterwards.

> But keys created or updated before a custom IMA policy is loaded
> are currently not measured. This includes keys added to, for instance,
> .builtin_trusted_keys which happens early in the boot process.

Let's not limit the example to just the .builtin_trusted_keys keyring.
 Please update it as:

This includes keys added, for instance, to either the .ima or
.builtin_trusted_keys keyrings, which happens early in the boot
process.

> 
> This change adds support for queuing keys created or updated before
> a custom IMA policy is loaded. The queued keys are processed when
> a custom policy is loaded. Keys created or updated after a custom policy
> is loaded are measured immediately (not queued).
> 
> If the kernel is built with both CONFIG_IMA and
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE enabled then the IMA policy
> must be applied as a custom policy for the keys to be measured.
> If a custom IMA policy is not provided within 5 minutes after
> IMA is initialized, any queued keys will be freed.

As the merge message, this is too much information.  I would extend
the previous paragraph and drop this one, like:
"... (not queued).  In the case when a custom policy is not loaded
within 5 minutes of IMA initialization, the queued keys are freed."

> This is by design.

It's unclear what "is by design" refers to.  Perhaps expand this
sentence like: "Measuring the early boot keys, by design, requires
loading a custom policy.

> 
> [1] https://lore.kernel.org/linux-integrity/20191211164707.4698-1-nramas@linux.microsoft.com/

thanks,

Mimi

