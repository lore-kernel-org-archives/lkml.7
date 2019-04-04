Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB802133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GG8gDsRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDDDl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:41:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45244 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDDl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:41:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343eI3k044012;
        Thu, 4 Apr 2019 03:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=mmYojRU0lMBF+LAPxrni+tg/zLQL1UFVNNa5v2nBnQo=;
 b=GG8gDsRdyMhwXqYsnWPf4eRk/Wn6K1gGoaBDNE7vJ+49g9ljSboAplqD0VYCK1Xk23Hd
 5KuBu06EY7PsYHw2xpxoQJj69g/PQx3mXhsdev+zkFzBUg7A5yt/DuE/dIXc0gzw0UtE
 IVtFCPZ6BiJtOdsusdMBYQrHnie2Chm5a0/Gp83uYrRgxwojKoH+tvgvsn/3dqGa4XWX
 NpLNqOiDFYe9Ml4dKGF12H9A5BrLqwtzSz5YfrSh9aZ2UJbp0ErujeG4AiQlPtB28CFC
 ttg4i98xK2owI0A0OYA+NqVX+CTzwJ8GdTrudNeajSHhsQHiWbF0w2DL7f88ovSdZjSo jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvtckdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:41:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x343eE5D115582;
        Thu, 4 Apr 2019 03:41:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f5emt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 03:41:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x343fi02020054;
        Thu, 4 Apr 2019 03:41:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 20:41:44 -0700
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     <qla2xxx-upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: qla2xxx: Remove useless set memory to zero use memset()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190323132753.22508-1-yuehaibing@huawei.com>
Date:   Wed, 03 Apr 2019 23:41:41 -0400
In-Reply-To: <20190323132753.22508-1-yuehaibing@huawei.com> (Yue Haibing's
        message of "Sat, 23 Mar 2019 21:27:53 +0800")
Message-ID: <yq1r2aisah6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=666
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040024
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=725 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yue,

> The memory return by kzalloc() has already be set to zero, so remove
> useless memset(0).

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
