Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C745C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0909023711
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 03:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567220616;
	bh=jKOurtFabItaq312+1/X6LXTgKDlX67X4b/wjhPFZGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MGL9ORZhxXrS9Z7x2IoyVMQAmLGB4/dVsXfgTrvnbBzXn8i3ZtfFstXgTvHbzv8Ek
	 ePCzhnXKYE2Y2bJJHUHuy8tqfyMTGRXc6HR2JThReysKPwIUVtSTzp+ehVryy55nTu
	 c3EOxCSiUbsUf6pvU5l/4b9o2XaoJ0zYmLbOQYo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfHaDDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 23:03:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46276 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfHaDDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 23:03:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id q139so5740143pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDtpCxMA8H41bnHxRfzVl8EMeSdhCb7UOfLz/E+sRgE=;
        b=EtjuSiwU9Kd3xhWB6tgMUQG7Ifc6gOJzbMLx1Q4rD3mWlaGjghYZHqsvKAhy6l069U
         QOx4jOKaWQ/GYvhi1bq3F10IC/AScEHDC6O8e/jKRkPXpvNT3+RXwC8YpKeCdlIUYvpu
         HAFBrrJAPukRB1KpYAXMXfvrA8bxSUMtNshzVPoeEJ1t+1045MeM+YL4PUDBxSCa8k4w
         9FCnJiVmK4ukYo34m1wvIne5+OZuJuHyAB4Zt+HWrdS1TSZw8cDk8hjE10eijw7dlbt4
         tMikKTjzo4ULXeA7/58Hp0TOi6rRqBeBhXYId6z/2yqJ+STopgekYFA4WlbYSk6VUDAv
         vjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDtpCxMA8H41bnHxRfzVl8EMeSdhCb7UOfLz/E+sRgE=;
        b=o/C0HDbPK/VUyMFxjtg7v1g2jhs2vopSYcxxXxcV3qraCTrUvEJn99LI1FloNqeAWg
         l8ohMiYbejFoaJnKlnqmQfUsm7R7OVtsoC9gFvGWSPXGuQOkZN0hxYakMq6iT+mflXSS
         /Ns+uFlYsbEQybyj8aw46N/YaJQpx+QXTwpNBzNcdQB42ysAFoCLxk1oz3XWFZayvynq
         BBX/OfTZdgoBBHtXtFZXCOKGfW9j5A/nWvSCuho6xv6kZJD0ZAX+H7SVdVj+6oU7jRNM
         MVRwmjpEYzwHgtL2HrUE5VitEtUxmg9zz4D4LOqmXmW7zQ5b+d9pPWMa/NRbJ6QYoKKm
         G0KA==
X-Gm-Message-State: APjAAAUiDMv08h/aWVC0zvXzUWhAqsupMwFEdq9CR+BuG7ZzUvI0gpuH
        jxs1T7NTd+BPu8RyekS1dbGVr4FS
X-Google-Smtp-Source: APXvYqw1/5sStiRXPsN3BQ35TgV2I0WdneLDADgSOayeqOXY4H4Q4Ekc6E86zCsiIoX7oUUGs9VWug==
X-Received: by 2002:a62:174a:: with SMTP id 71mr22540174pfx.140.1567220613792;
        Fri, 30 Aug 2019 20:03:33 -0700 (PDT)
Received: from google.com ([117.111.1.180])
        by smtp.gmail.com with ESMTPSA id p1sm8583330pff.44.2019.08.30.20.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 20:03:32 -0700 (PDT)
Date:   Sat, 31 Aug 2019 12:03:26 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190831030321.GA93532@google.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Aug 28, 2019 at 07:49:11AM -0700, Tejun Heo wrote:
> On Wed, Aug 28, 2019 at 04:31:23PM +0900, Namhyung Kim wrote:
> > @@ -958,6 +958,7 @@ struct perf_sample_data {
> >  	u64				stack_user_size;
> >  
> >  	u64				phys_addr;
> > +	u64				cgroup;
> 
> Ditto, please use fhandle as the identifier.

Hmm.. it looks hard to use fhandle as the identifier since perf
sampling is done in NMI context.  AFAICS the encode_fh part seems ok
but getting dentry/inode from a kernfs_node seems not.

I assume kernfs_node_id's ino and gen are same to its inode's.  Then
we might use kernfs_node for encoding but not sure you like it ;-)

Thanks
Namhyung
