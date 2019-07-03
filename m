Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D3DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B4121882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfGCLO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbfGCLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:14:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x63BDGYu096305
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 07:14:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgseymrbt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:14:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 3 Jul 2019 12:14:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 12:14:51 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x63BEpOK52953218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 11:14:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3397A405C;
        Wed,  3 Jul 2019 11:14:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3C8CA405B;
        Wed,  3 Jul 2019 11:14:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.77])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 11:14:49 +0000 (GMT)
Subject: Re: [PATCH] ima: Replace two seq_printf() calls by seq_puts() in
 ima_show_template_data_ascii()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Markus Elfring'" <Markus.Elfring@web.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Date:   Wed, 03 Jul 2019 07:14:39 -0400
In-Reply-To: <d94bfdb9d53b46059787b9bdd10c5919@AcuMS.aculab.com>
References: <e96eac40-0745-80b5-6aab-f872e6415031@web.de>
         <d94bfdb9d53b46059787b9bdd10c5919@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070311-0008-0000-0000-000002F96C24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070311-0009-0000-0000-00002266B96B
Message-Id: <1562152479.4774.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=800 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 09:16 +0000, David Laight wrote:

> > diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> > index 9fe0ef7f91e2..05636e9b19b1 100644
> > --- a/security/integrity/ima/ima_template_lib.c
> > +++ b/security/integrity/ima/ima_template_lib.c
> > @@ -74,7 +74,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
> >  	case DATA_FMT_DIGEST_WITH_ALGO:
> >  		buf_ptr = strnchr(field_data->data, buflen, ':');
> >  		if (buf_ptr != field_data->data)
> > -			seq_printf(m, "%s", field_data->data);
> > +			seq_puts(m, field_data->data);
> > 
> >  		/* skip ':' and '\0' */
> >  		buf_ptr += 2;
> 
> That code looks highly suspect!
> It uses a bounded scan then assumes a '\0' terminated string.
> It then adds 2 to a potentially NULL pointer.

The code here is used for displaying the IMA measurement list, that
the kernel itself created.  Protecting the in kernel memory from
attack is a different problem.  Refer to Igor Stoppa's write once
memory pools.

Mimi

