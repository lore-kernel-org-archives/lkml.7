Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278F2C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF4C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="r54oOfo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfGJSVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:21:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43088 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfGJSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:21:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so1613737plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fnGBpm29e8ih0nVcemzSumdnrI3YNjI1abxR9imHsCE=;
        b=r54oOfo9tCGgPU7nLvxeuwlcmdrm1W6iXQBTBZuQX3uMd5MEButIOxEC8ZsooBrS22
         XDo3wfladVbiIrIEHAd1Nm+DPdJFk/HTfy0vfc7vqlOmJoQWsAtsV9lgjDhoLXS7165x
         sya+OrBKZmq7S45Xj2EiJugybWH3jnJvSJsVvyUDD6HskfqZNxn78dEhQd3q/VfgptTd
         kNFdqMeSAXscKx3XhFpoKqqrx9qoo/xTN+hEJ+//orXsW7lcODdi6oOkp/sMhNJ7f3DN
         hdJ6f1X/S+eu/F9g8mTz3eA1OsGy9CUSqKRZWYDHeSs+cXWv8sadpOreFTMS07aDYZND
         7Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnGBpm29e8ih0nVcemzSumdnrI3YNjI1abxR9imHsCE=;
        b=gVIUtCFvLxT4W2j88H1Hp9Dqppsm1pBWw5fcZH5WeXPUTzmKr5MCV8asEF4K+NoATw
         68bx13i+wJYJ2ApZaNm1m9a0W58vPCs25C7wp+z+JPVQPdYUk2+G1xbiTyCCUW/d+qhn
         ZEHMeDi/X2RjEQioL2ofXImAWnWVWn6/99dGREIKbbHxUYJmURHiMrBCjmWeFNLoE2FM
         fvsgrn3EDVubZPTVkA3OBKwPJELSZaSIn3MTX4o0VzZXTvfGJjRHXnoNEsOnlpxdjYES
         VgfMBPcudMiI99TbfQfVEPS0iYhXfte/O6NVuM/oaT8Dib+cSlpFfMMi49Ln0m0EN3vL
         iyFQ==
X-Gm-Message-State: APjAAAV6roNrTQjQmdIZ4wvMb21+80KpYjsd1ChLqInPumTFsuQwAm1Q
        MxVqqdfh4cFaBCQmx0G1Vp25hg==
X-Google-Smtp-Source: APXvYqxB3CQ6to2JGHiSbwc0t9tlBi+Ho6PWoIO2Ce1gSNPx5pyEn4b7NBFexyxmsIzvyOnXSOYzfQ==
X-Received: by 2002:a17:902:b20c:: with SMTP id t12mr40667176plr.285.1562782866693;
        Wed, 10 Jul 2019 11:21:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id i15sm2855950pfd.160.2019.07.10.11.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 11:21:05 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:21:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 4/6] khugepaged: rename collapse_shmem() and
 khugepaged_scan_shmem()
Message-ID: <20190710182104.GE11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-5-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-5-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:44PM -0700, Song Liu wrote:
> Next patch will add khugepaged support of non-shmem files. This patch
> renames these two functions to reflect the new functionality:
> 
>     collapse_shmem()        =>  collapse_file()
>     khugepaged_scan_shmem() =>  khugepaged_scan_file()
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
