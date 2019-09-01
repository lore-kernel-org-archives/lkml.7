Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473C0C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122BE21897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VD8aoID6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfIAVLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 17:11:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45046 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbfIAVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:11:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81L9Yit156531;
        Sun, 1 Sep 2019 21:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OdZN1sJKRQ7ktng3Zlc0dxCEE8HA71yGt/LZvXW0FT8=;
 b=VD8aoID6FmNo+0KZs6KiZhElPgTxpgTETCcSFnyCdeZBbAKCuHJ0Fqdn6svVdTzyPkTr
 FxHtppusLfKN94IYS7Bh3h/Wu5lIhwHl/6krqYtNw4hIwcDD2q1x4jNmEFfXUFoTf78+
 a24Z4KPU8HUirLMuatxh4GUfdqnR21Rr3gILEeXi4wza2AyH/aynq6j9f1ojMcBApbIH
 Pz9DeA8B+BKgvLoU8Ho3xjQMcQvYQrU7wONlLm3nqWx8SvVSzuJGocwVzl2ydyRVVxn6
 US59Fkal3iE6W/UQX9RGsusthBds06XBGGBTTMNJsCNOU1qQe5186RT/ACHiyblrrugn 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2urnnhg023-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 21:10:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x81L8APN097814;
        Sun, 1 Sep 2019 21:10:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2uqgqjueap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Sep 2019 21:10:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x81LAc3R025645;
        Sun, 1 Sep 2019 21:10:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Sep 2019 14:10:37 -0700
Date:   Sun, 1 Sep 2019 14:10:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -next RESEND] tracing: fix iomap.h build warnings
Message-ID: <20190901211036.GC568270@magnolia>
References: <8a706c7b-5209-4bdd-e09f-5c2d619d75f5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a706c7b-5209-4bdd-e09f-5c2d619d75f5@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909010244
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909010244
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 01:25:37PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix 30 warnings for missing "struct inode" declaration (like these) by
> adding a forward reference for it.
> These warnings come from 'headers_check' (CONFIG_HEADERS_CHECK):
>   CC      include/trace/events/iomap.h.s
> 
> ./../include/trace/events/iomap.h:49:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration
> ./../include/trace/events/iomap.h:77:18: warning: 'struct inode' declared inside parameter list will not be visible outside of this definition or declaration
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> ---
> Resend to correct maintainer(s).

Looks ok, will add it to my tree.  Thanks for the patch. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
>  include/trace/events/iomap.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20190829.orig/include/trace/events/iomap.h
> +++ linux-next-20190829/include/trace/events/iomap.h
> @@ -44,6 +44,8 @@ DECLARE_EVENT_CLASS(iomap_page_class,
>  		  __entry->length)
>  )
>  
> +struct inode;
> +
>  #define DEFINE_PAGE_EVENT(name)		\
>  DEFINE_EVENT(iomap_page_class, name,	\
>  	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
> 
> 
