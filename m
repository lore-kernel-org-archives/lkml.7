Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD8020854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zvgJle9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfCFRgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:36:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55102 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfCFRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:36:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x26HXexC193464;
        Wed, 6 Mar 2019 17:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=s0jy1NVVr812ofAP6Y/uR8IxoJb4ey92Z1wpiqJnhxg=;
 b=zvgJle9nPgazVnE9EgczrG8FUeSC+xvjdKxJTAzZEvPuttX6nldJxwEsVAA24T47o/DP
 lSI5/dgFc0LIGOgtzFn6canSoQyX6PUVvXsfgize7jkKbZCw873jlendA7Ka5mOecb/i
 DE1Z+q8IIexdMpEAqL+M132DxD7arbKpbUfDCRBh9NcmYp1lGGrOqGKNG7Krp7nonTod
 f0ydxsde994jkjVCVuOJHEU+Hx2aZJ4WMR5R3turRAXe8v7cJZwFWUazRVhelMUfhQJ3
 GYRRai22eyN87c4wG2GFpqbT5EaKXce1/m0XCWn/JaJEtpr4FMeEcr9zUQwp83KsdITE KQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qyfbedfwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 17:36:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x26HZvvE011193
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 17:35:57 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x26HZvjU019338;
        Wed, 6 Mar 2019 17:35:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 09:35:56 -0800
To:     Felipe Franciosi <felipe@nutanix.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: virtio_scsi: don't send sc payload with tmfs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1550403730-27876-1-git-send-email-felipe@nutanix.com>
Date:   Wed, 06 Mar 2019 12:35:54 -0500
In-Reply-To: <1550403730-27876-1-git-send-email-felipe@nutanix.com> (Felipe
        Franciosi's message of "Wed, 27 Feb 2019 16:10:34 +0000")
Message-ID: <yq1tvgfzz0l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9187 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=810 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Felipe,

> The virtio scsi spec defines struct virtio_scsi_ctrl_tmf as a set of
> device-readable records and a single device-writable response entry:

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
