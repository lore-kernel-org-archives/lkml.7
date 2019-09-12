Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B90C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9F8208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LUE8CLyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfILIAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:00:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38797 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:00:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id h17so21377575otn.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qmb78FYDeqJwCvfIUFA64DMXds2PW8DdSpXeskuPq4=;
        b=LUE8CLyXWQcGt5ozi574sQ/J9n0AJBvhhr7mv+LYM7f/8vSmrjw+pFEvB6VjkLyi2t
         VykulW20DQEli1D3Mh2AuNGF45hqYL+SxnAJSDp01zHAp7mNNNUbKM/cre3vGpdeRS6H
         wy/2DOV2srDzpSUJ9zXH7YcwAPvdS4tOSNJEu2rY6jsa/6oo8fa3kREiLMB6QAxQBtaz
         E7jQbOT+uvfQSV/Cwgx6NmLW/9DJGQ2Q4QibUNeUoSN8y2iId9qV2HceqdpD3NzVa0jg
         RKOTKjKQdX+ORNbR4e7Wz/Z+71lOHkS+iVKdy00uIPl4ofTM9OQ2hBVdGTSodfBfBWV0
         NRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qmb78FYDeqJwCvfIUFA64DMXds2PW8DdSpXeskuPq4=;
        b=oeDe6eD0UcJ+btiCirpKrdpIsxtsFd6bOReDNHuf0EQsFhhvIhcPm8tBS2NIUQPlMc
         AY+onT17WHfbKUwuxTcZBiZhnn0UQEb2GoMt9ma+TVcqYzevoJcuEOjLhDMmhn03ZvVx
         uZGRNA2BjBkJEL42kC6TNGcSoL8uFbY8ohjFeLj3GGGWNGPdTesDJZCyFAuJL5OpfRYS
         Lu4/T0MaDvqAZ2Xb6MpxiDrVlxLEUmgSkPNWav/v0gaJtdr4v0RFyEbMel13g2xvOXu9
         WbOYWQ4N/j59+pnF2Dx8cXGTQic4K8JgQgr/hc9PD57DgYVbl+/ra14QYbw86MZlcn72
         6B1g==
X-Gm-Message-State: APjAAAUWYuj7sU/iC7zh7T29KSo+mNK4NMSckBK1/aclLUWTxye7gPKK
        1s8vlR3eEP7rDd+y5D8vzOFemhkbw/S2HPAgSrXjGw==
X-Google-Smtp-Source: APXvYqyNoKF90/9aOosnjKNEcyJn0PnaFlqebXAMnVcR447j+ePIeVT1xmancYwa1G/50/CDhUr+1E5BW/SAO4iY+u4=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr8105329oti.71.1568275245893;
 Thu, 12 Sep 2019 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
In-Reply-To: <cover.1568256705.git.joe@perches.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 Sep 2019 01:00:35 -0700
Message-ID: <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To:     Joe Perches <joe@perches.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Sep 11, 2019 at 7:55 PM Joe Perches <joe@perches.com> wrote:
>
> Rather than have a local coding style, use the typical kernel style.

I'd rather automate this. I'm going to do once-over with clang-format
and see what falls out.
