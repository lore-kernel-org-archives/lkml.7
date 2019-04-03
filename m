Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E9AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AE520651
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foreca.com header.i=@foreca.com header.b="RNqPP9kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCPAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:00:21 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35516 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDCPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:00:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id d132so6032574ywa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foreca.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=i8NGOVapS1LkNfEWyO8DgxQCl8hJgoHPU0suMItL5/4=;
        b=RNqPP9kAYBdNmIeKWtcLu614v+U+UC2Khg7wMlDEW/QAPy9VHQzvHGyKwcdqwflNbp
         83dMjI5yApr/11jC92Fo1jqweXTcLVITxgocX8uj9R9JnmUE7WLO3sJCX4xPFPyuDckV
         gXkQdz+WUDUb8usCODVvaWHnTrb0nkCqcQnBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i8NGOVapS1LkNfEWyO8DgxQCl8hJgoHPU0suMItL5/4=;
        b=JP3JEOxOLcg8Gasb1bDGDNdxRjKLG4lfkF0CI8CwY1atQuTktVIRpL6+M+K9KztwDg
         i+z1xSs7qUJLkLr+SR+NR41mG6XsEFHklDGqBvM6887WImbvQoUc8eK2X8higXEZ4g+e
         QFUpkkC+ibEtvDWqD11oNjbJ84r4KZlzNsI4Lh8X/qNW/e33CLGgFpLQjxkGOj1tsFNE
         m4/cr8WvE3T5mDskAgEnfPkHTdT/03ZT3Av2V1IhK/6lMAJ6p11V8W6cMj1n2bouP5l6
         9PnKESP0ASdgLcajXHQVoMglzdml91/xbxbJVlP49zU4h7oCLoIVKd3+t9MUcHEVsYFr
         GQ7A==
X-Gm-Message-State: APjAAAXM6lj/IZkiXh6Wv44uPO9tEzc/aHh9cYAX3TTBV4TjIcfitoUj
        tJFN4pi+ZUCgShHm82oV4hzuerJ3s4FkdDa2R59Rx0HK8BQ=
X-Google-Smtp-Source: APXvYqzYNvuLqc6Pd1Pqx3jTgeH1KaBgvf00I7k6ppfqXeG4VNVgEGGZ4rH6lhuKvhEkZfJaQaQ9Q9LHoWNO3EOcBfM=
X-Received: by 2002:a81:2f91:: with SMTP id v139mr1278567ywv.159.1554303619446;
 Wed, 03 Apr 2019 08:00:19 -0700 (PDT)
MIME-Version: 1.0
From:   Juha-Matti Tilli <juha-matti.tilli@foreca.com>
Date:   Wed, 3 Apr 2019 18:00:08 +0300
Message-ID: <CAA1_w39-q=8pcVVmwppyO81oBP0Pyn3pWr=4MKQbBvmcX=Ba5Q@mail.gmail.com>
Subject: NFS hang, sk_drops increasing, segs_in not, pfmemalloc suspected
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     edumazet@google.com, juha-matti.tilli@foreca.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please CC me, I'm not on the lists.

We at Foreca had an issue with NFS hangs in a heavily loaded jumbo frame
environment. Specifically, TCP NFS connections occasionally stall
irregardless of whether NFSv3 or NFSv4 is used. On closer inspection,
the issue seems to be a TCP issue: the NFS TCP server doesn't accept
data or ACKs from the client and continuously keeps on retransmitting
the same segment the client has already seen. The client sends a DSACK,
which the server doesn't see. On both ends, netstat shows unacked data
in the send buffers. This NFS hang happens approximately once per day,
and the problem goes away in 5-10 minutes. Often times, the existing TCP
connection is discarded due to a timeout and a new one is opened from
the same port.

Log from dmesg:

[1217343.872989] nfs: server 192.168.47.81 not responding, still trying
[1217343.873022] nfs: server 192.168.47.81 not responding, still trying
[1217343.873026] nfs: server 192.168.47.81 not responding, still trying
[1217343.873027] nfs: server 192.168.47.81 not responding, still trying
[1217343.873029] nfs: server 192.168.47.81 not responding, still trying
[1217343.873048] nfs: server 192.168.47.81 not responding, still trying
[1217343.873049] nfs: server 192.168.47.81 not responding, still trying
[1217343.873049] nfs: server 192.168.47.81 not responding, still trying
[1217343.873050] nfs: server 192.168.47.81 not responding, still trying
[1217343.873052] nfs: server 192.168.47.81 not responding, still trying
[1217591.216341] nfs: server 192.168.47.81 OK
[1217591.216437] nfs: server 192.168.47.81 OK
[1217591.216469] nfs: server 192.168.47.81 OK
[1217591.216523] nfs: server 192.168.47.81 OK
[1217591.216546] nfs: server 192.168.47.81 OK
[1217591.216555] nfs: server 192.168.47.81 OK
[1217591.216563] nfs: server 192.168.47.81 OK
[1217591.216677] nfs: server 192.168.47.81 OK
[1217591.216748] nfs: server 192.168.47.81 OK
[1217591.216753] nfs: server 192.168.47.81 OK

