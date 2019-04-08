Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EC620863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554752710;
	bh=9Kbqrvw6Vxmv5QUvjZc2024VCkrsqnOx5zOB1yP/8Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a0wdZ7nQvtEnVM2nH/ZV00m1DEwURehhWAAkHkqXCUKnrnDjmUsyBzFSUzjgbIhuq
	 e+cYWJrn0bZQhiaDp6IJTeMVm+sziaoE4mTRFhKRj3LjqZ9HZe8yVaLIflFsyNbLN9
	 h4Nl8oULwgjmb2Xb6b4r0iOwuq1CImeDA+3Qe6u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDHTpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:45:09 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34081 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:45:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id a3so1237204ybr.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjTnuzTQHiA0MMFJAawTA1rDWjQ+jv2E5LPgh/fJhNg=;
        b=uz6609eamMx0VrhzrqfWEDu1oQ3cLtp8ONVFgvmBf1LZBBCinI5dhZC2O8ubKGiMA4
         EZHNfO/Vno7spe4dfP0QK/pPj/KlUZQqiUq0HPcqGiI/Mx51+sVcwxStWFW3xc9sN6yP
         Qds49ANFscwiyQfrBAY/VemTqVo91KoyztTkVV2eNqKl4cPTX+xQU5T6JWL/zztoia97
         JUKLpMOCqCNvJeJbIMTagV4ijn2X6Raag1w7BOLyhC5MqCZ5FpNcidnxBToacEOHYc3d
         YhMFd877+5rXZH6aPjzIfbaMVJF9D1wrHGP2mLN+NKjB7VhUTR7KGv15mugRoVyLk8LN
         +M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjTnuzTQHiA0MMFJAawTA1rDWjQ+jv2E5LPgh/fJhNg=;
        b=INijM3ueSWIv1e5EwI6mIp3myFcNab/J2ypkk9oy5Rquwk9FicVNFpPDKD8Ejyuhfr
         FNa2q4Rckunqh7m86Dj9qk0G+jCZ7J0zo59J9NkXnih/BHwrfehovomTb0L66dAShLxS
         bUBKnxVh3y+pulCmiNudp5aMgxDYE9Dp5sUxzRXzCPv5zz4hk8toBug4SnZYosDlPwP2
         KoPRAWZTn+inxlYspBGzLy+0jFIGObojc94EQIo689+YSNbiQ0StQn1UllLXaxDTCl/B
         d2+OiArr3EBJtVEyybYevKIbbmlwttdNgIGaxXOl8n8HZw7wFRXjOvakuUSgwufcrkBF
         byQg==
X-Gm-Message-State: APjAAAVKSL1/x4SWZsmd+8hnJxPc8glBKdUaFLx5QHv/lbsEahXAUE9Y
        IV9zlYH9b7GoKO2/eMQOzLycjd3q
X-Google-Smtp-Source: APXvYqzMNJUGOmY+raFf7vAQj4R9qFlDU3umPD4Hob5erOgTuwNXoI+QTZGMyYSjncLd769Con2wLw==
X-Received: by 2002:a25:3716:: with SMTP id e22mr26063201yba.20.1554752707770;
        Mon, 08 Apr 2019 12:45:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:135c])
        by smtp.gmail.com with ESMTPSA id d64sm11091993ywb.64.2019.04.08.12.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 12:45:06 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:45:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/2] sched: Distangle worker accounting from rq lock
Message-ID: <20190408194505.GK1975820@devbig004.ftw2.facebook.com>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313165548.19713-3-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Mar 13, 2019 at 05:55:48PM +0100, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The worker accounting for CPU bound workers is plugged into the core
> scheduler code and the wakeup code. This is not a hard requirement and
> can be avoided by keeping track of the state in the workqueue code
> itself.
> 
> Keep track of the sleeping state in the worker itself and call the
> notifier before entering the core scheduler. There might be false
> positives when the task is woken between that call and actually
> scheduling, but that's not really different from scheduling and being
> woken immediately after switching away. When nr_running is updated when
> the task is retunrning from schedule() then it is later compared when it
> is done from ttwu().
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Link: http://lkml.kernel.org/r/20110622174919.135236139@linutronix.de
> Link: http://lkml.kernel.org/r/ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: preempt_disable() around wq_worker_sleeping() by Daniel Bristot de
>           Oliveira]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This looks good from wq side.  Peter, are you okay with routing this
through the wq tree?  If you wanna take it through the sched tree,
please feel free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
