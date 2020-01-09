Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431302067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgAIHA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:00:29 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:38266 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgAIHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:00:28 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 80FC22009CA;
        Thu,  9 Jan 2020 07:00:26 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id D79A220358; Thu,  9 Jan 2020 07:54:24 +0100 (CET)
Date:   Thu, 9 Jan 2020 07:54:24 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     mark.rutland@arm.com, hch@infradead.org, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, guohanjun@huawei.com, wcohen@redhat.com,
        linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
        wezhang@redhat.com
Subject: Re: [PATCH] sys_personality: Add a optional arch hook
 arch_check_personality() for common sys_personality()
Message-ID: <20200109065424.GA84503@light.dominikbrodowski.net>
References: <20200109013846.174796-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109013846.174796-1-bobo.shaobowang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:38:46AM +0800, Wang ShaoBo wrote:
> currently arm64 use __arm64_sys_arm64_personality() as its default
> syscall. But using a normal hook arch_check_personality() can reject
> personality settings for special case of different archs.

Thanks for your patch!

>  SYSCALL_DEFINE1(personality, unsigned int, personality)
>  {
> -	unsigned int old = current->personality;
> +	int check;
>  
> -	if (personality != 0xffffffff)
> -		set_personality(personality);
> +	check = arch_check_personality(personality);
> +	if (check)
> +		return check;
>  
> -	return old;
> +	return ksys_personality(personality);
>  }

Please leave the default check and call to set_personality()
in here and remove the now-unneeded ksys_personality() from
include/linux/syscalls.h

Thanks,
	Dominik
