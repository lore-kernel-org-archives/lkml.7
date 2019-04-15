Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D98C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E720833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555315258;
	bh=J+698oxhqHBOnMF8C8VUDpclE65kXybGTV8+R+kQBK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OrInbZsFvYDYa86vYjw54pQo29MQuYr2ihD6vObTSTrpvYsV6/fpx6RLVOy5RovcT
	 9BlrYENx+5+qsm/uPksHjg5cK91cabwP/JVad+QWhv7lyDIMWk/y/E7LI3HNT/G8fh
	 WjF3C6lMwQ+RSpk1ooUpbOTOo3GCt3ZATRhQ6djU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfDOIA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:00:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43352 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:00:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so14691560lja.10;
        Mon, 15 Apr 2019 01:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NzcgzxUNtWnsraNIBShDZ6XRg3i0t/Su0UrJJ7SzQFo=;
        b=O4sRvx5Mb1ftEeCQycjjeA28RCfoUsoI8bccPwNoOiCw6COOHR4jNxSJZVXIUpcXeK
         /2U5D/pUh5bc8hk11N3lrNZX1YI1XAtvItZ5tOmGzWALKqBn2QlOe78EsHxLCVOa+kGm
         5AwYSiUwf0oKeD5Tke4nJdLx40lmu1NYEEnrbFd0tuxvb4sbHIISxUoW4eEuy29MSyfd
         PV4ri1TN3wGsPoxF9SvUatV7lBPe7P0Isokf8G2DwT+SfnLLRrQrr4efx9gHmcvJs1mM
         oqkQ6dN18ENqFhBhJClH1ZZBGHHieGL7g+lpJn1pK3mbhoUQSU8UBX6zmpk7erCBU50K
         LbVw==
X-Gm-Message-State: APjAAAVzrx8OX+lVz7htvKcIsCnsGyOSUQUurmKKkNsPogl7AD+T9eYg
        yazKXWOHgT9hwmBxYpejaTRnd/xu
X-Google-Smtp-Source: APXvYqwY/Gb907x1ZzRilH+F3WXrDf8CCQSgoQdZaGZJkrMksVRFyzq/otEGqQL5aPrJ6TLfQh2UiQ==
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr37824891ljj.27.1555315254650;
        Mon, 15 Apr 2019 01:00:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w8sm3404125lfn.95.2019.04.15.01.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 01:00:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hFwXy-0007oB-Fh; Mon, 15 Apr 2019 10:00:58 +0200
Date:   Mon, 15 Apr 2019 10:00:58 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ramachandran Srinivasan (BRT-SG)" <srinivasan.r@brtchip.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: serial: defer URB submission for ftdi_sio
Message-ID: <20190415080058.GA29656@localhost>
References: <1554724399-2972-1-git-send-email-srinivasan.r@brtchip.com>
 <1554806826-11543-1-git-send-email-srinivasan.r@brtchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554806826-11543-1-git-send-email-srinivasan.r@brtchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:47:42AM +0000, Ramachandran Srinivasan (BRT-SG) wrote:
> From: Srinivasan R <srinivasan.r@brtchip.com>
> 
> Deferring the URB resubmission, this can help time share the available
> DMA chanels of DWC_OTG host controller in RaspberryPi.This change can
> fix the problem, failed to enumerate the USB device when all the 8
> instance of ftdi_sio serial driver is open by application. many bugs
> had been rasied for RaspberryPi around this problem can be solved

Thanks for resending with a commit message. Your patch is still
white-space damaged (check your mail setup, and make sure you can send a
patch to yourself and apply it with git am), but with the above
description I think I can give some feedback already.

First of all, if there's a problem here, it would need to be fixed in
the host-controller driver of the rpi as we don't want to add
workarounds for host-controller issues to every USB driver.

I suggest you write up an even more detailed bug report describing the
problem you're seeing and send it to the list.

Meanwhile, you can try increasing the latency timer of the connected
ftdi devices to reduce the amount of traffic they generate when they're
otherwise idle (16 ms default, can be increased up to 255 ms I think).
That may possibly allow you to push the limits of the rpi.

Johan
