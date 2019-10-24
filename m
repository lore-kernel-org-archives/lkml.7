Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C0621655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FEmemtBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408170AbfJXTpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:45:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58156 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407590AbfJXTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:45:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OJdhhh054750;
        Thu, 24 Oct 2019 19:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/TnQJ5UGPVxiEvHbnKiUchL/F1tRGlidcvPpnZv7wV4=;
 b=FEmemtBDIflI9JbfrghljbX94c8L6T8miPEQKi1VdsZ5iQN5+IFv56zeLYfJgJCgMPMl
 6OkMa/lQNi92oN8lB3JWgP9Fd022ECaEEPfjJPl+KLE8H7TiKCV0p2/CnFB+WItEUqAT
 voCz74rkDC6uYA+D2KAEyaWtd81iOouTxXQQ/hWaH911NHUn+1/ZOhGmchh+BellrBVh
 xKRmripbpgYe8wPhU+WIs3b4tNO34va4wKY5po2aChRx4KjncAkNnyLrnzBgzM/ePDqP
 FQL1YuiiabqXuxGhs34queFMQ7JVTVc1RkC94XYfvNKakHBX96bFKsqMhHo2wUrgAMi6 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r5nkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 19:45:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OJbhix099139;
        Thu, 24 Oct 2019 19:45:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vtsk5k4rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 19:45:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9OJj8Qc023168;
        Thu, 24 Oct 2019 19:45:08 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 12:45:07 -0700
Date:   Thu, 24 Oct 2019 22:45:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error:
 uninitialized symbol 'nents'.
Message-ID: <20191024194500.GD23523@kadam>
References: <20191022092839.GD10833@kadam>
 <20191023071120.GA3061@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023071120.GA3061@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:11:20PM +0900, Suwan Kim wrote:
> On Tue, Oct 22, 2019 at 12:28:39PM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7d194c2100ad2a6dded545887d02754948ca5241
> > commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
> > date:   7 weeks ago
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > drivers/usb/usbip/stub_rx.c:505 stub_recv_cmd_submit() error: uninitialized symbol 'nents'.
> > 
> > Old smatch warnings:
> > drivers/usb/usbip/stub_rx.c:450 stub_recv_xbuff() error: uninitialized symbol 'ret'.
> > 
> > # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea44d190764b4422af4d1c29eaeb9e69e353b406
> > git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > git remote update linus
> > git checkout ea44d190764b4422af4d1c29eaeb9e69e353b406
> > vim +/nents +505 drivers/usb/usbip/stub_rx.c
> > 
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  453  static void stub_recv_cmd_submit(struct stub_device *sdev,
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  454  				 struct usbip_header *pdu)
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  455  {
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  456  	struct stub_priv *priv;
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  457  	struct usbip_device *ud = &sdev->ud;
> > 2d8f4595d1f275 drivers/staging/usbip/stub_rx.c Max Vozeler        2011-01-12  458  	struct usb_device *udev = sdev->udev;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  459  	struct scatterlist *sgl = NULL, *sg;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  460  	void *buffer = NULL;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  461  	unsigned long long buf_len;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  462  	int nents;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  463  	int num_urbs = 1;
> > c6688ef9f29762 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  464  	int pipe = get_pipe(sdev, pdu);
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  465  	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  466  	int support_sg = 1;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  467  	int np = 0;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  468  	int ret, i;
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  469  
> > 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  470  	if (pipe == -1)
> > 635f545a7e8be7 drivers/usb/usbip/stub_rx.c     Shuah Khan         2017-12-07  471  		return;
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  472  
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  473  	priv = stub_priv_alloc(sdev, pdu);
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  474  	if (!priv)
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  475  		return;
> > 4d7b5c7f8ad49b drivers/staging/usbip/stub_rx.c Takahiro Hirofuchi 2008-07-09  476  
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  477  	buf_len = (unsigned long long)pdu->u.cmd_submit.transfer_buffer_length;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  478  
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  479  	/* allocate urb transfer buffer, if needed */
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  480  	if (buf_len) {
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  481  		if (use_sg) {
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  482  			sgl = sgl_alloc(buf_len, GFP_KERNEL, &nents);
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  483  			if (!sgl)
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  484  				goto err_malloc;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  485  		} else {
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  486  			buffer = kzalloc(buf_len, GFP_KERNEL);
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  487  			if (!buffer)
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  488  				goto err_malloc;
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  489  		}
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  490  	}
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  491  
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  492  	/* Check if the server's HCD supports SG */
> > ea44d190764b44 drivers/usb/usbip/stub_rx.c     Suwan Kim          2019-08-28  493  	if (use_sg && !udev->bus->sg_tablesize) {
> > 
> > Smatch thinks "use_sg" can be true when "buf_len" is zero.  It's hard
> > to tell if Smatch is right or wrong without more context...
> 
> This is a bit strange. The meaning of "use_sg" is that client will
> use scatter-gather and client's urb->num_sgs is not zero. And buffer
> length should not be zero.
> 
> usb_sg and buf_len are both client-dependent variables, so I think
> if they have wrong value in the server side, the client must have
> sent use_sg and buf_len with incorrect values.
> 
> Did this error occur when compiling?

Smatch is doing static analysis, yes.

> If then, Did Smatch also consider vhci tx side?

I'm not really sure...  I can't reproduce the warning because on my
system Smatch doesn't parse usbip_recv() correctly so it ends up
silencing that warning.  :/

regards,
dan carpenter

