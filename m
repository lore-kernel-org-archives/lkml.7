Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F2A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ISCoYDFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKKUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:41:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45029 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:41:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id f2so16089735wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8K8x18JCJt+y0F/d1syChnD1Af3sC+4itc7RyBI12Eg=;
        b=ISCoYDFHCnsxDIGOLnL3ikYvobtu5KjID6cfMKw+qehnDoiXOXDShQJtf8hBXsbUQf
         TGtyrXdClPy+S0sId7BfnX+zW7BOUoewe4xYcDZ+EDW8XVO3bc1iVw9m/OqNtZfakd69
         bU1WUG06oT8Dak6BW5N19UEQgoSdM99G6HLTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8K8x18JCJt+y0F/d1syChnD1Af3sC+4itc7RyBI12Eg=;
        b=uiqOs6JoTq3Nq673rjB1VbKPDit3GfppBbOhiT6QIMP6ImpTLY1i6WA226w7N+hP1O
         FBmczvrsp/lnNgFgjWWTSNHNoxDeP6Zwek2z9yLrGO6hYWwiCblRafbkFbY9ueiiLA0C
         DlW5flKaoU+/upTit/VpqF8IX1V0MjuyRn69/pxoJJ8YGmU3WTBdyyro7oMNO5LtUdV7
         bWSKlDQQkY+12kj/Rn2xMCDf2tvUpmb95ZvnBaYv1HlSYEu8M3pKlZdIyOBWY5YG8e0k
         JqrHtobp/ochxbbVC+ckAlGpn9jydR7ZYlHWftl5YJO1jWuAtfdnqSfWDpXz4js1oldv
         PYaw==
X-Gm-Message-State: APjAAAVBuqkFIwC+LUGfKYtWAzyVLZ1V+3d3vygbTKXnqMlly8hN7JUH
        72YMIsOP5Cee6h6+m92KG3JczX75suGlNNBK
X-Google-Smtp-Source: APXvYqwxfAqkG4oA9oTXP58v0Sq0bDi0Y8CwBTj7x9PlgAF4hyppLzMy1Epzx5mozN9MOW5blu9d6g==
X-Received: by 2002:a05:6000:103:: with SMTP id o3mr24351465wrx.80.1573504900980;
        Mon, 11 Nov 2019 12:41:40 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id o189sm1020173wmo.23.2019.11.11.12.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:41:40 -0800 (PST)
Subject: Re: [PATCH v7 1/2] fork: extend clone3() to support setting a PID
To:     Adrian Reber <areber@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191111131704.656169-1-areber@redhat.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <cc5f90b6-ea1f-dbdb-e713-cc0fceceafbe@rasmusvillemoes.dk>
Date:   Mon, 11 Nov 2019 21:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111131704.656169-1-areber@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2019 14.17, Adrian Reber wrote:
> The main motivation to add set_tid to clone3() is CRIU.
> 
> To restore a process with the same PID/TID CRIU currently uses
> /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> ns_last_pid and then (quickly) does a clone(). This works most of the
> time, but it is racy. It is also slow as it requires multiple syscalls.
> 
> Extending clone3() to support *set_tid makes it possible restore a
> process using CRIU without accessing /proc/sys/kernel/ns_last_pid and
> race free (as long as the desired PID/TID is available).
> 
> This clone3() extension places the same restrictions (CAP_SYS_ADMIN)
> on clone3() with *set_tid as they are currently in place for ns_last_pid.
> 
> The original version of this change was using a single value for
> set_tid. At the 2019 LPC, after presenting set_tid, it was, however,
> decided to change set_tid to an array to enable setting the PID of a
> process in multiple PID namespaces at the same time. If a process is
> created in a PID namespace it is possible to influence the PID inside
> and outside of the PID namespace. Details also in the corresponding
> selftest.
> 

>  	/*
>  	 * Verify that higher 32bits of exit_signal are unset and that
>  	 * it is a valid signal
> @@ -2556,8 +2561,17 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>  		.stack		= args.stack,
>  		.stack_size	= args.stack_size,
>  		.tls		= args.tls,
> +		.set_tid	= kargs->set_tid,
> +		.set_tid_size	= args.set_tid_size,
>  	};

This is a bit ugly. And is it even well-defined? I mean, it's a bit
similar to the "i = i++;". So it would be best to avoid.

> +	for (i = 0; i < args.set_tid_size; i++) {
> +		if (copy_from_user(&kargs->set_tid[i],
> +		    u64_to_user_ptr(args.set_tid + (i * sizeof(args.set_tid))),
> +		    sizeof(pid_t)))
> +			return -EFAULT;
> +	}
> +

If I'm reading this (and your test case) right, you expect the user
pointer to point at an array of u64, and here you're copying the first
half of each u64 to the pid_t array. That only works on little-endian.

It seems more obvious (since I don't think there's any disagreement
anywhere on sizeof(pid_t)) to expect the user pointer to point at an
array of pid_t and then simply copy_from_user() the whole thing in one go.

>  	return 0;
>  }
>  
> @@ -2631,6 +2645,10 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
>  	int err;
>  
>  	struct kernel_clone_args kargs;
> +	pid_t set_tid[MAX_PID_NS_LEVEL];
> +
> +	memset(set_tid, 0, sizeof(set_tid));
> +	kargs.set_tid = set_tid;

Hm, isn't it a bit much to add two cachelines (and dirtying them via the
memset) to the stack footprint of clone3, considering that almost nobody
(relatively speaking) will use this?

So how about copy_clone_args_from_user() does

if (args.set_tid) {
  set_tid = memdup_user(u64_to_user_ptr(), ...)
  if (IS_ERR(set_tid))
    return PTR_ERR(set_tid);
  kargs.set_tid = set_tid;
}

Then somebody needs to free that, but this is probably not the last
clone extension that might need extra data, so one could do

s/long _do_fork/static long __do_fork/

and then create a _do_fork that always cleans up the passed-in kargs, i.e.

long _do_fork(struct kargs *args)
{
  long ret = __do_fork(args);
  kfree(args->set_tid);
  return ret;
}

Rasmus
