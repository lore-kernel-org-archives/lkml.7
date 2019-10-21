Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92ECA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C5D21479
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+iTTPv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfJUJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:43:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34407 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJUJnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:43:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so7472284pgi.1;
        Mon, 21 Oct 2019 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cmN8zwVr2SuNtBtISWc5Bh4R5qvw1ehXj7JXCfcJmuc=;
        b=E+iTTPv2WkO7Sg5DrRrZ+3kq/EdTZW5ya2GSv2KVb+SpwOK95KlIhr70MPO1ZSRSSI
         q2JFAUNggIuKKqWLRhlVT9vZSVBRETLg4s/kp5XTj/Qqjk8Y86wP6CdR1VRPP++ichgn
         Nh2ICRJsXqZqMXOBZ3YHyM5AwOa2K1HHn3pwjcjaYOgmFfftQOaenHBzoCgj+/E3dGfr
         rM4sgRI2NgS+Ucuh24cwKJ2he7NQd/RE7zV7Z7CKxGcwJTuyhqXAm7WPcdWb+2W0GAMe
         WXezwahge7ydUykNsemHpwvyWfrogiRzphdeaOeOFopUamBh9aNQ0h9DxfnoOqYVqXzt
         mqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmN8zwVr2SuNtBtISWc5Bh4R5qvw1ehXj7JXCfcJmuc=;
        b=BU0OZHnefF9tMcZcrHH/qY52+KTfya4gimP6EO2N6XUsOPAuOEnmAqPb15nxKfnrZ0
         9Sc8nQMnidmOIAzuMadBaQjt7AReysab7Nn1HPdz6+eKdUc1/q5sO3vqkOUF+KSyN0Pm
         3Nc/lgzBkhIqg/WXwVcHoN1V+Admx+iH/Yek2QglAfSbf04CbpMf4j0DDqCmf6RQ+D5u
         QS7yryBOqas0mcruml8WJjBn3aYfm5bwUYFnOSR+pjvZMpidXCz4hwuOaBbVkdu3obhe
         tsXnCmgiA+dYsVgcxSw6fNjXUip39R6xD40DD/xNKScJRmF3xR24K7xxkaN+fmjb2HOS
         TgBQ==
X-Gm-Message-State: APjAAAVJ+iI7FfX7vrfd1qiJZHHtDVaumntMI9QMTKlNSxHJ8X2tlvVd
        GjjWXNUXISVLGbBmkBSh0yo=
X-Google-Smtp-Source: APXvYqwDcvipzqDP7Y+Jxpfnz7WJXuKBuHk1dgRmX0oj2k+9a8LrMfyS0HCuLT2q4KZPSGDyV3O49g==
X-Received: by 2002:aa7:9ed2:: with SMTP id r18mr21552878pfq.1.1571651028530;
        Mon, 21 Oct 2019 02:43:48 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.99])
        by smtp.gmail.com with ESMTPSA id w5sm14195645pfn.96.2019.10.21.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:43:47 -0700 (PDT)
Date:   Mon, 21 Oct 2019 18:43:42 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        shuah@kernel.org
Subject: Re: drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded
 by free on line 150 (fwd)
Message-ID: <20191021094342.GA2471@localhost.localdomain>
References: <alpine.DEB.2.21.1910191946510.5888@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910191946510.5888@hadrien>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 07:49:29PM +0200, Julia Lawall wrote:
> Is it guaranteed that if usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS (line
> 123) is true on one iteration, then it will be true on all iterations? If
> not, then it could be good to set iso_buffer to NULL after the kfree on
> line 150.
> 

It is not always true on all iteration because URB on each iteration
can have different type of pipe. So, I think you are right.
Thanks for reporting this.

I think it seems better to move the declaration of
usbip_iso_packet_descriptor into the while loop.

Could you send a patch to Shuah? Or should I send?

Regards
Suwan Kim

