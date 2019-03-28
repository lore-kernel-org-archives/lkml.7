Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C66217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uuaZgE8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfC1Opl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:45:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Opl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:45:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SEcUvS062047;
        Thu, 28 Mar 2019 14:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=f8nKABZEWRaEjHIFUMeN+b36gTly03R/PHIMpY8MInA=;
 b=uuaZgE8q/aWtQJOP54IW71CMDC/BlM73dkDzIw679k8+zPpBcGWC2p1k5DRTLJsHdsBG
 qXix9HQ9my8XkYjzWgp5BlzrAPuG5888hpE2w/bgzJbySXTu5PsxxqjpX1Mlpz++OfOv
 OXIm26R0a/zZgCdf1KwOOuJGgjymOphrN2dxRKfYigyGoz7yKfHq2zdamivFvNZdSEqi
 GHljtmuzsp6j9LussaI4T+XFU+Mcj+4MYRi9IYnqkx7hMOByANHxMy3NhbXSp8m4HTK6
 G7vvXi9nse0R7yN/ogTm0Z0H7MSoY/f8JP8NhRyoZyXnEi90wbONo7kWOAEXS54pOIVM /g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g1f1hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:45:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEjMbh023641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 14:45:22 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SEjM8u015597;
        Thu, 28 Mar 2019 14:45:22 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 07:45:21 -0700
Date:   Thu, 28 Mar 2019 17:45:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, devel@driverdev.osuosl.org,
        Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 22/68] vfs: Convert binderfs to use the new mount API
Message-ID: <20190328144507.GV32590@kadam>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373020049.7602.8355937001441630312.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155373020049.7602.8355937001441630312.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9208 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:43:20PM +0000, David Howells wrote:
> +static void binderfs_free_fc(struct fs_context *fc)
> +{
> +	struct binderfs_info *info = fc->s_fs_info;
> +
> +	if (info) {
> +		struct ipc_namespace *ipc_ns = fc->s_fs_info;
> +		put_ipc_ns(ipc_ns);

I feel like put_ipc_ns(info->ipc_ns) would be more readable.

> +		kfree(info);
> +	}
> +}
> +

