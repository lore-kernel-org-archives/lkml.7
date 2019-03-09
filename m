Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D09206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhsJitNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCIXrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 18:47:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34798 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfCIXrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 18:47:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so904327pfn.1;
        Sat, 09 Mar 2019 15:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CmRPucDAhrJ+BD2n/DaRCwYoyOfARyHWsJaBkdNE6Y4=;
        b=AhsJitNq/Ao+Upuo604Bq6v+LlM0ABRN9G16K55C4ZHw6hqcpTxOXCsIx+Rb9ctVVo
         ku/k3kKWb9qZAmoSSxumYxTkU7VHaUmy9iASB6Z59e8e1Qe+wT1W6OKKdv/E7HZZ+VQi
         1WiSvdQAOh7+UFyFNVirhbN8rywGFiiIVhKzqVBXRDsbkFLAFX/bMziFpWCJ5TBjSwqM
         r+tGv9n5KhoGVxfy8W6qZOwp1LQihc8EjGszCU9H5KNmOhD5xQ4NsiM9m1OXYbi+5QmL
         Uqsv6jr9BgoMZ+Vn4DC0+1lA0G15kOZreOFkA5atF87/o5LP1GF2Xj4zdJhWvWb1tJnQ
         vAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmRPucDAhrJ+BD2n/DaRCwYoyOfARyHWsJaBkdNE6Y4=;
        b=ctVmjB7E99DnlGY24T8x5oQxwGiyR8vsSuOTbEdmFBefZrrqyJFw/EuFMjgWSD9uzs
         szJK1CbNm7403Tdi+C2wz5j8wU4uk8NaKspmeGYzEy7DemN2njuOpjW4OSQmMA40+4Me
         DS2Q6NBKbDoggDW3qeA4BxqsCLI0+FwZHOBshlIPaRPqIw5iyFXvhb57Z8Q6aMHjA1Sv
         VpibTg2ssCVPj2w6u+EJ47ajZrDjFHiLBhc6ubs+9cW75e0BnqjHuZfYUxdwkauhQ8Th
         5vrRBg66D3qDmWPEkXKUEpEdBZE1aA5xjTvNefdMA+v4WpKBhXEU0QG6ddAyBlnlspt4
         tOig==
X-Gm-Message-State: APjAAAX2yVVSU0qfpPVFkRUtVdHhJ5ogqkROTfzKpixg6YSXhVgvc13A
        NnCZQdFEpqkny/sjxAlxTX8=
X-Google-Smtp-Source: APXvYqyYwxQJZCobiGEAxZeqoN558FKVrVAcdA8QWQUg7hT17LrgCPNN8HQYjNbcLI7VEGl3h9hh2w==
X-Received: by 2002:a63:1a5d:: with SMTP id a29mr21813559pgm.369.1552175222291;
        Sat, 09 Mar 2019 15:47:02 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p7sm2220063pfn.17.2019.03.09.15.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 15:47:01 -0800 (PST)
Date:   Sat, 9 Mar 2019 15:46:59 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zhipeng Xie <xiezhipeng1@huawei.com>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel.openeuler@huawei.com,
        euleros@huawei.com, huawei.libin@huawei.com,
        yangyingliang@huawei.com
Subject: Re: [PATCH] Input: fix oops in input_to_handler
Message-ID: <20190309234659.GD13699@dtor-ws>
References: <1551413607-32036-1-git-send-email-xiezhipeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551413607-32036-1-git-send-email-xiezhipeng1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhipeng,

On Fri, Mar 01, 2019 at 12:13:27PM +0800, Zhipeng Xie wrote:
> we got the following boot crash:
> 
> 	[   36.086344] Internal error: Oops: 96000004 [#1] SMP
> 	[   36.091371] CPU: 32 PID: 0 Comm: swapper/32 Tainted: G           OE     4.19.25-vhulk1901.1.0.h111.aarch64 #1
> 	[   36.101444] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.58 10/24/2018
> 	[   36.108860] pstate: 20000085 (nzCv daIf -PAN -UAO)
> 	[   36.113727] pc : input_to_handler+0x2c/0x148
> 	[   36.118058] lr : input_pass_values.part.2+0x148/0x168
> 	[   36.123177] sp : ffff000100103ba0
> 	[   36.126535] x29: ffff000100103ba0 x28: ffff801fb2ac5958
> 	[   36.131924] x27: ffff000009799000 x26: 0000000000000001
> 	[   36.137375] x25: 0000000000000000 x24: ffff801fb5b57c00
> 	[   36.142822] x23: 000000020987f3d0 x22: ffff801faf427e00
> 	[   36.148211] x21: 0000000000000003 x20: 0000000000000003
> 	[   36.153599] x19: ffff801faf427e00 x18: 000000000000000e
> 	[   36.158986] x17: 000000000000000e x16: 0000000000000007
> 	[   36.164374] x15: 0000000000000001 x14: 0000000000000019
> 	[   36.169762] x13: 0000000000000033 x12: 000000000000004c
> 	[   36.175150] x11: 0000000000000068 x10: ffff000008dfa290
> 	[   36.180538] x9 : 000000000000007d x8 : 0000000000000000
> 	[   36.185925] x7 : 0000000000000053 x6 : 0000000000000000
> 	[   36.191313] x5 : 0000000000000000 x4 : 0000000000000000
> 	[   36.196700] x3 : 0000000000000010 x2 : 0000000000000003
> 	[   36.202088] x1 : ffff801fb5b57c00 x0 : ffff000008a120a0
> 	[   36.207477] Process swapper/32 (pid: 0, stack limit = 0x0000000032f86b58)
> 	[   36.214361] Call trace:
> 	[   36.216840]  input_to_handler+0x2c/0x148
> 	[   36.220816]  input_pass_values.part.2+0x148/0x168
> 	[   36.225582]  input_handle_event+0x130/0x5b8
> 	[   36.229823]  i6.242013]  hid_input_report+0x128/0x1b0
> 	[   36.246076]  hid_irq_in+0x240/0x298
> 	[   36.249613]  __usb_hcd_giveback_urb+0x9c/0x130
> 	[   36.257460]  usb_giveback_urb_bh+0xf4/0x198
> 	[   36.265127]  tasklet_action_common.isra.6+0x94/0x160
> 	[   36.273458]  tasklet_hi_action+0x2c/0x38
> 	[   36.280597]  __do_softirq+0x118/0x314
> 	[   36.287494]  irq_exit+0xa4/0xe8
> 	[   36.293682]  __handle_domain_irq+0x6c/0xc0
> 	[   36.300783]  gic_handle_irq+0x6c/0x170
> 	[   36.307296]  el1_irq+0xb8/0x140
> 	[   36.313283]  arch_cpu_idle+0x38/0x1c0
> 	[   36.319776]  default_idle_call+0x24/0x44
> 	[   36.326527]  do_idle+0x1ec/0x2d0
> 	[   36.332503]  cpu_startup_entry+0x28/0x30
> 	[   36.339161]  secondary_start_kernel+0x194/0x1d8
> 
> We need to check the input_handler before referencing its members.
> 
> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> ---
>  drivers/input/input.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 3304aaa..b768d14 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -100,6 +100,9 @@ static unsigned int input_to_handler(struct input_handle *handle,
>  	struct input_value *end = vals;
>  	struct input_value *v;
>  
> +	if (!handler)
> +		return 0;

No, is not a proper change. That means that someone registered an input
handle without setting handler, which is not allowed. Do you have any
custom input handlers in your system?

Thanks.

-- 
Dmitry
