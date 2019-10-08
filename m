Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9375BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C8205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZO3tmZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJHO1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:27:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJHO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:27:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98E9LSo051875;
        Tue, 8 Oct 2019 14:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=GfyLIyqEXxIaQ2ACVoOP4oi4Ygck8YSsBITIQGuPxKk=;
 b=ZZO3tmZ3gQVSLd44qJDLr14aTBJ+45hTD+0oLHKe/QFJkx0wt0+8Il93UI62MOadCgun
 ZJ6zZ+pZDxJ8ldFJczwGgP3YcL323c84s04yGngHjtNTGa3YupuII/vmevf4fbw8yyKz
 CsjdpASsKjfV/5bpfHS0lbMEFOtckUmr0sWbL8zxzSj4oARMSlbtv2EQtc5RYqqE7g5D
 RYhNfxPXQRVlSBJbtYj8jpV/KpNztCyDVpYY+46TBuTAFVcve+zYzNa73qQMx+djrK++
 E/F1OxThFaX+iDXcuPfjZDmHVJ//uYpVYONh2FpX9igLgaDKbimL1ytGoG0Pp670fdXc oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vektrde4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:27:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98E92iE155480;
        Tue, 8 Oct 2019 14:25:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vg206ds9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 14:25:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x98EPP4U015274;
        Tue, 8 Oct 2019 14:25:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 07:25:24 -0700
Date:   Tue, 8 Oct 2019 17:25:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: vchiq: don't leak kernel address
Message-ID: <20191008142517.GO21515@kadam>
References: <20191008123346.3931-1-mcroce@redhat.com>
 <20191008131518.GH25098@kadam>
 <CAGnkfhxefH+3YKDWQMCOYoj1skcq6rUmHuiHZQ-76YixFqbQjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGnkfhxefH+3YKDWQMCOYoj1skcq6rUmHuiHZQ-76YixFqbQjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=830 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:21:54PM +0200, Matteo Croce wrote:
> On Tue, Oct 8, 2019 at 3:16 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The subject doesn't match the patch.  It should just be "remove useless
> > printk".
> >
> > regards,
> > dan carpenter
> >
> 
> Well, it avoids leaking an address by removing an useless printk.
> It seems that GKH already picked the patch in his staging tree, but
> I'm fine with both subjects, really,

The address wasn't leaked because it was already %pK.  The subject
says there is an info leak security problem, when the opposite is true.

regards,
dan carpenter

