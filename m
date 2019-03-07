Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5573C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F3020675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993170;
	bh=+EzdJy5O8fn0KiCQM7YrPUkDUNzISEGePxcDd/CvLRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=usSoYUbcOTGBZJ55CEehZ+TzMdBPZVe0W2PKMBssnUZC9lmkCSemkAo4gW/4eVYF0
	 tRLXEWIcwIEec8pC7td7+braWfcIEUGc2j9yEfEgTHvCYuUy4QRD6rp7HSpus+fMUV
	 2RfE3IEHhBIQcNGomAyfFRLG2Wzmsl4fY1+T8SZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfCGVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:49 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50015 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbfCGVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:44 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 48C5236B2;
        Thu,  7 Mar 2019 16:12:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jNMOlNzrHR6idAINaWRJDw5ZSeZ1H2NYnVymP+rw/vo=; b=mM2KDL5z
        nrLTqJd1dVMKmjx6h0inYUzvpeugoTmPqYlSYWbED6BnGytu4QLZzuwywpWgRkuF
        BYrH2bHZu9pn5k7vK27U6/2VgtEMi4XkrdtLtyUy4DAzDy8iguFKF4ZONKk3GiPa
        EkZ8e4GQIleddQCHGl3KZ+aCgw/XXgnuLgiNZQFidH8Zs4mq5ey1/1NDW19SemhV
        JiRxKVjiSmKb+B2hI0a49GXeZhuXVErgrS4Oo6v6QOjGT5YA86rNxNgxjEFr/7KP
        TnfnD32bgCGejptj40ZMgsgkYiwoEltUjIKy5lAe+b1+zo77LNlI2gxjCIiXfXMq
        cDlzqrkJt8g+dg==
X-ME-Sender: <xms:SomBXL-V9fJkBmHQKBYQtG-0pZ1KSxg_O5i6fiXWRB0FjGdt8qudlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecuff
    homhgrihhnpehtuhhhshdrohhrghdpihgvthhfrdhorhhgnecukfhppeduvdegrdduieel
    rdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhnsehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:SomBXL9RU2b-JjwXrsW7jXKH2XABC6hLGIQtJ13PmokQ8r5dd8htYg>
    <xmx:SomBXEBVqixPShDz_QgDIfKs7Qm-2Kk6kZcdqRcw_yBJ8lK1vCSRCA>
    <xmx:SomBXLzVHDMQ8BWiXVyFncV2i5RHpnGqA-FZRlI-_UDpG1MflTkU5A>
    <xmx:SomBXJ0JYJ1c00ReVgl7Vc-WqDibnMWGAmAduTzSrnTadC1J4Sq-Mw>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91F1810336;
        Thu,  7 Mar 2019 16:12:40 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] docs: Fix Title underline too short warning
Date:   Fri,  8 Mar 2019 08:11:52 +1100
Message-Id: <20190307211153.28400-9-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits a bunch of 'Title underline too short' warnings.  We can
fix these by using the correct length underlines.

Fix Title underline too short warning by amending heading underline.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/path-lookup.rst | 24 +++++-----
 Documentation/networking/snmp_counter.rst | 58 +++++++++++------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 9d6b68853f5b..80e22eda4132 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -344,7 +344,7 @@ In particular it is held while scanning chains in the dcache hash
 table, and the mount point hash table.
 
 Bringing it together with ``struct nameidata``
---------------------------------------------
+----------------------------------------------
 
 .. _First edition Unix: http://minnie.tuhs.org/cgi-bin/utree.pl?file=V1/u2.s
 
@@ -355,7 +355,7 @@ converts a "name" to an "inode".  ``struct nameidata`` contains (among
 other fields):
 
 ``struct path path``
-~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 A ``path`` contains a ``struct vfsmount`` (which is
 embedded in a ``struct mount``) and a ``struct dentry``.  Together these
@@ -366,13 +366,13 @@ step.  A reference through ``d_lockref`` and ``mnt_count`` is always
 held.
 
 ``struct qstr last``
-~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 This is a string together with a length (i.e. _not_ ``nul`` terminated)
 that is the "next" component in the pathname.
 
 ``int last_type``
-~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~
 
 This is one of ``LAST_NORM``, ``LAST_ROOT``, ``LAST_DOT``, ``LAST_DOTDOT``, or
 ``LAST_BIND``.  The ``last`` field is only valid if the type is
