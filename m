Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8A621721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvu46bxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfJ1TMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:12:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34293 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfJ1TMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:12:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so7557516pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIxcK82zdAikV69eNIaKCwJswys26I7OsAOmW8C2I7k=;
        b=pvu46bxePRBWKMscgR+TXKOrL+RNRcdIYbHu338UTkaSxnWT1KhCEH9YlKgSdd9ct2
         7BBlDEZA4/rcG0ozH9y+/CkWzOzp1U7GeIovEj8OPm8ypzVxJ35FrwpCbTVuHWwvmpm0
         kylQAmnD1Hv0jjlHCApBPwlMUxpc//s3hQT5f7/9fRGcsKOkhX0lW/EWZr3MgaeHOS1I
         3w72sfaD/PzhX+RNnw+UGtYbSrUHpnJ0jkqS/y9hmbWjuzF//fP5OqaWkE0lddtt9slb
         F7FBsUMP9quDvf5V6x4FEpuv1nlGLcYtyE8vq3AvtvsyiHT0FblF5sKhgClA73KjJKTB
         XdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIxcK82zdAikV69eNIaKCwJswys26I7OsAOmW8C2I7k=;
        b=CaP3etNRN3yV8v8VvwHkJ1mZyYhLkUMFnlE1RMJvej9ahLsD8zQ0M7jJDYyLj7Akgp
         x1cnV9axholZLRHleSH21rPf73q/4cpbO+rgqKL+j8vBdtxdofWt/+0CXSnT0/Vv97pG
         Gjz3Zarm/wZYt8uNtcTvT/EE/w7SMpV0dlDqOMFJ4fzerJGKAMZ/9k2jdyV92UoILJRJ
         Vcgk/6NM6Dqv68L0pRWekogOPQKhFnlwlIHGm4ZAouJeY9vNI5iAL7SQ8wUu1CvkrG6V
         Ooi5DLk6fIN0w65Fmw5c3ehrMB77FkbqSObdvySJdQtTRG7Wn43oMpQPIhCjGLK3aD/t
         WSEA==
X-Gm-Message-State: APjAAAXidnlNGWpBRVQflJ3H1ZrQM8hxEHOAeDRxGHMrEGuALwtDVEKM
        qjn5FnpEuI55OFgdcfPXJL2IRA==
X-Google-Smtp-Source: APXvYqzVIzRMuXvGysC3IR33nCYyBavYeEFxzf3lEbKKPuAQooHMm3yGTj4dtOMZHm4G64Bu5Zk5Ow==
X-Received: by 2002:aa7:8a97:: with SMTP id a23mr22285150pfc.76.1572289953410;
        Mon, 28 Oct 2019 12:12:33 -0700 (PDT)
Received: from sspatil-workstation.mtv.corp.google.com ([2620:15c:211:0:fb21:5c58:d6bc:4bef])
        by smtp.gmail.com with ESMTPSA id 21sm3911485pfa.170.2019.10.28.12.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:12:32 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:12:31 -0700
From:   sspatil@google.com
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        labbott@redhat.com, benjamin.gaignard@linaro.org,
        sumit.semwal@linaro.org, lmark@codeaurora.org,
        pratikp@codeaurora.org, Brian.Starkey@arm.com, afd@ti.com,
        akpm@linux-foundation.org, huyue2@yulong.com, rppt@linux.ibm.com,
        fengc@google.com, astrachan@google.com, hridya@google.com,
        dri-devel@lists.freedesktop.org
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 1/2] mm: cma: Export cma symbols for cma heap as a
 module
Message-ID: <20191028191231.GJ125958@google.com>
References: <20191025234834.28214-1-john.stultz@linaro.org>
 <20191025234834.28214-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025234834.28214-2-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:48:33PM +0000, John Stultz wrote:
> From: Sandeep Patil <sspatil@google.com>
> 
> Export cma_get_name, cma_alloc, cma_release, cma_for_each_area
> and dma_contiguous_default_area so that we can use these from
> the dmabuf cma heap when it is built as module.
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yue Hu <huyue2@yulong.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> [jstultz: Rewrote commit message, added
>  dma_contiguous_default_area to the set of exported symbols]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  kernel/dma/contiguous.c | 1 +
>  mm/cma.c                | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 69cfb4345388..ff6cba63ea6f 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -31,6 +31,7 @@
>  #endif
>  
>  struct cma *dma_contiguous_default_area;
> +EXPORT_SYMBOL(dma_contiguous_default_area);

I didn't need to do this for the (out-of-tree) ion cma heap [1].
Any reason why you had to?

Other than that, thanks for doing this John.

Acked-by: Sandeep Patil <sspatil@google.com>

- ssp

1] https://android-review.googlesource.com/c/kernel/common/+/1121591
