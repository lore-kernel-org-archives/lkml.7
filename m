Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652BC31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969FC207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQNJubjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389941AbfFJOf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:35:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389575AbfFJOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:35:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AETNbi096395;
        Mon, 10 Jun 2019 14:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AreI3Oi5t2BK9yZ9fvqJm8n0iuLc5FNcr71UXydQQ4A=;
 b=IQNJubjfwEeOewYwiDKlbW98yCxrRZxsg8eJ286mCQaJbD4mAofdKhmBiR4RhF2dZUEk
 TICkZvpOPCcleI+we1ow+JbbOmjINiMV2X5rCDRtnughpjq/kGhVUfQ8VqCpNs9oPOV4
 j21bGybX5KyQCvGZixli/KpymHd9vC0p2ODpdq7xyGTeHEKQ6sYGX6J+0J12afwOu6o4
 1I/7I/mW7bnBv5+iw0Jp81ayCbnc5CU+FFtIchtPJ+e+IVzLNCdAyEyTSqAGrgIKu9Y6
 ia/0/7RqwpIM5FPH9/LBsEJuSPpQ+yu4RrPdXNU2Kx+D5TGNypsZ9vykvRXlU0sr95Ct zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etfaqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 14:35:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5AEWjsM157789;
        Mon, 10 Jun 2019 14:33:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2t1jpgwam6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jun 2019 14:33:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5AEXiea023021;
        Mon, 10 Jun 2019 14:33:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 07:33:43 -0700
Date:   Mon, 10 Jun 2019 17:33:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, valdis.kletnieks@vt.edu,
        florian.c.schilhabel@googlemail.com, tiny.windzz@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        colin.king@canonical.com, larry.finger@lwfinger.net
Subject: Re: [PATCH 1/2] staging: rtl8712: r8712_setdatarate_cmd(): Change
Message-ID: <20190610143333.GA1915@kadam>
References: <20190607140658.11932-1-nishkadg.linux@gmail.com>
 <20190607141548.GP31203@kadam>
 <98b587c9-df5b-0905-ab8f-69a4bae296b0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b587c9-df5b-0905-ab8f-69a4bae296b0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906100101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=611 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:02:27AM +0530, Nishka Dasgupta wrote:
> On 07/06/19 7:45 PM, Dan Carpenter wrote:
> > Probably you sent this patch unintentionally.  The subject doesn't make
> > any sort of sense.  :P
> 
> So the problem with the subject line is that git send-email and vim (as
> configured on my laptop) tend to line-wrap even the subject line. Since I
> have two patches that do the same thing for different functions, I felt I
> should have the driver and the function name in the subject line (to avoid
> confusion between the patches and to allow for easy searching later). But
> that doesn't leave enough space in the subject line for "Change return
> values/type" or any other descriptive message. What should I do?
> 

I don't really care.

[PATCH] staging: rtl8712: clean up r8712_setdatarate_cmd() return type

regards,
dan carpenter

