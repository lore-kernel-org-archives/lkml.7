Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F63C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4438120652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ba/dhODp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfD3JND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:13:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfD3JNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:13:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U99T2M012438;
        Tue, 30 Apr 2019 09:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=D85Wq90jjObkLFFLUB4CImCULz5ARyZY4RoZ0C5wI1k=;
 b=ba/dhODp+oU3cXtVngVom0CQnh3Z7k6fuG8XTcNi1HCfnpfjWJjMEZmlvVGXlVIoNGhQ
 PAIv33FRbLaSKVWc3cg6jJ9Kfjg3xhht1+zHCK28D00mYtBeTbMsfWnBJQfGMEFtn0lK
 1JodDE/8Hcs5+66vRLIt68LYu7o8cQJ0dTpEgLg7BS3jsRplIxqid8VVPQ+UbPzSx3Gc
 ceK38GctkOMRP79SznizKPVYRUwqIQ4EhXA6BfEyRuCKVpU5MWyGVWSZw/lXFY1k+5de
 p7aj7maJEBMPIoMrsgDN+VpIdIIXJItSm4HwLeZbEXXI1/LIdzGRsx5rgdkflQ/MUbeH oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s4fqq38b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:12:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3U9CfsD143563;
        Tue, 30 Apr 2019 09:12:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2s4d4adfvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 09:12:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3U9CquC018369;
        Tue, 30 Apr 2019 09:12:52 GMT
Received: from kadam (/196.97.65.153)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 02:12:51 -0700
Date:   Tue, 30 Apr 2019 12:12:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: Use memset to initialize resources
Message-ID: <20190430091242.GA2269@kadam>
References: <20190424185742.7797-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424185742.7797-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:57:43AM -0700, Nathan Chancellor wrote:
> diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> index ad2cc0a3bfa1..13f544f3c0b9 100644
> --- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
> +++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
> @@ -93,8 +93,8 @@ void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, co
>  int  probe_core_basic(unsigned int core_num, struct kp2000_device *pcard, char *name, const struct core_table_entry cte)
>  {
>      struct mfd_cell  cell = {0};
> -    struct resource  resources[2] = {0};
> -    
> +    struct resource  resources[2];
> +
>      struct kpc_core_device_platdata  core_pdata = {

Greg already applied this and that's cool but I would have probably
gone with "struct resource resources[2] = {};".  memset() is only
required if we want to clear out the struct holes because we're going to
copy the whole struct to userspace.  (Some compilers will change
foo = {} into "foo.a = 0; foo.b = 0;" when it's faster than doing a
memset, so the struct holes don't always get cleared).

Also it was risky from a process perspective to delete the stray tab
from the next line because some one could have argued that it was
unrelated or that the whole line should be removed instead.  You would
have had to redo the patch for something silly... #YOLO #LivingOnTheEdge

But in this case, it's already applied so everything worked out. :)

regards,
dan carpenter

