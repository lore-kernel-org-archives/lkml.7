Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B22084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vkhzb6eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfCKMTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:19:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42586 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:19:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BC96fD072366;
        Mon, 11 Mar 2019 12:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bDD59JllYSk0321O5FEz0An2d6vIuOjVL8JIUviCVSk=;
 b=vkhzb6ePDn7HnTFONbASTcCW0EJMjcZcOXGGksraSBL7LOyj8G85KWnZ93SKOuZkddkz
 en8OMnJEhiSmhMaphCkxLHKDGxoBIRQFDrV+2y6CFrJC+AseVzznRB9jilq2uXK/5/ec
 cynfMukhe8kqEayNhYQGNxr+P30a4XNoPj3KzghNf/0IkYEFK6gNCyOrVi7kamZH2Pjb
 d+mWb6EdYjfBbEFZl4mmRYwS2kvsa4yaH4/gGRmTfVWI7k1G/RHDMkH1uI/bEITisMCq
 Ygu8RE5msgNStlUAew7hW2uLumPfa2uaYKt6AqZ3d5yUs+LhfV2XFHUeuVJu33FltKbW wg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430eefv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 12:19:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2BCJRJT031064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 12:19:27 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BCJR2v029888;
        Mon, 11 Mar 2019 12:19:27 GMT
Received: from kadam (/197.157.34.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 05:19:26 -0700
Date:   Mon, 11 Mar 2019 15:19:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, vz@mleia.com
Subject: Re: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Message-ID: <20190311121918.GD2412@kadam>
References: <20190311093959.86344-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311093959.86344-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9191 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:39:59PM +0800, Mao Wenan wrote:
> Add the missing uart_unregister_driver() and i2c_del_driver() before
> return from sc16is7xx_init() in the error handling case.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

This looks nice.  Thanks!

Reviewed-by: Dan Carpeter <dan.carpenter@oracle.com>

regards,
dan carpenter

