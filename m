Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF763CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C68D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MV7E6u1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfJaNZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:25:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46466 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfJaNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:25:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VDNNOg099567;
        Thu, 31 Oct 2019 13:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4EaenIUUVj/5ysEKkiJddwhA1/DDa77ctlLESSIuFlg=;
 b=MV7E6u1Dh3gksNYOSvZg2+3+NMPZI6Jv6EHle7fh/krrlnNSLc1zolutX9ZnzLk+wRPR
 ijTM4emqVxu4T3dM92ly/RiXG1/k8ICQaey5YYgMMnYW+7/CoaDPqYTnQdUCOCryJoqb
 BFwj9COYwvEed6vW/eu7yJn1JohPcYOq6Nw5OiMaab8aPZ0DkG/dsX4TbtX0eP24CtQG
 ksWwbrjnqZRSuEflA+w+sfl9WooXpuOnNLO1BoIA/iV6Gz1FF+w+1vR/S20jcdYO/RKf
 j6eTIIo0Kb4TfC37VuZ2Swtv2KmsNHBDZZiFEFwFFKlwJr92T5wU9pORbSzGQWjXsGL0 2Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhfu723-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 13:25:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VDMY4i063251;
        Thu, 31 Oct 2019 13:25:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vyqpe3t63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 13:25:13 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9VDPCDj006216;
        Thu, 31 Oct 2019 13:25:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 06:25:12 -0700
Date:   Thu, 31 Oct 2019 16:25:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Roi Martin <jroi.martin@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] staging: exfat: replace kmalloc with kmalloc_array
Message-ID: <20191031132503.GD1705@kadam>
References: <20191031123139.32361-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031123139.32361-1-jroi.martin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=929
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9426 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:31:39PM +0100, Roi Martin wrote:
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index f71235c6a338..f4f82aecc05d 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -713,8 +713,8 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
>  
>  	u32 checksum = 0;
>  
> -	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
> -						GFP_KERNEL);
> +	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
> +	p_fs->vol_utbl = upcase_table;

This patch is fine, but one idea for future patches is that you could
remove the "upcase_table" variable and use "p_fs->vol_utbl" everywhere
instead.

>  	if (!upcase_table)
>  		return -ENOMEM;

regards,
dan carpenter

