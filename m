Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E4AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727952081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mBpQM0Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfCHCiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:38:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57910 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHCiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:38:17 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x282YKJQ038776;
        Fri, 8 Mar 2019 02:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=yjJeNulqjQnicY53u3NHSMKhyR0CtoETc41K/OaFVjI=;
 b=mBpQM0Vi5MJMhPWDp1JtVnHCinVSQmjgVJjFgxgVVpi2xPRxdE3F8i4sI5Qk+4xhVUzG
 36cz1Bd/GUKUCVc8LnXcQpj7kRq8R2+sFWTYZXpZM12lZjT/bXphi8OryD0LOebPUhkR
 seUbkRdOA0EJJwBJ6W92pzsIfHL4n7Vxf7u7hD3RKZbWEQholQDUZcYkyeLz8oMQ/zOO
 a/yiUloSOo7ylsdpJVKpikTX+BdUhijK027nYeI0X4b5AJRzV1HnEynppbysgnXk6wFo
 UKHgxeVR4PtNQVC2Kz+RzYO99U7MDOClAD/QlwLcWVtNrNQRw4oXUyq9Pv3NuICFxy8x 6Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qyjfrwtvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 02:38:08 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x282c7NG024056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 02:38:08 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x282c7Ok030171;
        Fri, 8 Mar 2019 02:38:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Mar 2019 18:38:07 -0800
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cleech@redhat.com, hare@suse.de, Lee Duncan <lduncan@suse.com>
Subject: Re: [PATCH v2] scsi:libiscsi: Hold back_lock when calling iscsi_complete_task
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190225174130.29496-1-leeman.duncan@gmail.com>
Date:   Thu, 07 Mar 2019 21:38:04 -0500
In-Reply-To: <20190225174130.29496-1-leeman.duncan@gmail.com> (Lee Duncan's
        message of "Mon, 25 Feb 2019 09:41:30 -0800")
Message-ID: <yq14l8et7jn.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9188 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee,

> If there is an error queueing an iscsi command in
> iscsi_queuecommand(), for example if the transport fails to take the
> command in sessuin->tt->xmit_task(), then the error path can call
> iscsi_complete_task() without first aquiring the back_lock as
> required. This can lead to things like ITT pool can get corrupt,
> resulting in duplicate ITTs being sent out.
>
> The solution is to hold the back_lock around iscsi_complete_task()
> calls, and to add a little commenting to help others understand when
> back_lock must be held.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
