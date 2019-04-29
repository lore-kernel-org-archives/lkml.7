Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30CEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EF82075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfD2UFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:05:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36402 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:05:48 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so10141005ioc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tC2ii7OkMypP9Br4uPDYWWFU7NBDDS8QRme9Wy6zm/8=;
        b=BEF6FeqCkvGhBgLDl5yPPWV3i4tMpavwlD6geMWM/d1ryf9v+iHwgg4uJIB7rgioBh
         Kyp2l/4gBJz9MKEMcel32vMP8gnDkR0SdFHxUVBynbwY4G0sG1fo4VIBb4Gx5FKXexoo
         At9/+gjbjguglioui8T/cbrPPI8msEG+RpKaFYn59E92IQzOpxirZ/npNDNbpfR2CWQM
         FIVqwBbxlbkj6Ldm74V3h6UA5GqMx/GUCWiAPcDtVnIcY4pq/2k4f8FF7c5nQTs76tWr
         Xa48jUJEfYTYWK20klO5c2Zo+krNXbuuO0rDWLHuooMNHgMdOtwU52+B+AwA1sqY1Lpi
         GS3w==
X-Gm-Message-State: APjAAAW7QmtKrCyKUc7nExhhJPUOdivGF1FlCAfXzbsZNj0HrHeRBkwL
        LqzA8X4A8JiqMB9Xa8FtPq1ibg==
X-Google-Smtp-Source: APXvYqxivxOcXaQhwX8xCEpSH/9z5tK+xILufw0tv9Y5/ccJdVJ6UOC1csH3kacmPD5O/YpVwnzcUg==
X-Received: by 2002:a5d:8245:: with SMTP id n5mr12201452ioo.41.1556568346959;
        Mon, 29 Apr 2019 13:05:46 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id b72sm255077itc.30.2019.04.29.13.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 13:05:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 14:05:41 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xhci: Convert xhci_handshake() to use
 readl_poll_timeout_atomic()
Message-ID: <20190429200541.GA116440@google.com>
References: <20190208014816.21869-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208014816.21869-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 05:48:16PM -0800, Andrey Smirnov wrote:
> Xhci_handshake() implements the algorithm already captured by
> readl_poll_timeout_atomic(). Convert the former to use the latter to
> avoid repetition.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Tested-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Raul E Rangel <rrangel@chromium.org>

This fixes a bug on the AMD Stoneyridge platform. usleep(1) sometimes
takes over 10ms. This means a 5 second timeout can easily take over 15
seconds which will trigger the watchdog and reboot the system.

Thanks for the patch.
