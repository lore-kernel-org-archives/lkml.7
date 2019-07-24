Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B793C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D062253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tfbt2I4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfGXCPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:15:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:15:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2EXn6039333;
        Wed, 24 Jul 2019 02:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wUoL7Z86OEs4qLzhJXZrHf0vot8+kbrUJlufMs9r9h4=;
 b=tfbt2I4KTCy+11Ro1lX/a4E4Y06wol9qWrz+6I1aHlmnTVNK76HqaMIWTBtzwwfuTpVj
 rZkYkENvURhcfbUu2UKdL/GAjW231SqkBSXbrAlrjhefYzaGyCYW2I1JOR7YZ5azFpc+
 nlf0cLdgq2n0bRMaUwHi8bam1Eh+5xor4nULCo9NkISeoKRt+oNVgYhe1y5Po2fS2yfj
 1oJ3XFdxyrqbSbAhVAK4mP03t6kXxymtj0Y3daFzI5xKs3Q4605egArFmy3DWnj6KaUY
 UsIy4EEtXjYXvKfdpmLRwjQUGxpQgCU0FukMVrxIAGQe8OyA3Z9iTEWA1iCzFqasMdyS IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tx61bt7jk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:15:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2CsSN092226;
        Wed, 24 Jul 2019 02:15:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2tx60xkhtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:15:44 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6O2FhEn011364;
        Wed, 24 Jul 2019 02:15:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:15:42 -0700
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        martin.petersen@oracle.com
Subject: Re: [PATCH RESEND] scsi: megaraid_sas: fix panic on loading firmware crashdump
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190722161524.23192-1-junxiao.bi@oracle.com>
Date:   Tue, 23 Jul 2019 22:15:40 -0400
In-Reply-To: <20190722161524.23192-1-junxiao.bi@oracle.com> (Junxiao Bi's
        message of "Mon, 22 Jul 2019 09:15:24 -0700")
Message-ID: <yq1wog8qisz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=735 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Junxiao,

> While loading fw crashdump in function fw_crash_buffer_show(), left
> bytes in one dma chunk was not checked, if copying size over it,
> overflow access will cause kernel panic.

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
