Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3BCC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800AA24685
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aAWVqr+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLFIGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:06:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49792 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFIGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:06:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB68457E103385;
        Fri, 6 Dec 2019 08:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=UXQchjTv/zEG0bMsDAvcv9Juqcg6k6sEK7Jh6O76G50=;
 b=aAWVqr+iiJ9QAD0Ck4ZdaTIvwBWn/RMtsRcuFxqulhbXTILlmIlhXkrxSYDwi/MTIJXr
 0HihxeKWpn7ZDBgv8GeZhpwp2ivtaQ4gMvZWTSVTbAHOjb16dvlD8wfTVPWEq6xjI4k6
 JArQgqlwRyK9rwXtcK5KcxYncHS8ECa+rsFSVDLCajHl7mXHILn8W7hewUmyRmbvCqb1
 TbNLU6jfc5UGV3ncBxnSjj7KsAcoPqNejnrhBy6l9B8i+HtfTL02qHcsZHXK7V8wcW0l
 7j3qfVEoidUAN6aZyREcwlfdeS5WwZuK5MK5jBS2d7ypftbGZbmmkdMpboOudhVeCPW2 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuutjb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 08:06:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB684IBg144990;
        Fri, 6 Dec 2019 08:06:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wptq0q0hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Dec 2019 08:06:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB685wu4021557;
        Fri, 6 Dec 2019 08:05:59 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Dec 2019 00:05:58 -0800
Date:   Fri, 6 Dec 2019 11:05:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: add missed pci_release_regions
Message-ID: <20191206080552.GJ1765@kadam>
References: <20191206075515.18581-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206075515.18581-1-hslester96@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912060070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9462 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912060070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:55:15PM +0800, Chuhong Yuan wrote:
> The driver forgets to call pci_release_regions() in probe failure
> and remove.
> Add the missed calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