@@ -381,7 +381,7 @@ components of the symlink have been processed yet.  Others should be
 fairly self-explanatory.
 
 ``struct path root``
-~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~
 
 This is used to hold a reference to the effective root of the
 filesystem.  Often that reference won't be needed, so this field is
@@ -510,7 +510,7 @@ potentially interesting things about these dentries corresponding
 to three different flags that might be set in ``dentry->d_flags``:
 
 ``DCACHE_MANAGE_TRANSIT``
-~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If this flag has been set, then the filesystem has requested that the
 ``d_manage()`` dentry operation be called before handling any possible
@@ -529,7 +529,7 @@ filesystem, which will then give it a special pass through
 ``d_manage()`` by returning ``-EISDIR``.
 
 ``DCACHE_MOUNTED``
-~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~
 
 This flag is set on every dentry that is mounted on.  As Linux
 supports multiple filesystem namespaces, it is possible that the
@@ -542,7 +542,7 @@ If this flag is set, and ``d_manage()`` didn't return ``-EISDIR``,
 and a new ``dentry`` (both with counted references).
 
 ``DCACHE_NEED_AUTOMOUNT``
-~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If ``d_manage()`` allowed us to get this far, and ``lookup_mnt()`` didn't
 find a mount point, then this flag causes the ``d_automount()`` dentry
@@ -698,7 +698,7 @@ With that little refresher on seqlocks out of the way we can look at
 the bigger picture of how RCU-walk uses seqlocks.
 
 ``mount_lock`` and ``nd->m_seq``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 We already met the ``mount_lock`` seqlock when REF-walk used it to
 ensure that crossing a mount point is performed safely.  RCU-walk uses
@@ -727,7 +727,7 @@ results would have been the same.  This ensures the invariant holds,
 at least for vfsmount structures.
 
 ``dentry->d_seq`` and ``nd->seq``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In place of taking a count or lock on ``d_reflock``, RCU-walk samples
 the per-dentry ``d_seq`` seqlock, and stores the sequence number in the
@@ -774,7 +774,7 @@ getting a counted reference to the new dentry before dropping that for
 the old dentry which we saw in REF-walk.
 
 No ``inode->i_rwsem`` or even ``rename_lock``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A semaphore is a fairly heavyweight lock that can only be taken when it is
 permissible to sleep.  As ``rcu_read_lock()`` forbids sleeping,
@@ -796,7 +796,7 @@ locking.  This neatly handles all cases, so adding extra checks on
 rename_lock would bring no significant value.
 
 ``unlazy walk()`` and ``complete_walk()``
--------------------------------------
+-----------------------------------------
 
 That "dropping down to REF-walk" typically involves a call to
 ``unlazy_walk()``, so named because "RCU-walk" is also sometimes
diff --git a/Documentation/networking/snmp_counter.rst b/Documentation/networking/snmp_counter.rst
index fe8f741193be..4054f3614730 100644
--- a/Documentation/networking/snmp_counter.rst
+++ b/Documentation/networking/snmp_counter.rst
@@ -5,7 +5,7 @@ SNMP counter
 This document explains the meaning of SNMP counters.
 
 General IPv4 counters
-====================
+=====================
 All layer 4 packets and ICMP packets will change these counters, but
 these counters won't be changed by layer 2 packets (such as STP) or
 ARP packets.
@@ -112,7 +112,7 @@ dropped in the IP sending path and no route is found for it.
 .. _RFC1213 ipOutNoRoutes: https://tools.ietf.org/html/rfc1213#page-29
 
 ICMP counters
-============
+=============
 * IcmpInMsgs and IcmpOutMsgs
 Defined by `RFC1213 icmpInMsgs`_ and `RFC1213 icmpOutMsgs`_
 
@@ -209,7 +209,7 @@ and the sending packet path use IcmpOutErrors. When IcmpInCsumErrors
 is increased, IcmpInErrors would always be increased too.
 
 relationship of the ICMP counters
--------------------------------
+---------------------------------
 The sum of IcmpMsgOutType[N] is always equal to IcmpOutMsgs, as they
 are updated at the same time. The sum of IcmpMsgInType[N] plus
 IcmpInErrors should be equal or larger than IcmpInMsgs. When kernel
@@ -229,7 +229,7 @@ IcmpInMsgs should be less than the sum of IcmpMsgOutType[N] plus
 IcmpInErrors.
 
 General TCP counters
-==================
+====================
 * TcpInSegs
 Defined in `RFC1213 tcpInSegs`_
 
