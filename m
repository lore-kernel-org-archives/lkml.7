Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A998206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfB1W4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:56:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36955 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfB1W4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:56:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so10433760pgq.4;
        Thu, 28 Feb 2019 14:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBjUfSi8SSZo6d+K8p+ydz6wylgoOcuYkbYeqOyEYQ8=;
        b=k9oOFP0zNCga8LT1H5qocz+lQVJ0N3+hsMr67zZlvguCtQXOh7Qw41HJ7fgMyl2CZE
         GG8+Itkv7Tx6B7XH/UOaJDgefdnGc9IGl6w8yvRE/5GH4xShOF79IPyfykTsxWqz3K9W
         zgXw5XNg6Hr7JeROhEBZZqVpWvdb/3f9T4LLfNbjixQckrb0PX0kTXIga4zbI+RFj6PL
         FwO3TJeMj9lk/9AMeOFh/Tpt+2mIMfl8Q8Z+2jbvBI/l5j/iwXQ7wUVw0xDW/w5Zv7vc
         Z4/F/gVCfdeO0/duTmzgegbiektGh1xs0D/gWY7UnsHEdbbxW4yMhaF2f+6a7iaUJPMG
         2Qyw==
X-Gm-Message-State: AHQUAuaJ9iJpOycXfG/sxex4ZCMOLDkaKjYRh1tdK6R6M4rNW7c+egKb
        B74eRRKYcVzfWrtBz2rzVdI=
X-Google-Smtp-Source: AHgI3IY14w0CrjpfsUeHiKvhk3Rps1C5oT+zjxudPUYU6I8SIeDuP3Q4I0DAaeKKfbq0Y/1sSi1Y0Q==
X-Received: by 2002:a62:1851:: with SMTP id 78mr2171973pfy.206.1551394598244;
        Thu, 28 Feb 2019 14:56:38 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j197sm34164773pgc.76.2019.02.28.14.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 14:56:37 -0800 (PST)
Message-ID: <1551394596.31902.209.camel@acm.org>
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
From:   Bart Van Assche <bvanassche@acm.org>
To:     Shaobo He <shaobo@cs.utah.edu>, linux-rdma@vger.kernel.org
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Feb 2019 14:56:36 -0800
In-Reply-To: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 15:38 -0700, Shaobo He wrote:
+AD4 In function +AGA-c4iw+AF8-dealloc+AF8-mw+AGA, variable mhp's value is printed after
+AD4 freed, which triggers undefined behavior according to this post:
+AD4 https://trust-in-soft.com/dangling-pointer-indeterminate/.
+AD4 
+AD4 This commit fixes it by swapping the order of +AGA-kfree+AGA and +AGA-pr+AF8-debug+AGA.
+AD4 
+AD4 Signed-off-by: Shaobo He +ADw-shaobo+AEA-cs.utah.edu+AD4
+AD4 ---
+AD4  drivers/infiniband/hw/cxgb4/mem.c +AHw 2 +--
+AD4  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4 
+AD4 diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
+AD4 index 7b76e6f..bb8e0bc 100644
+AD4 --- a/drivers/infiniband/hw/cxgb4/mem.c
+AD4 +-+-+- b/drivers/infiniband/hw/cxgb4/mem.c
+AD4 +AEAAQA -684,8 +-684,8 +AEAAQA int c4iw+AF8-dealloc+AF8-mw(struct ib+AF8-mw +ACo-mw)
+AD4  			  mhp-+AD4-wr+AF8-waitp)+ADs
+AD4  	kfree+AF8-skb(mhp-+AD4-dereg+AF8-skb)+ADs
+AD4  	c4iw+AF8-put+AF8-wr+AF8-wait(mhp-+AD4-wr+AF8-waitp)+ADs
+AD4 -	kfree(mhp)+ADs
+AD4  	pr+AF8-debug(+ACI-ib+AF8-mw +ACU-p mmid 0x+ACU-x ptr +ACU-p+AFw-n+ACI, mw, mmid, mhp)+ADs
+AD4 +-	kfree(mhp)+ADs
+AD4  	return 0+ADs
+AD4  +AH0

Please quote the relevant paragraphs from the C standard. All I have found
about free() in ISO/IEC 9899:2017 is the following:

Description
The free function causes the space pointed to by ptr to be deallocated, that
is, made available for further allocation. If ptr is a null pointer, no
action occurs. Otherwise, if the argument does not match a pointer earlier
returned by a memory management function, or if the space has been
deallocated by a call to free or realloc, the behavior is undefined.

That is not sufficient to claim that the above code triggers undefined
behavior.

Bart.
