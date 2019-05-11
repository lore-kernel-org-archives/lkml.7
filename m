Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F0C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784AB217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdWDQ1Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEKWd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 18:33:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45318 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfEKWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:33:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4BMOgAx189680;
        Sat, 11 May 2019 22:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=cg1vXAzcRFjP3GXfQCRMyWsYUJ2Cc80Ce/8Y/l18iMY=;
 b=ZdWDQ1GlAM12R9SP3yvHS31Pp2G9dDtfK6IA0Xac73GUL0zD+nS5QIo9lvdcjZ5fprLA
 RBbMfZZNbNg7LHtQStm4pDyD/kTyDxRSFVIpDYaZ5bi46EqE1cO5vrM0GyB4xNERhak9
 yLuT+zJ6U4ji3CReu/YV3pgmEit6FxgJhnlIBlaOUbVCno7+KKe5lCmUqDhFZeKWWdxf
 8nnR9/rkifOcnfFelT97uZNiWd0oRDT+U5BL1WatnesS8orEMoWrKdrXEKPlm31Ov/yt
 FV7tVoJ9IBEHOI+xnGd9A3CRc4PfZQ4ViHzyHeVTms+aLyu5ofN+oiZU8+peyHK9KO8y 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sdntt9r1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 22:33:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4BMXH7O112688;
        Sat, 11 May 2019 22:33:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sdme9yw8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 22:33:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4BMX5ur020474;
        Sat, 11 May 2019 22:33:05 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 May 2019 15:33:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190510163612.GA23417@bombadil.infradead.org>
Date:   Sat, 11 May 2019 16:33:01 -0600
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, hannes@cmpxchg.org,
        mhocko@suse.com, mgorman@techsingularity.net,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B762A95-B8A6-4281-94F1-5DA6B62EDCF9@oracle.com>
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
 <87y33fjbvr.fsf@yhuang-dev.intel.com>
 <20190510163612.GA23417@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=688
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905110166
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9254 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=718 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905110165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 10, 2019, at 10:36 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> Please don't.  That embeds the knowledge that we can only swap out =
either=20
> normal pages or THP sized pages.  I'm trying to make the VM capable of=20=

> supporting arbitrary-order pages, and this would be just one more =
place
> to fix.
>=20
> I'm sympathetic to the "self documenting" argument.  My current tree =
has
> a patch in it:
>=20
>    mm: Introduce compound_nr
>=20
>    Replace 1 << compound_order(page) with compound_nr(page).  Minor
>    improvements in readability.
>=20
> It goes along with this patch:
>=20
>    mm: Introduce page_size()
>=20
>    It's unnecessarily hard to find out the size of a potentially huge =
page.
>    Replace 'PAGE_SIZE << compound_order(page)' with page_size(page).
>=20
> Better suggestions on naming gratefully received.  I'm more happy with=20=

> page_size() than I am with compound_nr().  page_nr() gives the wrong
> impression; page_count() isn't great either.

I like page_size() as well. At least to me, page_nr() or page_count() =
would
imply a basis of PAGESIZE, or that you would need to do something like:

    page_size =3D page_nr() << PAGE_SHIFT;

to get the size in bytes; page_size() is more straightforward in that =
respect.=
