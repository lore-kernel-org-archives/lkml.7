Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753DFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42802222A6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1tBhijm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfCXJjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 05:39:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46018 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 05:39:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so4391844pgk.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLHRKxv6xAaXXLDJNoc6q3LkQZpx6iAKZubfl7jWAec=;
        b=l1tBhijmtLc4PzdzUU7P9ecetMK8y2Gy7hOw1gtmXO34YVFU6aJQ37Otr2uv2d/t8e
         K6l/V+BhdEAh2YsBpF80IVUjlt5On/c7pwuUZcFAhDkCJb1almGpTWkRbKeUigmuxLk8
         iXf+ngddM2Rf4On+ptJXet364uppsKWZBIesol7NmdxSa489Lb4Zuwa7z0dQSS00F6+n
         cWCI8rMemcSkEVHb6RDt68PqChTMOfR7LA+lsoHLYU9PjpXgrp+ILB7HzJAjCzReUGpf
         wxsCqOJ2oQQFZlIhEmoEkXHXFDDZakXQt8IOkVmHyOCmfczMgswzbIqjBFQMrBEevzxs
         Ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLHRKxv6xAaXXLDJNoc6q3LkQZpx6iAKZubfl7jWAec=;
        b=RXGVng7SwPHtW55IG2og4zwVcdenQABqRLWtfW7lx0lnR9lz5EHVB8WxPk0IF4EWdy
         q9AJUJmhVha5VBcFhmLU4m+XhbTr+L/vxE8GTLX4bEPirWEvCy6ZbYxE2UrZrA09IUwr
         fbwIDAkgcWs/SDaDG1SjgOwOhg5xFwKxKyzPXWMCD47OSDaY+bDArH84xlwDSEtUtsbT
         YN0tlrxtn818rO0xj+iNI7ebrZCEnku497isLmzIPlGYhPX5DUsnSRS7sBVEs3hbOGjy
         PfjFO96B0DrMFOPpc8+5On3kP2yREXFLU226pXdA3nsO5tztpxCby/nStoDd4iouS0Bf
         ZCcQ==
X-Gm-Message-State: APjAAAX7bNT37JGyoWfYT1aUp2aleKp/7RTn0GUb7pbJOsD/zvGVBwb3
        VplEJ3TF4qKo6Drzo6ZYDddDlJjQ
X-Google-Smtp-Source: APXvYqwqKiM7gRMglPxoI+LtDTlrEA0AgTxiro1E1NOh8QHIwuFEb18zM0jXjinSbQ/0trUKTpYVfw==
X-Received: by 2002:a62:ab13:: with SMTP id p19mr18087419pff.131.1553420355905;
        Sun, 24 Mar 2019 02:39:15 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id z6sm43755206pgo.31.2019.03.24.02.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 02:39:15 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:09:10 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     philipp.panzer@fau.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: ralink-gdma: Use u32 over uint32_t
Message-ID: <20190324093910.GB15691@bharath12345-Inspiron-5559>
References: <20190323154648.GA10634@bharath12345-Inspiron-5559>
 <20190324085833.GA21912@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324085833.GA21912@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 09:58:33AM +0100, Greg KH wrote:
> On Sat, Mar 23, 2019 at 09:16:48PM +0530, Bharath Vedartham wrote:
> > Fixes the checkpatch.pl warning: "Prefer u32 over uint32_t"
> > 
> > Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> > ---
> > Changes since v3
> > 	- Fixed allignment issues.
> > 	- Submitted a seperate patch to change unsigned
> > 	to unsigned int.
> > 	- One of the allignments crosses 80 characters in a line
> > 	but I feel that we may loose readability if we try to reduce
> > 	the characters in the line.
> > ---
> >  drivers/staging/ralink-gdma/ralink-gdma.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> This patch does not apply to my staging-testing branch at all :(
Same case here :(. I have used linus's branch rather than the staging
branch. I have also noticed that this patch does not apply to the
staging branch as this checkpatch warning has already been  fixed in the
staging branch.