> julia
> 
> ---------- Forwarded message ----------
> Date: Sun, 20 Oct 2019 01:40:11 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@lists.01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded by free
>      on line 150
> 
> CC: kbuild-all@lists.01.org
> CC: linux-kernel@vger.kernel.org
> CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   998d75510e373aab5644d777d3b058312d550159
> commit: ea44d190764b4422af4d1c29eaeb9e69e353b406 usbip: Implement SG support to vhci-hcd and stub driver
> date:   7 weeks ago
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 weeks ago
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> >> drivers/usb/usbip/vhci_tx.c:150:8-18: ERROR: reference preceded by free on line 150
>    drivers/usb/usbip/vhci_tx.c:159:7-17: ERROR: reference preceded by free on line 150
> 
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea44d190764b4422af4d1c29eaeb9e69e353b406
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout ea44d190764b4422af4d1c29eaeb9e69e353b406
> vim +150 drivers/usb/usbip/vhci_tx.c
> 
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   51
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   52  static int vhci_send_cmd_submit(struct vhci_device *vdev)
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   53  {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   54  	struct usbip_iso_packet_descriptor *iso_buffer = NULL;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   55  	struct vhci_priv *priv = NULL;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   56  	struct scatterlist *sg;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   57
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   58  	struct msghdr msg;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   59  	struct kvec *iov;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   60  	size_t txsize;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   61
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   62  	size_t total_size = 0;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   63  	int iovnum;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   64  	int err = -ENOMEM;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   65  	int i;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   66
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   67  	while ((priv = dequeue_from_priv_tx(vdev)) != NULL) {
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   68  		int ret;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   69  		struct urb *urb = priv->urb;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   70  		struct usbip_header pdu_header;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   71
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   72  		txsize = 0;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   73  		memset(&pdu_header, 0, sizeof(pdu_header));
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   74  		memset(&msg, 0, sizeof(msg));
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   75  		memset(&iov, 0, sizeof(iov));
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   76
> 8272d099d05f7a drivers/usb/usbip/vhci_tx.c     Shuah Khan         2017-12-18   77  		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
> 8272d099d05f7a drivers/usb/usbip/vhci_tx.c     Shuah Khan         2017-12-18   78  				  priv->seqnum);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   79
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   80  		if (urb->num_sgs && usb_pipeout(urb->pipe))
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   81  			iovnum = 2 + urb->num_sgs;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   82  		else
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   83  			iovnum = 3;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   84
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   85  		iov = kcalloc(iovnum, sizeof(*iov), GFP_KERNEL);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   86  		if (!iov) {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   87  			usbip_event_add(&vdev->ud, SDEV_EVENT_ERROR_MALLOC);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   88  			return -ENOMEM;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   89  		}
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   90
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   91  		if (urb->num_sgs)
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   92  			urb->transfer_flags |= URB_DMA_MAP_SG;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   93
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   94  		/* 1. setup usbip_header */
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   95  		setup_cmd_submit_pdu(&pdu_header, urb);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   96  		usbip_header_correct_endian(&pdu_header, 1);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   97  		iovnum = 0;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09   98
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28   99  		iov[iovnum].iov_base = &pdu_header;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  100  		iov[iovnum].iov_len  = sizeof(pdu_header);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  101  		txsize += sizeof(pdu_header);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  102  		iovnum++;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  103
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  104  		/* 2. setup transfer buffer */
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  105  		if (!usb_pipein(urb->pipe) && urb->transfer_buffer_length > 0) {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  106  			if (urb->num_sgs &&
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  107  				      !usb_endpoint_xfer_isoc(&urb->ep->desc)) {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  108  				for_each_sg(urb->sg, sg, urb->num_sgs, i) {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  109  					iov[iovnum].iov_base = sg_virt(sg);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  110  					iov[iovnum].iov_len = sg->length;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  111  					iovnum++;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  112  				}
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  113  			} else {
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  114  				iov[iovnum].iov_base = urb->transfer_buffer;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  115  				iov[iovnum].iov_len  =
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  116  						urb->transfer_buffer_length;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  117  				iovnum++;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  118  			}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  119  			txsize += urb->transfer_buffer_length;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  120  		}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  121
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  122  		/* 3. setup iso_packet_descriptor */
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  123  		if (usb_pipetype(urb->pipe) == PIPE_ISOCHRONOUS) {
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  124  			ssize_t len = 0;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  125
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  126  			iso_buffer = usbip_alloc_iso_desc_pdu(urb, &len);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  127  			if (!iso_buffer) {
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  128  				usbip_event_add(&vdev->ud,
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  129  						SDEV_EVENT_ERROR_MALLOC);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  130  				goto err_iso_buffer;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  131  			}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  132
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  133  			iov[iovnum].iov_base = iso_buffer;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  134  			iov[iovnum].iov_len  = len;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  135  			iovnum++;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  136  			txsize += len;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  137  		}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  138
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  139  		ret = kernel_sendmsg(vdev->ud.tcp_socket, &msg, iov, iovnum,
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  140  				     txsize);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  141  		if (ret != txsize) {
> 1a4b6f66285785 drivers/staging/usbip/vhci_tx.c matt mooney        2011-05-19  142  			pr_err("sendmsg failed!, ret=%d for %zd\n", ret,
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  143  			       txsize);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  144  			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_TCP);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  145  			err = -EPIPE;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  146  			goto err_tx;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  147  		}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  148
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  149  		kfree(iov);
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09 @150  		kfree(iso_buffer);
> b8868e45c5f895 drivers/staging/usbip/vhci_tx.c Brian G. Merrell   2009-07-21  151  		usbip_dbg_vhci_tx("send txdata\n");
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  152
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  153  		total_size += txsize;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  154  	}
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  155
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  156  	return total_size;
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  157
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  158  err_tx:
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  159  	kfree(iso_buffer);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  160  err_iso_buffer:
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  161  	kfree(iov);
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  162
> ea44d190764b44 drivers/usb/usbip/vhci_tx.c     Suwan Kim          2019-08-28  163  	return err;
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  164  }
> 04679b3489e048 drivers/staging/usbip/vhci_tx.c Takahiro Hirofuchi 2008-07-09  165
> 
> :::::: The code at line 150 was first introduced by commit
> :::::: 04679b3489e048cd5dae79e050a3afed8e4e42b6 Staging: USB/IP: add client driver
> 
> :::::: TO: Takahiro Hirofuchi <hirofuchi@users.sourceforge.net>
> :::::: CC: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
