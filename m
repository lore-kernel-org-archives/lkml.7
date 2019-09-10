Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AD8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FE2206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfIJKVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:21:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfIJKVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:21:23 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8AAIHSZ125873
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 06:21:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ux6t3xj4d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 06:21:21 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 10 Sep 2019 11:21:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Sep 2019 11:21:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8AALDcq59441152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 10:21:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C98E1A4053;
        Tue, 10 Sep 2019 10:21:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 918DFA4040;
        Tue, 10 Sep 2019 10:21:13 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 10:21:13 +0000 (GMT)
Date:   Tue, 10 Sep 2019 12:21:12 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
        david@redhat.com, cohuck@redhat.com,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] kvm_s390_vm_start_migration: check dirty_bitmap before
 using it as target for memset()
In-Reply-To: <4668e4e9-c0bc-3647-6387-20c6f8107ed3@de.ibm.com>
References: <20190909145545.11759-1-imammedo@redhat.com>
        <4668e4e9-c0bc-3647-6387-20c6f8107ed3@de.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091010-0012-0000-0000-000003497464
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091010-0013-0000-0000-00002183D856
Message-Id: <20190910122112.098e3494@p-imbrenda.boeblingen.de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=773 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 18:21:47 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

[...]


> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index f329dcb3f44c..dfba51c9d60c 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -1018,6 +1018,10 @@ static int
> > kvm_s390_vm_start_migration(struct kvm *kvm) /* mark all the pages
> > in active slots as dirty */ for (slotnr = 0; slotnr <
> > slots->used_slots; slotnr++) { ms = slots->memslots + slotnr;
> > +		if (!ms->dirty_bitmap) {
> > +			WARN(1, "ms->dirty_bitmap == NULL\n");  
> 
> I would prefer to not have a WARN_ON. Otherwise this would allow a
> malicious user to spam the log. 

I agree, the WARN is not needed.
 
> 
> > +			return -EINVAL;
> > +		}
> >  		/*
> >  		 * The second half of the bitmap is only used on
> > x86,
> >  		 * and would be wasted otherwise, so we put it to
> > good 

Otherwise it looks good.



Claudio Imbrenda

