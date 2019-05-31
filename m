Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD2CC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE332229C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utc.com header.i=@utc.com header.b="RbN9lMZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEaQs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:48:28 -0400
Received: from mx0a-00105401.pphosted.com ([67.231.144.184]:35602 "EHLO
        mx0a-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfEaQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:48:28 -0400
X-Greylist: delayed 6064 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 May 2019 12:48:27 EDT
Received: from pps.filterd (m0072137.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4VF1lXW017148;
        Fri, 31 May 2019 11:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=utc.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=POD040618;
 bh=5gbVh/YkwhAuPANkJHMS3YLEMB4Kk7kz3rLpnk9QExc=;
 b=RbN9lMZDi3QcK/Hfoz1XPkD3UfZ3cx+5bVR4aYht5osrx4dN2VEawnAR2qyfd+/oW+QS
 /n/wI1mwraJB3moq9cxOvm6YZ0DFJchEYyKpFvrF5V+f+Y+V+TUEE+OJftXbTNjOhJax
 hRr3Ab3u/DRkbFW+x2jKLfcIJ2Y7JYFdwXUqop15PvJPiZ2ePK9F3sBIUKCIS+8F197J
 V76aIpIVtmeJHMRFtgl0d+YjswYtjIBdZzF7Fp03J7xCJ2fpjmQX+MSXYNdDr9Y8l8nM
 g5yvKn2AwV87n8M7EysxQSxXpd1OnLwYBl/j+m11/o4NXsDa5PcYpqWSY8/Fyg6feqTt pw== 
Received: from xnwpv37.utc.com ([167.17.239.17])
        by mx0a-00105401.pphosted.com with ESMTP id 2su2ep3je5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 May 2019 11:07:17 -0400
Received: from uusmna14.utc.com (mailhub.carcgl.com [159.82.227.148])
        by xnwpv37.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id x4VF7BrA092348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 11:07:11 -0400
Received: from UUSTOE1H.utcmail.com (UUSTOE1H.utcmail.com [10.221.3.34])
        by uusmna14.utc.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id x4VF7A5W028017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 11:07:11 -0400
Received: from UUSALE1A.utcmail.com (10.220.3.27) by UUSTOE1H.utcmail.com
 (10.221.3.34) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 May
 2019 10:07:10 -0500
Received: from UUSALE1A.utcmail.com ([10.220.5.27]) by UUSALE1A.utcmail.com
 ([10.220.5.27]) with mapi id 15.00.1473.003; Fri, 31 May 2019 11:07:10 -0400
From:   "Nagal, Amit               UTC CCS" <Amit.Nagal@utc.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "CHAWLA, RITU              UTC CCS" <RITU.CHAWLA@utc.com>
Subject: linux kernel page allocation failure and tuning of page cache
Thread-Topic: linux kernel page allocation failure and tuning of page cache
Thread-Index: AdUXwJaEVv2cRvqaQPqGQFhwqLYB3Q==
Date:   Fri, 31 May 2019 15:07:09 +0000
Message-ID: <09c5d10e9d6b4c258b22db23e7a17513@UUSALE1A.utcmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.3.246]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

We are using Renesas RZ/A1 processor based custom target board . linux kern=
el version is 4.9.123.

1) the platform is low memory platform having memory 64MB.

2)  we are doing around 45MB TCP data transfer from PC to target using netc=
at utility .On Target , a process receives data over socket and writes the =
data to flash disk .

3) At the start of data transfer , we explicitly clear linux kernel cached =
memory by  calling echo 3 > /proc/sys/vm/drop_caches .

4) during TCP data transfer , we could see free -m showing "free" getting d=
ropped to almost 1MB and most of the memory appearing as "cached"=20

# free -m
                                            total         used   free     s=
hared   buffers   cached
Mem:                                  57            56         1           =
      0            2           42
-/+ buffers/cache:                          12        45
Swap:                                   0              0           0

5) sometimes , we observed kernel memory getting exhausted as page allocati=
on failure happens in kernel  with the backtrace is printed below :
# [  775.947949] nc.traditional: page allocation failure: order:0, mode:0x2=
080020(GFP_ATOMIC)
[  775.956362] CPU: 0 PID: 1288 Comm: nc.traditional Tainted: G           O=
    4.9.123-pic6-g31a13de-dirty #19
