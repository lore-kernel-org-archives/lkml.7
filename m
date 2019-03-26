Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC96C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DBF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RgHCQqzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfCZCRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:17:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbfCZCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:16:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q2Eg06070669;
        Tue, 26 Mar 2019 02:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MVh6iyVh6pfaPwx2nIbPIPcsC6b9eJdbN6v4Q03ZN+c=;
 b=RgHCQqzyLx+FKCqoltB6qhClmde4MmOf0jOkKB3PT3JVrOPSsoZjzbR8y9HZPCNte4QP
 BBWo1Wx7A8hzyc62oJBtsElHuFTTQSZlSTidGYqKgHYrQksCpkC2IQIZWsWh6Q4Zb1ck
 2x1sAagesb+Qf74k3AQVSb53HSk7F7iVh0mOoX+sWA+y8GM8TpD4b2hH3DHRVssYlYkU
 uS9OhL+VyVVwKknaXKu/nxRcNx2MMaOAmpT9ouumj1ito3h+noCImL4RoAJIkWY1QAwY
 ReskAK9HpnXh0XxGSsOilPCrnFxT7kuRX4YBqEMSdp03o5NPVNhCrHniN4qXFXjQ87t3 gw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6dj7mxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:16:41 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2GZCj012186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 02:16:36 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q2GVYv023480;
        Tue, 26 Mar 2019 02:16:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 19:16:31 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qla4xxx: avoid freeing unallocated dma memory
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190322142530.904080-1-arnd@arndb.de>
Date:   Mon, 25 Mar 2019 22:16:28 -0400
In-Reply-To: <20190322142530.904080-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 22 Mar 2019 15:25:03 +0100")
Message-ID: <yq1y352z8g3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=678 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> Clang -Wuninitialized notices that on is_qla40XX we never allocate any
> DMA memory in get_fw_boot_info() but attempt to free it anyway:

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
