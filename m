Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715BC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846E220865
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdFpKtal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436759AbfIWKFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:05:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40309 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406837AbfIWKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:05:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so7745197pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GN9uWlPH+mRUOKL6lisCqKrCCm1x4VV54XbjaAcOsJ0=;
        b=AdFpKtale+UdPAqRVVH0fkEU9i6SHcwJqBcZYBseNzuhLNt/NGzkC55oi6FdJOLoxV
         G8gYDbiJ/ypG3KYfe05iuGw4zN20zFWoKRZnpto7CEvt/noqO370oRIwYRXwKURk/CKv
         aPxVdXi2O/j6jwwc5X4Ew8Gfk5+NLYhkyuDnKWYDyhTfcWvaB9k12IzYX8tShQLmD4sx
         L83adHOpCCNixrrUI4IWEbL7G7ZZjS+VaFaWfTydnm5enr2oD7BD9y+G9uC1pbaVYsXz
         a0NfzT0rvg6uVMn0JLO69l0lTCNBkBwR4VeMNnneXHNUlLUeOLdmRB3a8URubE4GBMdR
         TByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GN9uWlPH+mRUOKL6lisCqKrCCm1x4VV54XbjaAcOsJ0=;
        b=ZsylborIandRlIRWL42AgUvDaLZNXElDOvNlddTLOsB1KeNXeNZXUz1hHFnPgJhv/+
         CvhGi+IF2twcJxJzKTXheqJby7ai/K9h3STqXKywUZWl131HGLsfAT8/CAdz8g5xIDnz
         rF8MbBbS7IrzB96h50KV7HUpVbyYCbM91zhlU6xqgxrZV6+uFhaChtYPfeCmaBb3MULD
         KOujZrILN8iBA2r11dm05pOIhyZW1FAtqJUYnfc+YiKtvrxwiDLNOT87Mn5Hq6DSVkgY
         Hku7t2pjVGh217PgOYZaXWPFavt1ituGNQvjZkslC2GTD6KR5LbtKd08kMBhn/bTSWsC
         Ckzw==
X-Gm-Message-State: APjAAAUoxhbac7YXTUDzJLGLku+x7t8ssJXABwea89QcLh35ZerInbF+
        sBAloCr6WukxCjXT+Zm61kBpV/Wx
X-Google-Smtp-Source: APXvYqymz9dteM+jXvuRx1ZHLlJbP4zvdHYa0ZZN0LO8z3y9tkVXTV3Vwftor/JPVb1+/OrL/pdRNQ==
X-Received: by 2002:a63:c851:: with SMTP id l17mr4954033pgi.6.1569233117617;
        Mon, 23 Sep 2019 03:05:17 -0700 (PDT)
Received: from localhost ([110.70.15.104])
        by smtp.gmail.com with ESMTPSA id a13sm12231312pfg.10.2019.09.23.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:05:16 -0700 (PDT)
Date:   Mon, 23 Sep 2019 19:05:13 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Fix unnecessary returning broken pipe error from
 devkmsg_read
Message-ID: <20190923100513.GA51932@jagdpanzerIV>
References: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568813503-420025-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 21:31), zhe.he@windriver.com wrote:
> 
> When users read the buffer from start, there is no need to return -EPIPE
> since the possible overflows will not affect the output.
>
[..]
> -	if (user->seq < log_first_seq) {
> +	if (user->seq == 0) {
> +		user->seq = log_first_seq;
> +	} else if (user->seq < log_first_seq) {
>  		/* our last seen message is gone, return error and reset */
>  		user->idx = log_first_idx;
>  		user->seq = log_first_seq;

A tough call.

User-space wants to read messages which are gone: log_first_seq > user->seq.

I think returning EPIPE is sort of appropriate; user-space, possibly,
can printf(stderr, "Some /dev/kmsg messages are gone\n"); or something
like that.

	-ss
