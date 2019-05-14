Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3B6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1662147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfENNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:22:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:22:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so2878714wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30MZy6w8/UHFwckByseMshUTKJ0XAaQAYBwkRUyEATg=;
        b=OAbHBD6oSpON8YAunry6q0BMtvIM3sKt8MU91M7yt5nExRepww52P3VqLplvn9V4UM
         BewP07unongasMNJdT4ejFmT7LxGdcbRSG32qqODUHRwYdY8hvM7vrgGvJvQAyGvQCHj
         d4JK/81DmzmmuqfCjcKcN4CHM5ta7MFgfxpx8sPAIqrq2Mnrf+WJWf3qChBTBpT6rT2q
         x4yBELKkKLWk/pzAguRGr7ASPgkLzRroYg8j0ksGwWRBlBISRll7XPiB/4fe2skE5QQc
         5oe1uyRbZXLA6XBCWjohNBV9RTzD/MBtuOVgi9HnTn6BjNsQjWjAciA1DXsm2MUI4rDF
         Mfsg==
X-Gm-Message-State: APjAAAX3rywUvPrDX+twFq/XfPE3rEX5LxYQRZJaG78A/D7TdK8ri1ka
        4fXpcvpdnv8fsnrcmyTyEFg+
X-Google-Smtp-Source: APXvYqwC3BFcZP2L4DGiVRCHRXmxW9RKCIZlsYi2qXCsH8aM1VNcEqntfDgjJ/dMsnZG1ORhmCvuTA==
X-Received: by 2002:a1c:a7cc:: with SMTP id q195mr11561566wme.53.1557840170835;
        Tue, 14 May 2019 06:22:50 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id k30sm4597150wrd.0.2019.05.14.06.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 06:22:50 -0700 (PDT)
Date:   Tue, 14 May 2019 14:22:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC v2 3/4] mm/ksm: introduce force_madvise knob
Message-ID: <20190514132249.h233crdsz3b7akys@atomlin.usersys.com>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514131654.25463-4-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514131654.25463-4-oleksandr@redhat.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-05-14 15:16 +0200, Oleksandr Natalenko wrote:
> Present a new sysfs knob to mark task's anonymous memory as mergeable.
> 
> To force merging task's VMAs, its PID is echoed in a write-only file:
> 
>    # echo PID > /sys/kernel/mm/ksm/force_madvise
> 
> Force unmerging is done similarly, but with "minus" sign:
> 
>    # echo -PID > /sys/kernel/mm/ksm/force_madvise
> 
> "0" or "-0" can be used to control the current task.
> 
> To achieve this, previously introduced ksm_enter()/ksm_leave() helpers
> are used in the "store" handler.
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> ---
>  mm/ksm.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index e9f3901168bb..22c59fb03d3a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2879,10 +2879,77 @@ static void wait_while_offlining(void)
>  
>  #define KSM_ATTR_RO(_name) \
>  	static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
> +#define KSM_ATTR_WO(_name) \
> +	static struct kobj_attribute _name##_attr = __ATTR_WO(_name)
>  #define KSM_ATTR(_name) \
>  	static struct kobj_attribute _name##_attr = \
>  		__ATTR(_name, 0644, _name##_show, _name##_store)
>  
> +static ssize_t force_madvise_store(struct kobject *kobj,
> +				     struct kobj_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	int err;
> +	pid_t pid;
> +	bool merge = true;
> +	struct task_struct *tsk;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +
> +	err = kstrtoint(buf, 10, &pid);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (pid < 0) {
> +		pid = abs(pid);
> +		merge = false;
> +	}
> +
> +	if (!pid && *buf == '-')
> +		merge = false;
> +
> +	rcu_read_lock();
> +	if (pid) {
> +		tsk = find_task_by_vpid(pid);
> +		if (!tsk) {
> +			err = -ESRCH;
> +			rcu_read_unlock();
> +			goto out;
> +		}
> +	} else {
> +		tsk = current;
> +	}
> +
> +	tsk = tsk->group_leader;
> +
> +	get_task_struct(tsk);
> +	rcu_read_unlock();
> +
> +	mm = get_task_mm(tsk);
> +	if (!mm) {
> +		err = -EINVAL;
> +		goto out_put_task_struct;
> +	}
> +	down_write(&mm->mmap_sem);
> +	vma = mm->mmap;
> +	while (vma) {
> +		if (merge)
> +			ksm_enter(vma->vm_mm, vma, &vma->vm_flags);
> +		else
> +			ksm_leave(vma, vma->vm_start, vma->vm_end, &vma->vm_flags);
> +		vma = vma->vm_next;
> +	}
> +	up_write(&mm->mmap_sem);
> +	mmput(mm);
> +
> +out_put_task_struct:
> +	put_task_struct(tsk);
> +
> +out:
> +	return err ? err : count;
> +}
> +KSM_ATTR_WO(force_madvise);
> +
>  static ssize_t sleep_millisecs_show(struct kobject *kobj,
>  				    struct kobj_attribute *attr, char *buf)
>  {
> @@ -3185,6 +3252,7 @@ static ssize_t full_scans_show(struct kobject *kobj,
>  KSM_ATTR_RO(full_scans);
>  
>  static struct attribute *ksm_attrs[] = {
> +	&force_madvise_attr.attr,
>  	&sleep_millisecs_attr.attr,
>  	&pages_to_scan_attr.attr,
>  	&run_attr.attr,

Looks fine to me.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
