Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BDC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20A20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfCGIVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:21:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:27648 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGIVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:21:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121742409"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.107])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 00:21:12 -0800
Date:   Thu, 7 Mar 2019 16:21:25 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [LKP] [mac80211] c752cac9db:
 hwsim.ap_vlan_iface_cleanup_multibss_per_sta_vif.fail
Message-ID: <20190307082125.GR25100@shao2-debian>
References: <20190307070450.GO25100@shao2-debian>
 <F7CD281DE3E379468C6D07993EA72F84D17B4425@RTITMBSVM04.realtek.com.tw>
 <20190307075916.GQ25100@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307075916.GQ25100@shao2-debian>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 03:59:16PM +0800, kernel test robot wrote:
> On Thu, Mar 07, 2019 at 07:49:11AM +0000, Tony Chuang wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: kernel test robot [mailto:rong.a.chen@intel.com]
> > > Sent: Thursday, March 07, 2019 3:05 PM
> > > To: Tony Chuang
> > > Cc: Johannes Berg; Larry Finger; LKML; Linus Torvalds; lkp@01.org
> > > Subject: [LKP] [mac80211] c752cac9db:
> > > hwsim.ap_vlan_iface_cleanup_multibss_per_sta_vif.fail
> > > 
> > > FYI, we noticed the following commit (built with gcc-8):
> > > 
> > > commit: c752cac9db1b0c469db7ba9d17af4ba708984db5 ("mac80211: fix
> > > GFP_KERNEL under tasklet context")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > in testcase: hwsim
> > > with following parameters:
> > > 
> > > 	group: hwsim-02
> > > 
> > > 
> > > 
> > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2
> > > -m 4G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire
> > > log/backtrace):
> > > 
> > 
> > <...>
> > 
> > > 
> > > 2019-03-06 14:51:15 	./run-tests.py ap_vlan_iface_cleanup_multibss
> > > DEV: wlan0: 02:00:00:00:00:00
> > > DEV: wlan1: 02:00:00:00:01:00
> > > DEV: wlan2: 02:00:00:00:02:00
> > > APDEV: wlan3
> > > APDEV: wlan4
> > > START ap_vlan_iface_cleanup_multibss 1/1
> > > Test: AP VLAN operation in multi-BSS multi-VLAN case
> > > RTNETLINK answers: File exists
> > > Starting AP wlan4
> > > Starting interface wlan3
> > > Connect STA wlan0 to AP
> > > Connect STA wlan1 to AP
> > > wlan0 -> VLAN 2
> > > test wlan1 == VLAN 1
> > > wlan1 -> VLAN 2
> > > test wlan0 == VLAN 2
> > > PASS ap_vlan_iface_cleanup_multibss 3.037115 2019-03-06 14:51:19.362536
> > > passed all 1 test case(s)
> > > 2019-03-06 14:51:19 	./run-tests.py
> > > ap_vlan_iface_cleanup_multibss_per_sta_vif
> > > DEV: wlan0: 02:00:00:00:00:00
> > > DEV: wlan1: 02:00:00:00:01:00
> > > DEV: wlan2: 02:00:00:00:02:00
> > > APDEV: wlan3
> > > APDEV: wlan4
> > > START ap_vlan_iface_cleanup_multibss_per_sta_vif 1/1
> > > Test: AP VLAN operation in multi-BSS multi-VLAN case with per-sta-vif set
> > > Starting AP wlan4
> > > Starting interface wlan3
> > > Connect STA wlan0 to AP
> > > Connect STA wlan1 to AP
> > > dev1->dev2 unicast data delivery failed
> > > Traceback (most recent call last):
> > >   File "./run-tests.py", line 466, in main
> > >     t(dev, apdev)
> > >   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 505, in
> > > test_ap_vlan_iface_cleanup_multibss_per_sta_vif
> > >     'multi-bss-iface-per_sta_vif.conf')
> > >   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 413, in
> > > ap_vlan_iface_cleanup_multibss
> > >     hwsim_utils.test_connectivity_iface(dev[1], hapd1, "brvlan1")
> > >   File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 176, in
> > > test_connectivity_iface
> > >     max_tries=max_tries, timeout=timeout)
> > >   File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 169, in
> > > test_connectivity
> > >     raise Exception(last_err)
> > > Exception: dev1->dev2 unicast data delivery failed
> > > FAIL ap_vlan_iface_cleanup_multibss_per_sta_vif 6.917146 2019-03-06
> > > 14:51:26.784664
> > > passed 0 test case(s)
> > > skipped 0 test case(s)
> > > failed tests: ap_vlan_iface_cleanup_multibss_per_sta_vif
> > 
> > <...>
> > 
> > > 
> > > 
> > > To reproduce:
> > > 
> > >         # build kernel
> > > 	cd linux
> > > 	cp config-4.19.0-12453-gc752cac .config
> > > 	make HOSTCC=gcc-8 CC=gcc-8 ARCH=x86_64 olddefconfig
> > > 	make HOSTCC=gcc-8 CC=gcc-8 ARCH=x86_64 prepare
> > > 	make HOSTCC=gcc-8 CC=gcc-8 ARCH=x86_64 modules_prepare
> > > 	make HOSTCC=gcc-8 CC=gcc-8 ARCH=x86_64 SHELL=/bin/bash
> > > 	make HOSTCC=gcc-8 CC=gcc-8 ARCH=x86_64 bzImage
> > > 
> > > 
> > >         git clone https://github.com/intel/lkp-tests.git
> > >         cd lkp-tests
> > >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this
> > > email
> > > 
> > > 
> > > 
> > > Thanks,
> > > Rong Chen
> > 
> > 
> > It looks really strange that this patch failed the test.
> > And I checked the dmesg, the log shows me that
> > 
> > PASS ap_vlan_iface_cleanup_multibss_per_sta_vif
> > 
> > At line 24000.
> 
> Hi,
> 
> This doesn't happen every time. Here is a bad result:
> 
> 2019-03-06 14:51:19     ./run-tests.py ap_vlan_iface_cleanup_multibss_per_sta_vif 
> DEV: wlan0: 02:00:00:00:00:00
> DEV: wlan1: 02:00:00:00:01:00
> DEV: wlan2: 02:00:00:00:02:00
> APDEV: wlan3
> APDEV: wlan4
> START ap_vlan_iface_cleanup_multibss_per_sta_vif 1/1
> Test: AP VLAN operation in multi-BSS multi-VLAN case with per-sta-vif set
> Starting AP wlan4
> Starting interface wlan3
> Connect STA wlan0 to AP
> Connect STA wlan1 to AP
> dev1->dev2 unicast data delivery failed
> Traceback (most recent call last):
>   File "./run-tests.py", line 466, in main
>     t(dev, apdev)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 505, in test_ap_vlan_iface_cleanup_multibss_per_sta_vif
>     'multi-bss-iface-per_sta_vif.conf')
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_vlan.py", line 413, in ap_vlan_iface_cleanup_multibss
>     hwsim_utils.test_connectivity_iface(dev[1], hapd1, "brvlan1")
>   File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 176, in test_connectivity_iface
>     max_tries=max_tries, timeout=timeout)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/hwsim_utils.py", line 169, in test_connectivity
>     raise Exception(last_err)
> Exception: dev1->dev2 unicast data delivery failed
> FAIL ap_vlan_iface_cleanup_multibss_per_sta_vif 6.917146 2019-03-06 14:51:26.784664
> passed 0 test case(s)
> skipped 0 test case(s)
> failed tests: ap_vlan_iface_cleanup_multibss_per_sta_vif
> 

