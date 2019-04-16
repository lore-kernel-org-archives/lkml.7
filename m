Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A2EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2F22064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555426603;
	bh=5YVtZ6wjiJNVk1bpsUO/wQHjY3niLMbTZFs9NfxRGPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fJgn4+YXM2QqeErD8VMCJHAI91yKtnLrg2jF1L7TOWQSxFMSTXlwA2Ry2ZmwO0BN0
	 bvn9xVEfpLtDHdAdo+varlabFqzJM8NCxsFY363li0ftueIPKOFuSdswBc6tp6FSm5
	 uEdqPdkzcsgg/jw1Fdnjs1REZU2PArwOeMjpRFCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfDPO4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:56:41 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42355 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:56:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id e76so7392632ywa.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F4mMBtXzKevLFD5BEz0In9K3gLOn92cY1WhzcnB9D6A=;
        b=XgsbNJEfex5QRGca8MMXz6kHzguYUooI+SJ5KRts1ZqQlE/PKcFffZnata9Jj0Qh4k
         Bfggre0LT7T1kh8pA7tPiaSuHSryBLl1zbLg5EkyRxp2GtKWihX2dZyz7v0sGTX+u+U4
         sAck+ClRUMhWhfSeZwmZQNa+GuUtZYLtLCoGzWQxt9dA8UW1PsXKhP09/6Yey0W6YS4c
         UhdQP/i1sQQofoQjXgwfIh7wTF+F8Dg59LD12+rjJUWdJJOlM6WdfvPc6BDVfQ+S/nsu
         ONhjtaAkUxQL6zjNt+IEMfZU0P5tOIR5pN/+Z6DJAizuElCHid72v2ZRRtSB55k2ic+l
         g+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F4mMBtXzKevLFD5BEz0In9K3gLOn92cY1WhzcnB9D6A=;
        b=hJgPTSPGFhRAKEmWR1EIITFMfIJaicvb+GWFuCIbUASPae0gkpqO8IgtTovmwJJdWf
         zkmFae3+alErUc/P8yTpQh4YlgbQNrevtJMZMwEn7mxf5qsxOF/zTP4j4ZDuXvsGiUeg
         2ATyx8FBxPbOOTkCKKIc6QvfttidQBtZ4xP3Gtcb9AtzQVn7H89Rp6IOsMCmts7NMd2X
         +/Q3+JewFy78LULh6TTcLRRajWuiObalt/TCR8fpmwvPBJV+jzizfPZhq2m99YELpt+L
         5xlHc4VlaFpE9nwR8Iqnb7C+Sr8jlnFZHE6WPAmygLgZEwRZggbzvCKFvuykfUqlSDJR
         pBrw==
X-Gm-Message-State: APjAAAXNNJxpbf11JjJ0GTumQyzjl3LuoVNUoLbGbzdI1pjEViADCK+X
        NRVR8UCSuPdjvTzJLqj2RLQ=
X-Google-Smtp-Source: APXvYqxpYU/sDeR+a1J3QhCs2z6/VLLDXrNMZ2BSjeaL+0hBlx5Fs1EikLZfmo+q32MznxbdXXCopg==
X-Received: by 2002:a81:1693:: with SMTP id 141mr63266472yww.448.1555426600257;
        Tue, 16 Apr 2019 07:56:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::c7e0])
        by smtp.gmail.com with ESMTPSA id b68sm22308374ywh.50.2019.04.16.07.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:56:39 -0700 (PDT)
Date:   Tue, 16 Apr 2019 07:56:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] kernel/workqueue: Verify alloc_workqueue() argument list
 consistency
Message-ID: <20190416145637.GA374014@devbig004.ftw2.facebook.com>
References: <20190319174047.89815-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319174047.89815-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:40:47AM -0700, Bart Van Assche wrote:
> This patch avoids that gcc reports the following warning when building
> with W=1:
> 
> kernel/workqueue.c:4250:2: warning: function alloc_workqueue might be a candidate for gnu_printf format attribute [-Wsuggest-attribute=format]
>   vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> 
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: 669de8bda87b ("kernel/workqueue: Use dynamic lockdep keys for workqueues")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Applied to wq/for-5.2.

Thanks.

-- 
tejun
