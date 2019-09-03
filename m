Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA83C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D07622CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 11:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfICLzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 07:55:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:34894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfICLzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:55:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 04:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="198755614"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 04:55:28 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Sep 2019 14:55:27 +0300
Date:   Tue, 3 Sep 2019 14:55:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
Message-ID: <20190903115527.GE2691@lahna.fi.intel.com>
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
 <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
 <20190828102342.GT3177@lahna.fi.intel.com>
 <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
 <20190828131943.GZ3177@lahna.fi.intel.com>
 <be32b369-b013-cca8-5475-9b56acaa3e18@fnarfbargle.com>
 <20190903101325.GC2691@lahna.fi.intel.com>
 <71e34f9e-8e0d-f5f2-bc55-006aeb8a383b@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e34f9e-8e0d-f5f2-bc55-006aeb8a383b@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:11:32PM +0800, Brad Campbell wrote:
> G'day Mika,
> 
> I'm sending you two dmesg because with that patch applied, a warm boot (as
> in reboot) comes up with all 3 heads, but a cold boot only has the two. I
> thought that was odd, so I reproduced it a couple of times just to check.
> 
> So cold boot is dmesg.07 and warm boot is dmesg.06. If I cold boot I get 2
> displays. A reboot from there results in all 3.
> 
> I compiled, installed and rebooted into all 3 heads (which somewhat threw
> me, so I tried it a couple of times).
> 
> So that patch certainly made a difference. Timing/race issue?

I think the problem is that for some reason, probably because this is
first generation hardware with all the bugs included, you cannot read
the second dword from DP adapter path config space (you can write it
though).

I've updated the patch so that it reads only the first dword when it
discovers paths and also when it disables them. Can you try it out and
see if it makes a difference? This should also get rid of the warnings
you get.

diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index afe5f8391ebf..efda9f0467ad 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -45,7 +45,7 @@ static struct tb_port *tb_path_find_dst_port(struct tb_port *src, int src_hopid,
 	for (i = 0; port && i < TB_PATH_MAX_HOPS; i++) {
 		sw = port->sw;
 
-		ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hopid, 2);
+		ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hopid, 1);
 		if (ret) {
 			tb_port_warn(port, "failed to read path at %d\n", hopid);
 			return NULL;
@@ -129,7 +129,7 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 	for (i = 0; p && i < TB_PATH_MAX_HOPS; i++) {
 		sw = p->sw;
 
-		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 1);
 		if (ret) {
 			tb_port_warn(p, "failed to read path at %d\n", h);
 			return NULL;
@@ -171,7 +171,7 @@ struct tb_path *tb_path_discover(struct tb_port *src, int src_hopid,
 
 		sw = p->sw;
 
-		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 2);
+		ret = tb_port_read(p, &hop, TB_CFG_HOPS, 2 * h, 1);
 		if (ret) {
 			tb_port_warn(p, "failed to read path at %d\n", h);
 			goto err;
@@ -349,8 +349,10 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
 	ktime_t timeout;
 	int ret;
 
+	/* Use only first dword of hop when reading */
+
 	/* Disable the path */
-	ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
+	ret = tb_port_read(port, &hop, TB_CFG_HOPS, 2 * hop_index, 1);
 	if (ret)
 		return ret;
 
@@ -360,7 +362,7 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
 
 	hop.enable = 0;
 
-	ret = tb_port_write(port, &hop, TB_CFG_HOPS, 2 * hop_index, 2);
+	ret = tb_port_write(port, &hop, TB_CFG_HOPS, 2 * hop_index, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 1f7a9e1cc09c..28a72336558a 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -313,8 +313,10 @@ static struct tb_port *tb_find_unused_port(struct tb_switch *sw,
 			continue;
 		if (!sw->ports[i].cap_adap)
 			continue;
-		if (tb_port_is_enabled(&sw->ports[i]))
+		if (tb_port_is_enabled(&sw->ports[i])) {
+			tb_port_dbg(&sw->ports[i], "this already enabled\n");
 			continue;
+		}
 		return &sw->ports[i];
 	}
 	return NULL;
@@ -365,16 +367,25 @@ static int tb_tunnel_dp(struct tb *tb, struct tb_port *out)
 	struct tb_tunnel *tunnel;
 	struct tb_port *in;
 
-	if (tb_port_is_enabled(out))
+	tb_port_dbg(out, "trying to tunnel DP\n");
+
+	if (tb_port_is_enabled(out)) {
+		tb_port_dbg(out, "DP OUT port already enabled\n");
 		return 0;
+	}
+
+	tb_port_dbg(out, "finding free DP IN port\n");
 
 	do {
 		sw = tb_to_switch(sw->dev.parent);
 		if (!sw)
 			return 0;
+		tb_sw_dbg(sw, "finding available DP IN\n");
 		in = tb_find_unused_port(sw, TB_TYPE_DP_HDMI_IN);
 	} while (!in);
 
+	tb_port_dbg(in, "found DP IN\n");
+
 	tunnel = tb_tunnel_alloc_dp(tb, in, out);
 	if (!tunnel) {
 		tb_port_dbg(out, "DP tunnel allocation failed\n");
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 5a99234826e7..934a1978741c 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -351,9 +351,23 @@ struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in)
 	struct tb_tunnel *tunnel;
 	struct tb_port *port;
 	struct tb_path *path;
+	u32 data[2];
+	int ret;
+
+	tb_port_dbg(in, "start DP discover\n");
 
-	if (!tb_dp_port_is_enabled(in))
+	if (!tb_dp_port_is_enabled(in)) {
+		tb_port_dbg(in, "DP port NOT enabled\n");
 		return NULL;
+	}
+
+	ret = tb_port_read(in, data, TB_CFG_PORT, in->cap_adap,
+			   ARRAY_SIZE(data));
+	if (ret)
+		return NULL;
+
+	tb_port_dbg(in, "data[0]=0x%08x\n", data[0]);
+	tb_port_dbg(in, "data[1]=0x%08x\n", data[1]);
 
 	tunnel = tb_tunnel_alloc(tb, 3, TB_TUNNEL_DP);
 	if (!tunnel)