[  775.966085] Hardware name: Generic R7S72100 (Flattened Device Tree)
[  775.972501] [<c0109829>] (unwind_backtrace) from [<c010796f>] (show_stac=
k+0xb/0xc)
[  775.980118] [<c010796f>] (show_stack) from [<c0151de3>] (warn_alloc+0x89=
/0xba)
[  775.987361] [<c0151de3>] (warn_alloc) from [<c0152043>] (__alloc_pages_n=
odemask+0x1eb/0x634)
[  775.995790] [<c0152043>] (__alloc_pages_nodemask) from [<c0152523>] (__a=
lloc_page_frag+0x39/0xde)
[  776.004685] [<c0152523>] (__alloc_page_frag) from [<c03190f1>] (__netdev=
_alloc_skb+0x51/0xb0)
[  776.013217] [<c03190f1>] (__netdev_alloc_skb) from [<c02c1b6f>] (sh_eth_=
poll+0xbf/0x3c0)
[  776.021342] [<c02c1b6f>] (sh_eth_poll) from [<c031fd8f>] (net_rx_action+=
0x77/0x170)
[  776.029051] [<c031fd8f>] (net_rx_action) from [<c011238f>] (__do_softirq=
+0x107/0x160)
[  776.036896] [<c011238f>] (__do_softirq) from [<c0112589>] (irq_exit+0x5d=
/0x80)
[  776.044165] [<c0112589>] (irq_exit) from [<c012f4db>] (__handle_domain_i=
rq+0x57/0x8c)
[  776.052007] [<c012f4db>] (__handle_domain_irq) from [<c01012e1>] (gic_ha=
ndle_irq+0x31/0x48)
[  776.060362] [<c01012e1>] (gic_handle_irq) from [<c0108025>] (__irq_svc+0=
x65/0xac)
[  776.067835] Exception stack(0xc1cafd70 to 0xc1cafdb8)
[  776.072876] fd60:                                     0002751c c1dec6a0 =
0000000c 521c3be5
[  776.081042] fd80: 56feb08e f64823a6 ffb35f7b feab513d f9cb0643 0000056c =
c1caff10 ffffe000
[  776.089204] fda0: b1f49160 c1cafdc4 c180c677 c0234ace 200e0033 ffffffff
[  776.095816] [<c0108025>] (__irq_svc) from [<c0234ace>] (__copy_to_user_s=
td+0x7e/0x430)
[  776.103796] [<c0234ace>] (__copy_to_user_std) from [<c0241715>] (copy_pa=
ge_to_iter+0x105/0x250)
[  776.112503] [<c0241715>] (copy_page_to_iter) from [<c0319aeb>] (skb_copy=
_datagram_iter+0xa3/0x108)
[  776.121469] [<c0319aeb>] (skb_copy_datagram_iter) from [<c03443a7>] (tcp=
_recvmsg+0x3ab/0x5f4)
[  776.130045] [<c03443a7>] (tcp_recvmsg) from [<c035e249>] (inet_recvmsg+0=
x21/0x2c)
[  776.137576] [<c035e249>] (inet_recvmsg) from [<c031009f>] (sock_read_ite=
r+0x51/0x6e)
[  776.145384] [<c031009f>] (sock_read_iter) from [<c017795d>] (__vfs_read+=
0x97/0xb0)
[  776.152967] [<c017795d>] (__vfs_read) from [<c01781d9>] (vfs_read+0x51/0=
xb0)
[  776.159983] [<c01781d9>] (vfs_read) from [<c0178aab>] (SyS_read+0x27/0x5=
2)
[  776.166837] [<c0178aab>] (SyS_read) from [<c0105261>] (ret_fast_syscall+=
0x1/0x54)
[  776.174308] Mem-Info:
[  776.176650] active_anon:2037 inactive_anon:23 isolated_anon:0
[  776.176650]  active_file:2636 inactive_file:7391 isolated_file:32
[  776.176650]  unevictable:0 dirty:1366 writeback:1281 unstable:0
[  776.176650]  slab_reclaimable:719 slab_unreclaimable:724
[  776.176650]  mapped:1990 shmem:26 pagetables:159 bounce:0
[  776.176650]  free:373 free_pcp:6 free_cma:0
[  776.209062] Node 0 active_anon:8148kB inactive_anon:92kB active_file:105=
44kB inactive_file:29564kB unevictable:0kB isolated(anon):0kB isolated(file=
):128kB mapped:7960kB dirty:5464kB writeback:5124kB shmem:104kB writeback_t=
mp:0kB unstable:0kB pages_scanned:0 all_unreclaimable? no
[  776.233602] Normal free:1492kB min:964kB low:1204kB high:1444kB active_a=
non:8148kB inactive_anon:92kB active_file:10544kB inactive_file:29564kB une=
victable:0kB writepending:10588kB present:65536kB managed:59304kB mlocked:0=
kB slab_reclaimable:2876kB slab_unreclaimable:2896kB kernel_stack:1152kB pa=
getables:636kB bounce:0kB free_pcp:24kB local_pcp:24kB free_cma:0kB
[  776.265406] lowmem_reserve[]: 0 0
[  776.268761] Normal: 7*4kB (H) 5*8kB (H) 7*16kB (H) 5*32kB (H) 6*64kB (H)=
 2*128kB (H) 2*256kB (H) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 1492kB
10071 total pagecache pages
[  776.284124] 0 pages in swap cache
[  776.287446] Swap cache stats: add 0, delete 0, find 0/0
[  776.292645] Free swap  =3D 0kB
[  776.295532] Total swap =3D 0kB
[  776.298421] 16384 pages RAM
[  776.301224] 0 pages HighMem/MovableOnly
[  776.305052] 1558 pages reserved

6) we have certain questions as below :
a) how the kernel memory got exhausted ? at the time of low memory conditio=
ns in kernel , are the kernel page flusher threads , which should have writ=
ten dirty pages from page cache to flash disk , not executing at right time=
 ? is the kernel page reclaim mechanism not executing at right time ?=20

b) are there any parameters available within the linux memory subsystem wit=
h which the reclaim procedure can be monitored and  fine tuned ?

c) can  some amount of free memory be reserved so that linux kernel does no=
t caches it and kernel can use it for its other required page allocation ( =
particularly gfp_atomic ) as needed above on behalf of netcat nc process ? =
can some tuning be done in linux memory subsystem eg by using /proc/sys/vm/=
min_free_kbytes  to achieve this objective .

d) can we be provided with further clues on how to debug this issue further=
 for out of memory condition in kernel  ?


Regards
Amit
