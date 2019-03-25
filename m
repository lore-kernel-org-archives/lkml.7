Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BE12087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfCYUh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729626AbfCYUh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:37:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PKXSPE034138
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:37:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rf2x50s24-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:37:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 25 Mar 2019 20:37:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 20:37:18 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PKbHPc56230136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 20:37:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94548A405B;
        Mon, 25 Mar 2019 20:37:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4496A405F;
        Mon, 25 Mar 2019 20:37:16 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 20:37:16 +0000 (GMT)
Subject: Re: [PATCH v4a 1/2] selftests/kexec: make tests independent of IMA
 being enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Date:   Mon, 25 Mar 2019 16:37:16 -0400
In-Reply-To: <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
References: <1553283351-6310-1-git-send-email-zohar@linux.ibm.com>
         <20190325080935.GA12497@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032520-0028-0000-0000-000003582731
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032520-0029-0000-0000-00002416DBD4
Message-Id: <1553546236.5561.7.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 16:09 +0800, Dave Young wrote:
> Hi Mimi
> On 03/22/19 at 03:35pm, Mimi Zohar wrote:
> > Verify IMA is enabled before failing tests or emitting irrelevant
> > messages.  Also, don't skip the test if signatures are not required.
> > 
> > Suggested-by: Dave Young <dyoung@redhat.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> > Dave, if this patch resolves the outstanding issues, I can fold these
> > changes into the original patches. (Reminder, these patches will need to
> > be updated to support the "lockdown" patch set.)
> 
> They looks good to me, thanks for the update

I've folded the kexec_file_load changes into the kexec_file_load test.
 The remaining kexec_load change is left as a separate patch, since it
is dependent on the ikconfig change.

> Feel free to add my reviewed-by, I did some tests although not cover all
> ima cases.

Thanks!  Is this meant as a general "reviewed-by" for all of the
patches or just this specific one?

Mimi

