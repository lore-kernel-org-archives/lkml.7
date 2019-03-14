Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0320854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jXJYqj6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCNDQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:16:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfCNDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:16:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2E39mE0185682;
        Thu, 14 Mar 2019 03:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Tbn9L9JC2PvOXhZb++S5Xd5rp0+oxYJSrOIeCQrROhk=;
 b=jXJYqj6K5RsQOos0q0G1mt/6Fg7tAwrAKmepviNIW6qG6qhIY/ELgeLgAmcWNZ5oWBH8
 J9h8inex27r5uujMfvm8MoaRDCPFhgXzkMFiGlUhCe3oISdGI51C6WI17h10Cijwd5Qn
 QErgLjZqdNX9Qmsjg4LS4tq5l/Q0QUxu/3nTjDY/J9c6Zi1aljdhZSIzMndROeC19tWT
 eAWYnGgUY7sePq9/Hf2Cdt2xn4aTFeSEiyt1f5RlRGuKjeK/P935seApCPiSgCsR6w3f
 Q5iDn6EMr90yrMuVsHg4IgvYnf16/faKY5BpQ1Te/B9N0gkwX/CAChDu8ShQ2lL68Fqg lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2r44wueh0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 03:16:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2E3GUEN015452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 03:16:30 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2E3GTq0027374;
        Thu, 14 Mar 2019 03:16:29 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Mar 2019 20:16:29 -0700
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, diego.gonzalez@oracle.com
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Subject: [BUG] scsi: ses: out of bound accessing in ses_enclosure_data_process
Message-ID: <78dd3eca-7e8a-72f9-07f9-e2c7cc4569b0@oracle.com>
Date:   Thu, 14 Mar 2019 11:19:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

When our customer probe the lpfc devices, they encountered odd memory corruption issues,
and we get 'out of bound' access warning at following position after open KASAN

ses_enclosure_data_process

for (i = 0; i < types; i++, type_ptr += 4) {
  for (j = 0; j < type_ptr[1]; j++) {
                   ^^^^^^^^^^^
                   out of bound

With some debug log, I got following,

page1 ffff88042d1aad20 len 32 types 5 type_ptr ffff88042d1aad64

Would anyone please give some suggestions on this ?

Thanks
Jianchao
