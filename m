Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF6D20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGBL6qPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCGH3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:29:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32817 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:29:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so16140715wrw.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 23:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/0q1d1YjlgG6B/Hi2ywJV0dia9haEF2gLs3zPkjPLog=;
        b=XGBL6qPTz5AEPC/X882TszeiostpZBjaKd1waEJuAJQUk53YBT3mp7tE7o0buVXaIS
         gzmJ1BARp7YUVFtjGh32BV+u3x90jYYuWRQtjhfSpVHbm5b4LpFV/tSoh3B123JwlsYW
         4wxQ1aLPny0iUoNOW7ifrzWpTKL1aCqjysmnyrYXtcJhrM3c7Xym9PMPQUOPh0lkZiA5
         vP+LK/sSwTqpXq8HM74ZIDM/tcGiXNkYk0wmlRmBgE+fue1VRG2QNi+Z1cerrEiUcRdq
         PljD8RDaxEqpiAm8ICEffKoQzEO1/tvE6uCu+Mpun++wWUtdL3RdAnUlqwaZnEIKn9ut
         qdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/0q1d1YjlgG6B/Hi2ywJV0dia9haEF2gLs3zPkjPLog=;
        b=fQJQjuPEQWg7T9TZkm7E3ZiHc97Ck/nMINvk2sQFddEo6f+E1W6Z1gZmeOH+HnY1Gl
         VCWNULVBuMbDfkfve6BUXSJLMT7EXlDcXeDGDJYeq4DE7y5B+pcaOtPgWwVtQRm/of62
         tHDc4KW9Avo7qyh/yPMs0LWohwFSvDdWPRzB+OxWLhbaT2jRe56Pfg1yZ5Iw+EC5R22e
         E6/IM+W8FPqP3XT5AbQP+G/qQc0DfQWG0J1g9Dw3+ylWOUirroPnjjNkZaTXeiFrAzF6
         ndczNp8W2+Fx8jphnn36rmHeXq6dIe+30dGOqZ43Fin6VoXFCw0scArcpHQXGusYLb1D
         JWdQ==
X-Gm-Message-State: APjAAAWzuoPZiy+QYL0zi1OYCErQHcSIDKwpPpowedkBSQ6aZYr0Avl6
        23DxyFFZn503rPx1UBVExGuesBcf
X-Google-Smtp-Source: APXvYqzW8hDPoNb8ghbVx5FHbfsHtK8WqSx0jK9HAZuqk7FaYuHyqRFIedt4w7Y+DcYjlzfNSgkVGA==
X-Received: by 2002:adf:9167:: with SMTP id j94mr6048871wrj.106.1551943739540;
        Wed, 06 Mar 2019 23:28:59 -0800 (PST)
Received: from localhost.localdomain ([151.15.252.68])
        by smtp.gmail.com with ESMTPSA id u13sm9315252wmf.3.2019.03.06.23.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 23:28:58 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:28:56 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
Cc:     quentin.perret@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        will.deacon@arm.com, catalin.marinas@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307072856.GC29753@localhost.localdomain>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/03/19 20:57, Lingutla Chandrasekhar wrote:
> If user updates any cpu's cpu_capacity, then the new value is going to
> be applied to all its online sibling cpus. But this need not to be correct
> always, as sibling cpus (in ARM, same micro architecture cpus) would have
> different cpu_capacity with different performance characteristics.
> So updating the user supplied cpu_capacity to all cpu siblings
> is not correct.
> 
> And another problem is, current code assumes that 'all cpus in a cluster
> or with same package_id (core_siblings), would have same cpu_capacity'.
> But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
> cpu topology sibling masks")', when a cpu hotplugged out, the cpu
> information gets cleared in its sibling cpus. So user supplied
> cpu_capacity would be applied to only online sibling cpus at the time.
> After that, if any cpu hot plugged in, it would have different cpu_capacity
> than its siblings, which breaks the above assumption.
> 
> So instead of mucking around the core sibling mask for user supplied
> value, use device-tree to set cpu capacity. And make the cpu_capacity
> node as read-only to know the assymetry between cpus in the system.
> 
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> ---
>  drivers/base/arch_topology.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index edfcf8d..d455897 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -7,7 +7,6 @@
>   */
>  
>  #include <linux/acpi.h>
> -#include <linux/arch_topology.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
> @@ -51,37 +50,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
>  static void update_topology_flags_workfn(struct work_struct *work);
>  static DECLARE_WORK(update_topology_flags_work, update_topology_flags_workfn);
>  
> -static ssize_t cpu_capacity_store(struct device *dev,
> -				  struct device_attribute *attr,
> -				  const char *buf,
> -				  size_t count)
> -{
> -	struct cpu *cpu = container_of(dev, struct cpu, dev);
> -	int this_cpu = cpu->dev.id;
> -	int i;
> -	unsigned long new_capacity;
> -	ssize_t ret;
> -
> -	if (!count)
> -		return 0;
> -
> -	ret = kstrtoul(buf, 0, &new_capacity);
> -	if (ret)
> -		return ret;
> -	if (new_capacity > SCHED_CAPACITY_SCALE)
> -		return -EINVAL;
> -
> -	mutex_lock(&cpu_scale_mutex);
> -	for_each_cpu(i, &cpu_topology[this_cpu].core_sibling)
> -		topology_set_cpu_scale(i, new_capacity);
> -	mutex_unlock(&cpu_scale_mutex);
> -
> -	schedule_work(&update_topology_flags_work);
> -
> -	return count;
> -}
> -
> -static DEVICE_ATTR_RW(cpu_capacity);
> +static DEVICE_ATTR_RO(cpu_capacity);

There are cases in which this needs to be RW, as recently discussed
https://lore.kernel.org/lkml/20181123135807.GA14964@e107155-lin/

IMHO, if the core_sibling assumption doesn't work in all cases, one
should be looking into fixing it, rather than making this RO.

Best,

- Juri
