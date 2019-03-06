Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6825CC10F0C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B0E20828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NS75H5d4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfCFJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:36:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50356 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfCFJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:36:58 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x269XhiX164633;
        Wed, 6 Mar 2019 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=ySK+dnbEwNc/jKCcXQYwRKr281ZVSbI5VAD5JADKSXY=;
 b=NS75H5d4BIExubi8/gXjQ+2jAR9Hi4BPuZF3X6XKt/me6YlINo6XvDNNsBCC0vMEQyVo
 Pc3woLLg39I4or4aXAD39z0GMcS/BIt7hWfEyZXCrXqn85VsccruAlMigBRgynYXiTsV
 geQv/bjWg4mcE5q+DECQCOU78M3nW7FTprWJIOAHgT0XPCza+7bArIBNW8zUJIIEgn/Q
 JHtGrZ9G49gxvnq+su5xOIGf/Y8l7RtaAc0pGE9xgogrCTo028oMGWrncVdbBMOreUZe
 horeE9axn7c5GHwmel/i+f/S/LU7elvuZ8hB+zHgZHkg8jAR1L+T2Tv8eZYHxeEumG1l xQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qyfbeawsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 09:36:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x269acXb019478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 09:36:38 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x269abKR024174;
        Wed, 6 Mar 2019 09:36:37 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 01:36:37 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH v3] page cache: Store only head pages in i_pages
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <CAPhsuW5a8=QJe2acWXQGWic1a=CJigwPR6BxSu2O2vg4W1mhzA@mail.gmail.com>
Date:   Wed, 6 Mar 2019 02:36:35 -0700
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <863F9255-E992-402F-827D-DA5F4661B9AB@oracle.com>
References: <20190215222525.17802-1-willy@infradead.org>
 <CAPhsuW7Hu6jBn-ti7S2cJhO1YQYg_RDZUgkqtgFO8zpBMV_9LA@mail.gmail.com>
 <CAPhsuW5a8=QJe2acWXQGWic1a=CJigwPR6BxSu2O2vg4W1mhzA@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9186 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Other than the bug Song found in memfd_tag_pins(), I'd like to suggest =
two quick
but pedantic changes to mm/filemap.c:

Though not modified in this patch, in line 284, the parenthesis should =
be moved
to after the period:

 * modified.) The function expects only THP head pages to be present in =
the

> +		 * Move to the next page in the vector if this is a =
small page
> +		 * or the index is of the last page in this compound =
page).

A few lines later, there is an extraneous parenthesis, and the comment =
could be a bit
clearer.

Might I suggest:

                 * Move to the next page in the vector if this is a =
PAGESIZE
                 * page or if the index is of the last PAGESIZE page =
within
                 * this compound page.

You can say "base" instead of "PAGESIZE," but "small" seems open to =
interpretation.

I haven't run across any problems and have been hammering the code for =
over five days
without issue; all my testing was with transparent_hugepage/enabled set =
to
"always."

Tested-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
