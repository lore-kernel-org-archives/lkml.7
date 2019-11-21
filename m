Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D92F20878
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUCaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:30:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbfKUCaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:30:55 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 516E85B082EA019336F2;
        Thu, 21 Nov 2019 10:14:08 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.228) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 21 Nov 2019
 10:14:02 +0800
Subject: Re: [PATCH] serial: serial_core: Perform NULL checks for break_ctl
 ops
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1574263133-28259-1-git-send-email-xiaojiangfeng@huawei.com>
 <20191120154235.GA3004157@kroah.com>
CC:     <jslaby@suse.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <nixiaoming@huawei.com>, <zhangwen8@huawei.com>
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <35ac1c40-d2f4-f6dc-5e2f-f168a0a17c8b@huawei.com>
Date:   Thu, 21 Nov 2019 10:14:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20191120154235.GA3004157@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/20 23:42, Greg KH wrote:
> On Wed, Nov 20, 2019 at 11:18:53PM +0800, Jiangfeng Xiao wrote:
>> Doing fuzz test on sbsa uart device, causes a kernel crash
>> due to NULL pointer dereference:
>>
>> ------------[ cut here ]------------
>> Unable to handle kernel paging request at virtual address fffffffffffffffc
>> CPU: 2 PID: 2385 Comm: tty_fuzz_test Tainted: G           O    4.4.193 #1
>> task: ffffffe32b23f110 task.stack: ffffffe32bda4000
>> PC is at uart_break_ctl+0x44/0x84
>> LR is at uart_break_ctl+0x34/0x84
>> pc : [<ffffff8393196098>] lr : [<ffffff8393196088>] pstate: 80000005
>> sp : ffffffe32bda7cc0
>> [<ffffff8393196098>] uart_break_ctl+0x44/0x84
>> [<ffffff8393177718>] send_break+0xa0/0x114
>> [<ffffff8393179a1c>] tty_ioctl+0xc50/0xe84
>> [<ffffff8392fa5a40>] do_vfs_ioctl+0xc4/0x6e8
>> [<ffffff8392fa60cc>] SyS_ioctl+0x68/0x9c
>> [<ffffff8392e02e78>] __sys_trace_return+0x0/0x4
>> Code: b9410ea0 34000160 f9408aa0 f9402814 (b85fc280)
>> ---[ end trace 8606094f1960c5e0 ]---
>> Kernel panic - not syncing: Fatal exception
>>
>> Fix this problem by adding NULL checks prior to calling break_ctl ops.
>>
>> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>> ---
>>  drivers/tty/serial/serial_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
>> index c4a414a..b0a6eb1 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1111,7 +1111,7 @@ static int uart_break_ctl(struct tty_struct *tty, int break_state)
>>  	if (!uport)
>>  		goto out;
>>  
>> -	if (uport->type != PORT_UNKNOWN)
>> +	if (uport->type != PORT_UNKNOWN && uport->ops->break_ctl)
> 
> What serial driver does not define break_ctl?

I'm using arm_sbsa_uart_platform_driver, and sbsa_uart_pops does not define break_ctl.
I did a troubleshooting on the latest mainline 5.4-rc8 kernel.
There are 7 uart_ops without defining break_ctl:
./drivers/tty/serial/men_z135_uart.c:774:static const struct uart_ops men_z135_ops = {
./drivers/tty/serial/amba-pl011.c:2173:static const struct uart_ops sbsa_uart_pops = {
./drivers/tty/serial/owl-uart.c:464:static const struct uart_ops owl_uart_ops = {
./drivers/tty/serial/meson_uart.c:430:static const struct uart_ops meson_uart_ops = {
./drivers/tty/serial/qcom_geni_serial.c:1212:static const struct uart_ops qcom_geni_console_pops = {
./drivers/tty/serial/qcom_geni_serial.c:1232:static const struct uart_ops qcom_geni_uart_pops = {
./drivers/tty/serial/rda-uart.c:559:static const struct uart_ops rda_uart_ops = {

> You are running with a bunch of "out-of-tree" drivers, perhaps one of
> those needs to be fixed here instead?

I carefully confirmed it again, the kernel crash was caused by arm_sbsa_uart_platform_driver which is "in-tree".

There are two ways to fix this problem, one is to add a null pointer check,
and the other is to define break_ctl for each uart_ops.
I am a newbie on serial_core, so I don't know which way is more reasonable.

Based on the principle of minimal change, I chose to add a null pointer check.

Thank you for your review.

