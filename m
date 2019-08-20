Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9732C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96923206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566332119;
	bh=n29P5S3QcyG2uCxfNOSraHfdRpm8XtwyZOcGsAAJpnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SYfZ9MSQeTC6e3Bc6KtNf3+we1+lusj9fD10YrD3iPEDIiTcH+2m/Gs0ODksjqYWP
	 aGOFRa0Ztwm20dr/9zA6isMx3z4zLW7KpwQTCGjB4gM5Z8c9OFuDjoJKpAI5ABuiE3
	 yWGKcAUikDIv0YXiMUTw5UIuYjOslpqBwH9X8UT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfHTUPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfHTUPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:15:18 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A9C206DD;
        Tue, 20 Aug 2019 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566332117;
        bh=n29P5S3QcyG2uCxfNOSraHfdRpm8XtwyZOcGsAAJpnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z2YwkruaLKNEvRv9Abmz3yGf14hRNNZAgrGu+YlxQLshNXj8L0Mm+10vQlLLRpurJ
         RZKX2sXffWAjZSy5N2obFnKJoyJKFUE3ksXESv7PlzcEHZ46k2o5Y4B9Ax/qZEBI0l
         ACbRodmy2iraeTYmI5VzoxrJlF0S1AJx3eM6FxcY=
Date:   Tue, 20 Aug 2019 13:15:15 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        stable <stable@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
        linux-usb@vger.kernel.org
Subject: Re: USB: gadget: f_midi: fixing a possible double-free in f_midi
Message-ID: <20190820201515.GA20068@kroah.com>
References: <20190820174516.255420-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820174516.255420-1-salyzyn@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:45:13AM -0700, Mark Salyzyn wrote:
> From: "Yavuz, Tuba" <tuba@ece.ufl.edu>
> 
> cherry pick from commit 7fafcfdf6377b18b2a726ea554d6e593ba44349f
> ("USB: gadget: f_midi: fixing a possible double-free in f_midi")
> Removing 'return err;' from conflict.
> 
> It looks like there is a possibility of a double-free vulnerability on an
> error path of the f_midi_set_alt function in the f_midi driver. If the
> path is feasible then free_ep_req gets called twice:
> 
>          req->complete = f_midi_complete;
>          err = usb_ep_queue(midi->out_ep, req, GFP_ATOMIC);
>             => ...
>              usb_gadget_giveback_request
>                =>
>                  f_midi_complete (CALLBACK)
>                    (inside f_midi_complete, for various cases of status)
>                    free_ep_req(ep, req); // first kfree
>          if (err) {
>                  ERROR(midi, "%s: couldn't enqueue request: %d\n",
>                              midi->out_ep->name, err);
>                  free_ep_req(midi->out_ep, req); // second kfree
>                  return err;
>          }
> 
> The double-free possibility was introduced with commit ad0d1a058eac
> ("usb: gadget: f_midi: fix leak on failed to enqueue out requests").
> 
> Found by MOXCAFE tool.
> 
> Signed-off-by: Tuba Yavuz <tuba@ece.ufl.edu>
> Fixes: ad0d1a058eac ("usb: gadget: f_midi: fix leak on failed to enqueue out requests")
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: stable <stable@vger.kernel.org> # 4.4.y

No signed-off-by from you?

Anyway, this is already in the 4.4.y queue and will be in the next
release.

thanks,

greg k-h
