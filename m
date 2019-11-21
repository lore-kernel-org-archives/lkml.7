Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B5AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E56E20898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574320275;
	bh=N9Kaj7UNS7Ea6awEOY5ykIJwFNYXO2L/DbIOFWA+YLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ErcD1SWJImJj27SlVwyqHTvIYoDxHLj+jiLTm7DRvs/WDCge1UimvXyepgfQH/Kw
	 ZA0uYP2KMHKYLgZAFLczjwtAMlDAVRJeWRBhCXB9P5IM8l7aDF3pRDUkp9GkoW48br
	 iiiQ16PLQuj2D9r+Y3zV/2biy22x/J3Ear7kPddA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKUHLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:11:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUHLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:11:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE86620872;
        Thu, 21 Nov 2019 07:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574320272;
        bh=N9Kaj7UNS7Ea6awEOY5ykIJwFNYXO2L/DbIOFWA+YLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltJPd14tmE4FLLxP1LWLjhCb02srWll+/u9e3EZyujx8FQEy+FCYFpP0K9o1TrkvT
         mWfRcRR4/+1WlGETdgyCoPgZ7lvERWHBAeS7i31wfEoTtIUXJyRkL2IwtK7ao0b8Nu
         WMAOEh+b2VSyt+N7Xd5AQ5ZWgHlzljD4VAWCgYbo=
Date:   Thu, 21 Nov 2019 08:11:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, leeyou.li@huawei.com,
        nixiaoming@huawei.com, zhangwen8@huawei.com
Subject: Re: [PATCH] serial: serial_core: Perform NULL checks for break_ctl
 ops
Message-ID: <20191121071110.GA345427@kroah.com>
References: <1574263133-28259-1-git-send-email-xiaojiangfeng@huawei.com>
 <20191120154235.GA3004157@kroah.com>
 <35ac1c40-d2f4-f6dc-5e2f-f168a0a17c8b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ac1c40-d2f4-f6dc-5e2f-f168a0a17c8b@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 10:14:02AM +0800, Jiangfeng Xiao wrote:
> On 2019/11/20 23:42, Greg KH wrote:
> > On Wed, Nov 20, 2019 at 11:18:53PM +0800, Jiangfeng Xiao wrote:
> >> Doing fuzz test on sbsa uart device, causes a kernel crash
> >> due to NULL pointer dereference:
> >>
> >> ------------[ cut here ]------------
> >> Unable to handle kernel paging request at virtual address fffffffffffffffc
> >> CPU: 2 PID: 2385 Comm: tty_fuzz_test Tainted: G           O    4.4.193 #1
> >> task: ffffffe32b23f110 task.stack: ffffffe32bda4000
> >> PC is at uart_break_ctl+0x44/0x84
> >> LR is at uart_break_ctl+0x34/0x84
> >> pc : [<ffffff8393196098>] lr : [<ffffff8393196088>] pstate: 80000005
> >> sp : ffffffe32bda7cc0
> >> [<ffffff8393196098>] uart_break_ctl+0x44/0x84
> >> [<ffffff8393177718>] send_break+0xa0/0x114
> >> [<ffffff8393179a1c>] tty_ioctl+0xc50/0xe84
> >> [<ffffff8392fa5a40>] do_vfs_ioctl+0xc4/0x6e8
> >> [<ffffff8392fa60cc>] SyS_ioctl+0x68/0x9c
> >> [<ffffff8392e02e78>] __sys_trace_return+0x0/0x4
> >> Code: b9410ea0 34000160 f9408aa0 f9402814 (b85fc280)
> >> ---[ end trace 8606094f1960c5e0 ]---
> >> Kernel panic - not syncing: Fatal exception
> >>
> >> Fix this problem by adding NULL checks prior to calling break_ctl ops.
> >>
> >> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
> >> ---
> >>  drivers/tty/serial/serial_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> >> index c4a414a..b0a6eb1 100644
> >> --- a/drivers/tty/serial/serial_core.c
> >> +++ b/drivers/tty/serial/serial_core.c
> >> @@ -1111,7 +1111,7 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
> >>  	if (!uport)
> >>  		goto out;
> >>  
> >> -	if (uport->type != PORT_UNKNOWN)
> >> +	if (uport->type != PORT_UNKNOWN && uport->ops->break_ctl)
> > 
> > What serial driver does not define break_ctl?
> 
> I'm using arm_sbsa_uart_platform_driver, and sbsa_uart_pops does not define break_ctl.
> I did a troubleshooting on the latest mainline 5.4-rc8 kernel.
> There are 7 uart_ops without defining break_ctl:
> ./drivers/tty/serial/men_z135_uart.c:774:static const struct uart_ops men_z135_ops = {
> ./drivers/tty/serial/amba-pl011.c:2173:static const struct uart_ops sbsa_uart_pops = {
> ./drivers/tty/serial/owl-uart.c:464:static const struct uart_ops owl_uart_ops = {
> ./drivers/tty/serial/meson_uart.c:430:static const struct uart_ops meson_uart_ops = {
> ./drivers/tty/serial/qcom_geni_serial.c:1212:static const struct uart_ops qcom_geni_console_pops = {
> ./drivers/tty/serial/qcom_geni_serial.c:1232:static const struct uart_ops qcom_geni_uart_pops = {
> ./drivers/tty/serial/rda-uart.c:559:static const struct uart_ops rda_uart_ops = {
> 
> > You are running with a bunch of "out-of-tree" drivers, perhaps one of
> > those needs to be fixed here instead?
> 
> I carefully confirmed it again, the kernel crash was caused by arm_sbsa_uart_platform_driver which is "in-tree".
> 
> There are two ways to fix this problem, one is to add a null pointer check,
> and the other is to define break_ctl for each uart_ops.
> I am a newbie on serial_core, so I don't know which way is more reasonable.
> 
> Based on the principle of minimal change, I chose to add a null pointer check.

Yeah, that makes sense to me as well, I'll go queue this up.  Thanks for
the detailed information.

greg k-h
