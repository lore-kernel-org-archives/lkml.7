Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D7BCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7552B222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJSRtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 13:49:36 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9939 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfJSRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 13:49:36 -0400
X-IronPort-AV: E=Sophos;i="5.67,316,1566856800"; 
   d="scan'208";a="323310689"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 19:49:30 +0200
Date:   Sat, 19 Oct 2019 19:49:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Suwan Kim <suwan.kim027@gmail.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded by
 free on line 150 (fwd)
Message-ID: <alpine.DEB.2.21.1910191946510.5888@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it guaranteed that if usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS (line
123) is true on one iteration, then it will be true on all iterations? If
not, then it could be good to set iso_buffer to NULL after the kfree on
line 150.

julia

---------- Forwarded message ----------
Date: Sun, 20 Oct 2019 01:40:11 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded by free
     on line 150

CC: kbuild-all@lists.01.org
CC: linux-kernel@vger.kernel.org
CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   998d75510e373aab5644d777d3b058312d550159
commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
date:   7 weeks ago
:::::: branch date: 7 hours ago
:::::: commit date: 7 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded by free on line 150
   drivers/usb/usbip/vhci_tx.c:159:7-17: ERROR: reference preceded by free on line 150

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea44d190764b4422af4d1c29eaeb9e69e353b406
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout ea44d190764b4422af4d1c29eaeb9e69e353b406
vim +150 drivers/usb/usbip/vhci_tx.c

04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   51
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   52  static int vhci_send_cmd_submit(struct vhci_device *vdev)
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   53  {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   54  	struct usbip_iso_packet_descriptor *iso_buffer = NULL;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   55  	struct vhci_priv *priv = NULL;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   56  	struct scatterlist *sg;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   57
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   58  	struct msghdr msg;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   59  	struct kvec *iov;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   60  	size_t txsize;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   61
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   62  	size_t total_size = 0;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   63  	int iovnum;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   64  	int err = -ENOMEM;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   65  	int i;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   66
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   67  	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   68  		int ret;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   69  		struct urb *urb = priv->urb;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   70  		struct usbip_header pdu_header;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   71
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   72  		txsize = 0;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   73  		memset(&pdu_header, 0, sizeof(pdu_header));
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   74  		memset(&msg, 0, sizeof(msg));
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   75  		memset(&iov, 0, sizeof(iov));
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   76
8272d099d05f7a drivers/usb/usbip/vhci_tx.c     Shuah Khan         2017-12-18   77  		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
8272d099d05f7a drivers/usb/usbip/vhci_tx.c     Shuah Khan         2017-12-18   78  				  priv->seqnum);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   79
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   80  		if (urb->num_sgs && usb_pipeout(urb->pipe))
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   81  			iovnum = 2 + urb->num_sgs;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   82  		else
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   83  			iovnum = 3;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   84
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   85  		iov = kcalloc(iovnum, sizeof(*iov), GFP_KERNEL);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   86  		if (!iov) {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   87  			usbip_event_add(&vdev->ud, SDEV_EVENT_ERROR_MALLOC);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   88  			return -ENOMEM;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   89  		}
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   90
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   91  		if (urb->num_sgs)
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   92  			urb->transfer_flags |= URB_DMA_MAP_SG;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   93
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   94  		/* 1. setup usbip_header */
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   95  		setup_cmd_submit_pdu(&pdu_header, urb);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   96  		usbip_header_correct_endian(&pdu_header, 1);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   97  		iovnum = 0;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   98
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   99  		iov[iovnum].iov_base = &pdu_header;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  100  		iov[iovnum].iov_len  = sizeof(pdu_header);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  101  		txsize += sizeof(pdu_header);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  102  		iovnum++;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  103
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  104  		/* 2. setup transfer buffer */
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  105  		if (!usb_pipein(urb->pipe) && urb->transfer_buffer_length > 0) {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  106  			if (urb->num_sgs &&
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  107  				      !usb_endpoint_xfer_isoc(&urb->ep->desc)) {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  108  				for_each_sg(urb->sg, sg, urb->num_sgs, i) {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  109  					iov[iovnum].iov_base = sg_virt(sg);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  110  					iov[iovnum].iov_len = sg->length;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  111  					iovnum++;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  112  				}
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  113  			} else {
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  114  				iov[iovnum].iov_base = urb->transfer_buffer;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  115  				iov[iovnum].iov_len  =
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  116  						urb->transfer_buffer_length;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  117  				iovnum++;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  118  			}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  119  			txsize += urb->transfer_buffer_length;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  120  		}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  121
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  122  		/* 3. setup iso_packet_descriptor */
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  123  		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  124  			ssize_t len = 0;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  125
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  126  			iso_buffer = usbip_alloc_iso_desc_pdu(urb, &len);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  127  			if (!iso_buffer) {
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  128  				usbip_event_add(&vdev->ud,
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  129  						SDEV_EVENT_ERROR_MALLOC);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  130  				goto err_iso_buffer;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  131  			}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  132
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  133  			iov[iovnum].iov_base = iso_buffer;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  134  			iov[iovnum].iov_len  = len;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  135  			iovnum++;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  136  			txsize += len;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  137  		}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  138
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  139  		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum,
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  140  				     txsize);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  141  		if (ret != txsize) {
1a4b6f66285785 drivers/staging/usbip/vhci_tx.c matt mooney        2011-05-19  142  			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  143  			       txsize);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  144  			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_TCP);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  145  			err = -EPIPE;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  146  			goto err_tx;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  147  		}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  148
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  149  		kfree(iov);
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09 @150  		kfree(iso_buffer);
b8868e45c5f895 drivers/staging/usbip/vhci_tx.c Brian G. Merrell   2009-07-21  151  		usbip_dbg_vhci_tx("send txdata\n");
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  152
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  153  		total_size += txsize;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  154  	}
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  155
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  156  	return total_size;
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  157
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  158  err_tx:
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  159  	kfree(iso_buffer);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  160  err_iso_buffer:
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  161  	kfree(iov);
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  162
ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  163  	return err;
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  164  }
04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  165

:::::: The code at line 150 was first introduced by commit
:::::: 04679b3489e048cd5dae79e050a3afed8e4e42b6 Staging: USB/IP: add client driver

:::::: TO: Takahiro Hirofuchi <hirofuchi@users.sourceforge.net>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
