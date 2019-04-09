Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BABC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90A213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZLSLXsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfDICKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:10:53 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59924 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDICKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:10:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x392A4Rk097347;
        Tue, 9 Apr 2019 02:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=HfkS45Zt2fMESAbcnl3hyfZ2EC46gZ0d06xznFPMZWM=;
 b=lZLSLXskSicYiRk9BPdTzZLzw8GvWANg5CRXoY8w8tkndlhxs0iGlCdIC9XZzKvOjMm3
 2YFON2NdZdGuMtXgZY3K0DSbORuVuBaQW0YUOkfAfb82fMxd7DfKIOtlD/yxwKza6sO1
 hnpfhy9YJqZsL88ZVgXP1YoXHB83DEIH7ZhRg+1xin4TX5L12JzRZ29KW3EjXJtJWpZ7
 ASPu/rLFcFKF8Tr6Skwg3BtO+F6Z/44XxrcS0b6quxWCmYYLRUZBli8XSx85DH872IEm
 varNiMwz+sCBRV+gobC5kFXbMSNF7byyXP+eThY21sVA8LK0+JSkZV2vWP3csXQq92Ei pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmea66j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 02:10:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3929cb6007436;
        Tue, 9 Apr 2019 02:10:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2rpj5aa1v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 02:10:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x392ANCq014365;
        Tue, 9 Apr 2019 02:10:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 19:10:22 -0700
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Kento.A.Kobayashi@sony.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        USB Storage list <usb-storage@lists.one-eyed-alien.net>,
        <Jacky.Cao@sony.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: uas: fix usb subsystem hang after power off hub port
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <Pine.LNX.4.44L0.1904041522150.1288-100000@iolanthe.rowland.org>
Date:   Mon, 08 Apr 2019 22:10:19 -0400
In-Reply-To: <Pine.LNX.4.44L0.1904041522150.1288-100000@iolanthe.rowland.org>
        (Alan Stern's message of "Thu, 4 Apr 2019 15:33:38 -0400 (EDT)")
Message-ID: <yq1a7h0orn8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=411
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090013
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=431 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

> So it looks as though the SCSI subsystem doesn't like to have a reset 
> handler call scsi_remove_host.

Are you talking about a PCI device removal handler or a SCSI error
handler?

> Commands dispatched by the removal routines are forced to wait for the
> reset recovery to finish, which won't happen until those commands have
> been completed.
>
> Is this a bug in the SCSI core?  If not, we need to know what is the
> right way to do things when a reset handler detects that the SCSI host
> has been hot-unplugged.

PCI surprise removal should generally work. But it's somewhat unusual
for a SCSI host to evaporate in the middle of error handling. After all,
the main purpose of eh is to leverage the interfaces provided by the
host to try to reconnect to a target that tripped and fell off the
bus...

-- 
Martin K. Petersen	Oracle Linux Engineering
