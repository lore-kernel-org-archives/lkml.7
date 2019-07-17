Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137FCC76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA89720818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSPyRFAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfGQCdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:33:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38116 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQCdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:33:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2Tii0077151;
        Wed, 17 Jul 2019 02:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xvyqFU2Fdei8ljgzaJQFc1lnw/+9F3y2gxI3eTRxaxw=;
 b=lSPyRFAQSJnyKBSBT4kBXWcpoXoJEAggEpsYrk0UykTkqR/ilWfg+ti2gv181mXCOOxP
 t6ybED2Yi9+p8fn1CBdhG1ls/bB5HuDU9CehXwtj1burgOF+d77kfs5yanpM+C0Z3Y1C
 6TfdKx3Rcp0nVKNiPIOzlak5tOlzG4CrsFr3YlrNnbPI4zzJuPJukwSRkqUdcj1HJj77
 qPxo+l1VR07CePlLx0cqZ5PTmn5yUcvdLU23DFxf8/ZiQrVIQI0dDRxilkIRo6JzTLDa
 al8PRKFK0OOuScczWB2O08/LczipkLpolwfHu11f4MOJMRm7OCfAOhNsrEfgz8yDTHHh /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtqv7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:33:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2RgRV181553;
        Wed, 17 Jul 2019 02:33:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4du8f7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:33:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H2Wxil003297;
        Wed, 17 Jul 2019 02:32:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 02:32:59 +0000
To:     Colin King <colin.king@canonical.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libfc: fix null pointer dereference on a null lport
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190702091835.13629-1-colin.king@canonical.com>
Date:   Tue, 16 Jul 2019 22:32:57 -0400
In-Reply-To: <20190702091835.13629-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 2 Jul 2019 10:18:35 +0100")
Message-ID: <yq1o91tz8yu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=888 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Currently if lport is null then the null lport pointer is dereference
> when printing out debug via the FC_LPORT_DB macro. Fix this by using
> the more generic FC_LIBFC_DBG debug macro instead that does not use
> lport.

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