@@ -356,7 +356,7 @@ process might be failed due to some errors (e.g. memory alloc failed).
 
 
 TCP Fast Path
-============
+=============
 When kernel receives a TCP packet, it has two paths to handler the
 packet, one is fast path, another is slow path. The comment in kernel
 code provides a good explanation of them, I pasted them below::
@@ -401,7 +401,7 @@ increase 1.
 
 
 TCP abort
-========
+=========
 * TcpExtTCPAbortOnData
 It means TCP layer has data in flight, but need to close the
 connection. So TCP layer sends a RST to the other side, indicate the
@@ -465,7 +465,7 @@ TcpExtTCPAbortFailed will be increased.
 .. _RFC2525 2.17 section: https://tools.ietf.org/html/rfc2525#page-50
 
 TCP Hybrid Slow Start
-====================
+=====================
 The Hybrid Slow Start algorithm is an enhancement of the traditional
 TCP congestion window Slow Start algorithm. It uses two pieces of
 information to detect whether the max bandwidth of the TCP path is
@@ -497,7 +497,7 @@ TcpExtTCPHystartDelayDetect is the average CWND which detected by the
 packet delay.
 
 TCP retransmission and congestion control
-======================================
+=========================================
 The TCP protocol has two retransmission mechanisms: SACK and fast
 recovery. They are exclusive with each other. When SACK is enabled,
 the kernel TCP stack would use SACK, or kernel would use fast
@@ -590,7 +590,7 @@ The TCP stack receives a DSACK, which indicate an out of order
 duplicate packet is received.
 
 invalid SACK and DSACK
-====================
+======================
 When a SACK (or DSACK) block is invalid, a corresponding counter would
 be updated. The validation method is base on the start/end sequence
 number of the SACK block. For more details, please refer the comment
@@ -619,7 +619,7 @@ will be updated. If the undo_marker is set, TcpExtTCPDSACKIgnoredOld
 will be updated. As implied in its name, it might be an old packet.
 
 SACK shift
-=========
+==========
 The linux networking stack stores data in sk_buff struct (skb for
 short). If a SACK block acrosses multiple skb, the TCP stack will try
 to re-arrange data in these skb. E.g. if a SACK block acknowledges seq
@@ -640,7 +640,7 @@ A skb should be shifted or merged, but the TCP stack doesn't do it for
 some reasons.
 
 TCP out of order
-===============
+================
 * TcpExtTCPOFOQueue
 The TCP layer receives an out of order packet and has enough memory
 to queue it.
@@ -656,7 +656,7 @@ packet. the overlay part will be dropped. All of TcpExtTCPOFOMerge
 packets will also be counted into TcpExtTCPOFOQueue.
 
 TCP PAWS
-=======
+========
 PAWS (Protection Against Wrapped Sequence numbers) is an algorithm
 which is used to drop old packets. It depends on the TCP
 timestamps. For detail information, please refer the `timestamp wiki`_
@@ -672,7 +672,7 @@ Packets are dropped by PAWS in Syn-Sent status.
 Packets are dropped by PAWS in any status other than Syn-Sent.
 
 TCP ACK skip
-===========
+============
 In some scenarios, kernel would avoid sending duplicate ACKs too
 frequently. Please find more details in the tcp_invalid_ratelimit
 section of the `sysctl document`_. When kernel decides to skip an ACK
@@ -729,7 +729,7 @@ unacknowledged number (more strict than `RFC 5961 section 5.2`_).
 .. _RFC 5961 section 5.2: https://tools.ietf.org/html/rfc5961#page-11
 
 TCP receive window
-=================
+==================
 * TcpExtTCPWantZeroWindowAdv
 Depending on current memory usage, the TCP stack tries to set receive
 window to zero. But the receive window might still be a no-zero
@@ -745,7 +745,7 @@ The TCP receive window is set to no-zero value from zero.
 
 
 Delayed ACK
-==========
+===========
 The TCP Delayed ACK is a technique which is used for reducing the
 packet count in the network. For more details, please refer the
 `Delayed ACK wiki`_
@@ -771,7 +771,7 @@ triggered by other reasons, such as a packet is duplicated in the
 network.
 
 Tail Loss Probe (TLP)
-===================
+=====================
 TLP is an algorithm which is used to detect TCP packet loss. For more
 details, please refer the `TLP paper`_.
 
@@ -784,10 +784,10 @@ A TLP probe packet is sent.
 A packet loss is detected and recovered by TLP.
 
 examples
