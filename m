Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E392CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15075214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfJUIfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:35:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:30146 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfJUIfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:35:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 01:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,322,1566889200"; 
   d="xz'?scan'208";a="203279042"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Oct 2019 01:35:27 -0700
Date:   Mon, 21 Oct 2019 16:35:14 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: [ipc/sem.c] 6394de3b86: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20191021083514.GE9296@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20191011112009.2365-5-manfred@colorfullife.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: 6394de3b868537a90dd9128607192b0e97109f6b ("[PATCH 4/5] ipc/sem.c: Document and update memory barriers")
url: https://github.com/0day-ci/linux/commits/Manfred-Spraul/wake_q-Cleanup-Documentation-update/20191014-055627


in testcase: ltp
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls_part4

test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
test-url: http://linux-test-project.github.io/


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+-----------------------------------------------------+------------+------------+
|                                                     | e14fb72a58 | 6394de3b86 |
+-----------------------------------------------------+------------+------------+
| boot_successes                                      | 12         | 0          |
| boot_failures                                       | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address         | 0          | 9          |
| Oops:#[##]                                          | 0          | 12         |
| RIP:__list_del_entry_valid                          | 0          | 10         |
| Kernel_panic-not_syncing:Fatal_exception            | 0          | 12         |
| BUG:unable_to_handle_page_fault_for_address         | 0          | 3          |
| RIP:update_queue                                    | 0          | 2          |
| WARNING:at_lib/list_debug.c:#__list_del_entry_valid | 0          | 2          |
| RIP:wake_q_add                                      | 0          | 2          |
+-----------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>


