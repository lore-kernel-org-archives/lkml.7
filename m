Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746A22067B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKLSNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:13:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfKLSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:13:00 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACICtkU047403
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:12:59 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w80fw350j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:12:59 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 18:12:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 18:12:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACICPPE56492048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 18:12:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 846FCA4051;
        Tue, 12 Nov 2019 18:12:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D14A4055;
        Tue, 12 Nov 2019 18:12:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 18:12:24 +0000 (GMT)
Subject: Re: [PATCH] ima: avoid appraise error for hash calc interrupt
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Patrick Callaghan <patrickc@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue, 12 Nov 2019 13:12:24 -0500
In-Reply-To: <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
References: <20191111192348.30535-1-patrickc@linux.ibm.com>
         <e3f520ce-a290-206d-8097-b852123357ca@linux.microsoft.com>
         <1573578841.17949.48.camel@linux.ibm.com>
         <c6a57c24-2f30-f252-0f42-8d748ede65af@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111218-0016-0000-0000-000002C312CB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111218-0017-0000-0000-00003324AA2F
Message-Id: <1573582344.17949.67.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=707 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 09:33 -0800, Lakshmi Ramasubramanian wrote:
> On 11/12/2019 9:14 AM, Mimi Zohar wrote:
> 
> > On Mon, 2019-11-11 at 14:29 -0800, Lakshmi Ramasubramanian wrote:
> >> On 11/11/19 11:23 AM, Patrick Callaghan wrote:
> >>
> >>> -		if (rbuf_len == 0)
> >>> +		if (rbuf_len == 0) {	/* unexpected EOF */
> >>> +			rc = -EINVAL;
> >>>    			break;
> >>> +		}
> >>>    		offset += rbuf_len;
> >>
> >> Should there be an additional check to validate that (offset + rbuf_len)
> >> is less than i_size before calling cypto_shash_update (since rbuf_len is
> >> one of the parameters for this call)?
> > 
> > The "while" statement enforces that.
> > 
> > Mimi
> 
> Yes - but that check happens after the call to crypto_shash_update().
> 
> Perhaps integrity_kernel_read() will never return (rbuf_len) that will
>   => violate the check in the "while" statement.
>   => number of bytes read that is greater than the memory allocated for 
> rbuf even in error conditions.
> 
> Just making sure.

integrity_kernel_read() returns an error (< 0) or the number of bytes
read.  The while statement ensures that there is more data to read, so
returning 0 is always an error.

Mimi

