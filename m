Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2677C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7217E20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCGKFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:05:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:44310 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:05:22 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1ptt-0000as-2O; Thu, 07 Mar 2019 11:05:17 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1pts-000XQl-PC; Thu, 07 Mar 2019 11:05:16 +0100
Subject: Re: [PATCH] bpf: fix sysctl.c warning
To:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20190304203443.1992942-1-arnd@arndb.de>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1d79d4ec-99c7-1764-af8f-ea436a657eb0@iogearbox.net>
Date:   Thu, 7 Mar 2019 11:05:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190304203443.1992942-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25380/Wed Mar  6 10:23:41 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 09:34 PM, Arnd Bergmann wrote:
> When CONFIG_BPF_SYSCALL or CONFIG_SYSCTL is disabled, we get
> a warning about an unused function:
> 
> kernel/sysctl.c:3331:12: error: 'proc_dointvec_minmax_bpf_stats' defined but not used [-Werror=unused-function]
>  static int proc_dointvec_minmax_bpf_stats(struct ctl_table *table, int write,
> 
> The CONFIG_BPF_SYSCALL check was already handled, but the SYSCTL check
> is needed on top.
> 
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
