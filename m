Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C0C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3FC20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxxVAkKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfHXKqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 06:46:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfHXKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:46:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7OAhg6A001982;
        Sat, 24 Aug 2019 10:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=6Xe8d4/Qc67NKEUdvz915wuZpclJkk7CNF5g6iXqF5Q=;
 b=TxxVAkKor0C492SSz9eUNsWgdO7WiVZGpqc89E/qjzLXRT8C6XdsdwM44hfIBf1ZHX2l
 YTZ1MILMW6ZdZqRQUfkD7TIQnZAbB9q3QvhpwLf6w6njntnO27Z9Uicat2KZNBB3EWMu
 KBorrXzmbqdZuMIaZDfJxRVhvwIdRh5+AuQ5L5NYIaUY+A+BgjaHH7yIb++pH1/7MxAZ
 iC+ETyIB2NFoaignvx86k4a5Jk6oMaKhts9NcK8ktGkOGDIZmzcytPMIeMGLUPjaY4sf
 AK+5UiJLCIieMGFrDmD8fQt1NtHneSZoG9ybEkhaCRtcyjcLDEmkCpPDUd/HFgRzolZd BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ujw6yrwb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Aug 2019 10:46:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7OAhXrv145624;
        Sat, 24 Aug 2019 10:46:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ujw6t78pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Aug 2019 10:46:36 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7OAkUYd007167;
        Sat, 24 Aug 2019 10:46:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 24 Aug 2019 03:46:29 -0700
Date:   Sat, 24 Aug 2019 13:46:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Forest Bond <forest@alittletooquiet.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: vt6656: Use common error handling code in
 vnt_alloc_bufs()
Message-ID: <20190824104620.GC23408@kadam>
References: <91e8a9b7-e79d-dafc-10b8-dd79eb59eff9@web.de>
 <20190823145540.GA2536@qd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823145540.GA2536@qd-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9358 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908240119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9358 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908240120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code is fine.

There was no chance we were going to apply the patch so there is no need
for any discussion.  I don't know why Markus sent it when he knows.

regards,
dan carpenter

