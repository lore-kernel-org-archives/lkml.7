Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D51C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC93020840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="LCTOpdFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCGWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:11:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44061 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfCGWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:11:29 -0500
Received: by mail-yw1-f65.google.com with SMTP id x21so14687883ywx.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FHC23kKOOD8L5WKDG46G396bmkMA7Azge/SSFHjSA8k=;
        b=LCTOpdFAw92Re/ux6wXEumAMdp9TKQwpTrSs5Lh/Qfasc2H2gJ2JHORCOPqt1avoZp
         1tmaIxawMjWKMK8d+zD5JXjklFfimS9r/BqlbkyxHnTZO3x7cQwNnqJ6es6GzRicctNr
         EaB7LXmyAAXYzveD3svhTn+/IauwuK4QoRDoCm2/Sa1cRGHc3hk/h2+0fA/HPC4JljMg
         eiBJ55Ma79JLsP+jPuXuNBQYRQXn0ouq7/HS6Awte0dQHoJnfCAUHQbnT3JVi8TC+/t2
         IAmlCYL0po73tQ2RrijK8nFHuYWuO0Irn89uBprLX2gDt0zoB7NLVDWnzkdl4ndXwcmc
         424Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FHC23kKOOD8L5WKDG46G396bmkMA7Azge/SSFHjSA8k=;
        b=HwpXZ6KucRKeAYTNpcGig1CZ/LhJ+D2xp/qOOOAGwbHiOOX/5FvntARIU3ebjfCqfk
         0rri6viCZRrK3G6K3//UIjrjRo4t6kt/OInJarBCSIO9lAIozJDteP0fy83njDpi9P46
         TCKkxrDHVkKRah+Q08hhSSR1dWTIWKfBafFHQNTD6hWzZxfBknXIHLVpopCdMrQKl14U
         CDUAWxyVLxkdUCv+nC27k1eOfuLWLY6hp/AlP/oJMMJ0arnbEt5aMquTlM6+JOcR/ICf
         zUDTwPYWlQYgbLCxWQx8gQli5Sxmvz7a439qJqKt735D4plsa8nhWFFRDWjJ2jLxX/d3
         4NKw==
X-Gm-Message-State: APjAAAUNLmeg5UjVei2SrSFr/o3S1jM0/7SqqGlV/eszGRrd0N5xPkvp
        jlbuhSJGqfILltuG28Q4CHAnXA==
X-Google-Smtp-Source: APXvYqzJQV9pKn1T+xq8tEvgofda0YcYf0p7M5EupWuyPIKGF8VVn1dVryBLfJtwZGN7wSmKfJ91bQ==
X-Received: by 2002:a81:5f86:: with SMTP id t128mr12396998ywb.467.1551996688797;
        Thu, 07 Mar 2019 14:11:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::be7f])
        by smtp.gmail.com with ESMTPSA id a194sm2078380ywh.103.2019.03.07.14.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 14:11:28 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:11:27 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] blkcg: introduce io.sync_isolation
Message-ID: <20190307221125.hy2j76m6tv7vnjpr@macbook-pro-91.dhcp.thefacebook.com>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
 <20190307180834.22008-3-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307180834.22008-3-andrea.righi@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:08:33PM +0100, Andrea Righi wrote:
> Add a flag to the blkcg cgroups to make sync()'ers in a cgroup only be
> allowed to write out pages that have been dirtied by the cgroup itself.
> 
> This flag is disabled by default (meaning that we are not changing the
> previous behavior by default).
> 
> When this flag is enabled any cgroup can write out only dirty pages that
> belong to the cgroup itself (except for the root cgroup that would still
> be able to write out all pages globally).
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
