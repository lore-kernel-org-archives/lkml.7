Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B23C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2A8206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JMg4G6wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLQSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:06:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfLQSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:06:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHI524Y084487;
        Tue, 17 Dec 2019 18:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=T+GnWQ1AKZOIs5s0xU8NEiourpCMeoVx+dHg7sen55I=;
 b=JMg4G6wMki8gozIoQ2/uuHN4c+yy4H4tUcA+UlWC8jpjsViVbG4qaPOMtzkO8jP98ANa
 /8nxn3LuTULapjXgOA84gf3ozbAkIAemnieRpJ59iS+0xZ+EJMxzd8q6DWXH+KdwiEm4
 HrG9aeDvN3Gk9EO2AH4OjdLpVn7wzh/AcBJeGin2dXXElLa7hjrVo91Iy/+WtA5uWGAN
 YYcmsXXp4qiQMtt93jMTYoSeCFIzj3HfUiJXsTZngyvrd/ji+fqA78viHrVECf45hUY6
 aqsCjD8N/RsVwBMIhIiTv907Ja/GOTlZmOxDmBw55MpEN8VBDG33DrWK7BtqDgD1h5R3 0w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wvq5ugh4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:06:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBHI3PGR012618;
        Tue, 17 Dec 2019 18:06:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wxm5nmcm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 18:06:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBHI68Gi017125;
        Tue, 17 Dec 2019 18:06:08 GMT
Received: from [10.39.197.155] (/10.39.197.155)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Dec 2019 10:06:08 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 0/3] basic KASAN support for Xen PV domains
From:   Boris Ostrovsky <BORIS.OSTROVSKY@ORACLE.COM>
In-Reply-To: <20191217140804.27364-1-sergey.dyasli@citrix.com>
Date:   Tue, 17 Dec 2019 13:06:05 -0500
Cc:     xen-devel@lists.xen.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7301D02C-D33F-4205-BB32-C3E61015D26E@ORACLE.COM>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912170142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9474 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912170142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 17, 2019, at 9:08 AM, Sergey Dyasli <sergey.dyasli@citrix.com> =
wrote:
>=20
> This series allows to boot and run Xen PV kernels (Dom0 and DomU) with
> CONFIG_KASAN=3Dy. It has been used internally for some time now with =
good
> results for finding memory corruption issues in Dom0 kernel.
>=20
> Only Outline instrumentation is supported at the moment.
>=20
> Patch 1 is of RFC quality
> Patches 2-3 are independent and quite self-contained.


Don=E2=80=99t you need to initialize kasan before, for example, calling =
kasan_alloc_pages() in patch 2?

-boris