-=======
+========
 
 ping test
---------
+---------
 Run the ping command against the public dns server 8.8.8.8::
 
   nstatuser@nstat-a:~$ ping 8.8.8.8 -c 1
@@ -831,7 +831,7 @@ and its corresponding Echo Reply packet are constructed by:
 So the IpExtInOctets and IpExtOutOctets are 20+16+48=84.
 
 tcp 3-way handshake
-------------------
+-------------------
 On server side, we run::
 
   nstatuser@nstat-b:~$ nc -lknv 0.0.0.0 9000
@@ -873,7 +873,7 @@ ACK, so client sent 2 packets, received 1 packet, TcpInSegs increased
 1, TcpOutSegs increased 2.
 
 TCP normal traffic
------------------
+------------------
 Run nc on server::
 
   nstatuser@nstat-b:~$ nc -lkv 0.0.0.0 9000
@@ -996,7 +996,7 @@ and the packet received from client qualified for fast path, so it
 was counted into 'TcpExtTCPHPHits'.
 
 TcpExtTCPAbortOnClose
---------------------
+---------------------
 On the server side, we run below python script::
 
   import socket
@@ -1030,7 +1030,7 @@ If we run tcpdump on the server side, we could find the server sent a
 RST after we type Ctrl-C.
 
 TcpExtTCPAbortOnMemory and TcpExtTCPAbortOnTimeout
------------------------------------------------
+--------------------------------------------------
 Below is an example which let the orphan socket count be higher than
 net.ipv4.tcp_max_orphans.
 Change tcp_max_orphans to a smaller value on client::
@@ -1152,7 +1152,7 @@ FIN_WAIT_1 state finally. So we wait for a few minutes, we could find
   TcpExtTCPAbortOnTimeout         10                 0.0
 
 TcpExtTCPAbortOnLinger
----------------------
+----------------------
 The server side code::
 
   nstatuser@nstat-b:~$ cat server_linger.py
@@ -1197,7 +1197,7 @@ After run client_linger.py, check the output of nstat::
   TcpExtTCPAbortOnLinger          1                  0.0
 
 TcpExtTCPRcvCoalesce
--------------------
+--------------------
 On the server, we run a program which listen on TCP port 9000, but
 doesn't read any data::
 
@@ -1257,7 +1257,7 @@ the receiving queue. So the TCP layer merged the two packets, and we
 could find the TcpExtTCPRcvCoalesce increased 1.
 
 TcpExtListenOverflows and TcpExtListenDrops
-----------------------------------------
+-------------------------------------------
 On server, run the nc command, listen on port 9000::
 
   nstatuser@nstat-b:~$ nc -lkv 0.0.0.0 9000
@@ -1305,7 +1305,7 @@ TcpExtListenOverflows and TcpExtListenDrops would be larger, because
 the SYN of the 4th nc was dropped, the client was retrying.
 
 IpInAddrErrors, IpExtInNoRoutes and IpOutNoRoutes
-----------------------------------------------
+-------------------------------------------------
 server A IP address: 192.168.122.250
 server B IP address: 192.168.122.251
 Prepare on server A, add a route to server B::
@@ -1400,7 +1400,7 @@ a route for the 8.8.8.8 IP address, so server B increased
 IpOutNoRoutes.
 
 TcpExtTCPACKSkippedSynRecv
-------------------------
+--------------------------
 In this test, we send 3 same SYN packets from client to server. The
 first SYN will let server create a socket, set it to Syn-Recv status,
 and reply a SYN/ACK. The second SYN will let server reply the SYN/ACK
@@ -1448,7 +1448,7 @@ Check snmp cunter on nstat-b::
 As we expected, TcpExtTCPACKSkippedSynRecv is 1.
 
 TcpExtTCPACKSkippedPAWS
-----------------------
+-----------------------
 To trigger PAWS, we could send an old SYN.
 
 On nstat-b, let nc listen on port 9000::
@@ -1485,7 +1485,7 @@ failed, the nstat-b replied an ACK for the first SYN, skipped the ACK
 for the second SYN, and updated TcpExtTCPACKSkippedPAWS.
 
 TcpExtTCPACKSkippedSeq
---------------------
+----------------------
 To trigger TcpExtTCPACKSkippedSeq, we send packets which have valid
 timestamp (to pass PAWS check) but the sequence number is out of
 window. The linux TCP stack would avoid to skip if the packet has
-- 
2.21.0

