Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F014AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF326217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqD4PJ2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfC2LD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:03:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfC2LD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:03:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TAwpHo032792;
        Fri, 29 Mar 2019 11:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZHfTymQFHSl6HXWw9TRWSFfgK57Gz5hPFe96mnLTIT8=;
 b=qqD4PJ2MO/wj4nZ/g1CCvhsk72Y4hQNnTUcBt0M7bKrN5LEVz20nbGOusOtI4zIztbhp
 LEpjnu8LpSectuhAxT0JX8W0aTWUdbo4ZQBkB5XO3C9zf1B6sc9HRm+vWR4M5pQzQN4P
 ntdcs8/3kY8iNHZL/yBzhpN+QeYCgutKYAEseb7eswuoxmggJqVAqNjRoQRSt85pa/4g
 gPwn5gvm9oIto5z8VbYaa8yp4G034SYOlVwjwnD57c6Ieg4h2tsZb8kewnohwEpCuL19
 Cb1RfhbqAKqYjQeITHGwct8eRolPattdQGGNmcaxJDh6T5KQ6n+zyorn98Q/44woiVo0 0Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1kqr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 11:03:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TB3BZN031960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 11:03:12 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TB39Ur007914;
        Fri, 29 Mar 2019 11:03:09 GMT
Received: from kadam (/41.202.241.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 04:03:08 -0700
Date:   Fri, 29 Mar 2019 14:02:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Message-ID: <20190329110258.GB32590@kadam>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=684 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're going to export ion_alloc() for other drivers to use then let's
make an ion_free() helper function as well.

void ion_free(struct dma_buf *dmabuf)
{
	dma_buf_put(dmabuf);
}

regards,
dan carpenter

