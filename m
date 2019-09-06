Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884EF206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DOF557n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405548AbfIFOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 10:42:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfIFOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 10:42:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86Ed6m5079684;
        Fri, 6 Sep 2019 14:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=y8TtBHLyh9FaXB7YWA2oSVkXqqAPTbDmmbDnNI16F7o=;
 b=DOF557n5O1G3LePDNwr0JmO+vUm1GxrH6KN/LwtR3hkP3O/j3iy8egyMpJJWrEE044Ms
 63u4oumZ8oks/ZQRt7gfi0pK7vIAlULQAqYOtlGhhrRO2AZGGB3aE1kS0SNn+hXG9h2j
 0e2sQGNUvzrsaDZFQ6WFwgwhQrFW5urHG0xRcT9U5UnygFZRpuhg1toZ5VtMpqbhEJdX
 KtuV4y/6mgxs7wmro5Da451nB8UjHcp+oaXbc6Bq5IEq+BnYuuiB0W22oulaN3NFJ5sQ
 nCF9axdCfZyMG1fkwd20WASjft3Kw2kS6qExeFXgNQ6OKHyjfNOrCMLbrU9vRwOEetaz OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2uus55048m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:41:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86Ed28j110378;
        Fri, 6 Sep 2019 14:41:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2uum4h555m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:41:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x86EfIvV032549;
        Fri, 6 Sep 2019 14:41:18 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 07:41:17 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id BD96F6A00C1; Fri,  6 Sep 2019 10:43:00 -0400 (EDT)
Date:   Fri, 6 Sep 2019 10:43:00 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] swiotlb-xen: simplify cache maintainance
Message-ID: <20190906144300.GD7824@char.us.oracle.com>
References: <20190905113408.3104-1-hch@lst.de>
 <20190905113408.3104-10-hch@lst.de>
 <e4f9b393-2631-57cd-f42f-3581e75ab9a3@oracle.com>
 <20190906140123.GA9894@lst.de>
 <ca88e7b8-08ca-51b2-0c77-c828d92da0db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca88e7b8-08ca-51b2-0c77-c828d92da0db@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=893 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 10:19:01AM -0400, Boris Ostrovsky wrote:
> On 9/6/19 10:01 AM, Christoph Hellwig wrote:
> > On Fri, Sep 06, 2019 at 09:52:12AM -0400, Boris Ostrovsky wrote:
> >> We need nop definitions of these two for x86.
> >>
> >> Everything builds now but that's probably because the calls are under
> >> 'if (!dev_is_dma_coherent(dev))' which is always false so compiler
> >> optimized is out. I don't think we should rely on that.
> > That is how a lot of the kernel works.  Provide protypes only for code
> > that is semantically compiled, but can't ever be called due to
> > IS_ENABLED() checks.  It took me a while to get used to it, but it
> > actually is pretty nice as the linker does the work for you to check
> > that it really is never called.  Much better than say a BUILD_BUG_ON().
> 
> 
> (with corrected Juergen's email)
> 
> I know about IS_ENABLED() but I didn't realize that this is allowed for
> compile-time inlines and such as well.
> 
> Anyway, for non-ARM bits
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

as well.

Albeit folks have tested this under x86 Xen with 'swiotlb=force' right?

I can test it myself but it will take a couple of days.
> 
> If this goes via Xen tree then the first couple of patches need an ack
> from ARM maintainers.
> 
> -boris
