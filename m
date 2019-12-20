Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A140021D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576855410;
	bh=Xngl0akcA9oyoBaD+j4NC9ZhmSFN/lCnqu5mH8MwMww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nRMsYMyyJmvKx/m/dQIgz1N2NgAdsLWf5Jb2AyTeyMT+uYS6q1ZTn0E1RGwwO2t5m
	 q38zAvW3tmmJo+88hm5AImqcivCs6vkegPmwPqqxtHTHNc1ohR46y464ImvSndJOhj
	 e5TDDgMHsah8uX2H4N6Go9u6Kl0QPgCW+vG+Jqk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLTPX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:23:29 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38500 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:23:29 -0500
Received: by mail-qv1-f68.google.com with SMTP id t6so3749339qvs.5;
        Fri, 20 Dec 2019 07:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2dn9cCazElcEyS2nqL7r4gWAf9lvaYb6Vn/YiRslYl4=;
        b=dGqWkP7rNkkQ7wUNrXT5Y+51zZH0VVkgByyhw1p3XDzd8Hm6ZI/KbJ15sYaaKz40mK
         m14HPSZLBB8qG6man7ts9USB8X02PwIELsvF+5HE7dyPBIQEYANf400GS5D45CGtOwGd
         UoUgAvbZgoFH9qNxz1fAu4gPXznAN221WPoStJYmjwGiZts7nmHEeS4QP/bfEgD3WXxI
         W0coGzcwpxRTNR5W+wa4L+N6p1VkOWbvkAG28QfMLLeqIxFKEsP6elr6fsdzJRtTLtnK
         Y0Yv9GoWMDoQ5a2sEI99k0ieykriHKFoOw1e0zMDDEd5yHCZgMD0jZzoP+5USz+bgVgm
         uc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2dn9cCazElcEyS2nqL7r4gWAf9lvaYb6Vn/YiRslYl4=;
        b=s8Nvstzdyxh1Gf1YqUtPWUHIe1z+fTMnvr7S0cGW+ndzuybLHSWqttGwyfPqO50YdM
         bEapaEUXRIJ9CDR/KfvPbTy+9nthgJIBA1FvFWBovbs+UWL0qwr6cxWIkAEqZ+YYJrVK
         15oubOVFoPcQRjbbTpAhHhkg0uWCuZkT7LwWwNZoJELxjmwhK5L7cJq8LAWq0aVdMCLY
         5UrTxHknoVALpcw6bIxOMb/eybPK8v3khw0dvzXsVdaQdkc8IWLqwV7eaqNFwr4xnfw0
         fiPoqXWINfCInPttoXOJARDPwUGRvNI32pXKGWYQcZlwT1+CK5UePyqmIeWaALlEEryi
         EB3A==
X-Gm-Message-State: APjAAAWVgTILhUKsjGCDT/87bafybIxFlIf1vuyt18kinLwqWocPlPjO
        0Hc0ko9A9ejfN+G30p/6EYo=
X-Google-Smtp-Source: APXvYqzDPIlFhFSz/g8F5LJ6vpVFsAu6aHjc9thDeArzy5CSpzV1/fm1bZ/GTXvelMJtI2ygX+dpKw==
X-Received: by 2002:a0c:aa8a:: with SMTP id f10mr13041213qvb.200.1576855408130;
        Fri, 20 Dec 2019 07:23:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::11e7])
        by smtp.gmail.com with ESMTPSA id n19sm2941698qkn.52.2019.12.20.07.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 07:23:27 -0800 (PST)
Date:   Fri, 20 Dec 2019 07:23:24 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220043253.3278951-3-namhyung@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:32:46PM +0900, Namhyung Kim wrote:
> The PERF_SAMPLE_CGROUP bit is to save (perf_event) cgroup information
> in the sample.  It will add a 64-bit id to identify current cgroup and
> it's the file handle in the cgroup file system.  Userspace should use
> this information with PERF_RECORD_CGROUP event to match which cgroup
> it belongs.

You don't need PERF_RECORD_CGROUP for that.  Something like the
following should work.

	struct {
		struct file_handle fh;
		char stor[MAX_HANDLE_SZ];
	} fh_store;
	struct file_handle *fh = &fh_store;

	fh->handle_type = 0xfe; // FILEID_KERNFS
	fh->handle_bytes = sizeof(u64);
	*(u64 *)fh->f_handle = cgrp_id;

	mnt_fd = open('/sys/fs/cgroup', O_RDONLY);
	fd = open_by_handle_at(mnt_fd, fh, O_RDONLY);

	snprintf(proc_path, PATH_MAX, "/proc/self/fd/%d", fd);
	readlink(proc_path, cgrp_path, PATH_MAX);

-- 
tejun
