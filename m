Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70434C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BE206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NuihAVEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfJKMzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:55:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfJKMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:55:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BCs5XP158079;
        Fri, 11 Oct 2019 12:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=NqqBMltJqshjqlO0unczWYT072xc5lc4mD81BsYMdno=;
 b=NuihAVEg1zU+Dt9xpZnWOcsZG34qHhhDVxSW033srZIyTlRDDkBmwZvDU/jlxKE+xGUs
 FPPgWNkZnTGQBL/AAHtFxIkiRVaW8zg3WkmSMkrkGAt6JA1S3RyY90J2O/Ny5/W/olwy
 xXA3duN4yyDeYTeOUbsxo6uaiBFhSF1DhKqKaSeX5CzM9WAzvC4qHivuk4etTW4sq15a
 cWZwRgYcQTamSPVFBcNjG6mcUzdEU0RGvvF8wkF3IlFnxviOTAF75H2UKuC9CFUbcLZg
 9ISGJxgYbKZXxoAqjriCZnbq98xyGa2zsjSwUW/GsoR2N+OfetUEJntrxI/pFRCZJKvT 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkv1j1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 12:54:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9BCs4vu121731;
        Fri, 11 Oct 2019 12:54:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vj9qutbgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Oct 2019 12:54:55 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9BCssYi003401;
        Fri, 11 Oct 2019 12:54:54 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Oct 2019 05:54:54 -0700
Date:   Fri, 11 Oct 2019 15:54:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "lkp@lists.01.org" <lkp@lists.01.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild@01.org
Subject: Re: [PATCH] staging: wfx: fix potential vulnerability to spectre
Message-ID: <20191011125446.GD4774@kadam>
References: <20191011101551.30946-1-Jerome.Pouiller@silabs.com>
 <20191011121027.GA1144221@kroah.com>
 <2165496.I6CF8xJYvu@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2165496.I6CF8xJYvu@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910110122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9406 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910110122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:35:36PM +0000, Jerome Pouiller wrote:
> On Friday 11 October 2019 14:10:35 CEST Greg Kroah-Hartman wrote:
> > On Fri, Oct 11, 2019 at 10:15:54AM +0000, Jerome Pouiller wrote:
> > > From: Jérôme Pouiller <jerome.pouiller@silabs.com>
> > >
> > > array_index_nospec() should be applied after a bound check.
> > >
> > > Fixes: 9bca45f3d6924f19f29c0d019e961af3f41bdc9e ("staging: wfx: allow to send 802.11 frames")
> > 
> > No need for the full sha1, this should be:
> >         Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> 
> I copy-pasted information from kbuild robot notification.
> 
> I suggest that commit-id in robot notification is also cut down to 12
> characters. Or even better, to use this snippet:
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 9bca45f3d692 ("staging: wfx: allow to send 802.11 frames")
> 
> (I added lkp@lists.01.org in CC but, I am not sure it is the correct
> ML. I am sorry if it is not the case)

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-testing
head:   d49d1c76b96ebf39539e93d5ab7943a01ef70e4f
commit: 9bca45f3d6924f19f29c0d019e961af3f41bdc9e [55/111] staging: wfx: allow to send 802.11 frames

If you cut and paste then you the "[55/111] " text isn't right either.
Also kbuild works on rebase-able trees as well as non-rebase/published
trees so the hash could change as well.

I am a little bit surprised that checkpatch.pl doesn't complain about
this, though.  You could consider adding that?

regards,
dan carpenter