[  482.792516] tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
[  482.792520] 
[  482.802139] tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
[  482.802143] 
[  482.810179] tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
[  482.810183] 
[  482.820803] select_var.h:66: INFO: Testing libc select()
[  482.820807] 
[  482.830021] tst_timer_test.c:264: INFO: select() sleeping for 1000us 500 iterations, threshold 450.01us
[  482.830024] 
[  482.847596] tst_timer_test.c:307: INFO: min 1059us, max 7003us, median 1165us, trunc mean 1469.95us (discarded 25)
[  482.847600] 
[  482.858297] tst_timer_test.c:310: FAIL: select() slept for too long
[  482.858302] 
[  482.864980] 
[  482.870867]  Time: us | Frequency
[  482.870870] 
[  482.881126] --------------------------------------------------------------------------------
[  482.881130] 
[  482.895705]      1059 | ********************************************************************
[  482.895711] 
[  482.903498]      1372 | *+
[  482.903501] 
[  482.908663]      1685 | +
[  482.908666] 
[  482.913050]      1998 | *-
[  482.913053] 
[  482.916768]      2311 | +
[  482.916771] 
[  482.921066]      2624 | *+
[  482.921069] 
[  482.925993]      2937 | *+
[  482.925996] 
[  482.930684]      3250 | *+
[  482.930687] 
[  482.935946]      3563 | **-
[  482.935949] 
[  482.941233]      3876 | *-
[  482.941238] 
[  482.946576]      4189 | *
[  482.946579] 
[  482.950791]      4502 | +
[  482.950820] 
[  482.954670]      4815 | *
[  482.954673] 
[  482.958516]      5128 | +
[  482.958519] 
[  482.962408]      5441 | .
[  482.962411] 
[  482.966423]      5754 | +
[  482.966426] 
[  482.970379]      6067 | .
[  482.970382] 
[  482.974289]      6380 | .
[  482.974292] 
[  482.978140]      6693 | +
[  482.978143] 
[  482.985114] --------------------------------------------------------------------------------
[  482.985117] 
[  482.992572]     313us | 1 sample = 0.17481 '*', 0.34961 '+', 0.69923 '-', non-zero '.'
[  482.992576] 
[  482.996417] 
[  483.002115] tst_timer_test.c:264: INFO: select() sleeping for 2000us 500 iterations, threshold 450.01us
[  483.002118] 
[  483.011234] tst_timer_test.c:307: INFO: min 2031us, max 7845us, median 2148us, trunc mean 2348.76us (discarded 25)
[  483.011237] 
[  483.018878] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.018881] 
[  483.026893] tst_timer_test.c:264: INFO: select() sleeping for 5000us 300 iterations, threshold 450.04us
[  483.026895] 
[  483.036121] tst_timer_test.c:307: INFO: min 5046us, max 10579us, median 5168us, trunc mean 5493.15us (discarded 15)
[  483.036124] 
[  483.043537] tst_timer_test.c:310: FAIL: select() slept for too long
[  483.043540] 
[  483.047267] 
[  483.050003]  Time: us | Frequency
[  483.050006] 
[  483.057332] --------------------------------------------------------------------------------
[  483.057335] 
[  483.065553]      5046 | ********************************************************************
[  483.065556] 
[  483.075327]      5338 | ****-
[  483.075330] 
[  483.081463]      5630 | **+
[  483.081466] 
[  483.089971]      5922 | ***
[  483.089974] 
[  483.093897]      6214 | *+
[  483.093900] 
[  483.099142]      6506 | **
[  483.099145] 
[  483.103055]      6798 | +
[  483.103058] 
[  483.107398]      7090 | +
[  483.107401] 
[  483.111596]      7382 | +
[  483.111599] 
[  483.115623]      7674 | -
[  483.115627] 
[  483.119716]      7966 | **
[  483.119720] 
[  483.123760]      8258 | -
[  483.123763] 
[  483.127902]      8550 | +
[  483.127904] 
[  483.131916]      8842 | *
[  483.131919] 
[  483.136585]      9134 | +
[  483.136588] 
[  483.142237]      9426 | *+
[  483.142243] 
[  483.149548]      9718 | +
[  483.149554] 
[  483.153138]     10010 | +
[  483.153141] 
[  483.157302]     10302 | +
[  483.157305] 
[  483.164111] --------------------------------------------------------------------------------
[  483.164114] 
[  483.171562]     292us | 1 sample = 0.31050 '*', 0.62100 '+', 1.24201 '-', non-zero '.'
[  483.171565] 
[  483.175390] 
[  483.181145] tst_timer_test.c:264: INFO: select() sleeping for 10000us 100 iterations, threshold 450.33us
[  483.181149] 
[  483.190439] tst_timer_test.c:307: INFO: min 10053us, max 14724us, median 10197us, trunc mean 10749.59us (discarded 5)
[  483.190442] 
[  483.197834] tst_timer_test.c:310: FAIL: select() slept for too long
[  483.197837] 
[  483.201303] 
[  483.203916]  Time: us | Frequency
[  483.203919] 
[  483.211027] --------------------------------------------------------------------------------
[  483.211030] 
[  483.219870]     10053 | ********************************************************************
[  483.219873] 
[  483.225281]     10299 | *********+
[  483.225284] 
[  483.230064]     10545 | **-
[  483.230068] 
[  483.234029]     10791 | **-
[  483.234032] 
[  483.237921]     11037 | ***+
[  483.237924] 
[  483.241894]     11283 | *****+
[  483.241897] 
[  483.245752]     11529 | ***+
[  483.245755] 
[  483.249736]     11775 | ***+
[  483.249739] 
[  483.253790]     12021 | ***+
[  483.253811] 
[  483.257606]     12267 | 
[  483.257609] 
[  483.261554]     12513 | **-
[  483.261557] 
[  483.265496]     12759 | **-
[  483.265499] 
[  483.269462]     13005 | *
[  483.269465] 
[  483.273456]     13251 | *
[  483.273459] 
[  483.277520]     13497 | **-
[  483.277523] 
[  483.281319]     13743 | **-
[  483.281322] 
[  483.285722]     13989 | *
[  483.285725] 
[  483.288929]     14235 | *
[  483.288932] 
[  483.292662]     14481 | **-
[  483.292665] 
[  483.299588] --------------------------------------------------------------------------------
[  483.299591] 
[  483.306884]     246us | 1 sample = 1.19298 '*', 2.38596 '+', 4.77193 '-', non-zero '.'
[  483.306887] 
[  483.312268] 
[  483.317644] tst_timer_test.c:264: INFO: select() sleeping for 25000us 50 iterations, threshold 451.29us
[  483.317647] 
[  483.326674] tst_timer_test.c:307: INFO: min 25065us, max 31973us, median 25175us, trunc mean 25657.06us (discarded 2)
[  483.326678] 
[  483.333754] tst_timer_test.c:310: FAIL: select() slept for too long
[  483.333758] 
[  483.339116] 
[  483.341544]  Time: us | Frequency
[  483.341547] 
[  483.348868] --------------------------------------------------------------------------------
[  483.348872] 
[  483.356606]     25065 | ********************************************************************
[  483.356610] 
[  483.365158]     25429 | ***+
[  483.365161] 
[  483.369295]     25793 | *+
[  483.369298] 
[  483.373778]     26157 | ***+
[  483.373781] 
[  483.377857]     26521 | ***+
[  483.377860] 
[  483.381337]     26885 | ***+
[  483.381341] 
[  483.385648]     27249 | *+
[  483.385679] 
[  483.388959]     27613 | 
[  483.388961] 
[  483.393088]     27977 | *+
[  483.393091] 
[  483.399322]     28341 | *+
[  483.399328] 
[  483.408035]     28705 | 
[  483.408041] 
[  483.414130]     29069 | 
[  483.414134] 
[  483.417933]     29433 | 
[  483.417936] 
[  483.421615]     29797 | 
[  483.421619] 
[  483.424957]     30161 | *+
[  483.424960] 
[  483.429455]     30525 | *+
[  483.429458] 
[  483.435853]     30889 | 
[  483.435859] 
[  483.439883]     31253 | 
[  483.439886] 
[  483.443367]     31617 | *+
[  483.443370] 
[  483.449449] --------------------------------------------------------------------------------
[  483.449452] 
[  483.456743]     364us | 1 sample = 1.94286 '*', 3.88571 '+', 7.77143 '-', non-zero '.'
[  483.456746] 
[  483.462420] 
[  483.470113] tst_timer_test.c:264: INFO: select() sleeping for 100000us 10 iterations, threshold 537.00us
[  483.470119] 
[  483.481094] tst_timer_test.c:307: INFO: min 100131us, max 103539us, median 100220us, trunc mean 100670.44us (discarded 1)
[  483.481097] 
[  483.488255] tst_timer_test.c:310: FAIL: select() slept for too long
[  483.488258] 
[  483.493307] 
[  483.495878]  Time: us | Frequency
[  483.495882] 
[  483.502201] --------------------------------------------------------------------------------
[  483.502204] 
[  483.509908]    100131 | ********************************************************************
[  483.509912] 
[  483.516527]    100311 | 
[  483.516530] 
[  483.519777]    100491 | 
[  483.519780] 
[  483.523031]    100671 | 
[  483.523034] 
[  483.526706]    100851 | 
[  483.526710] 
[  483.531098]    101031 | ***********-
[  483.531101] 
[  483.534626]    101211 | 
[  483.534629] 
[  483.539392]    101391 | ***********-
[  483.539395] 
[  483.543898]    101571 | 
[  483.543901] 
[  483.548411]    101751 | 
[  483.548415] 
[  483.553914]    101931 | 
[  483.553919] 
[  483.559862]    102111 | ***********-
[  483.559865] 
[  483.563383]    102291 | 
[  483.563386] 
[  483.567519]    102471 | 
[  483.567522] 
[  483.571286]    102651 | 
[  483.571290] 
[  483.574563]    102831 | 
[  483.574566] 
[  483.578421]    103011 | 
[  483.578427] 
[  483.581578]    103191 | 
[  483.581582] 
[  483.586016]    103371 | ***********-
[  483.586019] 
[  483.592335] --------------------------------------------------------------------------------
[  483.592338] 
[  483.599755]     180us | 1 sample = 11.33333 '*', 22.66667 '+', 45.33333 '-', non-zero '.'
[  483.599759] 
[  483.605208] 
[  483.610713] tst_timer_test.c:264: INFO: select() sleeping for 1000000us 2 iterations, threshold 4400.00us
[  483.610716] 
[  483.620198] tst_timer_test.c:307: INFO: min 1000207us, max 1002366us, median 1000207us, trunc mean 1000207.00us (discarded 1)
[  483.620201] 
[  483.627885] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.627888] 
[  483.635436] tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
[  483.635439] 
[  483.641490] tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
[  483.641494] 
[  483.647824] tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
[  483.647827] 
[  483.656692] select_var.h:69: INFO: Testing SYS_select syscall
[  483.656695] 
[  483.672043] tst_timer_test.c:264: INFO: select() sleeping for 1000us 500 iterations, threshold 450.01us
[  483.672047] 
[  483.681266] tst_timer_test.c:307: INFO: min 1026us, max 9860us, median 1143us, trunc mean 1303.48us (discarded 25)
[  483.681269] 
[  483.691056] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.691060] 
[  483.699289] tst_timer_test.c:264: INFO: select() sleeping for 2000us 500 iterations, threshold 450.01us
[  483.699292] 
[  483.707203] tst_timer_test.c:285: INFO: Found 2 outliners in [27564,23935] range
[  483.707206] 
[  483.717665] tst_timer_test.c:307: INFO: min 2030us, max 27564us, median 2149us, trunc mean 2432.32us (discarded 25)
[  483.717668] 
[  483.725838] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.725841] 
[  483.736025] tst_timer_test.c:264: INFO: select() sleeping for 5000us 300 iterations, threshold 450.04us
[  483.736028] 
[  483.745866] tst_timer_test.c:307: INFO: min 5023us, max 10096us, median 5164us, trunc mean 5361.09us (discarded 15)
[  483.745869] 
[  483.754268] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.754271] 
[  483.764744] tst_timer_test.c:264: INFO: select() sleeping for 10000us 100 iterations, threshold 450.33us
[  483.764747] 
[  483.774978] tst_timer_test.c:307: INFO: min 10069us, max 14123us, median 10169us, trunc mean 10315.24us (discarded 5)
[  483.774981] 
[  483.785770] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  483.785773] 
[  483.794917] tst_timer_test.c:264: INFO: select() sleeping for 25000us 50 iterations, threshold 451.29us
[  483.794920] 
[  484.008296] tst_timer_test.c:307: INFO: min 25065us, max 29510us, median 25233us, trunc mean 25540.21us (discarded 2)
[  484.008299] 
[  484.016840] tst_timer_test.c:310: FAIL: select() slept for too long
[  484.016843] 
[  484.024443] 
[  484.028091]  Time: us | Frequency
[  484.028094] 
[  484.040652] --------------------------------------------------------------------------------
[  484.040657] 
[  484.052910]     25065 | ********************************************************************
[  484.052913] 
[  484.063459]     25299 | **************
[  484.063462] 
[  484.068515]     25533 | 
[  484.068519] 
[  484.074365]     25767 | *******
[  484.074368] 
[  484.079386]     26001 | *********-
[  484.079389] 
[  484.085273]     26235 | ****+
[  484.085277] 
[  484.089746]     26469 | **-
[  484.089749] 
[  484.094720]     26703 | 
[  484.094723] 
[  484.098897]     26937 | **-
[  484.098901] 
[  484.103199]     27171 | 
[  484.103203] 
[  484.107318]     27405 | 
[  484.107322] 
[  484.113051]     27639 | ****+
[  484.113054] 
[  484.120068]     27873 | 
[  484.120073] 
[  484.124407]     28107 | **-
[  484.124411] 
[  484.127982]     28341 | 
[  484.127985] 
[  484.131838]     28575 | 
[  484.131841] 
[  484.136283]     28809 | 
[  484.136287] 
[  484.141330]     29043 | 
[  484.141335] 
[  484.147183]     29277 | **-
[  484.147186] 
[  484.153769] --------------------------------------------------------------------------------
[  484.153772] 
[  484.161029]     234us | 1 sample = 2.34483 '*', 4.68966 '+', 9.37931 '-', non-zero '.'
[  484.161032] 
[  484.166668] 
[  484.172311] tst_timer_test.c:264: INFO: select() sleeping for 100000us 10 iterations, threshold 537.00us
[  484.172314] 
[  485.015313] tst_timer_test.c:307: INFO: min 100208us, max 100294us, median 100275us, trunc mean 100265.11us (discarded 1)
[  485.015319] 
[  485.023959] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  485.023963] 
[  485.043016] tst_timer_test.c:264: INFO: select() sleeping for 1000000us 2 iterations, threshold 4400.00us
[  485.043020] 
[  487.019884] tst_timer_test.c:307: INFO: min 1001184us, max 1001186us, median 1001184us, trunc mean 1001184.00us (discarded 1)
[  487.019890] 
[  487.035395] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  487.035401] 
[  487.045448] tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
[  487.045453] 
[  487.056039] tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
[  487.056043] 
[  487.066416] tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
[  487.066421] 
[  487.077159] select_var.h:72: INFO: Testing SYS_pselect6 syscall
[  487.077163] 
[  487.088250] tst_timer_test.c:264: INFO: select() sleeping for 1000us 500 iterations, threshold 450.01us
[  487.088254] 
[  487.648115] tst_timer_test.c:307: INFO: min 1060us, max 7520us, median 1188us, trunc mean 1187.02us (discarded 25)
[  487.648121] 
[  487.660865] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  487.660871] 
[  487.681755] tst_timer_test.c:264: INFO: select() sleeping for 2000us 500 iterations, threshold 450.01us
[  487.681760] 
[  488.765527] tst_timer_test.c:307: INFO: min 2072us, max 5461us, median 2217us, trunc mean 2206.84us (discarded 25)
[  488.765532] 
[  488.777841] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  488.777844] 
[  488.789015] tst_timer_test.c:264: INFO: select() sleeping for 5000us 300 iterations, threshold 450.04us
[  488.789018] 
[  490.358620] tst_timer_test.c:307: INFO: min 5090us, max 9929us, median 5230us, trunc mean 5229.22us (discarded 15)
[  490.358624] 
[  490.370107] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  490.370110] 
[  490.381126] tst_timer_test.c:264: INFO: select() sleeping for 10000us 100 iterations, threshold 450.33us
[  490.381130] 
[  491.389762] tst_timer_test.c:307: INFO: min 10071us, max 16644us, median 10234us, trunc mean 10230.05us (discarded 5)
[  491.389768] 
[  491.400810] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  491.400812] 
[  491.412920] tst_timer_test.c:264: INFO: select() sleeping for 25000us 50 iterations, threshold 451.29us
[  491.412923] 
[  492.654871] tst_timer_test.c:307: INFO: min 25155us, max 28435us, median 25232us, trunc mean 25232.15us (discarded 2)
[  492.654877] 
[  492.665458] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  492.665461] 
[  492.676978] tst_timer_test.c:264: INFO: select() sleeping for 100000us 10 iterations, threshold 537.00us
[  492.676981] 
[  493.658209] tst_timer_test.c:307: INFO: min 100273us, max 100291us, median 100288us, trunc mean 100284.78us (discarded 1)
[  493.658215] 
[  493.669206] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  493.669209] 
[  493.681098] tst_timer_test.c:264: INFO: select() sleeping for 1000000us 2 iterations, threshold 4400.00us
[  493.681102] 
[  495.654195] LTP: starting semctl01
[  495.665460] tst_timer_test.c:307: INFO: min 1001178us, max 1001182us, median 1001178us, trunc mean 1001178.00us (discarded 1)
[  495.665465] 
[  495.678498] tst_timer_test.c:322: PASS: Measured times are within thresholds
[  495.678501] 
[  495.686271] tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
[  495.686275] 
[  495.695265] tst_timer_test.c:345: INFO: CLOCK_MONOTONIC resolution 1ns
[  495.695269] 
[  495.703086] tst_timer_test.c:357: INFO: prctl(PR_GET_TIMERSLACK) = 50us
[  495.703089] 
[  495.712458] select_var.h:75: INFO: Testing SYS__newselect syscall
[  495.712462] 
[  495.725790] tst_timer_test.c:264: INFO: select() sleeping for 1000us 500 iterations, threshold 450.01us
[  495.725812] 
[  495.737856] select_var.h:52: CONF: syscall(-1) __NR__newselect not supported
[  495.737860] 
[  495.743433] 
[  495.746020] Summary:
[  495.746023] 
[  495.749409] BUG: kernel NULL pointer dereference, address: 0000000000000002
[  495.751192] passed   15
[  495.751195] 
[  495.754769] #PF: supervisor read access in kernel mode
[  495.754771] #PF: error_code(0x0000) - not-present page
[  495.754773] PGD 0 P4D 0 
[  495.754777] Oops: 0000 [#1] SMP PTI
[  495.754782] CPU: 0 PID: 7442 Comm: semctl01 Not tainted 5.4.0-rc2-00382-g6394de3b86853 #1
[  495.757491] failed   6
[  495.757495] 
[  495.759023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  495.759035] RIP: 0010:__list_del_entry_valid+0x25/0x90
[  495.759040] Code: c3 0f 1f 40 00 48 8b 07 48 b9 00 01 00 00 00 00 ad de 48 8b 57 08 48 39 c8 74 26 48 b9 22 01 00 00 00 00 ad de 48 39 ca 74 2e <48> 8b 32 48 39 fe 75 3a 48 8b 50 08 48 39 f2 75 48 b8 01 00 00 00
[  495.762252] skipped  0
[  495.762255] 
[  495.764857] RSP: 0018:ffffab238045fc28 EFLAGS: 00010203
[  495.764860] RAX: 0000000000000020 RBX: 0000000000000020 RCX: dead000000000122
[  495.764861] RDX: 0000000000000002 RSI: ffffab2380a7bd20 RDI: ffffab2380a7bd20
[  495.764862] RBP: ffff898b5bed7400 R08: ffffab238045fd10 R09: 0000000000000001
[  495.764863] R10: 0000000000000001 R11: ffffffff85132ae0 R12: ffffab2380a7bd20
[  495.764864] R13: 0000000000000004 R14: 0000000000000000 R15: ffffab2380a7bd20
[  495.764866] FS:  00007f013c3f3500(0000) GS:ffff898b7fc00000(0000) knlGS:0000000000000000
[  495.764868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  495.764869] CR2: 0000000000000002 CR3: 0000000197550000 CR4: 00000000000006f0
[  495.764876] Call Trace:
[  495.767458] warnings 0
[  495.767461] 
[  495.769346]  update_queue+0xac/0x1a0
[  495.773856] <<<execution_status>>>
[  495.773859] 
[  495.774808]  do_smart_update+0x8b/0x110
[  495.774813]  do_semtimedop+0xc77/0x1270
[  495.777521] initiation_status="ok"
[  495.777524] 
[  495.780101]  ? reuse_swap_page+0x106/0x350
[  495.780107]  ? ptep_set_access_flags+0x23/0x30
[  495.780114]  ? wp_page_reuse+0x58/0x70
[  495.780117]  ? do_wp_page+0x141/0x3e0
[  495.780120]  ? __handle_mm_fault+0x9ea/0xf70
[  495.785671] duration=27 termination_type=exited termination_id=1 corefile=no
[  495.785674] 
[  495.790152]  ? handle_mm_fault+0xdd/0x210
[  495.790159]  ? __do_page_fault+0x310/0x520
[  495.790169]  ? do_syscall_64+0x5b/0x1d0
[  495.793079] cutime=3 cstime=11
[  495.793084] 
[  495.794012]  ? do_semtimedop+0x1270/0x1270
[  495.794014]  do_syscall_64+0x5b/0x1d0
[  495.794024]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  495.794029] RIP: 0033:0x7f013bf23587
[  495.797426] <<<test_end>>>
[  495.797429] 
[  495.800048] Code: 73 01 c3 48 8b 0d 11 e9 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 41 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 e8 2a 00 f7 d8 64 89 01 48
[  495.800050] RSP: 002b:00007ffdfdaafba8 EFLAGS: 00000202 ORIG_RAX: 0000000000000041
[  495.800052] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f013bf23587
[  495.800053] RDX: 0000000000000001 RSI: 00005608192d16f4 RDI: 0000000000000000
[  495.800054] RBP: 00005608192cff10 R08: 0000000000000000 R09: 00007ffdfdaae9d0
[  495.800055] R10: 0000000000000853 R11: 0000000000000202 R12: 0000000000000006
[  495.800056] R13: 00005608190b55d0 R14: 00007f013c3f3498 R15: 00005608192d1574
[  495.800058] Modules linked in: overlay fuse vfat fat btrfs xor zstd_decompress zstd_compress raid6_pq ext4 mbcache jbd2 loop xfs libcrc32c dm_mod intel_rapl_msr intel_rapl_common crct10dif_pclmul sr_mod crc32_pclmul cdrom crc32c_intel sg ghash_clmulni_intel bochs_drm drm_vram_helper ppdev ttm ata_generic pata_acpi drm_kms_helper snd_pcm aesni_intel syscopyarea sysfillrect snd_timer sysimgblt fb_sys_fops crypto_simd drm snd cryptd glue_helper joydev soundcore pcspkr serio_raw i2c_piix4 ata_piix parport_pc parport floppy ip_tables
[  495.803953] <<<test_start>>>
[  495.803955] 
[  495.806468] CR2: 0000000000000002
[  495.806474] ---[ end trace 84cb6cfa04b40df0 ]---


