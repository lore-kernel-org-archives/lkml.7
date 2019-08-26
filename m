Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D793C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D6920850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWVJcKiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfHZRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:04:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34551 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732202AbfHZRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:04:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so10986834pgc.1;
        Mon, 26 Aug 2019 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rV/QxiLUfmMPgKwGt5WE0he8vOLvp0R3y7oyfz3sl9k=;
        b=iWVJcKiTJXGckIV/C6XHfB+VJvjeXB5tiWkVWU/goCNQkAKMDwUgLKSjU8iKtWnYYH
         Yx2CrNttKkdr8yOQrtu/3NonWPm11zzHAueIAKk9t/RbAaPM//SY67IS531OqHI2nvdq
         /c8hkEH64Cw0vYplLq1rzVdEV3gdwjQG9kn0EVs2X1zTBAPaTd/DL5reEFyNtSFjA2nI
         gEaRlK5n4IGDJnynh+TuMKaz/E5qX1/fChu9hn3IaT9HcxE47wZIEHd4UyznO9lN4i+0
         3vrK7D5H4oslSZ1uJP+DAHF2ftOOKPOcTuav/r6leBa5VbAMT59DqA85K9QZaYZEfO8p
         bZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rV/QxiLUfmMPgKwGt5WE0he8vOLvp0R3y7oyfz3sl9k=;
        b=ahxLy5RzYMGRXIbbhHiJCkG7fzvrZ++BUU2O0TpW0znUkzX80ZZ+FZJOu5NiJ6nk0s
         8NpHF5XuIxEJ1OJghpx3N+P0rMAELJxmwv1vPO03cMsJm+GwnsaC5cyVckQ/5olNuksh
         JzarJXx5lrYld6b8IKe241nM/EsVVboENEm16hY4UDMSP62qLamzYQIH2xXgrkVY3qpn
         2mo6lSStzS699cZO0ysIGXpLzox8O1BgxsT9Y2BlhSmrwP9ni9zt4mcSi8ME7GaEcjQt
         1KRlHEMXvWPyWqF6aIUKkMa/2iS1hFZnlCqY3mcoL9k4dA7MD910hj7YbC8m5QlUyzRo
         fY9Q==
X-Gm-Message-State: APjAAAVVvigKeUWrQcpNpiG6PvcSnIQHCKwSJWaYNdhWoL0b2mjEts8z
        fsHeTa2R9Pww9mfhLoRb5gA=
X-Google-Smtp-Source: APXvYqyGrnDlBIoQc7qmXhnO14jQvg2UvGIXB4WJzg/U4DEArH+8N6j3OwNAcaflwL3z+VwsrIF4tw==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr21081325pjs.92.1566839095647;
        Mon, 26 Aug 2019 10:04:55 -0700 (PDT)
Received: from localhost.localdomain ([221.155.202.134])
        by smtp.gmail.com with ESMTPSA id k14sm9688345pfi.98.2019.08.26.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 10:04:55 -0700 (PDT)
Date:   Tue, 27 Aug 2019 02:04:50 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] usbip: Implement SG support to vhci-hcd and stub
 driver
Message-ID: <20190826170450.GA2314@localhost.localdomain>
References: <20190826150007.12187-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826150007.12187-1-suwan.kim027@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:00:07AM +0900, Suwan Kim wrote:
> There are bugs on vhci with usb 3.0 storage device. In USB, each SG
> list entry buffer should be divisible by the bulk max packet size.
> But with native SG support, this problem doesn't matter because the
> SG buffer is treated as contiguous buffer. But without native SG
> support, USB storage driver breaks SG list into several URBs and the
> error occurs because of a buffer size of URB that cannot be divided
> by the bulk max packet size. The error situation is as follows.
> 
> When USB Storage driver requests 31.5 KB data and has SG list which
> has 3584 bytes buffer followed by 7 4096 bytes buffer for some
> reason. USB Storage driver splits this SG list into several URBs
> because VHCI doesn't support SG and sends them separately. So the
> first URB buffer size is 3584 bytes. When receiving data from device,
> USB 3.0 device sends data packet of 1024 bytes size because the max
> packet size of BULK pipe is 1024 bytes. So device sends 4096 bytes.
> But the first URB buffer has only 3584 bytes buffer size. So host
> controller terminates the transfer even though there is more data to
> receive. So, vhci needs to support SG transfer to prevent this error.
> 
> In this patch, vhci supports SG regardless of whether the server's
> host controller supports SG or not, because stub driver splits SG
> list into several URBs if the server's host controller doesn't
> support SG.
> 
> To support SG, vhci sets URB_DMA_MAP_SG flag in urb->transfer_flags
> if URB has SG list and this flag will tell stub driver to use SG
> list. After receiving urb from stub driver, vhci clear URB_DMA_MAP_SG
> flag to avoid dma unmapping in HCD.
 
I have a mistake not modifying this commit log according to the
change of the code. I will resend v8.

Regards
Suwan Kim
