Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F80C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D0A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfDJP77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:59:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728970AbfDJP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:59:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AFxiPM135673
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:59:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsh66gdxg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:59:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 10 Apr 2019 16:59:53 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 10 Apr 2019 16:59:49 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3AFxmKU57737226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 15:59:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 122F611C04C;
        Wed, 10 Apr 2019 15:59:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A57DC11C04A;
        Wed, 10 Apr 2019 15:59:47 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Apr 2019 15:59:47 +0000 (GMT)
Date:   Wed, 10 Apr 2019 17:59:46 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Ingo Franzki <ifranzki@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
In-Reply-To: <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
References: <20190408212648.2407234-1-arnd@arndb.de>
        <20190408212648.2407234-5-arnd@arndb.de>
        <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041015-0012-0000-0000-0000030D6416
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041015-0013-0000-0000-00002145892E
Message-Id: <20190410175946.0e6d2b00@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904100111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019 11:54:30 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 08.04.19 23:26, Arnd Bergmann wrote:
> > The 'func_code' variable gets printed in debug statements without
> > a prior initialization in multiple functions, as reported when building
> > with clang:
> >
> > drivers/s390/crypto/zcrypt_api.c:659:6: warning: variable 'func_code' is used uninitialized whenever 'if' condition is true
> >       [-Wsometimes-uninitialized]
> >         if (mex->outputdatalength < mex->inputdatalength) {
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:725:29: note: uninitialized use occurs here
> >         trace_s390_zcrypt_rep(mex, func_code, rc,
> >                                    ^~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:659:2: note: remove the 'if' if its condition is always false
> >         if (mex->outputdatalength < mex->inputdatalength) {
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/crypto/zcrypt_api.c:654:24: note: initialize the variable 'func_code' to silence this warning
> >         unsigned int func_code;
> >                               ^
> >
> > Add initializations to all affected code paths to shut up the warning
> > and make the warning output consistent.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/s390/crypto/zcrypt_api.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> > index eb93c2d27d0a..23472063d9a8 100644
> > --- a/drivers/s390/crypto/zcrypt_api.c
> > +++ b/drivers/s390/crypto/zcrypt_api.c
> > @@ -657,6 +657,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
> >  	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
> >  
> >  	if (mex->outputdatalength < mex->inputdatalength) {
> > +		func_code = -1;
> >  		rc = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -739,6 +740,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
> >  	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
> >  
> >  	if (crt->outputdatalength < crt->inputdatalength) {
> > +		func_code = -1;
> >  		rc = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -946,6 +948,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
> >  
> >  		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
> >  		if (!targets) {
> > +			func_code = -1;
> >  			rc = -ENOMEM;
> >  			goto out;
> >  		}
> > @@ -953,6 +956,7 @@ static long zcrypt_send_ep11_cprb(struct ap_perms *perms,
> >  		uptr = (struct ep11_target_dev __force __user *) xcrb->targets;
> >  		if (copy_from_user(targets, uptr,
> >  				   target_num * sizeof(*targets))) {
> > +			func_code = -1;
> >  			rc = -EFAULT;
> >  			goto out_free;
> >  		}  
> Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> variable initialized with 0 instead of -1.
> If you agree with this, I'll rewrite the patch and apply it to our
> internal git and it will appear at kernel org with the next s390 code merge then.

Do we agreement on func_coed=0 for this one ?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

