Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14EBCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A65621925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFHtrhEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442679AbfJRLab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:30:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbfJRLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:30:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IBSjdL182948;
        Fri, 18 Oct 2019 11:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=mmN3Nf8EOZFfA0GztjsmQxxSmIoUSxz/s0RPgOyHAuY=;
 b=SFHtrhEh5euJP8Z0Vy8Jg3DLSaX5x1xY/SNso1ebQEsKPEe9EchYEY8NlSmLMd6vpW2F
 Md76CFSYFJQpAOX/XMlq6mmOeSWRQ32kPmQaefELsfgcsd5cdpUak3yokjoRXYDC4k6m
 F9wmSt2AcreUEVif5bdAw+srYqHsDimxGuJ2JIo2B1EqOSMkYdsbBiDZpbxQwoNHewvr
 n5TwpLPCC+2LCM9WgDl2sCpIhN/3Hs1zr+E7EOWsjMkwa8hGfc3ZNo2mB/BUdLEh+tSU
 /Smb1c6Z8D8eSJQqX5s6NLVmiYHutdyIaOkL5UZeWwq0vQBiT1ChSVphSbDssNwnoEmk Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vq0q4bab2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 11:30:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IBSpoN174326;
        Fri, 18 Oct 2019 11:30:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vq0dxcbws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 11:30:26 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IBUPaV002334;
        Fri, 18 Oct 2019 11:30:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 11:30:24 +0000
Date:   Fri, 18 Oct 2019 14:30:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: reduce stack usage of
 rtw_cfg80211_unlink_bss
Message-ID: <20191018113017.GG24678@kadam>
References: <20191018104837.23246-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018104837.23246-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=985 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:48:37AM +0100, Sudip Mukherjee wrote:
> The build of xtensa allmodconfig gives warning of:
> In function 'rtw_cfg80211_unlink_bss':
> warning: the frame size of 1136 bytes is larger than 1024 bytes
> 
> Instead of having 'select_network' structure as a variable use it as a
> pointer.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Heh.  Nice.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

