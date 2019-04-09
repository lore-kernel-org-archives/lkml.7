Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5451720883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PEOwFrOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDIBjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:39:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53562 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfDIBjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:39:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391dJu2080266;
        Tue, 9 Apr 2019 01:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=j4Cdgmb3epUrJ87NfkbFLyJhjtgeFOZYHV246lxYQxU=;
 b=PEOwFrOzbXuuSs3gkQmvoPzelE1R74NDV71q9VylbaApUL11kwSO+LJC9Me/+AYXQKT3
 hdb866EF08V74JmHQP4G69rIQoUDCo4hm8JashLHtL/B10GxKSNfO5xC3xuShEE6rP+s
 Y+o8c3AN0bhmsVXi66uUrq//9Ken4J1VHb2f5+vY63j6h1ypvrzq13cqwtuFna0AjSQf
 iK3lV0WVTOOt4ElWoq/GlRpNpTlMuipKtHtUXo+5kjNG0NhFZwbVZLEMAu9/MKKYROwh
 o0nF0vZ/iSUp5aHyzp3g73O5BTUE5Yzdgf2UHWs+iv+kTp/6n5xxeHnVqDGZPeBGMEj5 LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rpmrq1uug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:39:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391boCO166824;
        Tue, 9 Apr 2019 01:39:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rpytbbf6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:39:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x391dGqD029461;
        Tue, 9 Apr 2019 01:39:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 18:39:16 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     Rik Faith <faith@cs.unc.edu>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] fdomain: Resurrect fdomain and fdomain_cs drivers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190407185617.8467-1-linux@zary.sk>
        <20190407185617.8467-2-linux@zary.sk>
Date:   Mon, 08 Apr 2019 21:39:14 -0400
In-Reply-To: <20190407185617.8467-2-linux@zary.sk> (Ondrej Zary's message of
        "Sun, 7 Apr 2019 20:56:16 +0200")
Message-ID: <yq1imvoot31.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=820
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090009
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=863 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ondrej,

> This reverts commit e184f2bf4d9f1a3c612a8c1d67e73e9cf8ab5ab9.
> It does not compile but following patches will fix that.

I don't have any particular objections to reviving this driver if people
are actually using it. However, breaking bisection is going to be a
problem. So you'll have to squash the revert and the fixup patch and
carefully annotate the resolutions in the commit description.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
