Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0122C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26D22173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ITfJiVja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfEUPPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:15:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42904 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:15:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1qQ1087594;
        Tue, 21 May 2019 15:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Uqv3nKXWWkJ9B0A+oT8QlIR1q8DM2+THe+i7fy28Bj4=;
 b=ITfJiVjadmq6ClilKxKxon+dtJaovaW0GkxecG/dv90DcwQUhhq0gyY3qsDwBe2kMmWj
 3yho1AgjU+mvWW3hrcd++ohKN/QHCfNcDYWZn3ZKeGyLQ8d1izdfOhny9qLzLTd4LiRS
 T9vcWliYo/Pu7OKatoilij9FlRp96r4WF62yPOimXY4Gg8dYi6GdCD4cTlD8metInNXS
 FhiKVHIr5OU4f9QQFzVGZeXrgR+7xA9LZewti0/fpP/5b9bGediB2FXBuxfqLeHN/CXJ
 D+gXJ5gar9Rg2cMK6VULlhoogzaKhuyhUQQVGYdTG08HrsOA4MYonzb2V6xTGMgf+8YM 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sj9fte5h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:14:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LFDUqm112774;
        Tue, 21 May 2019 15:14:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2sks1y8sw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:14:56 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LFEq2e002400;
        Tue, 21 May 2019 15:14:52 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 15:14:51 +0000
Date:   Tue, 21 May 2019 18:14:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tianzheng Li <ltz0302@gmail.com>
Cc:     rspringer@google.com, devel@driverdev.osuosl.org,
        zhangjie.cnde@gmail.com, linux-kernel@i4.cs.fau.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        toddpoynor@google.com
Subject: Re: [PATCH] staging/gasket: Fix string split
Message-ID: <20190521151444.GN31203@kadam>
References: <20190521150728.25501-1-ltz0302@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521150728.25501-1-ltz0302@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=851 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 05:07:28PM +0200, Tianzheng Li wrote:
> This patch removes unnecessary quoted string splits.
> 
> Signed-off-by: Tianzheng Li <ltz0302@gmail.com>
> Signed-off-by: Jie Zhang <zhangjie.cnde@gmail.com>

What do the two sign off mean here?  What did Jie Zhang do?  Who wrote
this patch?

Co-developed-by?  Reviewed-by?

regards,
dan carpenter

