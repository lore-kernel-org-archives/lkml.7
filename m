Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F6C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A475220869
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 02:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p0VMc7Gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3CHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 21:07:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45201 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfK3CHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 21:07:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so15296909pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QudVKO8PpHDY0QPRDjrLS+45fBA9fe2WvpbxZI2jQhM=;
        b=p0VMc7GvAyQocYJ21HkYujY5ESSrqjlbOvCYQJANZQ82Vq/rwhHtcaq7g3t4V7tmqK
         ltDD0ctybM+2zQKe7/dFqP9e6RASHLFtLM7gpg6IAWJ/50jZyvd0H/gGSzNDfN7dpskp
         zFlfTf9BfAOjK+sXLw16ZTlBuoqATSAkV8gV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QudVKO8PpHDY0QPRDjrLS+45fBA9fe2WvpbxZI2jQhM=;
        b=UqHI09ZFjCCKBo6zNRY+nu99LlDaT6axQoOuD6Fadsk/w5SoH/qdVYEZ64+oUN65FH
         DwIFjOpsGwP/3Y6L6xoVZ1r2wpw0aDjrTNQG3b1gTjuqUa4saNkFnOi67m99KDoYE5wQ
         FZidvZAUP6he9Krzo2AVAUGBQ9Gq0b+wwn4Bfsz4s/8aXhVci+kcx0UR6nRx0lHRz0yV
         YXtdtfJK+cXC0Tw93Msjd9jVLYquQjvPEhdwMPvqBo00IKBHX7MA4mVfM8vePaO1emt1
         QtKql3OtYkLzWiR6nqnlI1GCRnJLWYHWvNV5P7b/dJI2cLhtH4XClZr/EtnRt2CGEQ7k
         D5zw==
X-Gm-Message-State: APjAAAUXfOhQdXUGMAsgkGu9WajlrSt7cv1JC2IOxtUQkfgpHsCNz6mc
        PajKEqKpx5/PIu5e0x/KXQIgAA==
X-Google-Smtp-Source: APXvYqxvrL7gQ4UHvGl0OH80nFnpTXbY9LyocxTQJ8pHkSe9LnSm6z/+3DuUedz0z8nb/MsLQYnEYQ==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr59616561pfo.60.1575079664078;
        Fri, 29 Nov 2019 18:07:44 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s22sm15478745pjr.5.2019.11.29.18.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 18:07:43 -0800 (PST)
Date:   Fri, 29 Nov 2019 21:07:42 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191130020742.GF157739@google.com>
References: <20191128153203.GA23803@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128153203.GA23803@workstation-kernel-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> add __rcu notation to RCU protected global pointer auditd_conn

Again, please use proper punctuation and captilization. This is unacceptable.
Please put more effort into changelog.

Otherwise the patch diff itself looks good to me, with the above nit
corrected, you could add my tag to the next revision:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Fixes multiple instances of sparse error:
> error: incompatible types in comparison expression
> (different address spaces)
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
> v2:
> - fix erroneous RCU pointer initialization
> 
>  kernel/audit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index da8dc0db5bd3..ff7cfc61f53d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -102,12 +102,13 @@ struct audit_net {
>   * This struct is RCU protected; you must either hold the RCU lock for reading
>   * or the associated spinlock for writing.
>   */
> -static struct auditd_connection {
> +struct auditd_connection {
>  	struct pid *pid;
>  	u32 portid;
>  	struct net *net;
>  	struct rcu_head rcu;
> -} *auditd_conn = NULL;
> +};
> +static struct auditd_connection __rcu *auditd_conn;
>  static DEFINE_SPINLOCK(auditd_conn_lock);
>  
>  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> -- 
> 2.24.0
> 
