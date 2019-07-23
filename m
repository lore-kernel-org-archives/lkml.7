Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B5CC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958D321BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nwCKAaST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfGWCHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:07:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfGWCHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:07:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6N1re3L104217;
        Tue, 23 Jul 2019 02:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Y27WdOmWGGBo+d60lQRdAQazGR5CP6v/UekKksrT8PA=;
 b=nwCKAaSTgkq36JRcdnAJgNsDGnTaXQVu/ENL6NfQ7fTlmqig1JackaSEF5siiIl0QaoL
 BbVhxwMU7Lq3CPkVGjer4i378KJds/zdzWLOFy2jtu5sFsQsFtr78eWr+X78udVLYXUe
 wU3x7u3xLoKw8YCEjJusMbw1WKT2FE7myx4nCy6RMeG+dW0omZtF5g7Hn0zOzu3rhFzo
 QtaZwwnZBY49qem8GVrKn9NiDLHKhNBheg6chXpHVuVBYP9auGLStMAE7PPrpVPgKSdF
 bGZNz4qYagL7t5Sx2mhHStdKNAPJ8oPTSA395M8w6wSsH18juk4xkMzgj3KiZQ66dpKv IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2tutwpb4ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 02:07:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6N1qw4L114300;
        Tue, 23 Jul 2019 02:07:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tuts3dn8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 02:07:09 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6N274H4002001;
        Tue, 23 Jul 2019 02:07:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 19:07:04 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ondrej Zary <linux@zary.sk>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH B] scsi: fdomain: fix building pcmcia front-end
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190722121908.163702-1-arnd@arndb.de>
        <20190722121908.163702-2-arnd@arndb.de>
Date:   Mon, 22 Jul 2019 22:07:01 -0400
In-Reply-To: <20190722121908.163702-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 22 Jul 2019 14:19:08 +0200")
Message-ID: <yq1pnm1sdve.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907230012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=758 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907230012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Move all of SCSI_LOWLEVEL_PCMCIA inside of the existing SCSI_LOWLEVEL
> section. Very few people use the PCMCIA support these days, and they
> likely don't mind having to turn on SCSI_LOWLEVEL as well. This way we
> avoid the link error and get a more sensible structure.

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
