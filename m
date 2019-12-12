Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9EDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B43214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbfLLVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:13:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49934 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730969AbfLLVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:13:20 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCL74f0013136
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:13:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf70xf98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 16:13:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 12 Dec 2019 21:13:16 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 21:13:12 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBCLCTdw40042846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 21:12:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 880DFA405C;
        Thu, 12 Dec 2019 21:13:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62341A405B;
        Thu, 12 Dec 2019 21:13:10 +0000 (GMT)
Received: from dhcp-9-31-102-17.watson.ibm.com (unknown [9.31.102.17])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 21:13:10 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Thu, 12 Dec 2019 16:13:09 -0500
In-Reply-To: <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
References: <20191211185116.2740-1-nramas@linux.microsoft.com>
         <20191211185116.2740-2-nramas@linux.microsoft.com>
         <1576138743.4579.147.camel@linux.ibm.com>
         <0cc15a43-8e1b-9819-33fe-8325068f8df2@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121221-0020-0000-0000-0000039792F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121221-0021-0000-0000-000021EE9E41
Message-Id: <1576185189.4579.165.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_07:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=3 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-12 at 08:57 -0800, Lakshmi Ramasubramanian wrote:
> On 12/12/19 12:19 AM, Mimi Zohar wrote:
> 
> >>> +	ima_process_keys = true;
> >> +
> >> +	INIT_LIST_HEAD(&temp_ima_keys);
> >> +
> >> +	mutex_lock(&ima_keys_mutex);
> >> +
> >> +	list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> >> +		list_move_tail(&entry->list, &temp_ima_keys);
> >> +
> >> +	mutex_unlock(&ima_keys_mutex);
> > 
> > 
> > The v1 comment, which explained the need for using a temporary
> > keyring, is an example of an informative comment.  If you don't
> > object, instead of re-posting this patch, I can insert it.
> 
> Sure Mimi. Thanks for including the comment in the patch.

Looking at this again, something seems off or at least the comment 
doesn't match the code.

       /*
         * To avoid holding the mutex while processing queued keys,
         * transfer the queued keys with the mutex held to a temp list,
         * release the mutex, and then process the queued keys from
         * the temp list.
         *
         * Since ima_process_keys is set to true above, any new key will
         * be processed immediately and not queued.
         */

Setting ima_process_key before taking the lock won't prevent the race.
 I think you want to test ima_process_keys before taking the lock and
again immediately afterward taking the lock, before setting it.  Then
the comment would match the code.

Shouldn't ima_process_keys be defined as static to limit the scope to
this file?

Mimi

