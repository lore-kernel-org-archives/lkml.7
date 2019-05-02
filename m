Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CEC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFE920651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfJa+OfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEBVJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:09:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40762 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:09:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id d15so3513047ljc.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fQeF4YFfp+NAQvbsEuYp4YnBN8ZOfcDR5taD1BAPMsw=;
        b=BfJa+OfFnBf4up8Si8/XdPDnmJV270NIwn9A1p2Aazn7CLm4/wAGLVar908BlZlkyc
         HvfY6SgZ5nVLBpLLQV2L5azfC1ULRJzbuT8p00iLq+SXsmBnD9SfwO+3V89vOHtSvvz8
         DFM5i15S/dWmqpllfl75ttnYdW3RCjAGjhqwFB18d/61bKztGvfahSne/0eJWFeH+SVD
         T9AxRKyA7CvRbgMSV+1Y3PF86jnTocDoh1OxjlBz40ApZk1ry2pnwKLQKOOeGcLzko2K
         1hFpWIVTQ7dMGuaF0WCFcLm9tYGjlRVjyFL2n0FtZItXA8h+6PaGe5sHiGtuvSmUrgLx
         qxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQeF4YFfp+NAQvbsEuYp4YnBN8ZOfcDR5taD1BAPMsw=;
        b=RmC8lH2bS7FKQ/Wxx5u8nUOhFKMQbr3vq/3ZplWzEL+CcBZ81SWbwpAMLqoTKzn2c+
         vKIjSACIeT7UClnM7jpxVDvJaqePz9DHCj9Yvfk3g3rLCMxoHkth3aflo9egR2UTn7LS
         Q2wRq7wkD2OpqqE6SqIVeTppFVb5wpMPcPAlP5B2h0XwgnONB96Pafm0ZgnEPxG8K+iH
         Wx8T8U2Mj+pHl6ykXG4vo+Ff06KSVuUy7WERXVvYIO+Y7QLMvuBcOHrMBXDMIeZs3ckg
         8cWBCJQyb+dpWyapq+PwvwgSqzeerVYveghRQcpSVhwKzC7BmGUM/cnIB0JLOCk9xcPO
         lPHw==
X-Gm-Message-State: APjAAAVYVNRTE4bJHnTwP5sK1910N76PGSxZmDc3YihLgOBxuPdc1rGL
        9iUQ6KAQpQgoxqYsPDkoSpM=
X-Google-Smtp-Source: APXvYqxg3PTj3sExzYgbIYqhkIni3B/qRouQZ8IyGUuVXH9RccDL6fqAl9aV/YlbCcJOzlVCT8Akfg==
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr3116056ljd.35.1556831363181;
        Thu, 02 May 2019 14:09:23 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id b28sm38600lfc.7.2019.05.02.14.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 14:09:22 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 248204603CA; Fri,  3 May 2019 00:09:22 +0300 (MSK)
Date:   Fri, 3 May 2019 00:09:22 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <norov.maillist@gmail.com>
Subject: Re: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to
 prctl(2)
Message-ID: <20190502210922.GF2488@uranus.lan>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556830342-32307-2-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:52:21PM -0400, Joel Savitz wrote:
>  
> +static int prctl_get_tasksize(void __user * uaddr)
> +{
> +	unsigned long task_size = TASK_SIZE;
> +	return copy_to_user(uaddr, &task_size, sizeof(unsigned long))
> +			? -EFAULT : 0;
> +}

Won't be possible to use put_user here? Something like

static int prctl_get_tasksize(unsigned long __user *uaddr)
{
	return put_user(TASK_SIZE, uaddr) ? -EFAULT : 0;
}