The NICs are ixgbe, connected to a jumbo frame low-latency 10Gbps LAN
that is very reliable and there shouldn't be any packet drops in this
LAN. ICMP echo packets are responded to all the time; I have monitoring
that pings through the network every second and there's absolutely no
packet loss. The 2-node NUMA machines have 88 virtual CPU cores, and
those aren't just idling; they are performing heavy computation nearly
continuously.

Some ixgbe driver information:

$ ethtool -g eno2
Ring parameters for eno2:
Pre-set maximums:
RX:        4096
RX Mini:    0
RX Jumbo:    0
TX:        4096
Current hardware settings:
RX:        512
RX Mini:    0
RX Jumbo:    0
TX:        512

$ ethtool -l eno2
Channel parameters for eno2:
Pre-set maximums:
RX:        0
TX:        0
Other:        1
Combined:    63
Current hardware settings:
RX:        0
TX:        0
Other:        1
Combined:    63

ethtool -S eno2 shows (among other non-interesting information):
alloc_rx_page_failed: 0
alloc_rx_buff_failed: 0
rx_no_dma_resources: 2239

When debugging the issue, I found that sk_drops was increasing but
segs_in was not. Closer inspection led me to believe that the SKB is
allocated from pfmemalloc reserves, as there are not many other reasons
for segs_in not incrementing at the same time sk_drops is incrementing.
On this very specific kernel version, there is no counter for such
dropped segments; recent kernels have LINUX_MIB_PFMEMALLOCDROP counter
that Eric Dumazet added a couple of years ago.

We found that vm.min_free_kbytes is only 90112 (90 megabytes) even
though the machines have 128-256 gigabytes of RAM. We bumped up
vm.min_free_kbytes by multiplying it by 10 and the NFS hang went away;
the system has been stable for about a week, whereas before this bump
NFS hangs happened approximately once per day. This, among my
investigations of the Linux kernel source code, suggests that pfmemalloc
is the cause of our NFS issues.

The NFS server is under extremely heavy memory pressure all the time, as
the machine is doing weather forecasting and weather service business,
with data set being greater than RAM size. The NFS server isn't a
dedicated NFS-only server, as we actually use the considerable CPU
resources on the server. There is memory fragmentation and
/proc/buddyinfo can easily show readings as bad as this (not during NFS
hang, but during old vm.min_free_kbytes value):

Node 0, zone      DMA      0      1      0      0      2      1      1
     0      1      1      3
Node 0, zone    DMA32    619    456    750   2890   1638    901    431
   124      4      0      0
Node 0, zone   Normal  13620      0      0      0      0      0      0
     0      0      0      0
Node 1, zone   Normal  25620 423610  91505   6636    573      1      0
     0      0      0      0

...so one NUMA node is nearly starved of memory, the remaining memory
being fragmented. I suspect the node 0 normal memory can be even worse,
but I didn't manage to capture /proc/buddyinfo during an NFS hang and
don't want to reproduce a hang anymore as the machine is in production
use (nearly immediately when I started to suspect memory issues, I
bumped up vm.min_free_kbytes, so I have only limited logs at old
vm.min_free_kbytes values).

I have several questions:

A) Is it enough to have a LINUX_MIB_PFMEMALLOCDROP counter for
pfmemalloc drops? Shouldn't there be a big honking rate-limited warning
printed to dmesg?  Something like "packet dropped due to out-of-memory
condition, please bump up vm.min_free_kbytes"? I mean, if you run out of
memory, surely the sysadmin should be notified. Most sysadmins aren't
experienced enough to read every single netstat counter. We only see the
issue as NFS hangs in dmesg; there is nothing that could direct the
sysadmin to suspect memory issues.

B) Why does the ixgbe driver keep on dropping packets for 5-10 minutes?
Does this indicate that ixgbe is reusing the pfmemalloc pages? Should
Intel be informed of this as the developer of the ixgbe driver? Or is
the SKB allocated outside of ixgbe? The ixgbe driver version we use is
the one that comes with CentOS 7.

C) Why is the default vm.min_free_kbytes only 90 megabytes, even though
there is plenty of RAM? Should vm.min_free_kbytes be bigger as default?

BR, Juha-Matti
