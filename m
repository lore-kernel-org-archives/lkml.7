Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7507208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557817781;
	bh=ITRl29uk1B/UaKiilPt5FS1F0G2ftFSNtxGTuE614Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1bxuedth/AIn6Cwu2iRJMHq14KpRI9mScTsOSJbmTMMqDmNKtjU2bphIZ111FEDAj
	 Td/arxhA1HsB6n9AT144FGI2QFjWqnZmGs61p5ZJ22S1HuPAcTq2Gz7czRwyrNU3//
	 C1wzUNVOnGNgBW503rlzJ3iZQ9VC7HdaX5s4kihk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfENHJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:09:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:09:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id d12so17828880wrm.8;
        Tue, 14 May 2019 00:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdlc9MTtwlwuiFWHHDc7Cbg8Rd7zeI6w6ebTpyjJjb4=;
        b=eqQ6JOUcpdrU3mHf/8l4OwyMi1FRiJ1u2jCZkCh3t48j+tb6i+oCFePpPC69p6n7XL
         wcEDoD5pQH30xxN908M9mUcba4IraYCzTxqqDCicLQJ1edxIpUAhP1jH4fcEMSiKAHz0
         9rkAap4vd+LuLCo2ES1z7yMH0/bxKI3x91rHWO9iDPFKC8WyTuzUF4RTrSGaTd4gffND
         eAvgzzZ/owqTGvE1af+wX3GUhfr1G44VFOu4Q60whhEEpt8DhPs76cXsC/ELC3AKVb7a
         gS9KMsiIxDeI32KcV0SjVe3TgX/JQYB0Jhz4JEXKhJB6F/AA+nf0cTunAc/AWDT2qwjx
         CgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdlc9MTtwlwuiFWHHDc7Cbg8Rd7zeI6w6ebTpyjJjb4=;
        b=gihP3lF+sk+l8xE79ROUm54/MWpm7rexQERuop8Qh07ikkDzps1MWgNMWxhRigq0Z5
         WMwonman1r9PX4hTkLpurpSkmVi45qA4N7pKK42RkGCSpVEXB6PrwB8KCJuA10H68XKT
         oo3tf6XmTXCcBr+3g7ISFAxiBSGcHNHWQnK4Jj+XuDS6hI6BX41tPcCAbHlDGk0xGSLf
         ScuAK6TgCeEmZdjFqcc1j8DnWdOqDMIA4lSgWG2zlVTZe7fsIbP7smP9vHMszJv3pRfp
         f1C6+cIYmmcZgMcp5OKzgFcIboATrph1RM3hX4gyTz5MxGBD/1ZHIoqf1/NLwtAc76li
         0Nrg==
X-Gm-Message-State: APjAAAVcltVxzKYsCYnzl4R7O3eo0z3VGmYrYZmKw7BzohEO99CDrX/D
        AyIsSrNQshCuQ6VrMkj95EE=
X-Google-Smtp-Source: APXvYqya4yupYUE/EnzUln2j44s3nkubt/Rim3Kv0GGeWTlPYqe/xVCiF+faibvPCyUipklXseWWDA==
X-Received: by 2002:adf:f4c5:: with SMTP id h5mr3544560wrp.268.1557817778433;
        Tue, 14 May 2019 00:09:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a10sm8539844wrm.94.2019.05.14.00.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 00:09:37 -0700 (PDT)
Date:   Tue, 14 May 2019 09:09:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        srinivas.eeda@oracle.com
Subject: Re: [PATCH v2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
Message-ID: <20190514070935.GA18949@gmail.com>
References: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> The default behavior of hardlockup depends on the config of
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
> 
> Fix the description of nmi_watchdog to make it clear.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  v2: fix description using words suggested by Steven Rostedt
> 
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 08df588..b9d4358 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2805,8 +2805,9 @@
>  			0 - turn hardlockup detector in nmi_watchdog off
>  			1 - turn hardlockup detector in nmi_watchdog on
>  			When panic is specified, panic when an NMI watchdog
> -			timeout occurs (or 'nopanic' to override the opposite
> -			default). To disable both hard and soft lockup detectors,
> +			timeout occurs (or 'nopanic' to not panic on an NMI
> +			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
> +			To disable both hard and soft lockup detectors,
>  			please see 'nowatchdog'.
>  			This is useful when you use a panic=... timeout and
>  			need the box quickly up again.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
