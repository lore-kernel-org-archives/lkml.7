Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AA620815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCDMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:47:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCDMr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:47:56 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 637A41103007087AA386;
        Mon,  4 Mar 2019 20:47:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 20:47:46 +0800
From:   maowenan <maowenan@huawei.com>
Subject: question about memory leak in ip_mc_del1_src
To:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kuznet@ms2.inr.ac.ru>
Message-ID: <91def48c-15be-2bac-7c9b-2cead21b6fa9@huawei.com>
Date:   Mon, 4 Mar 2019 20:47:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is one report shows that memory in ip_mc_msfilter.
details as below:
00:13:12 executing program 0:
r0 = socket$inet_udp(0x2, 0x2, 0x0)
setsockopt$inet_mreqn(r0, 0x0, 0x23, &(0x7f0000000400)={@multicast2, @remote}, 0xc)
getsockopt$inet_udp_int(r0, 0x11, 0x66, &(0x7f0000000000), &(0x7f0000000040)=0x4)
setsockopt$inet_msfilter(r0, 0x0, 0x29, &(0x7f0000000340)={@multicast2, @remote, 0x1, 0x2, [@dev, @remote]}, 0x18)
BUG: memory leak
unreferenced object 0xffff888366182ba0 (size 64):
  comm "softirq", pid 0, jiffies 4296340851 (age 18.283s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ac 14 14 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003571cc08>] ip_mc_msfilter+0x4e5/0xac0 net/ipv4/igmp.c:2466
    [<00000000ffc04980>] do_ip_setsockopt.isra.3+0x2039/0x2890 net/ipv4/ip_sockglue.c:957
    [<00000000eb430827>] ip_setsockopt+0x3a/0xc0 net/ipv4/ip_sockglue.c:1246
    [<0000000027c7421b>] udp_setsockopt+0x45/0x90 net/ipv4/udp.c:2525
    [<000000004bcb55ab>] __sys_setsockopt+0x136/0x210 net/socket.c:1900
    [<00000000ff5179e9>] __do_sys_setsockopt net/socket.c:1911 [inline]
    [<00000000ff5179e9>] __se_sys_setsockopt net/socket.c:1908 [inline]
    [<00000000ff5179e9>] __x64_sys_setsockopt+0xbf/0x160 net/socket.c:1908
    [<000000005b4e95d0>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<000000005f4b13c0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000521b1057>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff888366182c00 (size 64):
  comm "softirq", pid 0, jiffies 4296340851 (age 18.283s)
  hex dump (first 32 bytes):
    a0 2b 18 66 83 88 ff ff ac 14 14 bb 00 00 00 00  .+.f............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003571cc08>] ip_mc_msfilter+0x4e5/0xac0 net/ipv4/igmp.c:2466
    [<00000000ffc04980>] do_ip_setsockopt.isra.3+0x2039/0x2890 net/ipv4/ip_sockglue.c:957
    [<00000000eb430827>] ip_setsockopt+0x3a/0xc0 net/ipv4/ip_sockglue.c:1246
    [<0000000027c7421b>] udp_setsockopt+0x45/0x90 net/ipv4/udp.c:2525
    [<000000004bcb55ab>] __sys_setsockopt+0x136/0x210 net/socket.c:1900
    [<00000000ff5179e9>] __do_sys_setsockopt net/socket.c:1911 [inline]
    [<00000000ff5179e9>] __se_sys_setsockopt net/socket.c:1908 [inline]
    [<00000000ff5179e9>] __x64_sys_setsockopt+0xbf/0x160 net/socket.c:1908
    [<000000005b4e95d0>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<000000005f4b13c0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000521b1057>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff888366182d20 (size 64):
  comm "softirq", pid 0, jiffies 4296340867 (age 18.267s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ac 14 14 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003571cc08>] ip_mc_msfilter+0x4e5/0xac0 net/ipv4/igmp.c:2466
    [<00000000ffc04980>] do_ip_setsockopt.isra.3+0x2039/0x2890 net/ipv4/ip_sockglue.c:957
    [<00000000eb430827>] ip_setsockopt+0x3a/0xc0 net/ipv4/ip_sockglue.c:1246
    [<0000000027c7421b>] udp_setsockopt+0x45/0x90 net/ipv4/udp.c:2525
    [<000000004bcb55ab>] __sys_setsockopt+0x136/0x210 net/socket.c:1900
    [<00000000ff5179e9>] __do_sys_setsockopt net/socket.c:1911 [inline]
    [<00000000ff5179e9>] __se_sys_setsockopt net/socket.c:1908 [inline]
    [<00000000ff5179e9>] __x64_sys_setsockopt+0xbf/0x160 net/socket.c:1908
    [<000000005b4e95d0>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<000000005f4b13c0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000521b1057>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff888366182cc0 (size 64):
  comm "softirq", pid 0, jiffies 4296340867 (age 18.267s)
  hex dump (first 32 bytes):
    20 2d 18 66 83 88 ff ff ac 14 14 bb 00 00 00 00   -.f............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003571cc08>] ip_mc_msfilter+0x4e5/0xac0 net/ipv4/igmp.c:2466
    [<00000000ffc04980>] do_ip_setsockopt.isra.3+0x2039/0x2890 net/ipv4/ip_sockglue.c:957
    [<00000000eb430827>] ip_setsockopt+0x3a/0xc0 net/ipv4/ip_sockglue.c:1246
    [<0000000027c7421b>] udp_setsockopt+0x45/0x90 net/ipv4/udp.c:2525
    [<000000004bcb55ab>] __sys_setsockopt+0x136/0x210 net/socket.c:1900
    [<00000000ff5179e9>] __do_sys_setsockopt net/socket.c:1911 [inline]
    [<00000000ff5179e9>] __se_sys_setsockopt net/socket.c:1908 [inline]
    [<00000000ff5179e9>] __x64_sys_setsockopt+0xbf/0x160 net/socket.c:1908
    [<000000005b4e95d0>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<000000005f4b13c0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000521b1057>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff8883d139c6c0 (size 64):
  comm "softirq", pid 0, jiffies 4296340884 (age 18.250s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 ac 14 14 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003571cc08>] ip_mc_msfilter+0x4e5/0xac0 net/ipv4/igmp.c:2466
    [<00000000ffc04980>] do_ip_setsockopt.isra.3+0x2039/0x2890 net/ipv4/ip_sockglue.c:957
    [<00000000eb430827>] ip_setsockopt+0x3a/0xc0 net/ipv4/ip_sockglue.c:1246
    [<0000000027c7421b>] udp_setsockopt+0x45/0x90 net/ipv4/udp.c:2525
    [<000000004bcb55ab>] __sys_setsockopt+0x136/0x210 net/socket.c:1900
    [<00000000ff5179e9>] __do_sys_setsockopt net/socket.c:1911 [inline]
    [<00000000ff5179e9>] __se_sys_setsockopt net/socket.c:1908 [inline]
    [<00000000ff5179e9>] __x64_sys_setsockopt+0xbf/0x160 net/socket.c:1908
    [<000000005b4e95d0>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<000000005f4b13c0>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000521b1057>] 0xffffffffffffffff

I have found that some suspicion:
call trace ip_mc_msfilter->ip_mc_add_src, in ip_mc_add_src(), if ip_mc_add1_src failed, ip_mc_del1_src()
will be called. Is there any memory leak after the line of "rv = 1".

	if (!psf->sf_count[MCAST_INCLUDE] && !psf->sf_count[MCAST_EXCLUDE]) {
#ifdef CONFIG_IP_MULTICAST
		struct in_device *in_dev = pmc->interface;
		struct net *net = dev_net(in_dev->dev);
#endif

		/* no more filters for this source */
		if (psf_prev)
			psf_prev->sf_next = psf->sf_next;
		else
			pmc->sources = psf->sf_next;
#ifdef CONFIG_IP_MULTICAST
		if (psf->sf_oldin &&
		    !IGMP_V1_SEEN(in_dev) && !IGMP_V2_SEEN(in_dev)) {
			psf->sf_crcount = in_dev->mr_qrv ?: net->ipv4.sysctl_igmp_qrv;
			psf->sf_next = pmc->tomb;
			pmc->tomb = psf;
			rv = 1;         //if it does not kfree(psf), will it lead to memory leak after this line?
		} else
#endif
			kfree(psf);
	}


Can I fix this to do kfree(psf) after the line of "rv = 1"?







