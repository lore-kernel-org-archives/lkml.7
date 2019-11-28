Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F75C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5EC217BA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1KDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:03:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:9956 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1KDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:03:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 02:03:38 -0800
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="203389544"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 02:03:34 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH] drm/dp_mst: Fix W=1 warnings
In-Reply-To: <20191112123938.2346-1-benjamin.gaignard@st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191112123938.2346-1-benjamin.gaignard@st.com>
Date:   Thu, 28 Nov 2019 12:03:32 +0200
Message-ID: <877e3knwqz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> Fix the warnings that show up with W=1.
> They are all about unused but set variables.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 50 +++++++++++++----------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index b854a422a523..6ff554be8000 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -672,7 +672,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>  				      u8 *replybuf, u8 replybuflen, bool hdr)
>  {
>  	int ret;
> -	u8 crc4;
>  
>  	if (hdr) {
>  		u8 hdrlen;
> @@ -714,8 +713,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>  	}
>  
>  	if (msg->curchunk_idx >= msg->curchunk_len) {
> -		/* do CRC */
> -		crc4 = drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len - 1);

Someone who knows this code really needs to check if we should be using
crc4 instead of just throwing this away as unused.

>  		/* copy chunk into bigger msg */
>  		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
>  		msg->curlen += msg->curchunk_len - 1;
> @@ -1744,14 +1741,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
>   */
>  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)

The function changed in c485e2c97dae ("drm/dp_mst: Refactor pdt
setup/teardown, add more locking").

>  {
> -	int ret;
>  	u8 rad[6], lct;
>  	bool send_link = false;
>  	switch (port->pdt) {
>  	case DP_PEER_DEVICE_DP_LEGACY_CONV:
>  	case DP_PEER_DEVICE_SST_SINK:
>  		/* add i2c over sideband */
> -		ret = drm_dp_mst_register_i2c_bus(&port->aux);
> +		drm_dp_mst_register_i2c_bus(&port->aux);
>  		break;
>  	case DP_PEER_DEVICE_MST_BRANCHING:
>  		lct = drm_dp_calculate_rad(port, rad);
> @@ -1821,21 +1817,18 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
>  
>  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *guid)
>  {
> -	int ret;
> -
>  	memcpy(mstb->guid, guid, 16);
>  
>  	if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>  		if (mstb->port_parent) {
> -			ret = drm_dp_send_dpcd_write(
> +			drm_dp_send_dpcd_write(
>  					mstb->mgr,
>  					mstb->port_parent,
>  					DP_GUID,
>  					16,
>  					mstb->guid);

Indentation could be fixed while at it.

>  		} else {
> -
> -			ret = drm_dp_dpcd_write(
> +			drm_dp_dpcd_write(
>  					mstb->mgr->aux,
>  					DP_GUID,
>  					mstb->guid,
> @@ -2427,14 +2420,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_link_address_ack_reply *reply;
> -	int i, len, ret;
> +	int i, ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>  	if (!txmsg)
>  		return;
>  
>  	txmsg->dst = mstb;
> -	len = build_link_address(txmsg);
> +	build_link_address(txmsg);

Maybe you should make the function void while at it?

>  
>  	mstb->link_address_sent = true;
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2476,7 +2469,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_enum_path_resources_ack_reply *path_res;
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len;
>  	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2484,7 +2476,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>  		return -ENOMEM;
>  
>  	txmsg->dst = mstb;
> -	len = build_enum_path_resources(txmsg, port->port_num);
> +	build_enum_path_resources(txmsg, port->port_num);

Maybe you should make the function void while at it?

>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -2567,7 +2559,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> -	int len, ret, port_num;
> +	int ret, port_num;
>  	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>  	int i;
>  
> @@ -2592,9 +2584,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  		sinks[i] = i;
>  
>  	txmsg->dst = mstb;
> -	len = build_allocate_payload(txmsg, port_num,
> -				     id,
> -				     pbn, port->num_sdp_streams, sinks);
> +	build_allocate_payload(txmsg, port_num,
> +			       id,
> +			       pbn, port->num_sdp_streams, sinks);

Maybe you should make the function void while at it?

>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -2623,7 +2615,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port, bool power_up)
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len, ret;
> +	int ret;
>  
>  	port = drm_dp_mst_topology_get_port_validated(mgr, port);
>  	if (!port)
> @@ -2636,7 +2628,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>  	}
>  
>  	txmsg->dst = port->parent;
> -	len = build_power_updown_phy(txmsg, port->port_num, power_up);
> +	build_power_updown_phy(txmsg, port->port_num, power_up);

Maybe you should make the function void while at it?

>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
>  	ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> @@ -2856,7 +2848,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port,
>  				 int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret = 0;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -2871,7 +2862,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_read(txmsg, port->port_num, offset, size);
> +	build_dpcd_read(txmsg, port->port_num, offset, size);

Maybe you should make the function void while at it?

>  	txmsg->dst = port->parent;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2909,7 +2900,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>  				  struct drm_dp_mst_port *port,
>  				  int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -2924,7 +2914,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
> +	build_dpcd_write(txmsg, port->port_num, offset, size, bytes);

Maybe you should make the function void while at it?

>  	txmsg->dst = mstb;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3147,7 +3137,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  {
>  	int len;
>  	u8 replyblock[32];
> -	int replylen, origlen, curreply;
> +	int replylen, curreply;
>  	int ret;
>  	struct drm_dp_sideband_msg_rx *msg;
>  	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
> @@ -3167,7 +3157,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  	}
>  	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
>  
> -	origlen = replylen;
>  	replylen -= len;
>  	curreply = len;
>  	while (replylen > 0) {
> @@ -3959,17 +3948,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  	mutex_lock(&mgr->lock);
>  	if (mgr->mst_primary) {
>  		u8 buf[DP_PAYLOAD_TABLE_SIZE];
> -		int ret;
>  
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
>  		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> +		drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>  		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> +		drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>  		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
>  
>  		/* dump the standard OUI branch header */
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
>  		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
>  		for (i = 0x3; i < 0x8 && buf[i]; i++)
>  			seq_printf(m, "%c", buf[i]);

-- 
Jani Nikula, Intel Open Source Graphics Center