Sorry, ap_vlan_iface_cleanup_multibss_per_sta_vif.fail is this one, but hwsim.ap_wpa2_eap_aka_sql fails too.
the kernel of parent commit can't run successfully, I'm not 100% sure the failure was caused by this commit.

81c5dce2cd0bb0ec c752cac9db1b0c469db7ba9d17a
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :90          14%          13:91    hwsim.ap_vlan_iface_cleanup_multibss_per_sta_vif.fail
           :90           9%           8:91    stderr.Failed_to_connect_to_hostapd-wpa_ctrl_open:No_such_file_or_directory
         90:90        -100%            :91    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
           :90           6%           5:91    dmesg.RIP:__ieee80211_beacon_get[mac80211]
           :90           1%           1:91    dmesg.RIP:console_unlock
           :90           6%           5:91    dmesg.WARNING:at_net/mac80211/tx.c:#__ieee80211_beacon_get/0x
         90:90         -94%           5:91    dmesg.boot_failures
      21732:90      -24148%            :91    dmesg.timestamp:BUG:sleeping_function_called_from_invalid_context_at_mm/slab.h
           :90       14125%       12712:91    dmesg.timestamp:RIP:__ieee80211_beacon_get[mac80211]
           :90        3137%        2822:91    dmesg.timestamp:RIP:console_unlock
           :90       14125%       12712:91    dmesg.timestamp:WARNING:at_net/mac80211/tx.c:#__ieee80211_beacon_get/0x
      22439:90       70264%       85676:91    dmesg.timestamp:last

Best Regards,
Rong Chen
