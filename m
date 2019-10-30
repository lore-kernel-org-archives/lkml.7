Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C82CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4B8218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sdr9cjVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfJ3ITZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:19:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54310 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3ITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:19:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8J7hT009487;
        Wed, 30 Oct 2019 08:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=bIafaFA6HUgKwXCo2YA8eFCgR93KDB2EKBkIkqUQlYQ=;
 b=sdr9cjVMnTfB0Ft0DVbAJNo2Nbv7Vrb6mlr9KWywCq8lX0SlzizxQygoYcgvtUAGXfwb
 Lw66xtc9MwCffa4X8GvlbyEU2ZUPoNDad13SjLcD9sRckPh9mDmoM4cfHmWyLZmJwsek
 BDP1s+Q7Cv99I7ahE04L9htax12+muewtvJgir2Ndg68qObSNzR8CIyIVHmAWNp9BruL
 VQy9CdMLHQRQf0iFBcTTcpctkQz4qFEJuGAF97F1ySjCMudH/pmtKiUf2VyJX0ujtED9
 nP4hXft2xIeXzTfr4joxjNV6wrwyyUpF2VHB8x9+PpRxJiNMHNjBJzyOk07eKpuIkiso kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vxwhfj9sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:19:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8J6CD065699;
        Wed, 30 Oct 2019 08:19:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vxwj9hbc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:19:19 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8JILf022399;
        Wed, 30 Oct 2019 08:19:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:19:17 -0700
Date:   Wed, 30 Oct 2019 11:19:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     shuah <shuah@kernel.org>, kbuild@lists.01.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
Message-ID: <20191030081628.GD3866@kadam>
References: <20191022092839.GD10833@kadam>
 <20191023071120.GA3061@localhost.localdomain>
 <20191024194500.GD23523@kadam>
 <ce76c90b-3431-9342-8b75-882d582c6366@kernel.org>
 <20191026024141.GA3339@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191026024141.GA3339@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=847
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 11:41:41AM +0900, Suwan Kim wrote:
> On Thu, Oct 24, 2019 at 04:52:52PM -0600, shuah wrote:
> > On 10/24/19 1:45 PM, Dan Carpenter wrote:
> > > On Wed, Oct 23, 2019 at 04:11:20PM +0900, Suwan Kim wrote:
> > > > On Tue, Oct 22, 2019 at 12:28:39PM +0300, Dan Carpenter wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > > head:   7d194c2100ad2a6dded545887d02754948ca5241
> > > > > commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
> > > > > date:   7 weeks ago
> > > > > 
> > > > > If you fix the issue, kindly add following tag
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > 
> > > > > New smatch warnings:
> > > > > drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error: uninitialized symbol 'nents'.
> > > > > 
> > > > > Old smatch warnings:
> > > > > drivers/usb/usbip/stub_rx.c:450 stub_recv_xbuff() error: uninitialized symbol 'ret'.
> 
> Here, ret is not initialized, meaning priv->num_urbs is 0.
> priv->urbs must be greater than zero.
> priv->num_urbs = 0 means nents is 0 (line 505)
> 
> Dan, What is the relationship between old and new warnings?
> priv->num_urbs is set as value of "num_urbs" at stub_recv_cmd_submit()
> and "num_urbs" is initialized as 1 first. "num_urbs" will be reset
> only at the place where smatch new warnings happened (line 505).
> 
> So, In my opinion, old smatch warnings should occur after the new
> smatch warnings. Does this look right to you?

I don't know exactly how the 0day bot runs Smatch.  If you have cross
function analysis enabled then silencing the uninitialized "nents"
warning will also silence the uninitialized "ret" warning.

regards,
dan carpenter

