Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A14C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE18218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IK5jRT10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfB1VdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:33:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54454 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfB1VdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:33:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1SLERO7082133;
        Thu, 28 Feb 2019 21:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=9cjAB8k482sCSDI8ZI00ufOwnTQdR1UDDejmT12EfLw=;
 b=IK5jRT10KiIbs+MeoHXGnViw+Wx/ztx1TQ64VQFsmz/NDvWk/EY8F4zu981bXu9nXBlY
 gYMcea/eyZwUF+2B2InUG4rF0Jbk9Uw4SQZcbEEuc/SY7P0QgUPo237+giHa/zCMhc+k
 00aRoV3Ylx7HE9Vhj1UeR0tYq3Un84ADOOpNDKZ4+QnaFngOKZYUkNxis3C2Q+URspUa
 Y9JNtHv71krIi7EjnqDs52vbZk2pGIFgG0ISETkITPgDtkftWdrG14oQ9yqleZaYIwCS
 H3Hc2r9fYyc5BWe2fgC+LXFnmyFD0ymL01M0dX7nlqsfHorUGYL3S7uC9aBpl0FJX9AS pQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qtupem174-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 21:32:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1SLWjpS008053
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Feb 2019 21:32:45 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1SLWgrn022976;
        Thu, 28 Feb 2019 21:32:43 GMT
Received: from dhcp-10-65-148-83.vpn.oracle.com (/10.65.148.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Feb 2019 13:32:42 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v2 2/4] mm: remove zone_lru_lock() function access
 ->lru_lock directly
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190228102229.dec5e125fc65a3ff7c6f865f@linux-foundation.org>
Date:   Thu, 28 Feb 2019 14:32:41 -0700
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3682FD80-92AD-4388-8751-00FD1CC74D46@oracle.com>
References: <20190228083329.31892-1-aryabinin@virtuozzo.com>
 <20190228083329.31892-2-aryabinin@virtuozzo.com>
 <7AF5AEF9-FF0A-41C1-834A-4C33EBD0CA09@oracle.com>
 <20190228102229.dec5e125fc65a3ff7c6f865f@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9181 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=712 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902280142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 28, 2019, at 11:22 AM, Andrew Morton =
<akpm@linux-foundation.org> wrote:
>=20
> I don't think so.  This kernedoc comment was missing its leading /**.=20=

> The patch fixes that.

That makes sense; it had looked like just an extraneous asterisk.

