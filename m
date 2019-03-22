Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAEDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7042218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260161;
	bh=zKZxTsa4BYtR0zTzldElS2Qvo12vFcJsSibWmuV87gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eSmjXa/skCZsTMpgHJhb3x1ZgSXGg4L/XjFbXnqGReCZy0bhRmOBXR4i0AOUfaBZz
	 Fx8HCvBQ2ZiKoZaCF2ljAud5ihTlI16DohdWW5eBq1bt6/MAcPaUA1MVPdfO/bjYLd
	 WjHbj7i1iIv+WdHRhE/7vmazOhqk4VVCPV+ihxOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfCVNJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbfCVLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DF9F218B0;
        Fri, 22 Mar 2019 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254510;
        bh=zKZxTsa4BYtR0zTzldElS2Qvo12vFcJsSibWmuV87gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NeEPde0fmdJ0MeGKjskn39EcDCzFIdLuN5vUimRQ1xwhbo/KJbjKbCN1QQawgZ4UL
         ETHhw0L8PTwsYBmN+j5eTz9ai3+9a9CWk/e9B+t8S0MUr+p9mRqrNUs9zuV5BBDMlr
         LQaLRNtKyl/U/EzSP95rer3ekGPaZUBAzVUQVRx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 140/230] ipvlan: disallow userns cap_net_admin to change global mode/flags
Date:   Fri, 22 Mar 2019 12:14:38 +0100
Message-Id: <20190322111246.482087369@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 7cc9f7003a969d359f608ebb701d42cafe75b84a ]

When running Docker with userns isolation e.g. --userns-remap="default"
and spawning up some containers with CAP_NET_ADMIN under this realm, I
noticed that link changes on ipvlan slave device inside that container
can affect all devices from this ipvlan group which are in other net
namespaces where the container should have no permission to make changes
to, such as the init netns, for example.

This effectively allows to undo ipvlan private mode and switch globally to
bridge mode where slaves can communicate directly without going through
hostns, or it allows to switch between global operation mode (l2/l3/l3s)
for everyone bound to the given ipvlan master device. libnetwork plugin
here is creating an ipvlan master and ipvlan slave in hostns and a slave
each that is moved into the container's netns upon creation event.

* In hostns:

  # ip -d a
  [...]
  8: cilium_host@bond0: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
     link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
     ipvlan  mode l3 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
     inet 10.41.0.1/32 scope link cilium_host
       valid_lft forever preferred_lft forever
  [...]

* Spawn container & change ipvlan mode setting inside of it:

  # docker run -dt --cap-add=NET_ADMIN --network cilium-net --name client -l app=test cilium/netperf
  9fff485d69dcb5ce37c9e33ca20a11ccafc236d690105aadbfb77e4f4170879c

  # docker exec -ti client ip -d a
  [...]
  10: cilium0@if4: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l3 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
      inet 10.41.197.43/32 brd 10.41.197.43 scope global cilium0
         valid_lft forever preferred_lft forever

  # docker exec -ti client ip link change link cilium0 name cilium0 type ipvlan mode l2

  # docker exec -ti client ip -d a
  [...]
  10: cilium0@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l2 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
      inet 10.41.197.43/32 brd 10.41.197.43 scope global cilium0
         valid_lft forever preferred_lft forever

* In hostns (mode switched to l2):

  # ip -d a
  [...]
  8: cilium_host@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l2 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
      inet 10.41.0.1/32 scope link cilium_host
         valid_lft forever preferred_lft forever
  [...]

Same l3 -> l2 switch would also happen by creating another slave inside
the container's network namespace when specifying the existing cilium0
link to derive the actual (bond0) master:

  # docker exec -ti client ip link add link cilium0 name cilium1 type ipvlan mode l2

  # docker exec -ti client ip -d a
  [...]
  2: cilium1@if4: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l2 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
  10: cilium0@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l2 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
      inet 10.41.197.43/32 brd 10.41.197.43 scope global cilium0
         valid_lft forever preferred_lft forever

* In hostns:

  # ip -d a
  [...]
  8: cilium_host@bond0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
      link/ether 0c:c4:7a:e1:3d:cc brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 65535
      ipvlan  mode l2 bridge numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
      inet 10.41.0.1/32 scope link cilium_host
         valid_lft forever preferred_lft forever
  [...]

One way to mitigate it is to check CAP_NET_ADMIN permissions of
the ipvlan master device's ns, and only then allow to change
mode or flags for all devices bound to it. Above two cases are
then disallowed after the patch.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipvlan/ipvlan_main.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -389,7 +389,12 @@ static int ipvlan_nl_changelink(struct n
 	struct ipvl_dev *ipvlan = netdev_priv(dev);
 	struct ipvl_port *port = ipvlan_port_get_rtnl(ipvlan->phy_dev);
 
-	if (data && data[IFLA_IPVLAN_MODE]) {
+	if (!data)
+		return 0;
+	if (!ns_capable(dev_net(ipvlan->phy_dev)->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (data[IFLA_IPVLAN_MODE]) {
 		u16 nmode = nla_get_u16(data[IFLA_IPVLAN_MODE]);
 
 		ipvlan_set_port_mode(port, nmode);
@@ -454,6 +459,8 @@ static int ipvlan_link_new(struct net *s
 		struct ipvl_dev *tmp = netdev_priv(phy_dev);
 
 		phy_dev = tmp->phy_dev;
+		if (!ns_capable(dev_net(phy_dev)->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
 	} else if (!netif_is_ipvlan_port(phy_dev)) {
 		err = ipvlan_port_create(phy_dev);
 		if (err < 0)