To reproduce:

        # build kernel
	cd linux
	cp config-5.4.0-rc2-00382-g6394de3b86853 .config
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email



Thanks,
Rong Chen


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc2-00382-g6394de3b86853"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-rc2 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDA_INTEL_DETECT_DMIC is not set
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_EXFAT_FS is not set
CONFIG_QLGE=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=y
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='ltp'
	export testcase='ltp'
	export category='functional'
	export need_modules=true
	export need_memory='3G'
	export job_origin='/lkp/lkp/.src-20191018-224157/allot/cyclic:vm-p1:linux-devel:devel-hourly/vm-snb/ltp-1hdd-part1.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='vm-snb-9aa50d282682'
	export tbox_group='vm-snb'
	export nr_vm=64
	export submit_id='5dab445a8a90f7651babeaa4'
	export job_file='/lkp/jobs/scheduled/vm-snb-9aa50d282682/ltp-1HDD-xfs-syscalls_part4-debian-x86_64-2019-05-14.cgz-6394de3b86853-20191020-25883-zhyexr-8.yaml'
	export id='2a3e8b0ce729ebbf1e6b5cb27fa928cfeb738b6e'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='8G'
	export hdd_partitions='/dev/vda /dev/vdb /dev/vdc /dev/vdd /dev/vde /dev/vdf'
	export swap_partitions='/dev/vdg'
	export need_kconfig='CONFIG_BLK_DEV_SD
