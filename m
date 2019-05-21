Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD55EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2221743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mI86anzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfEUOhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:37:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:37:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LESia5053994;
        Tue, 21 May 2019 14:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=RskMyQenR2wM63OcevwOWHNzwugK/Hp4hiHKYsTHcGs=;
 b=mI86anzZgCOl64SZEtqO81GboHVZc8TD37fnMGspxVJG0lLQGcgTh5wWn4sopBVW2vq2
 LjIc/aSOzROGo2RCIB+BtG2R2Eq469qTKrBQevEtmobyIPPiYoJOf3awZCMRFZdRipzJ
 ZwcnZYvS2kG72UzfU0533ZWV8ofPpP9/4WhNx0ubYLtLmmJzVoDYI9eQ5LcXWE7zJUDQ
 XL6Ggi9QRZ7gs1H2z1enYQAf2QPmPKMODc+AqdiisfTkRtleQ2LEp+Kh1ETI/ksAf7Sw
 qNMn5zJJJqZe4p2kfkMCEZmtpUiRU4dPUiyFHuOpBslTBZeL55fBtnOYcP6JLrZrrAoF iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sj9ftdvd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 14:37:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LEa216025352;
        Tue, 21 May 2019 14:37:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sm0470wsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 14:37:38 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LEbb6J005043;
        Tue, 21 May 2019 14:37:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 14:37:36 +0000
Date:   Tue, 21 May 2019 17:37:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Oscar Gomez Fuente <oscargomezf@gmail.com>,
        devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] staging: fieldbus: core: fix ->poll() annotation
Message-ID: <20190521143730.GJ31203@kadam>
References: <20190521142009.7331-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521142009.7331-1-TheSven73@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210091
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:20:09AM -0400, Sven Van Asbroeck wrote:
> From: Oscar Gomez Fuente <oscargomezf@gmail.com>
> 
> ->poll() functions should return __poll_t, but the fieldbus
> core's poll() does not. This generates a sparse warning.
> 
> Fix the ->poll() return value, and use recommended __poll_t
> constants (EPOLLxxx).
> 
> Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
> ---

If you're resending someone's patch, you have to add your own Signed off
by line as well.  Everyone who touches a patch has to sign that they
didn't add any of SCO's all powerful UnixWare source code into the
patch.

regards,
dan carpenter


