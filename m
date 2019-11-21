Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AFC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6CC206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574359446;
	bh=1jgzamKxvcY1tfDe6mbz/HAF10TIHWqDUszuqFoLJXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L4d628yUfcEMpzD5BDDC6xddEemo6euvIBmq7wCeV5rZTMUEy0GZ9MFHiV6sYVtf+
	 Zyv4pJmNEg7A+jodiAfhbhhn8so5rzF5RbQe8Ti4IpfphP4LsPiIaq/fi9CyShNqEn
	 XCin52apHX2kQ8ck5L3aMd6CCX95uhgEmOIA6SmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKUSEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:04:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKUSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:04:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so5554169wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMS8WThQLgXSYyBxSADTHOAcqudcuVlRYct6kXLQmYg=;
        b=uJnZ/emTRW6j6tjuZ5oDn05X+dEO/fH3XbtAgolT+0BJnCymBREzjd0kn+0xKE1UsV
         YpdapDesOJOqfmfJqmY6EJhww4CIQmGcZcTqu/CT2jbbVQjx/3MbstTLl665ajC+RehW
         gB6HAdAQsME/Z0ylMJaKWq8dy04hHYiQ1d8e8Yn4+4Yrcv4rmgMNiuCdQ4Zps5f0OQDQ
         qETynPMk4wEZAVwt2yvu++r+wzrp+Vc5t8mHG0JYyRM6WMN+hkGX0nUdGICdSlYjY8F0
         jv2UEQeNCQoe5Cy3/j+svpJ7erIGqblAO4IOLUGXLi9u6NkR7ENUU1S2eyKU4NjCVKf2
         Veaw==
X-Gm-Message-State: APjAAAXyCB0Rz3EVj5OWAj9YUViqh1V1lawMqF1ivSP7SpSB4kogxFmq
        8uortV+Fssv4JzzOfYVJR7Q=
X-Google-Smtp-Source: APXvYqyu+Eq7u50JFAbXTk9DnsWsPzHOCn7SZlNlBn2hxw+SJW8ZwTVVzQDhHlOIKA/BwIJSnyuEwg==
X-Received: by 2002:a5d:4991:: with SMTP id r17mr12620993wrq.176.1574359443578;
        Thu, 21 Nov 2019 10:04:03 -0800 (PST)
Received: from localhost (ip-37-188-163-220.eurotel.cz. [37.188.163.220])
        by smtp.gmail.com with ESMTPSA id u18sm4201832wrp.14.2019.11.21.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:04:02 -0800 (PST)
Date:   Thu, 21 Nov 2019 19:04:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <fly@kernel.page>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 00/19] Modify zonelist to nodelist v1
Message-ID: <20191121180401.GL23213@dhcp22.suse.cz>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-11-19 23:17:52, Pengfei Li wrote:
[...]
> Since I don't currently have multiple node NUMA systems, I would be
> grateful if anyone would like to test this series of patches.

I didn't really get to think about the actual patchset. From a very
quick glance I am wondering whether we need to optimize as there are
usually only small amount of numa nodes. But I am quite busy so I cannot
really do any claims.

Anyway, you can test this even without NUMA HW. Have a look at numa=fake
option (numa_emu_cmdline). Or you can use kvm/qemu which provides easy
ways to setup a NUMA capable virtual machine.
-- 
Michal Hocko
SUSE Labs