CONFIG_SCSI
CONFIG_BLOCK=y
CONFIG_SATA_AHCI
CONFIG_SATA_AHCI_PLATFORM
CONFIG_ATA
CONFIG_PCI=y
CONFIG_BLK_DEV_LOOP
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_VCAN=m
CONFIG_IPV6_VTI=m
CONFIG_MINIX_FS=m
CONFIG_KVM_GUEST=y
CONFIG_XFS_FS'
	export commit='6394de3b868537a90dd9128607192b0e97109f6b'
	export ssh_base_port=23032
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2019-05-14.cgz'
	export enqueue_time='2019-10-20 01:14:06 +0800'
	export _id='5dab445e8a90f7651babeaa8'
	export _rt='/result/ltp/1HDD-xfs-syscalls_part4/vm-snb/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b'
	export user='lkp'
	export head_commit='2fcbef48534d2d6e9f20773312e7d6eec2f91617'
	export base_commit='4f5cafb5cb8471e54afdc9054d973535614f7675'
	export branch='linux-devel/devel-hourly-2019101909'
	export result_root='/result/ltp/1HDD-xfs-syscalls_part4/vm-snb/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b/8'
	export scheduler_version='/lkp/lkp/.src-20191018-224157'
	export LKP_SERVER='inn'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-2019-05-14.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/vm-snb-9aa50d282682/ltp-1HDD-xfs-syscalls_part4-debian-x86_64-2019-05-14.cgz-6394de3b86853-20191020-25883-zhyexr-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019101909
commit=6394de3b868537a90dd9128607192b0e97109f6b
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b/vmlinuz-5.4.0-rc2-00382-g6394de3b86853
max_uptime=3600
RESULT_ROOT=/result/ltp/1HDD-xfs-syscalls_part4/vm-snb/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b/8
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fs_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/ltp_2019-10-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/ltp-x86_64-dc6156b-1_2019-10-18.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=12
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/6394de3b868537a90dd9128607192b0e97109f6b/vmlinuz-5.4.0-rc2-00382-g6394de3b86853'
	export dequeue_time='2019-10-20 01:14:31 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-9aa50d282682/ltp-1HDD-xfs-syscalls_part4-debian-x86_64-2019-05-14.cgz-6394de3b86853-20191020-25883-zhyexr-8.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup nr_hdd=1 $LKP_SRC/setup/disk

	run_setup fs='xfs' $LKP_SRC/setup/fs

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='syscalls_part4' $LKP_SRC/tests/wrapper ltp
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper ltp
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time ltp.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--XuV1QlJbYrcVoo+x
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
AgAAAAAEWVo=

--XuV1QlJbYrcVoo+x--
