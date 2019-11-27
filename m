Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32BFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9178A2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 02:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YdGbiaMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0C32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:29:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfK0C32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 21:29:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so10168575pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 18:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NN2NK4AVnHEIbvB9lst01l+3zKuPHZoMQF6S334Sv9g=;
        b=YdGbiaMu/yoWaKdN4xLKKLWNKdEv4Ec2V5T+CBLpDakJdirXjnihGmEMfcfVHpU03y
         hbXNsp0s0xpC1m/qkIcZTQkwcSjocPq/hPYojNUH6Mc2LdAwueyJa25wJLmbLDyhQ7n3
         TICUTAr5viybVXfMWtNdFutu6P0ZtFSnMmR1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NN2NK4AVnHEIbvB9lst01l+3zKuPHZoMQF6S334Sv9g=;
        b=bLD0mEYpodFgfFE5jb8VXqjUlGKgEU+q6l4Xvlb+VxzkLZqlEKU6Z7Ux+UThSUA2ty
         O1L0BKeuZ1DgsNJeQc6mf9jIleVcKaxSIWDwX5d7vrjGKh/HIqTp4t+zSqMM+hYubPpA
         dgwD6XOe2gRg9qdlMohQsvNNTxdwxx53gcJuMFiHrm4t57RdcWXiB6EAkj6TUaA8QP5Z
         vgjYri28BqR/1fh0ejy9ykdQnMEpgtlaucqBnAhroPhYVo5ox9+ZzR7SdQ90P5XVwLKb
         5j4ngziViDjam/2VCzbU+PBxaDSQqeEeJXWMsl2W1RA0P7A2DkY8jCA+DZXHf5jWli4c
         XX0Q==
X-Gm-Message-State: APjAAAWu2TLjVOtu8Fxzd1ohVjWB0GclogeDcRDb8btaTr92uS9UGl5B
        wkOTmj9GsTQJRqtS8VPM8UXg7w==
X-Google-Smtp-Source: APXvYqx+HX61yjud9fIbZqiRcxDpx9y0e6bR1uba8VJ+HnNyYomcwswg1BHVEDSvG74B2G9ilx7NIQ==
X-Received: by 2002:a63:770c:: with SMTP id s12mr2129673pgc.25.1574821767441;
        Tue, 26 Nov 2019 18:29:27 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u7sm4370989pjx.19.2019.11.26.18.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:29:26 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:29:25 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20191127022925.GB157739@google.com>
References: <20191126172723.GA12759@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126172723.GA12759@workstation-kernel-dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:57:23PM +0530, Amol Grover wrote:
> add __rcu notation to RCU protected global pointer auditd_conn
> 
> Fixes multiple instances of sparse error:
> error: incompatible types in comparison expression
> (different address spaces)
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> ---
>  kernel/audit.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index da8dc0db5bd3..30e7fc9b8da2 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -102,12 +102,14 @@ struct audit_net {
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
> +RCU_INIT_POINTER(auditd_conn);

Looks like this causes a build error. Always please build test your patches
in the very least. And I also did not understand how RCU_INIT_POINTER can
even be used outside of a function. In C, executable code cannot be outside
functions.

Is doing the following not sufficient to fix the sparse issue?

thanks,

 - Joel

---8<-----------------------

diff --git a/kernel/audit.c b/kernel/audit.c
index 49b6049b26ac..c5d4b5a2dea1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -108,8 +108,8 @@ struct auditd_connection {
 	struct net *net;
 	struct rcu_head rcu;
 };
-static struct auditd_connection __rcu *auditd_conn;
-RCU_INIT_POINTER(auditd_conn);
+static struct auditd_connection __rcu *auditd_conn = NULL;
+
 static DEFINE_SPINLOCK(auditd_conn_lock);
 
 /* If audit_rate_limit is non-zero, limit the rate of sending audit records
