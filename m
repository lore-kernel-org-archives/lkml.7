Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A8DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488CE22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfICKN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:13:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:42467 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfICKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:13:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 03:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="198739823"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 03:13:26 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Sep 2019 13:13:25 +0300
Date:   Tue, 3 Sep 2019 13:13:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
Message-ID: <20190903101325.GC2691@lahna.fi.intel.com>
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
 <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
 <20190828102342.GT3177@lahna.fi.intel.com>
 <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
 <20190828131943.GZ3177@lahna.fi.intel.com>
 <be32b369-b013-cca8-5475-9b56acaa3e18@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be32b369-b013-cca8-5475-9b56acaa3e18@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Thu, Aug 29, 2019 at 12:27:08AM +0800, Brad Campbell wrote:
> It wouldn't surprise me if the firmware was doing something funky. It was
> one of the first Thunderbolt equipped models and the support docs explicitly
> say only one Thunderbolt display in Windows and two in later versions of
> OSX. It almost needs a quirk to say "firmware does something we don't like,
> reset the controller and re-discover from scratch".
> 
> Anyway, I'm not in any hurry. It doesn't get rebooted often and it's not in
> any way preventing me using the machine. In fact, upgrading the third head
> from an old 24" 1920x1200 to the second Thunderbolt display has been
> invaluable.

Can you apply the below patch and then boot with two monitors connected?
Then send me the dmesg. It does not fix anything but should log a bit
more.

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
index 5a99234826e7..93c2c965bdde 100644
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
+		tb_port_dbg(in, "DP port enabled\n");
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
